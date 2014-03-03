# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'mail'
require 'nokogiri'

require 'decoration_mail/base'
require 'decoration_mail/html'
require 'decoration_mail/image'
require 'decoration_mail/message'

Mail::Message.send :include, DecorationMail::Message
