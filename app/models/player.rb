class Player < ActiveRecord::Base
  
  belongs_to :gender
  
  validates :first_name, :last_name, :email, :phone, :gender_id, :presence => {message: "Required"}
  validates :email, :uniqueness => {message: "Email Already Taken"}, :email => {message: "Invalid Email"}
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
end
