module ApplicationHelper

  def sprite_tag(klass, options = {})
    image_tag('s.gif', {:class => klass, :alt => klass}.merge(options))
  end

end
