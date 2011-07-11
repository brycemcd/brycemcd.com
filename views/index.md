## Hello world

this is kinda cool

now, here's a list:

+ one
+ two

<script src="https://gist.github.com/981513.js?file=gistfile1.rb"></script>
<noscript>
    class Person
            has_many :groups
            has_many :group_memberships, :foreign_key => "member_id", :through => :groups
            
            scope :owned_groups, where(:is_owner => true).joins(:group_memberships) # gets all groups where this person is owner
    end

    class Group_Membership
            belongs_to :member, :class_name => 'Person'
            belongs_to :group
            
            # note that these attributes need to be defined
            # is_owner (boolean)
            # member_approved (boolean)
            
            scope :requested, :where(:member_approved => false)
    end

    class Group
            belongs_to :person
            has_many :group_memberships
            has_many :members, :class_name => "Person", :through => "group_memberships", :foreign_key => "member_id"
    end
</noscript>
