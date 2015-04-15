class PlayerSession < ActiveRecord::Base
  
  has_one :ranking
  
  belongs_to :player
  belongs_to :session
end
