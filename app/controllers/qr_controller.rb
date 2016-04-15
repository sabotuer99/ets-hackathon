require 'rqrcode'

class QrController < ApplicationController
  before_filter :authenticate_user!

  
  def index
    base = "https://chart.googleapis.com/chart?cht=qr&chs=150x150&choe=UTF-8&chld=H&chl="
    @codes = Item.all.take(20).collect do |item|
       qr = {}
       qr['item'] = item
       #qr['code'] = RQRCode::QRCode.new( request.protocol + request.host + edit_item_path(item), :size => 6, :level => :h )
       qr['src'] = base + CGI::escape("#{request.protocol}#{request.host}#{edit_item_path(item)}")
       qr
    end 
  end
  
end

