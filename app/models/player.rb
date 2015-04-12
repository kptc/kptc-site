class Player < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  has_many :player_sessions
  has_many :sessions, through: :player_sessions
  belongs_to :gender
  
  validates :first_name, :last_name, :email, :phone, :gender_id, :presence => {message: "Required"}
  validates :email, :uniqueness => {message: "Email Already Taken"}, :email => {message: "Invalid Email"}
  
  def name
    [first_name, last_name].join(' ')
  end
  
  def admin?
    self.role == 'A'
  end
  
end
