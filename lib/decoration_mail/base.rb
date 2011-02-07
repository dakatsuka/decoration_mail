# coding: utf-8

module DecorationMail
  class Base
    def initialize(mail)
      @attachments = mail.attachments
      @body_text = NKF.nkf("-w", mail.text_part.to_s)
      @body_html = Nokogiri.parse(NKF.nkf("-w", mail.html_part.body.to_s)).at('body')
    end

    def html
      @body_html.to_s
    end
  end
end
