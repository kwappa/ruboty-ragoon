require 'ragoon'
require 'ruboty'
require 'ruboty/handlers/ragoon'
require 'ruboty/ragoon/template'
require 'ruboty/ragoon/event'
require 'ruboty/ragoon/version'
require 'tilt'
require 'tilt/erb'

TEMPLATE_DIR = File.join(File.dirname(File.expand_path(__FILE__)), '..', '..', 'templates')
