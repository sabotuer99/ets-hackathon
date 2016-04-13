class Profile < ActiveRecord::Base
    attr_accessible :email, :user_name, :agency_id
    validates :email, presence: true
end
