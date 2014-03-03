# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe DecorationMail::Image do
  before {
    @mail = Mail.read(File.expand_path('../../resources/docomo_decoration_with_attachment.eml', __FILE__))
    @deco = @mail.decoration

    images = []
    @deco.save {|image| images << image}
    @image = images.first
  }

  subject { @image }

  it { should respond_to :path }
  it("have the same content with attached file"){ subject.read.should eql @mail.attachments.first.decoded }
  its(:content_id) { should eql "cid:01@110207.142735@______F03B@docomo.ne.jp" }
  its(:filename) { should eql "06_gochisou_header.gif" }
  its(:extension) { should eql "gif" }
  its(:src) { should eql "06_gochisou_header.gif" }

  context "when path is given" do
    before { @image.path = 'http://example.com/image.gif' }

    its(:src) { should eql 'http://example.com/image.gif' }
  end
end
