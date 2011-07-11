module Helpers
    def titleize(string)
        string.gsub("-", " ").split(" ").map {|s| s.capitalize }.join(" ")
    end

    def recent_posts
        #Dir.entries("views/blog") - ["." , ".."]
        YAML::load( File.open( "config/blogs.yml" ) )
    end
end
