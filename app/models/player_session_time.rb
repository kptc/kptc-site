class PlayerSessionTime < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :session_time
  
  validates :score,
    numericality: {
      message: 'Must be a number'
    },
    allow_blank: true
  
  def self.open_sub_request
    where({sub_requested: true, sub_player_id: nil})
  end
  
  def as_json(options = {})
    {
      :id => self.session_time_id,
      :player_id => self.player_id,
      :start => self.session_time.start_time.rfc822,
      :end => self.session_time.end_time.rfc822,
      :allDay => 0,
      :url => "/player_session_times/#{session_time_id}/request_sub/#{player_id}"
    }
  end
  
  def post_params
    params.require(:player_session_time).permit(
      :player_id,
      :session_time_id,
      :score
    )
  end
  
end
