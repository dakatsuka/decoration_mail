# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'mail'
require 'nokogiri'
require 'nkf'

require 'decoration_mail/base'
require 'decoration_mail/message'

Mail::Message.send :include, DecorationMail::Message
