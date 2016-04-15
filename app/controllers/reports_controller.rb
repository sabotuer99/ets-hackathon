class ReportsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @agg = []
  end
  
  
  def agency
    @agg = Item.all.group_by { |x| x.agency_id }.collect do |id,arr|
      data = {}
      data['id'] = id
      data['sums'] = arr.reduce([0,0]) {|last, item| [last[0] + item.orig_cost, last[1] + (Time.now - item.date_acquired.to_datetime) / (3600*24*365) ] }
      data['avg_cost'] = data['sums'][0] / arr.length rescue 0
      data['avg_age'] = data['sums'][1] / arr.length rescue 0
      data['oldest'] = arr.sort { |x, y| x.date_acquired <=> y.date_acquired }.first.date_acquired
      data['highest_cost'] = arr.sort { |x, y| x.orig_cost <=> y.orig_cost }.last.orig_cost
      data['lowest_cost'] = arr.sort { |x, y| x.orig_cost <=> y.orig_cost }.first.orig_cost
      data
    end
  end 
  
  def user
    @agg = getUserData
  end  
    
  def userpie
    rawdata = getUserData.sort! {|x, y| x['sums'][0] <=> y['sums'][0]}
    @agg = [['Users', 'Total Cost']]
    rawdata.each do |data|
      @agg.push [data['id'],data['sums'][0]]
    end
  end
  
  def getUserData
    Item.all.group_by { |x| x.assigned_to }.collect do |user,arr|
      data = {}
      data['id'] = user == '' ? "Unassigned" : user
      data['count'] = arr.length
      data['sums'] = arr.reduce([0,0]) {|last, item| [last[0] + item.orig_cost, last[1] + (Time.now - item.date_acquired.to_datetime) / (3600*24*365) ] }
      data['avg_cost'] = data['sums'][0] / arr.length rescue 0
      data['avg_age'] = data['sums'][1] / arr.length rescue 0
      data['oldest'] = arr.sort { |x, y| x.date_acquired <=> y.date_acquired }.first.date_acquired
      data['highest_cost'] = arr.sort { |x, y| x.orig_cost <=> y.orig_cost }.last.orig_cost
      data['lowest_cost'] = arr.sort { |x, y| x.orig_cost <=> y.orig_cost }.first.orig_cost
      data
    end
  end
  
  
end
