class PlayersController < ApplicationController
  
  before_action :authenticate_player!
  
  def index
      
    @current_players = Player.includes(
      {sessions: [
        :session_dates,
        :player_sessions
      ]}
    ).references(:sessions).merge(Session.current)
    
    @other_players = Player.includes(
      {sessions: [
        :session_dates,
        :player_sessions
      ]}
    ).references(:sessions).merge(Session.past)
    
    @roles = Role.all
    
  end

  def show
    @player = Player.includes(
      {sessions: [
        :session_dates,
        :player_sessions
      ]}
    ).find(params[:id])
    
    @current_sessions = @player.sessions.current.all
    @upcoming_sessions = Session.upcoming.gender(@player.gender).all
    @registration_deadline = Session.registration_deadline(@upcoming_sessions)
    
    @sub_preferences = SubPreference.where(session_id: @upcoming_sessions.map(&:id))
    
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
  
  def update_sessions
    player = Player.find(params[:id])
    
    updated_session_ids = []
    player.sessions.upcoming(false).each do |existing|
      updated_session_ids.push(existing.id.to_s)
    end
    params[:player][:session_ids].each do |upcoming_id|
      updated_session_ids.push(upcoming_id)
    end
    player.session_ids = updated_session_ids
    
    SubPreference.includes(
      :session
    ).references(:session).merge(Session.upcoming).where(player_id: params[:id]).destroy_all
    
    params[:player][:sub_preference_ids].each do |sub|
      if not sub.blank?
        player.sub_preferences.build(player_id: params[:id], session_id: sub)
      end
    end
    
    if player.save
      redirect_to player_path
    else
      render show
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
