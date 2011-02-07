# coding: utf-8

require 'rubygems'
require 'bundler'
require 'nkf'

ENV['BUNDLER_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
Bundler.setup
Bundler.require

require File.expand_path('../../lib/decoration_mail', __FILE__)
