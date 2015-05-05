class PlayerSessionTimesController < ApplicationController
  
  def request_sub
    player_session_time = PlayerSessionTime.find_by_session_time_id_and_player_id(params[:id], params[:player_id])
    
    if player_session_time.update_attribute :sub_requested, true
      flash[:notice] = {
        class: 'success',
        body: 'Your sub request has been sent'
      }
      redirect_to player_path(params[:player_id])
    else
      flash[:notice] = {
        :class => 'danger',
        :body => 'Could not send your sub request'
      }
      render player_path(params[:player_id])
    end
    
  end
  
  def player_session_times_params
    params.require(:player_session_time).permit(
      player_sessions_attributes: [
        :sub_requested,
        :sub_player_id
      ]
    )
  end
end
