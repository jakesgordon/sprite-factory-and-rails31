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

  #----------------------------------------------------------------------------

end
  

