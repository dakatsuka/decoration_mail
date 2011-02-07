# coding: utf-8

module DecorationMail
  module Message
    def decoration_data
      if html_part
        DecorationMail::Base.new(self)
      else
        nil
      end
    end
  end
end
