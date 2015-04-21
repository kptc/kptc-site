class PlayerSession < ActiveRecord::Base
  
  belongs_to :player
  belongs_to :session
  
  validates :rank_letter,
    length: {
      maximum: 1,
      too_long: "Max %{count} character"
    },
    allow_blank: true
    
  validates :rank_number,
    numericality: {
      message: 'Must be a number'
    },
    length: {
      maximum: 1,
      too_long: "Max %{count} number"
    },
    allow_blank: true
  
  def rank
    [rank_letter, rank_number].join('')
  end
  
  def post_params
    params.require(:player_session).permit(
      :player_id,
      :session_id,
      :rank_letter,
      :rank_number,
      :is_in_session,
      :is_sub
    )
  end
end
