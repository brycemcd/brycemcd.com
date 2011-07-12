// some js should go here. This comment makes sure git notices this file
function get_tweets(){
    $.ajax({
        url: "https://api.twitter.com/1/statuses/user_timeline.json?screen_name=brycemcd&count=4",
    dataType: "jsonp",
    success: function(data){
        $.each(data, function(index, tweet ){
            $("div#twitter").append("<div class='tweet'>"+ tweet.text +"</div>");
        })
    }
    });
}

function get_comments(hashtag){
    $.ajax({
        url: "http://search.twitter.com/search.json?q=%23" + hashtag,
        dataType: "jsonp",
        success: function(data){
            if( data.results.length > 0 ) {
                $.each(data.results, function(index, tweet ){
                    $("div#comments").append("<div class='comments_post'><span class='commenter'><img src='"+tweet.profile_image_url+"' alt='@"+tweet.from_user+"'s picture' title='@"+tweet.from_user+"' class='avatar' /> <a href='http://www.twitter.com/"+tweet.from_user+"'>@"+tweet.from_user+"</a> <br /> "+ tweet.text +"</div>");
                })
            } else {
                    $("div#comments").append("<div class='comment'><strong><a href='https://twitter.com/share?text=%23"+hashtag+" ' title='comment on this post at twitter' data-text=' ' target='_blank'>Comment via twitter</a> </strong></div>");
            }    
        }
    });
}

function get_photos(){
    $.ajax({
        url: "/photos",
    success: function(data){
        $.each(data, function(index, photo ){
            $("div#flickr").append("<img src='"+ photo.thumbnail_3 +"' alt='cell phone imagry' />");
        })
    }
    });
}
