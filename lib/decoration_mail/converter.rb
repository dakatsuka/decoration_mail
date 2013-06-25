# coding: utf-8

module DecorationMail
  module Converter
    def self.convert_to_xhtml(html)
      html = convert_body_to_div(html)
      html = convert_font_color_to_css(html)
      html = convert_font_size_to_css(html)
      html = convert_align_to_css(html)
      html = convert_blink_to_css(html)
      html = convert_marquee_to_css(html)
    end

    private
    def self.convert_body_to_div(html)
      html.search("body").each do |body|
        body.name = 'div'
        bgcolor = body[:bgcolor]
        body.attributes.each{|k, v| body.remove_attribute k}
        body[:style] = "background-color:#{bgcolor};" if bgcolor
      end
      html
    end

    def self.convert_font_color_to_css(html)
      html.search("font").each do |element|
        if element[:color]
          str = "<span>#{element.inner_html}</span>"
          tmp = Nokogiri.HTML(str).search("span")
          tmp.first[:style] = "color:#{element[:color].downcase};"
          element.swap(tmp.to_html)
        end
      end
      html
    end

    def self.convert_font_size_to_css(html)
      html.search("font").each do |element|
        if element[:size]
          str = "<span>#{element.inner_html}</span>"
          tmp = Nokogiri.HTML(str).search("span")

          case element[:size]
          when "1"
            tmp.first[:style] = "font-size:xx-small;"
          when "2"
            tmp.first[:style] = "font-size:x-small;"
          when "3"
            tmp.first[:style] = "font-size:small;"
          when "4"
            tmp.first[:style] = "font-size:medium;"
          when "5"
            tmp.first[:style] = "font-size:large;"
          when "6"
            tmp.first[:style] = "font-size:x-large;"
          when "7"
            tmp.first[:style] = "font-size:xx-large;"
          else
            tmp.first[:style] = "font-size:x-small;"
          end
          element.swap(tmp.to_html)
        end
      end
      html
    end

    def self.convert_align_to_css(html)
      html.search("div").each do |element|
        if element[:align]
          str = "<div>#{element.inner_html}</div>"
          tmp = Nokogiri.HTML(str).search "div"

          tmp.first[:style] = "text-align:#{element[:align]};"
          element.swap(tmp.to_html)
        end
      end
      html
    end

    def self.convert_blink_to_css(html)
      html.search("blink").each do |element|
        element.swap('<span style="text-decoration:blink;">' + element.inner_html + '</span>')
      end
      html
    end

    def self.convert_marquee_to_css(html)
      html.search("marquee").each do |element|
        if element[:behavior] == "scroll"
          element.swap('<div style="display:-wap-marquee;-wap-marquee-loop:infinite;">' + element.inner_html + '</div>')
        elsif element[:behavior] == "alternate"
          element.swap('<div style="display:-wap-marquee;-wap-marquee-style:alternate;-wap-marquee-loop:infinite;">' + element.inner_html + '</div>')
        else
          element.swap('<div style="display:-wap-marquee;-wap-marquee-loop:infinite;">' + element.inner_html + '</div>')
        end
      end
      html
    end
  end
end
