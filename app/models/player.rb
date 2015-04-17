class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :player_sessions#, dependent: :destroy :nullify
  
  has_many :sessions, through: :player_sessions
  
  default_scope {
    order('role', 'last_name')
  }
  
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
  
  def self.gender(gender)
    where(gender: gender)
  end
  
end
