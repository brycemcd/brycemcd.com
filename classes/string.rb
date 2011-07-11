class String
    def reverse_titleize
        self.split(" ").map {|s| s.downcase }.join("-")
    end

    def titleize
        self.gsub("-", " ").split(" ").map {|s| s.capitalize }.join(" ")
    end

    def post_date
        Time.parse( self ).strftime("%A, %B %d, %Y")
    end
end
