class MapController < ApplicationController
  def index
      @map = GMap.new("map_div")
  	  @map.control_init(:large_map => true,:map_type => true)
  	  @map.center_zoom_init([75.5,-42.56],4)
  	  @map.overlay_init(GMarker.new([75.6,-42.467],:title => "Map FlashMob", :info_window => "Local infos"))
  end

end
