The original purpose of this tool is to help the developer to meet designers requirements by overlaying images on the page.

We were struggling to see the gap between designers photoshop files and our HTML/CSS implementation, the best way to figure it out was to load their rendered work in the page and play with opacity to see the differences, that's what this tool facilitate.


## Features

- overlay images over a web page saving their position/opacity locally (using HTML5 localStorage)
  - images can be loaded from a project local directory (see Project base use)
  - an image can be added on the fly with its absolute url
- bring back your HTML on top of the overlays (page content will need to be in a #container div)
  - control the opacity of the page content
  - keep on playing with the CSS while having with a visual overlay
- addon layout_resizer, to switch between pre-recorded devices format


## Use it now !

You can try it live on any site by loading the javascript on top of any page (a handy bookmarklet link is available [on this page](http://dev.frontfoot.com.au/overlay_me/demo_page.html)).


## Screenshot

![Screenshot](http://github.com/frontfoot/overlay_me/raw/master/screenshot_frontfoot_website.jpg)


## Todo

- content opacity
  - add parent container div dynamically (at the moment the toolbar is looking for a #content or #container element)

- overlays
  - overlay images sub-sets (sub-directories) should appear as nested blocks
  - make another version of the toolbar fixed on top of the screen
  - detail: make full cell clickable to switch image on/off (not only text)


## Usage

2 options for your project:

- The script is precompiled (overlay_me/load.js)
  - Add the minified load.js to your header

- The project is available as a Ruby gem, so if you too use bundler

    # Gemfile
    
    gem "overlay_me", :git => "git://github.com/frontfoot/overlay_me.git"


### Load the compiled load.js

under a rails app:

    = javascript_include_tag 'overlay_me/load.js'

or in a simpler project, (we are using [middleman](http://middlemanapp.com/))
  
    %script{ :src => '/javascripts/overlay_me/load.js', :type => 'text/javascript', :charset => 'utf-8' }

And that's it ! Reload your page :)


### Extended use - share overlay images to your work team, keep images sets per project

By default the script will try to load the list of images from /overlay_images

List your images in JSON, simply:

    [
      "/images/overlays/Home_1024r_1.png",
      "/images/overlays/Home_1100r_1.jpg",
      "/images/overlays/Home_1300r_1.png",
      "/images/overlays/Home_320r_1.jpg",
      "/images/overlays/Home_480r_1.png",
      "/images/overlays/Home_720r_1.png",
      "/images/overlays/Home_768r_1.png"
    ]

I made a simple Rack app to build that JSON list for you

Here is how to initialise the path and the feed route

using rails

    #config/initializers/overlay_me.rb

    if defined?(OverlayMe)
      OverlayMe.root_dir = Dir[Rails.root.join("public")].to_s
      OverlayMe.overlays_directory = 'images/overlays' 
    end

    #config/routes.rb

    if ["development", "test"].include? Rails.env
      match "/overlay_images" => OverlayMe::App
    end

using middleman

    #config.rb:
    
    OverlayMe.root_dir = Dir.pwd + '/source'
    OverlayMe.overlays_directory = 'images/overlays'

    map "/overlay_images" do
      run OverlayMe::App
    end



## Plug on!

You can add some app specific menu for specific project.. Have a look at layout_resizer.coffee addon to have a quick view of how to use OverlayMe.Menu and OverlayMe.MenuItem

    = javascript_include_tag 'overlay_me/addons/layout_resizer.js'

    

## Known problems

- the content management bit needs the page content to be in a #container div (will upgrade that soon)
- you can't find the panel? it's probably hidden aside (previous bigger screen location) or hidden (press 'H')
- you see the overlay but can't drag it? the 'Content on Top' option is probably on (press 'C')
- not a big deal: I tried to bend middleman sprockets configuration to load the stylesheets into /assets but failed... so we try loading both local paths for stylesheets (/assets/xx.css and /stylesheets/xx.css - see load.coffee)



## Contributors

- Rufus Post - former workmate who founded the ovelaying concept
- Joseph Boiteau - taking Rufus's idea to 11 (and loving it) - FrontFoot Media Solutions
- Lachlan Sylvester - Ruby advisor - Frontfoot Media Solutions
- Dan Smith - User Experience Strategist and Califloridian - FrontFoot Media Solutions

