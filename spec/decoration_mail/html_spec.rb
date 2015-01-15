# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)


describe DecorationMail::HTML do
  context "with invalid HTML" do
    it "raises ArgumentError" do
      lambda{ DecorationMail::HTML.new('') }.should raise_error ArgumentError
    end
  end

  describe "#match" do
    subject{ DecorationMail::HTML.new('<body bgcolor="#ffffff">ほげほげ</body>') }

    it "performs regexp matching within body" do
      subject.match(/ほげ/).should be_true
      subject.match(/#ffffff/).should be_true
      subject.match(/もげ/).should be_false
      subject.match(/html/).should be_false
    end
  end

  describe "#append_img" do
    subject{ DecorationMail::HTML.new('<body>ほげほげ</body>') }

    it "inserts img tag after the content" do
      subject.append_img('http://example.com/img.gif')
      subject.to_s.should == %(<div>ほげほげ<br><div style="text-align:center;"><img src="http://example.com/img.gif"></div>\n</div>)
    end

    context "when src is nil" do
      before{ subject.append_img(nil) }

      it "ignores the img" do
        subject.to_s.should == %(<div>ほげほげ</div>)
      end
    end
  end

  describe "#prepend_img" do
    subject{ DecorationMail::HTML.new('<body>ほげほげ</body>') }

    it "inserts img tag ahead of the content" do
      subject.prepend_img('http://example.com/img.gif')
      subject.to_s.should == %(<div>\n<div style="text-align:center;"><img src="http://example.com/img.gif"></div>\n<br>ほげほげ</div>)
    end

    context "when src is nil" do
      before{ subject.prepend_img(nil) }

      it "ignores the img" do
        subject.to_s.should == %(<div>ほげほげ</div>)
      end
    end
  end

  describe "#update_img_src" do
    subject{ DecorationMail::HTML.new('<body>ほげほげ<img src="cid:hoge"><img src="fuga.gif"></body>') }

    it "changes img's src to new one" do
      subject.update_img_src('cid:hoge', 'http://example.com/img.gif')
      subject.to_s.should == %(<div>ほげほげ<img src="http://example.com/img.gif">\n</div>)
    end

    context "when src is nil" do
      before{ subject.update_img_src('cid:hoge', nil) }

      it "deletes the img tag" do
        subject.to_s.should == %(<div>ほげほげ</div>)
      end
    end
  end

  describe "#to_s" do
    it "should convert body to div" do
      '<body>ほげほげ</body>'.should be_converted_to '<div>ほげほげ</div>'
    end

    context "with 'bgcolor' attribute" do
      it "should convert body to div and inline css" do
        '<body bgcolor="#ffffff">ほげほげ</body>'.
          should be_converted_to '<div style="background-color:#ffffff;">ほげほげ</div>'
      end
    end

    context "with 'onclick' attribute" do
      it "should not contain it" do
        '<body onclick="alert(\'a\')">ほげほげ</body>'.
          should be_converted_to '<div>ほげほげ</div>'
      end
    end

    context "when the html contains cid reference which is not resloved by #update_img_src" do
      subject{ DecorationMail::HTML.new('<body>ほげほげ<img src="cid:hoge"><img src="cid:fuga"></body>') }
      before do
        subject.update_img_src('cid:hoge', 'hoge.gif')
      end

      it "removes the img tag" do
        subject.to_s.should == %(<div>ほげほげ<img src="hoge.gif">\n</div>)
      end
    end

    context "when the html contains img tag whose src is relative path" do
      it "removes the img tag" do
        '<body>ほげほげ<img src="../hoge.gif" /></body>'.
          should be_converted_to '<div>ほげほげ</div>'
      end
    end

    context "when the html contains img tag whose src is absolute URI with file scheme" do
      it "removes the img tag" do
        '<body>ほげほげ<img src="file:///hoge.gif" /></body>'.
          should be_converted_to '<div>ほげほげ</div>'
      end
    end

    context "when the html contains img tag whose src is absolute URI with http scheme" do
      it "keeps the img tag" do
        '<body>ほげほげ<img src="http://example.com/hoge.gif" /></body>'.
          should be_converted_to %(<div>ほげほげ<img src="http://example.com/hoge.gif">\n</div>)
      end
    end

    context "when the html contains img tag whose src is absolute URI with https scheme" do
      it "keeps the img tag" do
        '<body>ほげほげ<img src="https://example.com/hoge.gif" /></body>'.
          should be_converted_to %(<div>ほげほげ<img src="https://example.com/hoge.gif">\n</div>)
      end
    end

    context "when the html contains img tag whose src is URI with data scheme" do
      it "keeps the img tag" do
        '<body>ほげほげ<img src="data:image/gif;base64,R0lG" /></body>'.
          should be_converted_to %(<div>ほげほげ<img src="data:image/gif;base64,R0lG">\n</div>)
      end
    end
  end

  describe "#convert_font_color_to_css" do
    it "should convert font to span and inline css" do
      '<body><font color="#ffffff">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="color:#ffffff;">ほげほげ</span></div>'
    end
  end

  describe "#convert_font_size_to_css" do
    it "should convert font(size=1) to span and inline css(xx-small)" do
      '<body><font size="1">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:xx-small;">ほげほげ</span></div>'
    end

    it "should convert font(size=2) to span and inline css(x-small)" do
      '<body><font size="2">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:x-small;">ほげほげ</span></div>'
    end

    it "should convert font(size=3) to span and inline css(small)" do
      '<body><font size="3">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:small;">ほげほげ</span></div>'
    end

    it "should convert font(size=4) to span and inline css(medium)" do
      '<body><font size="4">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:medium;">ほげほげ</span></div>'
    end

    it "should convert font(size=5) to span and inline css(large)" do
      '<body><font size="5">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:large;">ほげほげ</span></div>'
    end

    it "should convert font(size=6) to span and inline css(x-large)" do
      '<body><font size="6">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:x-large;">ほげほげ</span></div>'
    end

    it "should convert font(size=7) to span and inline css(xx-large)" do
      '<body><font size="7">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:xx-large;">ほげほげ</span></div>'
    end

    it "should convert font of invalid size to span and inline css(x-small)" do
      '<body><font size="10">ほげほげ</font></body>'.
        should be_converted_to '<div><span style="font-size:x-small;">ほげほげ</span></div>'
    end
  end

  describe "#convert_align_to_css" do
    context "when align is left" do
      it "should convert legacy attribute to inline css" do
        '<body><div align="left">ほげほげ</div></body>'.
          should be_converted_to '<div><div style="text-align:left;">ほげほげ</div></div>'
      end
    end

    context "when align is right" do
      it "should convert legacy attribute to inline css" do
        '<body><div align="right">ほげほげ</div></body>'.
          should be_converted_to '<div><div style="text-align:right;">ほげほげ</div></div>'
      end
    end

    context "when align is center" do
      it "should convert legacy attribute to inline css" do
        '<body><div align="center">ほげほげ</div></body>'.
          should be_converted_to '<div><div style="text-align:center;">ほげほげ</div></div>'
      end
    end
  end

  describe "#convert_blink_to_css" do
    it "should convert blink to span and inline css" do
      '<body><blink>ほげほげ</blink></body>'.
        should be_converted_to '<div><span style="text-decoration:blink;">ほげほげ</span></div>'
    end
  end

  describe "#convert_marquee_to_css" do
    context "when behavior is scroll" do
      it "should convert marquee to div and inline css" do
        '<body><marquee behavior="scroll">ほげほげ</marquee></body>'.
          should be_converted_to '<div><div style="display:-wap-marquee;-wap-marquee-loop:infinite;">ほげほげ</div></div>'
      end
    end

    context "when behavior is alternate" do
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
