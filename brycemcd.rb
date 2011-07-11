require "classes/helpers"
require 'classes/string'
require 'httparty'
require 'picasa'
require 'json'
helpers { include Helpers }

get '/' do
  erb :index, :layout => :home_layout
end

get "/portfolio" do
    @title = "Portland, Oregon Developer Ruby on Rails Portfolio for Bryce McDonnell"
    @post = {}
    @post['title'] = "Portfolio"
    @post['date_published'] = "07/10/2011"
    markdown :portfolio
end

get "/photos" do
    content_type 'application/json'
    @photos = Picasa.photos(:google_user => "brycebrycebaby", :album_id => "5625352816807757329")[:photos]
   JSON.generate( @photos[0..7] )
end

get "/:page" do
    @title = File.basename( File.join(__FILE__, "views", "posts", params[:page]) )
    @all_posts = recent_posts
    @post = @all_posts.select { |x| x["title"] =~ /#{@title.titleize}/i }.first
    markdown "posts/#{params[:page]}".to_sym
end
