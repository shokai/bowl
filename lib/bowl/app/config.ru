require 'rubygems'
require 'rack'
require 'sinatra'
$stdout.sync = true if development?
require 'sinatra/reloader' if development?
require 'sinatra/content_for'
require 'sinatra/cometio'
require 'json'
require 'haml'
require 'sass'
require 'event_emitter'
require 'hashie'
require 'fileutils'
require File.dirname(__FILE__)+'/bootstrap'
Bootstrap.init :libs, :helpers, :controllers

set :haml, :escape_html => true

run Sinatra::Application
