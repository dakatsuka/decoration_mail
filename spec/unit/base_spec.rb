# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe DecorationMail::Base do
  context "when subject is blank" do
    before do
      @mail = Mail.read(File.expand_path('../../resources/docomo_decoration_with_attachment.eml', __FILE__))
      @mail.subject = nil
    end
    subject { @mail.decoration }
    its(:subject) { should be_nil }
  end

  context "received DoCoMo" do
    before do
      @mail = Mail.read(File.expand_path('../../resources/docomo_decoration_with_attachment.eml', __FILE__))
      @deco = @mail.decoration
    end

    subject { @deco }

    it { should have(7).images }
    its(:subject) { should eql @mail.subject }

    context "using save method" do
      it "ブロック付きで呼び出すべき" do
        lambda { subject.save }.should raise_error(ArgumentError)
      end

      it "ブロック変数はDecorationMail::Imageのインスタンスであるべき" do
        images = []
        subject.save do |image|
          images << image
        end
        images.first.should be_instance_of DecorationMail::Image
      end

      it "HTMLが返るべき" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("div").should_not be_empty
      end

      it "HTMLにはHTMLタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("html").should be_empty
      end

      it "HTMLにはHEADタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("head").should be_empty
      end

      it "HTMLにはBODYタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("body").should be_empty
      end

      it "ブロック変数にパスを渡すとIMGタグのSRCが書き換わるべき" do
        html = subject.save do |image|
          image.path = "http://exmaple.com"
        end
        html.should match /http:\/\/exmaple\.com/
      end

      it "other_imagesオプションで:topを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :top) {}
        html.should match /20110205153513\.jpg/
      end

      it "other_imagesオプションで:bottomを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :bottom) {}
        html.should match /20110205153513\.jpg/
      end
    end
  end

  context "received au" do
    before do
      @mail = Mail.read(File.expand_path('../../resources/au_decoration_with_attachment.eml', __FILE__))
      @deco = @mail.decoration
    end

    subject { @deco }

    it { should have(4).images }
    its(:subject) { should eql @mail.subject }

    context "using save method" do
      it "ブロック付きで呼び出すべき" do
        lambda { subject.save }.should raise_error(ArgumentError)
      end

      it "ブロック変数はDecorationMail::Imageのインスタンスであるべき" do
        images = []
        subject.save do |image|
          images << image
        end
        images.first.should be_instance_of DecorationMail::Image
      end

      it "HTMLが返るべき" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("div").should_not be_empty
      end

      it "HTMLにはHTMLタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("html").should be_empty
      end

      it "HTMLにはHEADタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("head").should be_empty
      end

      it "HTMLにはBODYタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("body").should be_empty
      end

      it "ブロック変数にパスを渡すとIMGタグのSRCが書き換わるべき" do
        html = subject.save do |image|
          image.path = "http://exmaple.com"
        end
        html.should match /http:\/\/exmaple\.com/
      end

      it "other_imagesオプションで:topを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :top) {}
        html.should match /100503_1507~01\.jpg/
      end

      it "other_imagesオプションで:bottomを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :bottom) {}
        html.should match /100503_1507~01\.jpg/
      end
    end
  end

  context "received Softbank" do
    before do
      @mail = Mail.read(File.expand_path('../../resources/softbank_decoration_with_attachment.eml', __FILE__))
      @deco = @mail.decoration
    end

    subject { @deco }

    it { should have(9).images }
    its(:subject) { should eql @mail.subject }

    context "using save method" do
      it "ブロック付きで呼び出すべき" do
        lambda { subject.save }.should raise_error(ArgumentError)
      end

      it "ブロック変数はDecorationMail::Imageのインスタンスであるべき" do
        images = []
        subject.save do |image|
          images << image
        end
        images.first.should be_instance_of DecorationMail::Image
      end

      it "HTMLが返るべき" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("div").should_not be_empty
      end

      it "HTMLにはHTMLタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("html").should be_empty
      end

      it "HTMLにはHEADタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("head").should be_empty
      end

      it "HTMLにはBODYタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("body").should be_empty
      end

      it "ブロック変数にパスを渡すとIMGタグのSRCが書き換わるべき" do
        html = subject.save do |image|
          image.path = "http://exmaple.com"
        end
        html.should match /http:\/\/exmaple\.com/
      end

      it "other_imagesオプションで:topを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :top) {}
        html.should match /P1000043\.JPG/
      end

      it "other_imagesオプションで:bottomを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :bottom) {}
        html.should match /P1000043\.JPG/
      end
    end
  end

  context "recieve HTML Mail" do
    before do
      @mail = Mail.read(File.expand_path('../../resources/other_decoration.eml', __FILE__))
      @deco = @mail.decoration
    end

    subject { @deco }
    it { should have(7).images }

    context "using save method" do
      it "ブロック付きで呼び出すべき" do
        lambda { subject.save }.should raise_error(ArgumentError)
      end

      it "ブロック変数はDecorationMail::Imageのインスタンスであるべき" do
        images = []
        subject.save do |image|
          images << image
        end
        images.each {|image| image.should be_instance_of DecorationMail::Image }
      end

      it "HTMLが返るべき" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("div").should_not be_empty
      end

      it "HTMLにはHTMLタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("html").should be_empty
      end

      it "HTMLにはHEADタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("head").should be_empty
      end

      it "HTMLにはBODYタグが含まれない" do
        html = subject.save do |image|
        end
        Nokogiri.parse(html).search("body").should be_empty
      end

      it "ブロック変数にパスを渡すとIMGタグのSRCが書き換わるべき" do
        html = subject.save do |image|
          image.path = "http://exmaple.com"
        end
        html.should match /http:\/\/exmaple\.com/
      end

      it "other_imagesオプションで:topを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :top) {}
        html.should match /20110205153513\.jpg/
      end

      it "other_imagesオプションで:bottomを指定すると添付画像をデコメ上部に貼り付ける" do
        html = subject.save(:other_images => :bottom) {}
        html.should match /20110205153513\.jpg/
      end
    end
  end
end
