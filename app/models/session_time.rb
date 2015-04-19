class SessionTime < ActiveRecord::Base
  
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
  
end
