class MapController < ApplicationController
  def index
    
    @items = Item.all
    @center = {
      'lat' => @items.reduce(0){|last, item| last + item.loc_lat.to_f} / @items.count,
      'lng' => @items.reduce(0){|last, item| last + item.loc_long.to_f} / @items.count
    }
    
    @markers = @items.collect do |item| 
      marker = Marker.new
      marker.lat = item.loc_lat
      marker.lng = item.loc_long
      marker.infowindow = item.description
      picture = MarkerPicture.new
      picture.url = "http://people.mozilla.com/~faaborg/files/shiretoko/firefoxIcon/firefox-32.png"
      picture.width = 32
      picture.height = 32
      marker.picture = picture
      marker
    end
    
  end
end
