
class MapController < ApplicationController
 	def index
 	  @address = "Avenida Brasil"
 	  @map = GMap.new("map_div")
	  @map.control_init(:large_map => true,:map_type => true)
 	  #testing a address
 	  result = Geocoding::get(@address)
    if result.status == Geocoding::GEO_SUCCESS
    	coord = result[0].latlon
    	@map.overlay_init(GMarker.new(coord,:title => "FlashMob Map",:info_window => @address))
    	@map.center_zoom_init(coord,15)
    end

	end

end
