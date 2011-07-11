require 'rubygems'
require 'sinatra'
require 'rdiscount'

Sinatra::Application.set(:run, false)
Sinatra::Application.set(:environment, :development)
Sinatra::Application.set(:markdown, :layout_engine => :erb)
require 'brycemcd'
run Sinatra::Application
