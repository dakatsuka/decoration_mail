# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)


describe DecorationMail::Converter do
  describe "body tag" do
    it "should convert body to div" do
      html = Hpricot.parse('<body>ほげほげ</body>')
      result = DecorationMail::Converter.convert_to_xhtml(html).to_html
      result.should eql '<div>ほげほげ</div>'
    end

    context "with bgcolor" do
      it "should convert body to div and inline css" do
        html = Hpricot.parse('<body bgcolor="#ffffff">ほげほげ</body>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="background-color:#ffffff;">ほげほげ</div>'
      end
    end
  end

  describe "font tag" do
    context "color" do
      it "should convert font to span and inline css" do
        html = Hpricot.parse('<font color="#ffffff">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="color:#ffffff;">ほげほげ</span>'
      end
    end

    context "size = 1" do
      it "should convert font to span and inline css (xx-small)" do
        html = Hpricot.parse('<font size="1">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:xx-small;">ほげほげ</span>'
      end
    end

    context "size = 2" do
      it "should convert font to span and inline css (x-small)" do
        html = Hpricot.parse('<font size="2">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:x-small;">ほげほげ</span>'
      end
    end

    context "size = 3" do
      it "should convert font to span and inline css (small)" do
        html = Hpricot.parse('<font size="3">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:small;">ほげほげ</span>'
      end
    end

    context "size = 4" do
      it "should convert font to span and inline css (medium)" do
        html = Hpricot.parse('<font size="4">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:medium;">ほげほげ</span>'
      end
    end

    context "size = 5" do
      it "should convert font to span and inline css (large)" do
        html = Hpricot.parse('<font size="5">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:large;">ほげほげ</span>'
      end
    end

    context "size = 6" do
      it "should convert font to span and inline css (x-large)" do
        html = Hpricot.parse('<font size="6">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:x-large;">ほげほげ</span>'
      end
    end

    context "size = 7" do
      it "should convert font to span and inline css (xx-large)" do
        html = Hpricot.parse('<font size="7">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:xx-large;">ほげほげ</span>'
      end
    end

    context "size = 10 (invalid value)" do
      it "should convert font to span and inline css (x-small)" do
        html = Hpricot.parse('<font size="10">ほげほげ</font>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<span style="font-size:x-small;">ほげほげ</span>'
      end
    end
  end

  describe "div tag" do
    context "align = left" do
      it "should convert legacy attribute to inline css" do
        html = Hpricot.parse('<div align="left">ほげほげ</div>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="text-align:left;">ほげほげ</div>'
      end
    end

    context "align = right" do
      it "should convert legacy attribute to inline css" do
        html = Hpricot.parse('<div align="right">ほげほげ</div>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="text-align:right;">ほげほげ</div>'
      end
    end

    context "align = center" do
      it "should convert legacy attribute to inline css" do
        html = Hpricot.parse('<div align="center">ほげほげ</div>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="text-align:center;">ほげほげ</div>'
      end
    end
  end

  describe "blink tag" do
    it "should convert blink to span and inline css" do
      html = Hpricot.parse('<blink>ほげほげ</blink>')
      result = DecorationMail::Converter.convert_to_xhtml(html).to_html
      result.should eql '<span style="text-decoration:blink;">ほげほげ</span>'
    end
  end

  describe "marquee tag" do
    context "behavior = scroll" do
      it "should convert marquee to div and inline css" do
        html = Hpricot.parse('<marquee behavior="scroll">ほげほげ</marquee>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="display:-wap-marquee;-wap-marquee-loop:infinite;">ほげほげ</div>'
      end
    end

    context "behavior = alternate" do
      it "should convert marquee to div and inline css" do
        html = Hpricot.parse('<marquee behavior="alternate">ほげほげ</marquee>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="display:-wap-marquee;-wap-marquee-style:alternate;-wap-marquee-loop:infinite;">ほげほげ</div>'
      end
    end

    context "without attribute" do
      it "should convert marquee to div and inline css" do
        html = Hpricot.parse('<marquee>ほげほげ</marquee>')
        result = DecorationMail::Converter.convert_to_xhtml(html).to_html
        result.should eql '<div style="display:-wap-marquee;-wap-marquee-loop:infinite;">ほげほげ</div>'
      end
    end
  end
end
