class SubPreference < ActiveRecord::Base
  belongs_to :player
  belongs_to :session
end
