# coding: utf-8
require 'kconv'

module DecorationMail
  class Base
    attr_reader :images, :subject

    def initialize(mail)
      extract_attachments(mail)
      @subject     = mail.subject.blank? ? nil : mail.subject.toutf8
      @text_body = mail.text_part.to_s.toutf8
      @html_body = DecorationMail::HTML.new(mail.html_part.body.to_s.toutf8)
    end

    def save(options = {}, &block)
      @images.each do |image|
        image.instance_eval(&block)

        if @html_body.match /#{image.content_id}/
          @html_body.update_img_src(image.content_id, image.src)
        else
          case options[:other_images]
          when :top
            @html_body.prepend_img(image.src)
          when :bottom
            @html_body.append_img(image.src)
          end
        end
      end

      @html_body.to_s
    end

  private

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

    def extract_attachments(part)
      @images = [] unless defined?(@images)

      if part.multipart?
        part.parts.each do |part|
          if part.multipart?
            extract_attachments(part)
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
