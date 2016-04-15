def genItem
    
    rndDesc = [
        "Commodore SX-64",
        "Kaypro 2000",
        "Toshiba T1100",
        "Cambridge Z88",
        "Apple Powerbook",
        "IBM RS/6000 N40",
        "Dell Inspiron 15-i3543",
        "Asus F555LA",
        "Acer Aspire E5-571-588M",
        "Leather Office Chair",
        "Brenton Studio Crawley Executive High-Back Chair, Black",
        "Serta® Smart Layers™ Jennings Super Task Big and Tall Chair, Black/Slate",
        "WorkPro® 15000 Series Big & Tall High-Back Chair, Black/Silver",
        "Beat up old office chair",
        "Paper shredder",
        "All-in-one printer",
        "Xerox laser printer",
        "Epson color laser printer",
        'Realspace® Magellan Performance Collection L Desk, 30"H x 70 9/10"W x 23 1/5"D, Espresso',
        'Z-Line Designs Z-Tech Modular Desk, 30"H x 35 27/32"W x 23 1/2"D, Oak/Silver/White',
        "Some cardboard boxes and old crates taped together to make a make-shift desk",
        "Some servers and junk"
        ]
        
    rndDev = [
        "julie.arp@wyo.gov",
        "rob.galik@wyo.gov",
        "troy.whorten@wyo.gov",
        "tyler.christopherson@wyo.gov",
        "mark.notz@wyo.gov",
        "joe.grady@wyo.gov",
        "josh.soffe@wyo.gov",
        "sean.moore@wyo.gov",
        "jackie.childress@wyo.gov",
        "patty.walsh@wyo.gov",
        "dan.young@wyo.gov",
        "ben.nelson3@wyo.gov",
        "tricia.gasner@wyo.gov",
        "joe.schmoe@wyo.gov",
        "jane.doe@wyo.gov",
        "joe.schmoe@wyo.gov",
        "jane.doe@wyo.gov",
        "joe.schmoe@wyo.gov",
        "jane.doe@wyo.gov",
        "joe.schmoe@wyo.gov",
        "jane.doe@wyo.gov",
        "joe.schmoe@wyo.gov",
        "jane.doe@wyo.gov",
        "joe.schmoe@wyo.gov",
        "jane.doe@wyo.gov"
        ]    
        
        
    rndAsset = ('A'..'Z').to_a.shuffle[0,3].join + '-' + rand(10000..99999).to_s
    
    agency = Agency.all.sample
    template = Item.all.sample
    item = Item.new
    item.description = rndDesc.sample
    item.assigned_to = rndDev.sample
    item.state_asset_tag = rndAsset
    item.loc_lat = template.loc_lat.to_f + rand/50 - 0.02
    
    #check lat bounds
    item.loc_lat = 41 unless item.loc_lat.to_f > 41 
    item.loc_lat = 45 unless item.loc_lat.to_f < 45 
    
    item.loc_long = template.loc_long.to_f + rand/50 - 0.02
    
    #check long bounds
    item.loc_long = -104.05 unless item.loc_long.to_f < -104.05 
    item.loc_long = -111.05 unless item.loc_long.to_f > -111.05 
    
    item.city = template.city
    item.zip = template.zip.to_i + rand(0..4) - 2
    item.state_id = template.state_id
    item.agency_id = agency.id
    item.date_acquired = time_rand Time.local(1999, 1, 1)
    item.orig_cost = (rand * 1000 + 50).round 2
    return item
end


def time_rand from = 0.0, to = Time.now
  Time.at(from + rand * (to.to_f - from.to_f))
end