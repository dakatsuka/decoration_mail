# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe DecorationMail::Base do
  before {
    @mail = Mail.read(File.expand_path('../../resources/docomo_decoration_with_attachment.eml', __FILE__))
    @deco = @mail.decoration
  }

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
      Hpricot.parse(html).search("div").should_not be_empty
    end

    it "HTMLにはHTMLタグが含まれない" do
      html = subject.save do |image|
      end
      Hpricot.parse(html).search("html").should be_empty
    end

    it "HTMLにはHEADタグが含まれない" do
      html = subject.save do |image|
      end
      Hpricot.parse(html).search("head").should be_empty
    end

    it "HTMLにはBODYタグが含まれない" do
      html = subject.save do |image|
      end
      Hpricot.parse(html).search("body").should be_empty
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
