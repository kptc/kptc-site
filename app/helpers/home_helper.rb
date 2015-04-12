module HomeHelper
  
  def resource_name
    :player
  end
 
  def resource
    @resource ||= Player.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:player]
  end

  #def actions(player)
  #  if player.admin?
  #    render 'players/admin_actions'
  #  else
  #    render 'players/user_actions'
  #  end
  #end
  # erb <%= actions(player) %>
end
