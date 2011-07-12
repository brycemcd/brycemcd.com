require "classes/helpers"
require 'classes/string'
require 'httparty'
require 'picasa'
require 'json'
require 'builder'
require 'redis'
$redis = Redis.new

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
    json = $redis.get "photos"
    unless json
        @photos = Picasa.photos(:google_user => "brycebrycebaby", :album_id => "5625352816807757329")[:photos]
        
        json = JSON.generate( @photos[0..7] )
        $redis.set "photos", json
        $redis.expire "photos", 5.days.from_now
    end
    json
end

get "/sitemap.xml" do
    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct!
    xml.urlset "xmlns:xsi" =>"http://www.w3.org/2001/XMLSchema-instance" , "xsi:schemaLocation" => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd", "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9"  do
        recent_posts.each do |post|
            xml.url do
                xml.loc "http://www.brycemcdonnell.com/#{post["title"].reverse_titleize}"
                xml.lastmod Time.parse(post["date_published"]).iso8601
                xml.changefreq "monthly"
                xml.priority "0.2"
            end
        end
    end
end

get "/:page" do
    @title = File.basename( File.join(__FILE__, "views", "posts", params[:page]) )
    @all_posts = recent_posts
    @post = @all_posts.select { |x| x["title"] =~ /#{@title.titleize}/i }.first
    markdown "posts/#{params[:page]}".to_sym
end
