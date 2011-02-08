# coding: utf-8

module DecorationMail
  class Image
    attr_accessor :path
    attr_reader :content_id, :filename, :body

    def initialize(content_id, content_type, filename, body)
      @content_id   = content_id
      @content_type = content_type
      @filename     = filename
      @body         = body
    end

    def extension
      case @content_type
      when /^image\/gif/
        ".gif"
      when /^image\/jpg/
        ".jpg"
      when /^image\/jpeg/
        ".jpg"
      when /^image\/png/
        ".png"
      else
        nil
      end
    end
  end
end
