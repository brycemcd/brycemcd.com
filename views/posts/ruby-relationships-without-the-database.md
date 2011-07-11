I've been working on scaling a pretty small application that gets a ton of traffic. It an app that gets a lot of reads and writes all at the same time. The app is in that uncomfortable place where distributing the load across multiple servers is overkill yet the load on the single server is getting too high. The client doesn't want to pay for multiple servers so thus an engineering challenge presented itself.

Inspired by <a href="http://railscasts.com/episodes/193-tableless-model">Ryan Bate's great screencast on tableless model'</a>s, I got to thinking: What data is being read a lot that doesn't change much? In the solution I present here, it's key that this will really only work for a read intensive table or relationship that rarely, if ever, gets written to.

For a contrived example, let's pretend that we have a big building with a few ballrooms. The building's ballrooms don't ever change. Each ballroom has an assigned number of tables that may move around in the ballroom, but they're pretty much always there. Each table has a ton of chairs that cycle in and out of the ballroom. Further more, the chairs are cheap and get replaced fortnightly. Chairs are being re-assigned to table at a rate of 2000 - 3000 times pre minute (this is a cool ballroom).

Rather than create a Ballroom model, which would make all the sense in the world, I created a Ballroom class and hand coded the relationship to the tables thusly:
<script src="https://gist.github.com/1048132.js?file=ballroom.rb"></script>
<noscript>class Ballroom

  # returns an array of all the ballroom titles
  def self.all_titles
    tables.collect { |x| x[0] }
  end

  # returns an array of table ids.
  def self.get(table)
    tables[table]
  end

  private

  # this is a listing of all the ballrooms by name. This is quite manual but since this data never changes, we're okay
  def self.districts
    #works like this:
    # "ballroom title" =&gt; [table1.id, table2.id ... tablen.id]
    {
      "The Grand Room" =&gt;  (1..20).map,
      "Crystal Ballroom" =&gt; [21, 22],
      "Emerald Ballroom" =&gt; [23, 24, 25]
    }
  end
end</noscript>
I don't think I can stress enough how this will only work for extremely static data. But here, I've created the listing of three ballrooms and hand coded the array of table ids (the primary key for the tables db table).

To quickly get all the chairs in the one ballroom, I created a named_scope in the chair's model:

<script src="https://gist.github.com/1048132.js?file=chairs.rb"></script>
<noscript>class Chairs &lt;&lt; ActiveRecord::Base     named_scope :chairs_in_ballroom, lambda { |table_ids|           { :conditions =&gt; ["table_id IN (?)", table_ids] }
     }
end</noscript>
And that's it. Just call:
<pre lang="ruby">   Chair.chairs_in_ballroom( Ballroom.get("Emerald Ballroom") )</pre>
To get an array of all chairs in the single ballroom. For me, it took several queries down to one. It had the added benefit of saving some disk I/O and helped scale the application at least a little. It's not my favorite solution, but it certainly helped for this particular case.
