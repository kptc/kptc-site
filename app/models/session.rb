class Session < ActiveRecord::Base
  
  belongs_to :gender
  belongs_to :session_type
  
end
