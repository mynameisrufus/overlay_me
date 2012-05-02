
The original purpose of this tool is to help the developer to meet designers requirements by overlaying images on the page.

We were struggling to see the gap between designers photoshop files and our HTML/CSS implementation, the best way to figure it out was to load their rendered work in the page and play with opacity to see the differences, that's what this tool facilitate.

Features
--------
- images overlay with images position/opacity retention
- layout resizing (to switch between pre-recorded devices format)

see [screenshot](screenshot_frontfoot_website.jpg)

Todo
----
- add a way to dynamically add new images (by absolute url) to the overlay system
- images sub-sets (directories) should appear as nested blocks
- add some appealing screenshots on this repo :)

How to use
----------
- Load the compiled plugins.js

  * under a rails app:

      = javascript_include_tag 'webdev_toolbox/plugins.js'

  * or in a simpler project, (we are using [middleman](http://middlemanapp.com/))
  
      %script{ :src => '/javascripts/webdev_toolbox/plugins.js', :type => 'text/javascript', :charset => 'utf-8' }

- Initialise path variables and overlay images feed route:

  * rails

      #config/initializers/webdev_toolbox.rb
      
      WebdevToolbox.root_dir = Dir[Rails.root.join("public")].to_s
      WebdevToolbox.overlays_directory = 'images/dev_overlays' 

      #config/routes.rb

      if ["development", "test"].include? Rails.env
        match "/overlay_images" => WebdevToolbox::App
      end

  * using middleman, in config.rb:

      WebdevToolbox.root_dir = Dir.pwd + '/source'
      WebdevToolbox.overlays_directory = 'images/overlays'

      map "/overlay_images" do
        run WebdevToolbox::App
      end
  

- And add some images in that overlays directory !

Plug on!
--------
You can add some app specific menu for specific project.. Have a look at layout_resizer.coffee addon to have a quick view of how to use DevTools.Menu and DevTools.MenuItem
    
Known problems
--------------
- it's version 0.9 as checkboxes and localStorage retention may fail..
- the overlays management system needs your page content to be in a #content or #container div
- when you can't find the panel, it's maybe hidden aside (previous bigger screen location) or hidden (press 'H')
- not a big deal, I tried to bend middleman sprockets configuration to load the stylesheets into /assets but failed... so we try loading both path (see plugins.coffee)

