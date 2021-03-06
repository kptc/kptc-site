class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :player_sessions#, dependent: :destroy :nullify
  has_many :player_session_times
  
  has_many :sessions, through: :player_sessions
  has_many :upcoming_sessions, ->{ upcoming }, through: :player_sessions, source: :session
    accepts_nested_attributes_for :player_sessions
  has_many :session_times, through: :player_session_times
    accepts_nested_attributes_for :session_times
  
  default_scope {
    order('role', 'last_name')
  }
  
  paginates_per 10
  
  # --- Validations ---
  
  validates :first_name, :last_name, :email, :phone, :gender, :presence => {
    message: "Required"
  }
  
  validates :email,
    :uniqueness => {
      message: "Email Already Taken"
    },
    :email => {
      message: "Invalid Email"
    }
  
  # --- Virtual Attributes ---
  
  def name
    [first_name, last_name].join(' ')
  end
  
  # --- Scopes ----

  def admin?
    self.role == 'A'
  end
  
  def self.inactive?(positive = true)
    if (positive)
      where("role = ?", 'L')
    else
      where.not("role = ?", 'L')
    end
  end
  
  def self.gender(gender)
    where(gender: gender)
  end
  
end
