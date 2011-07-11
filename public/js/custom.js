
	
	// Zomm effect
    $(document).ready(function(){
								   	
		$('.list_blocks li').hover(function(){
			$(this).find('div').css({
				visibility: 'visible',
				display: 'none'
			}).fadeIn('1000');
		},
		function(){
			$(this).find('div').css({
				visibility: 'hidden'
			}).fadeIn('1000');
		});
     });
	
	// Fade loading images
	$(document).ready(function(){
		$(".fade").fadeTo(1, 0);
	});
	
	$(window).load(function(){
		$(".fade").fadeTo("slow", 1);
	});

	// TWITTER DISPLAY // 
    getTwitters('deadTweets', {
        id: 'Devilcantburn', 
        prefix: '',  // If you want display your avatar and name <img height="16" width="16" src="%profile_image_url%" /><a href="http://twitter.com/%screen_name%">%name%</a> said:<br/>
        clearContents: false, // leave the original message in place
        count: 1, 
        withFriends: true,
        ignoreReplies: false,
        newwindow: true
    });