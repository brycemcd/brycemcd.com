##Thoughts on Developing

As I grow as a professional, I often find significant philosophical differences between me and other developers. In an effort to help you get to know me better, I thought I’d outline a few of those philosophies here.

###There Are No HTML/CSS Programmers

Markup languages are not programming languages. They can’t do math and neither can be written to create more of their own code. I’ve met a few people in my years of experience who have described themselves as HTML and/or CSS programmers. These developers have usually turned out to be disasters on my team. Overwriting changes on production servers, bloated markup and wonky css are just a few of the frustrations experienced with these lower level developers.

I don’t mean to disrespect other developers at all. I consider it a starting point for developers to get a strong command for html markup. Like good writers, I require anyone working on my sites to use only the markup required and take everything else away. It makes for a good looking site that is quick to load in the browser and simple to make updates to six months later.

HTML and CSS are also languages that developers and designers can unite over. Both designers and developers should have a strong sense of how to create good markup and style since it is one of the few things that overlap each others’ talents. So, while CSS and HTML are markup languages, they are not programming languages and both designers and developers should be rock solid on both before moving on to more advanced languages.

###Just Making It Work Is Dumb

So many times I meet developers who have created superfluous html markup or javascript because they’ve hacked together a solution. A hacked solution is a bad solution. When we come back to that solution in six months, the process for arriving at that solution has long been forgotten and we spend way too much extra time just trying to figure out what we were thinking when we created the hack.

It should work, but it should work in a way that is not hacked together and makes sense now … and in six months when we need to make edits.

###The Best Solution Is The Simplest Solution

This may be redundant, but I think the approach to software design as an engineer is very personal. Just like I don’t like a lot of extraneous markup, I also like to limit the number of moving parts in an application. Keeping as much logic in a single language for example helps to create an overall simplicity to the project.

Take, for example, an application written in Ruby, using MySQL and Apache for data storage and web serving respectively. Say the application uses a lot of stored procedures or triggers in MySQL for some data processing. This could be done in the ruby application language, but for whatever reason, it was written in the MySQL framework. Now say the business has a compelling reason to leave MySQL and move to another RDMS. If the data processing had been written in Ruby instead of MySQL, then the port would be relatively simple and quarantined to only the database classes. Instead, new code must be written in the new RDMS language.

This example is fairly trivial but illustrates a point that I like to keep the engineering of an application simple so it can be nimble and respond to changes in business practices and usability.

###Source Control is a Must

I’ve led development on projects a few times and I’m always disappointed when other developers look at me blankly when I mention [git](http://www.github.com/brycemcd) or svn for source code management. For developers, their use is fairly intuitive. For projects, their use is a requirement. Source control makes sure that a group of developers and designers on a team do not overwrite each others changes and it provides a means to revert bad changes that inevitably make it into a staging or production environment. It’s also a great accountability tool to see which developers are contributing most to the source code.

Designers I’ve worked with often pick up how to use git or svn pretty quickly limiting disruptions in productivity and creating a secure, backed up, developing environment.

Beyond the benefits of automatic backup and accountability, source control also offers an easy way to scale web applications. When your site gets to the point that one server isn’t enough, source control allows for pushing changes in source code over multiple servers quickly.
