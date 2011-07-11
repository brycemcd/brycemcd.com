## Custom Routes with Shoulda

   posted at: February 19th, 2010

   I’ve recently been using Shoulda as my testing framework of choice to speed up my Rspec test writing. One common pattern kept recurring
   which was totally vexing: I wasn’t able to test my custom routes. Just recently, I was writing a reviews controller that is mostly
   controlled by an admin user of the site. It’s logical to route the index request of the reviews controller to /admin.

   I kept trying to force the request with the following failing code:

<script src="https://gist.github.com/309123.js?file=wrong.rb"></script>
<noscript>
    #don't use this, it's bad
    #I want to reroute /reviews to /admin
    get "/admin"
</noscript>

   That was clearly wrong, but nothing immediately jumped out at me as to how to fix it. After much googling around, I finally found the quick and easy solution:

   [ruby code on github here](https://gist.github.com/309123)
<script src="https://gist.github.com/309123.js?file=review_controller_spec.rb"></script>
<noscript>
    describe "/admin" do
        before(:each){
            get :index
        }

        it { should route(:get, "/admin").to(:controller =>; :reviews, :action =>; :index) }
        it { should respond_with(:success) }
    end
</noscript>

   
Hope this saves someone else some time.

