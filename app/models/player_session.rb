class PlayerSession < ActiveRecord::Base
  
  has_one :ranking
  
  belongs_to :player
  belongs_to :session
  
  def post_params
    params.require(:player_session).permit(
      :player_id,
      :session_id
    )
  end
end
