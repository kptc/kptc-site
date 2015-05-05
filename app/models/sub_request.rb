class SubRequest < ActiveRecord::Base
  belongs_to :session_time
  belongs_to :player
end
