# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe DecorationMail::Base do
  before {
    @mail = Mail.read(File.expand_path('../../resources/docomo_decoration.eml', __FILE__))
    @deco = @mail.decoration_data
  }

  context "using html method" do
    subject { @deco.html }
    it { should eql Nokogiri.parse(NKF.nkf("-w", @mail.html_part.body.to_s)).at('body').to_s }
  end
end
