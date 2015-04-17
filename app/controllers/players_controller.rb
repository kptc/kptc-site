class PlayersController < ApplicationController
  
  before_action :authenticate_player!
  
  def index
    @players = Player.includes(
      {sessions: [ # restrict to latest session that does not start in the future
        :session_dates,
        {player_sessions: :ranking},
      ]}
    ).references(:sessions).merge(Session.current)
    @roles = Role.all
  end

  def show
    @player = Player.includes(
      {sessions: [
        :session_dates,
        {player_sessions: :ranking},
      ]}
    ).find(params[:id])
    
  end
  
  def toggle_activate
    player = Player.find(params[:id])
    player_role = player.role
    
    case player_role
    when 'L'
      new_role = 'U'
    when 'U', 'A'
      new_role = 'L'
    end
    
    if player.update_attribute :role, new_role
      redirect_to '/players'
    else
      render 'index'
    end
  end
  
  def toggle_admin
    player = Player.find(params[:id])
    player_role = player.role
    
    case player_role
    when 'A'
      new_role = 'U'
    when 'U'
      new_role = 'A'
    else
      new_role = 'L'
    end
    
    if player.update_attribute :role, new_role
      redirect_to '/players'
    else
      render 'index'
    end
  end

  #def create
  #  
  #  if @player.save
  #    flash[:notice] = {
  #      :class => 'success',
  #      :body => 'You have been registered! Check your inbox for your confirmation email.'
  #    }
  #    PlayerMailer.registration_admin_email(@player).deliver_later
  #    PlayerMailer.registration_email(@player).deliver_later
  #    redirect_to '/'
  #  else
  #    @genders = Gender.all
  #    flash[:notice] = {
  #      :class => 'danger',
  #      :body => 'You could not be registered, please try again'
  #    }
  #    render :register, :layout => 'public'
  #  end
  #end
  
end
