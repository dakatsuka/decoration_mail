# coding: utf-8
$:.unshift(File.dirname(__FILE__))

require 'mail'
require 'hpricot'
require 'nkf'

require 'decoration_mail/converter'
require 'decoration_mail/base'
require 'decoration_mail/message'

Mail::Message.send :include, DecorationMail::Message
