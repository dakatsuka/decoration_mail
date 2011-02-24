# coding: utf-8

module DecorationMail
  class Image
    attr_accessor :path
    attr_reader :content_id, :filename

    def initialize(content_id, content_type, filename, attachment)
      @content_id   = "cid:#{content_id}"
      @content_type = content_type
      @filename     = filename
      @attachment   = attachment
    end

    def body
      warn "[DEPRECATION] 'body' is deprecated. Please use 'read'"
      @attachment.read
    end

    def read
      @attachment.read
    end

    def extension
      case @content_type
      when /^image\/gif/
        "gif"
      when /^image\/jpg/
        "jpg"
      when /^image\/jpeg/
        "jpg"
      when /^image\/png/
        "png"
      else
        nil
      end
    end
  end
end
