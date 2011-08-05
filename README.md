This is a VERY TEMPORARY AND EXPERIMENTAL rails 3.1 project.

I am using it to decide what changes I need to make to the sprite-factory
gem in upcoming v1.4.0 to make it fit better with the rails 3.1 asset pipeline

To use new version (1.4.0) of sprite-factory with rails 3.1 you should...

Add sprite-factory to your Gemfile
==================================

Plus its image library dependency (either rmagick or chunkypng)

    group :assets do
      # ...
      gem 'sprite-factory', '>= 1.4.0'
      gem 'chunky_png'
    end

Store sprite images in app/assets/images sub-folders
====================================================

E.g

    app/assets/images/avatars/*.png
    app/assets/images/icons/*.png
    ...

Create a Rake task for regenerating your sprites
================================================

E.g. in lib/tasks/assets.rake

    namespace :assets do

      desc 'recreate sprite images and css'
      task :resprite => :environment do 
        
        require 'sprite_factory'
        
        SpriteFactory.report  = true         # output report during generation
        SpriteFactory.library = :chunkypng   # use simple chunkypng gem to handle .png sprite generation
        SpriteFactory.layout  = :packed      # pack sprite sheets into optimized rectangles
        SpriteFactory.csspath = "<%= asset_path '$IMAGE' %>" #  ensure correct cache-busting urls are used within generated css file

        SpriteFactory.run!('app/assets/images/avatars', :output_style => 'app/assets/stylesheets/avatars.css.erb')
        SpriteFactory.run!('app/assets/images/icons',   :output_style => 'app/assets/stylesheets/icons.css.erb',  :selector => 'img.icon_')
      
      end

    end

>> NOTE: the :csspath option embeds erb into the generated css file to allow Rails to
   provide the correct path to the images, along with cache-busting version numbers
   if necessary.

>> NOTE: the :output_style option is used to override the default behavior and instead of
   generating the css file alongside the image, it saves it in the `app/assets/stylesheets` folder
   so that it will automatically get picked up by the rails asset pipeline. It is also given a
   .erb extension to tell the asset pipeline to process with ERB in order to evaluate the
   #asset_path calls. 

Add a #sprite_tag helper
========================

E.g. in application_helper.rb

    def sprite_tag(klass, options = {})
      image_tag('s.gif', {:class => klass, :alt => klass}.merge(options))
    end

Use the #sprite_tag helper
==========================

Somewhere in a view, lets show a sprite

    <%= sprite_tag('icon_email') %>
    <%= sprite_tag('avatar7')    %>

GO!
==

Run your rake task to generate the unified .png and .css files

    bundle exec rake assets:resprite

View your page in a browser

 * BOOYA!

