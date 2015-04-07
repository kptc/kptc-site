class SessionType < ActiveRecord::Base
  
  has_many :players
  has_many :sessions
  
end
