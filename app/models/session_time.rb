class SessionTime < ActiveRecord::Base
  
  has_many :player_session_times
  
  has_many :players, through: :player_session_times
  
  belongs_to :session
  
  default_scope {
    order(start_time: :asc)
  }
  
  def date
    start_time.strftime("%B #{start_time.day.ordinalize}, %Y")
  end
  
  def time
    start_time.strftime("%I:%M %p")
  end
  
  def end_time
    start_time + 1.hour
  end

  def as_json(options = {})
    {
      :id => self.id,
      :player_id => self.player_session_times.first.player_id,
      :start => start_time.rfc822,
      :end => end_time.rfc822,
      :allDay => 0,
      :url => "/player_session_times/#{id}/request_sub/#{player_session_times.first.player_id}"
    }
  end
end
