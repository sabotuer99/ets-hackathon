class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /items
  # GET /items.json
  def index
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
    @item.agency_id = Profile.find(current_user.profile_id).agency_id
    @item.state_id = 57 #Wyoming
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def nearby
    params.permit(:lat, :lng)
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    
    items = Item.select {|item| (item.loc_lat.to_f - lat).abs < 0.9 && (item.loc_long.to_f - lng).abs < 0.9 }
                .group_by {|item| item.street.strip }.values.collect {|arr| arr[0]}
    
    items.sort_by! {|item| ((item.loc_lat.to_f - lat)**2 + (item.loc_long.to_f - lng)**2)**0.5}
    
    nearby = items.take(5).collect do |item| 
      address = {}
      address['street_number'] = item.street
      address['city'] = item.city
      address['state'] = State.find(item.state_id).state_abbr rescue "Unknown"
      address['zip'] = item.zip
      address
    end

    render json: nearby
  end
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:description, :agency_id, :street, :city, :state_id, 
                                   :zip, :loc_lat, :loc_long, :assigned_to, :state_asset_tag,
                                   :date_acquired, :orig_cost)
    end
end
