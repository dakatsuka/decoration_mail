# coding: utf-8

module DecorationMail
  class Base
    def initialize(mail)
      @attachments = mail.attachments
      @body_text   = parse_text(mail.text_part)
      @body_html   = parse_html(mail.html_part)
    end

    def images
      images = []

      @attachments.each do |attachment|
        content_type = attachment.header['content-type'].to_s
        content_id   = "cid:" + attachment.header['content-id'].to_s.sub(/^</, '').sub(/>$/, '')
        file_name    = attachment.filename

        next unless check_content_type(content_type)
        images << DecorationMail::Image.new(content_id, content_type, file_name, attachment.read)
      end

      images
    end

    def save(options = {}, &block)
      images.each do |image|
        image.instance_eval(&block)

        if image.content_id
          @body_html.search("img").each do |element|
            if element[:src] == image.content_id
              element[:src] = (image.path ? image.path : image.filename)
            end
          end
        else
          case options[:other_images]
          when :top
            @body_html = Hpricot("<div style='text-align:center;'><img src='#{image.path ? image.path : image.filename}' /></div><br />" + @body_html.to_html)
          when :bottom
            @body_html = Hpricot(@body_html.to_html + "<br /><div style='text-align:center;'><img src='#{image.path ? image.path : image.filename}' /></div>")
          end
        end
      end

      @body_html.to_html
    end

    private
    def parse_text(text)
      NKF.nkf("-w", text.to_s)
    end

    def parse_html(html)
      html = NKF.nkf("-w", html.body.to_s)
      html = Hpricot.parse(html)

      if html.search("body").empty?
        raise ArgumentError, 'invalid HTML'
      else
        html = DecorationMail::Converter.convert_to_xhtml(html).at('div')
      end

      html
    end

    def check_content_type(content_type)
      case content_type
      when /^image\/gif/
        true
      when /^image\/jpg/
        true
      when /^image\/jpeg/
        true
      when /^image\/png/
        true
      else
        false
      end
    end
  end
end
