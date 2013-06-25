# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)


describe DecorationMail::Converter do
  describe "body tag" do
    it "should convert body to div" do
      '<body>ほげほげ</body>'.should be_converted_to '<div>ほげほげ</div>'
    end

    context "with bgcolor" do
      it "should convert body to div and inline css" do
        '<body bgcolor="#ffffff">ほげほげ</body>'.
          should be_converted_to '<div style="background-color:#ffffff;">ほげほげ</div>'
      end
    end

    context "with onclick" do
      it "should convert body to div and inline css" do
        '<body onclick="alert(\'a\')">ほげほげ</body>'.
          should be_converted_to '<div>ほげほげ</div>'
      end
    end
  end

  describe "font tag" do
    context "color" do
      it "should convert font to span and inline css" do
        '<body><font color="#ffffff">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="color:#ffffff;">ほげほげ</span></div>'
      end
    end

    context "size = 1" do
      it "should convert font to span and inline css (xx-small)" do
        '<body><font size="1">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:xx-small;">ほげほげ</span></div>'
      end
    end

    context "size = 2" do
      it "should convert font to span and inline css (x-small)" do
        '<body><font size="2">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:x-small;">ほげほげ</span></div>'
      end
    end

    context "size = 3" do
      it "should convert font to span and inline css (small)" do
        '<body><font size="3">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:small;">ほげほげ</span></div>'
      end
    end

    context "size = 4" do
      it "should convert font to span and inline css (medium)" do
        '<body><font size="4">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:medium;">ほげほげ</span></div>'
      end
    end

    context "size = 5" do
      it "should convert font to span and inline css (large)" do
        '<body><font size="5">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:large;">ほげほげ</span></div>'
      end
    end

    context "size = 6" do
      it "should convert font to span and inline css (x-large)" do
        '<body><font size="6">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:x-large;">ほげほげ</span></div>'
      end
    end

    context "size = 7" do
      it "should convert font to span and inline css (xx-large)" do
        '<body><font size="7">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:xx-large;">ほげほげ</span></div>'
      end
    end

    context "size = 10 (invalid value)" do
      it "should convert font to span and inline css (x-small)" do
        '<body><font size="10">ほげほげ</font></body>'.
          should be_converted_to '<div><span style="font-size:x-small;">ほげほげ</span></div>'
      end
    end
  end

  describe "div tag" do
    context "align = left" do
      it "should convert legacy attribute to inline css" do
        '<body><div align="left">ほげほげ</div></body>'.
          should be_converted_to '<div><div style="text-align:left;">ほげほげ</div></div>'
      end
    end

    context "align = right" do
      it "should convert legacy attribute to inline css" do
        '<body><div align="right">ほげほげ</div></body>'.
          should be_converted_to '<div><div style="text-align:right;">ほげほげ</div></div>'
      end
    end

    context "align = center" do
      it "should convert legacy attribute to inline css" do
        '<body><div align="center">ほげほげ</div></body>'.
          should be_converted_to '<div><div style="text-align:center;">ほげほげ</div></div>'
      end
    end
  end

  describe "blink tag" do
    it "should convert blink to span and inline css" do
      '<body><blink>ほげほげ</blink></body>'.
        should be_converted_to '<div><span style="text-decoration:blink;">ほげほげ</span></div>'
    end
  end

  describe "marquee tag" do
    context "behavior = scroll" do
      it "should convert marquee to div and inline css" do
        '<body><marquee behavior="scroll">ほげほげ</marquee></body>'.
          should be_converted_to '<div><div style="display:-wap-marquee;-wap-marquee-loop:infinite;">ほげほげ</div></div>'
      end
    end

    context "behavior = alternate" do
      it "should convert marquee to div and inline css" do
        '<body><marquee behavior="alternate">ほげほげ</marquee></body>'.
          should be_converted_to '<div><div style="display:-wap-marquee;-wap-marquee-style:alternate;-wap-marquee-loop:infinite;">ほげほげ</div></div>'
      end
    end

    context "without attribute" do
      it "should convert marquee to div and inline css" do
        '<body><marquee>ほげほげ</marquee></body>'.
          should be_converted_to '<div><div style="display:-wap-marquee;-wap-marquee-loop:infinite;">ほげほげ</div></div>'
      end
    end
  end
end
