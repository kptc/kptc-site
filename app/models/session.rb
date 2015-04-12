class Session < ActiveRecord::Base
  
  has_many :player_sessions
  
  belongs_to :gender
  belongs_to :session_type
  
  def name
    gender = Gender.find(gender_id)
    session_type = SessionType.find(session_type_id)
    [Date::DAYNAMES[day_of_week.to_i],
      get_time_of_day(time_of_day),
      get_possessive(gender.name),
      session_type.name].join(' ')
  end
  
  def self.current
    where("? BETWEEN start_date AND end_date", Date.today)
  end
  
  def self.past
    where("? > start_date AND end_date", Date.today)
  end
  
  def get_time_of_day(time_of_day_id)
    times = {
      "N" => "Night",
      "D" => "Day"
    }
    times[time_of_day_id]
  end
  
  def get_possessive(gender_name)
    possessives = {
      "Female" => "Women's",
      "Male" => "Men's"
    }
    possessives[gender_name]
  end
  
end
