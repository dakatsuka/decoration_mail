# coding: utf-8

module DecorationMail
  class HTML
    def initialize(str)
      @tree = Nokogiri.HTML(str)
      @unresolved_references = @tree.css('img').map{|img| img['src'] }
      raise ArgumentError, 'invalid HTML' if @tree.search("body").empty?

      convert_font_color_to_css
      convert_font_size_to_css
      convert_align_to_css
      convert_blink_to_css
      convert_marquee_to_css
    end

    def match(regexp)
      @tree.css('body').to_html =~ regexp
    end

    def append_img(src)
      @tree.css('body').children.after(%(<br /><div style="text-align:center;"><img src="#{src}" /></div>)) if src
    end

    def prepend_img(src)
      @tree.css('body').children.before(%(<div style="text-align:center;"><img src="#{src}" /></div><br />)) if src
    end

    def update_img_src(from, to)
      @unresolved_references.delete(from)
      @tree.css("img[src=\"#{from}\"]").each do |e|
        if to
          e['src'] = to
        else
          e.remove
        end
      end
    end

    def to_s
      remove_invalid_references
      to_div.to_html
    end

  private

    def to_div
      @tree.search('body').first.dup.tap do |body|
        body.name = 'div'
        bgcolor = body[:bgcolor]
        body.attributes.each{|k, v| body.remove_attribute k}
        body[:style] = "background-color:#{bgcolor};" if bgcolor
      end
    end

    def convert_font_color_to_css
      @tree.search("font").each do |element|
        if element[:color]
          str = "<span>#{element.inner_html}</span>"
          tmp = Nokogiri::HTML.fragment(str).search("span")
          tmp.first[:style] = "color:#{element[:color].downcase};"
          element.swap(tmp.to_html)
        end
      end
    end

    def convert_font_size_to_css
      @tree.search("font").each do |element|
        if element[:size]
          str = "<span>#{element.inner_html}</span>"
          tmp = Nokogiri::HTML.fragment(str).search("span")

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
    end

    def convert_align_to_css
      @tree.search("div").each do |element|
        if element[:align]
          str = "<div>#{element.inner_html}</div>"
          tmp = Nokogiri::HTML.fragment(str).search "div"

          tmp.first[:style] = "text-align:#{element[:align]};"
          element.swap(tmp.to_html)
        end
      end
    end

    def convert_blink_to_css
      @tree.search("blink").each do |element|
        element.swap('<span style="text-decoration:blink;">' + element.inner_html + '</span>')
      end
    end

    def convert_marquee_to_css
      @tree.search("marquee").each do |element|
        if element[:behavior] == "scroll"
          element.swap('<div style="display:-wap-marquee;-wap-marquee-loop:infinite;">' + element.inner_html + '</div>')
        elsif element[:behavior] == "alternate"
          element.swap('<div style="display:-wap-marquee;-wap-marquee-style:alternate;-wap-marquee-loop:infinite;">' + element.inner_html + '</div>')
        else
          element.swap('<div style="display:-wap-marquee;-wap-marquee-loop:infinite;">' + element.inner_html + '</div>')
        end
      end
    end

    def invalid_references
      @unresolved_references.reject do |src|
        %w(http https data).include? URI.parse(src).scheme
      end
    end

    def remove_invalid_references
      invalid_references.each do |src|
        @tree.css("img[src=\"#{src}\"]").each do |e|
          e.remove
        end
      end
    end
  end
end
