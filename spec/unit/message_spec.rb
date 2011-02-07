# coding: utf-8
require File.expand_path('../../spec_helper', __FILE__)

describe DecorationMail::Message do
  context "when decoration mail" do
    before  { @mail = Mail.read(File.expand_path('../../resources/docomo_decoration.eml', __FILE__)) }
    subject { @mail }
    its(:decoration_data) { should be_instance_of DecorationMail::Base }
  end

  context "when normal mail" do
    before  { @mail = Mail.new }
    subject { @mail }
    its(:decoration_data) { should be_nil }
  end
end
