# coding: utf-8

require 'rubygems'
require 'bundler'

ENV['BUNDLER_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
Bundler.setup
Bundler.require

require File.expand_path('../../lib/decoration_mail', __FILE__)

RSpec::Matchers.define :be_converted_to do |expected|
  match do |actual|
    convert(actual) == expected
  end

  failure_message_for_should do
    <<-MESSAGE
expected #{expected}
     got #{convert(actual)}
    MESSAGE
  end

  def convert(str)
    DecorationMail::HTML.new(str).to_s
  end
end
