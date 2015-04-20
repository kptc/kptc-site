class PlayerSessionTime < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :session_time
  
  validates :score,
    numericality: {
      message: 'Must be a number'
    },
    allow_blank: true

  def post_params
    params.require(:player_session_time).permit(
      :player_id,
      :session_time_id,
      :score
    )
  end
  
end
