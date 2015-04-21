class Session < ActiveRecord::Base
  
  has_many :player_sessions
  has_many :session_times, autosave: true, dependent: :destroy
  accepts_nested_attributes_for :session_times
  has_many :sub_preferences, dependent: :destroy
  
  has_many :players, through: :player_sessions
    accepts_nested_attributes_for :players
  
  belongs_to :session_type
  
  default_scope {
    order(start_date: :desc)
  }
  
  # --- Validations ---
  
  # --- Virtual Attributes ---
  
  def name
    genders = Gender.all
    session_type = SessionType.find(session_type_id)
    [Date::DAYNAMES[day_of_week.to_i],
      get_time_of_day(time_of_day),
      get_possessive(genders[gender]),
      session_type.name].join(' ')
  end
  
  def dates
    start_date.strftime("%B #{start_date.day.ordinalize}, %Y") + " - " + end_date.strftime("%B #{end_date.day.ordinalize}, %Y")
  end
  
  # --- Scopes ---
  
  def self.current(positive = true)
    if (positive)
      where("? BETWEEN sessions.start_date AND sessions.end_date", Date.today)
    else
      where.not("? BETWEEN sessions.start_date AND sessions.end_date", Date.today)
    end
  end
  
  def self.upcoming(positive = true)
    if (positive)
      where("? < sessions.start_date", Date.today)
    else
      where.not("? < sessions.start_date", Date.today)
    end
  end
  
  def self.past(positive = true)
    if (positive)
      where("? > sessions.end_date", Date.today)
    else
      where.not("? > sessions.end_date", Date.today)
    end
  end
  
  def self.gender(gender)
    where(gender: gender)
  end

  # --- Other Methods ---

  def self.registration_deadline(sessions)    
    sessions.last.start_date - 14
  end
  
  def self.set_start_date(start_date, day_of_week)
    day_of_week = day_of_week.to_i
    start_date_wday = start_date.to_date.wday.to_i
    if start_date_wday != day_of_week
      difference = (day_of_week < start_date_wday) ? day_of_week - start_date_wday + 7 : day_of_week - start_date_wday
      start_date = start_date.to_time + difference.days
    end
    start_date.to_time
  end
  
  def self.set_end_date(end_date, day_of_week)
    day_of_week = day_of_week.to_i
    end_date_wday = end_date.to_date.wday.to_i
    if end_date_wday != day_of_week
      difference = (day_of_week > end_date_wday) ? end_date_wday - day_of_week  + 7 : end_date_wday - day_of_week
      end_date = end_date.to_time - difference.days
    end
    end_date.to_time
  end
  
  def self.generated_session_times(session_times_attributes, set_start_date, set_end_date)
    generated_session_times = {}
    number_of_matches = Session.number_of_matches(set_start_date, set_end_date)
    session_date = set_start_date
    
    number_of_matches.times do |i|
      session_times_attributes.each_with_index do |session_start_time, index|
        session_time = (session_times_attributes[index.to_s][:start_time]).to_time
        session_date_time = DateTime.new(session_date.year, session_date.month, session_date.day, session_time.hour, session_time.min, session_time.sec)
        generated_session_times.merge!((i * 3 + index).to_s => {"start_time" => session_date_time})
      end
      i += 1
      session_date = session_date + 7.days
    end
    
    generated_session_times
  end
  
private

  def self.number_of_matches(start_date, end_date)
    ((end_date - start_date) / 86400).to_i / 7 + 1
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
