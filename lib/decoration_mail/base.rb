# coding: utf-8
require 'kconv'

module DecorationMail
  class Base
    attr_reader :images, :subject

    def initialize(mail)
      each_attachments(mail)
      @subject     = mail.subject.blank? ? nil : mail.subject.toutf8
      @body_text   = parse_text(mail.text_part)
      @body_html   = parse_html(mail.html_part)
    end

    def save(options = {}, &block)
      @images.each do |image|
        image.instance_eval(&block)

        if @body_html.inner_html =~ /#{image.content_id}/
          @body_html.search("img").each do |element|
            if element[:src] == image.content_id
              element[:src] = (image.path ? image.path : image.filename.to_s)
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
        text.to_s.toutf8
      end

      def parse_html(html)
        html = html.body.to_s.toutf8
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

      def each_attachments(part)
        @images = [] unless defined?(@images)

        if part.multipart?
          part.parts.each do |part|
            if part.multipart?
              each_attachments(part)
            else
              content_type = part.header['content-type'].to_s
              next unless check_content_type(content_type)

              content_id   = part.header['content-id'].to_s.sub(/^</, '').sub(/>$/, '')
              content_id   = part.filename if content_id.blank?
              filename     = part.filename
              @images << DecorationMail::Image.new(content_id, content_type, filename, part)
            end
          end
        end
      end
  end
end
