class Player < ActiveRecord::Base
  
  belongs_to :gender
  
  validates :first_name, :last_name, :email, :phone, :gender_id, presence: true
  validates :email, uniqueness: true, email: true
  
  def full_name
    [first_name, last_name].join(' ')
  end
  
end
