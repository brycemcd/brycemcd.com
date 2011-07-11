A little while ago, I posted some javascript for a mootools content slider. I’ve used it a lot in my own [Ruby on Rails]("http://www.rubyonrails.org") and [ PHP ](http://www.php.net) development work and my work with [jv2](http://www.jv2.com) I have been itching to just drop it into my code like Squeezebox or Swfobject.

So, here it is, a fairly beta version of a horizontal content slider written with the Mootools 1.2 framework. Simply download (or copy and paste) the ContentSlider class into your page and then instantiate with the required arguments.


Usage Example:

####the ContentSlider class
<script src="https://gist.github.com/1063973.js?file=contentslider.js"></script>
<noscript>
/**
 * Content Slider - A Useable Horizontal Scroller
 *
 *  Requires a parent element with hidden overflow and child elements floated inside the parent.
 *  Take any two elements as previous and next buttons and scolls the child elements through the parent element
 *
 * Dependencies: MooTools 1.2 (and probably 1.1.x but not tested)
 *
 * adapted from Antonio Lupetti's original blog post at
 *    http://woork.blogspot.com/2009/01/elegant-animated-weekly-timeline-for.html
 *
 * @version       0.9
 *
 * @license     MIT-style license
 * @author     Bryce McDonnell bryce {at} bridgetownint {dot} com   www.brycemcdonnell.com
 * @copyright Bryce McDonnell
 */
var ContentSlider = new Class({
config: {
totIncrement: 0,
increment: 0,
maxRightIncrement: 0,
container: $empty,
slidingEl: "",
slideAtATime: 1,
previous_btn: $empty,
next_btn: $empty,
duration: 1000,
transition: Fx.Transitions.Back.easeInOut
},

initialize: function(config) {

this.config = $merge(this.config, config);

this.config.maxRightIncrement = this.config.increment * -( ( $$(this.config.slidingEl).length / this.config.slideAtATime) - 1 );
if (this.config.previous_btn &amp;&amp; this.config.next_btn) {
this.activateMoveBtns();
};

return this.config
},

move: function() {
          this.config.fx = new Fx.Tween(this.config.container, {
property: 'margin-left',
duration: this.config.duration,
transition: this.config.transition,

onStart: function() {
this.config.previous_btn.removeEvents('click');
this.config.next_btn.removeEvents('click');
}.bind(this),

onComplete: function() {
this.activateMoveBtns();
}.bind(this)

});
},

activateMoveBtns: function() {
                      //Next Button
                      this.config.next_btn.addEvents({
                              'click' : function(event){
                              this.config.totIncrement = (this.config.totIncrement&gt;this.config.maxRightIncrement) ? this.config.totIncrement - this.config.increment : 0;
                              event.stop();
                              this.move();
                              this.config.fx.start(this.config.totIncrement);
                              }.bind(this)

                              });

                      //Previous Button
                      this.config.previous_btn.addEvents({
                              'click' : function(event){
                              this.move();
                              event.stop();
                              this.config.totIncrement = (this.config.totIncrement &lt; 0) ? this.config.totIncrement + this.config.increment : this.config.maxRightIncrement;
                              this.config.fx.start(this.config.totIncrement);
                              }.bind(this)

                              });
                  }
});
ContentSlider.extend(new Fx.Tween);
</noscript>

####html markup

<script src="https://gist.github.com/1063973.js?file=index.html"></script>
<noscript>
<script src="/lib/js/homeslider.js" type="text/javascript"><!--mce:0--></script>
<div id="worksamples" class="slide-box">
<a id="slide-left" class="slider-arrows"> previous </a>
<a id="slide-right" class="slider-arrows">next</a>
<div id="workimgs">
<ul id="slider-list">
<li><img class="aligncenter size-full wp-image-168" title="BME logo small" src="http://blog.thedevranch.net/wp-content/uploads/2009/05/BME-logo-small.jpg" alt="BME logo small" width="300" height="405" /></li>
<li><img src="/lib/img/slide/img.jpg" alt="meth" width="292" height="184" /></li>
<li><img src="/lib/img/slide/img.jpg" alt="nuskin" width="292" height="184" /></li>
<li><img src="/lib/img/slide/img.jpg" alt="choice" width="292" height="184" /></li>
<li><img src="/lib/img/slide/img.jpg" alt="meth" width="292" height="184" /></li>
<li><img src="/lib/img/slide/img.jpg" alt="nuskin" width="292" height="184" /></li>
<li><img src="/lib/img/slide/img.jpg" alt="choice" width="292" height="184" /></li>
</ul>
</div>
</div>
</noscript>

####the javascript

<script src="https://gist.github.com/1063973.js?file=invocation.js"></script>
<noscript>
new ContentSlider({
increment: 904,
container: $("slider-list"),
slidingEl: "#slider-list li",
slideAtATime: 3,
next_btn: $("slide-right"),
previous_btn: $("slide-left")
});
</noscript>

####the css markup:
<script src="https://gist.github.com/1063973.js?file=application.css"></script>
<noscript>
/***  SLIDER   ***/
#worksamples {
    width:960px;
height:180px;
}
#workimgs{
width:900px;
overflow:auto;
overflow:hidden;
height:200px;
margin:0 auto;
}
#slider-list{
width:20000px;
margin:0;
padding:0;
left:400px;
}
#slider-list li{
    list-style:none;
margin:0;
       margin-right:5px;
padding:2px;
float:left;
width:292px;
height:200px;
}
.slider-arrows {
display:block;
width:18px;
height:42px;
       text-indent:-9999px;
overflow:hidden;
         margin-top:74px;
cursor:pointer;
}
#slide-left {
float:left;
background:url(../img/left-arrow.png) no-repeat !important;
background:url(../img/left-arrow.gif) no-repeat;
}
#slide-right {
float:right;
background:url(../img/right-arrow.png) no-repeat !important;
background:url(../img/right-arrow.gif) no-repeat;

}
</noscript>

####Explanation:

This serves as a pretty rudimentary example. The markup is simply a list with containing images that need scrolling. For the next and previous buttons, I got creative and got rid of the text and set an image for the background. That provides a good looking UI to the user.

Usage requires two basic elements: a container and child elements to scroll through. The parent should hide all overflow and the child elements should float so as to be one long horizontal array of scrolling elements. Simply include the class on any page and then instantiate the class passing in the required arguments.

####Arguments:

increment : the number of pixels the container should scoll. You could call $(”inner-el”).width here if you want to just scroll one element. I’m working on eliminating this requirement and instead just calculating it using the other arguments passed in.

container: A reference to the parent element with hidden overflow

slidingEl: collection of elements to scroll horizontally. Can be a css selector object

slideAtATime: an integer passed in to indicate how many child elements to scroll at when either the previous or next buttons are pushed. defaults to 1

next_btn: a reference to the element to scroll to the right. A click event is added to this element when the class is instantiated

previous_btn: a reference to the element to scroll to the right. A click event is added to this element when the class is instantiated

####Closing:

Happy MooTool’ing ! Be sure to post a comment if you see something wrong or would like to add to this.
