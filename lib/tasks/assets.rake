namespace :assets do

  desc 'recreate sprite images and css'
  task :resprite => :environment do 
    
    require 'sprite_factory'
    
    SpriteFactory.report  = true         # output report during generation
    SpriteFactory.library = :chunkypng   # use simple chunkypng gem to handle .png sprite generation
    SpriteFactory.layout  = :packed      # pack sprite sheets into optimized rectangles
    SpriteFactory.csspath = '/assets/'   # prepend background image urls with expected rails 3.1 path

    # In an ideal world, the output css file will be a .css.erb file so that we can do this:
    #
    #    SpriteFactory.csspath = "<%= asset_path '$IMAGE' %>"
    #
    # instead of hard coded prepend
    #
    #    SpriteFactory.csspath = "/assets/"
    #
    # ... but I'll need to update sprite-factory to allow output filename overrides (to add the .erb)
    #

    SpriteFactory.run!( 'app/assets/sprites/avatars'                         )
    SpriteFactory.run!( 'app/assets/sprites/icons', :selector => 'img.icon_' )
  
  end

  #----------------------------------------------------------------------------

end
  

