class Session < ActiveRecord::Base
  
  has_many :player_sessions
  has_many :session_dates
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
    start_date.strftime("%B #{start_date.day.ordinalize}, %Y") + ' to ' + end_date.strftime("%B #{end_date.day.ordinalize}, %Y")
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
  
private

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
