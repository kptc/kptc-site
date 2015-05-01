class PlayerSessionsController < ApplicationController
  
  def select
    player = Player.find(params[:player_id])
    
    params[:player][:player_sessions_attributes].each_with_index do |player_session, index|
      if player_session[1]["is_in_session"] == "0" && player_session[1]["is_sub"] == "0"
        params[:player][:player_sessions_attributes].except!(player_session[index])
      end
      if player_session[1].has_key?("id")
        PlayerSession.destroy(player_session[1]["id"])
      end
    end
    
    if player.update_attributes(session_params)
      redirect_to player_path(player)
    end
    
  end
  
  def session_params
    params.require(:player).permit(
      player_sessions_attributes: [
        :session_id,
        :is_in_session,
        :is_sub
      ]
    )
  end
  
end
