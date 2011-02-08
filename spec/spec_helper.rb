# coding: utf-8

require 'rubygems'
require 'bundler'

ENV['BUNDLER_GEMFILE'] = File.expand_path('../../Gemfile', __FILE__)
Bundler.setup
Bundler.require
