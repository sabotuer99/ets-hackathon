require 'rqrcode'

class QrController < ApplicationController
  
  def index
    @codes = Item.all.collect do |item|
       qr = {}
       qr['item'] = item
       qr['code'] = RQRCode::QRCode.new( request.protocol + request.host + edit_item_path(item), :size => 6, :level => :h )
       qr
    end 
  end
  
end
