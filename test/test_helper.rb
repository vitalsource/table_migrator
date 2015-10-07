require 'rubygems'
require 'shoulda'
require 'shoulda/context'
require 'active_record'
require 'test/unit'

TEST_ROOT = File.expand_path(File.dirname(__FILE__))
PLUGIN_ROOT = File.expand_path(TEST_ROOT, '..')

$: << File.join(TEST_ROOT, 'lib')

load 'database.rb'

include Shoulda::Context::ClassMethods
