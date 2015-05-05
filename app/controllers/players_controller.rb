class PlayersController < ApplicationController
  
  before_action :authenticate_player!
  
  def index
    
    @current_players = Session.includes(player_sessions: :player).where(player_sessions: {is_in_session: true}).current
    @current_subs = Session.includes(player_sessions: :player).where(player_sessions: {is_sub: true}).current
    
    @inactive_players = Player.inactive?
    @all_players = Player.inactive?(false)
    
    @roles = Role.all
    
  end

  def show
    @player = Player.includes(
      {sessions: [
        :session_times,
        :player_sessions
      ]}
    ).find(params[:id])
    
    @current_sessions = @player.sessions.current.all
    @upcoming_sessions = Session.upcoming.gender(@player.gender).all
    if @upcoming_sessions != []
      @registration_deadline = Session.registration_deadline(@upcoming_sessions)
    end
    
    @my_open_sub_requests = @player.player_session_times.includes(:session_time).open_sub_request
    @available_to_sub = PlayerSessionTime.all.open_sub_request.where.not(player_id: params[:id])
    
  end
  
  def calendar
    @player = Player.find(params[:id])
    @player_session_times = PlayerSessionTime.includes(:session_time).where(
      'player_session_times.player_id = ? OR player_session_times.sub_player_id = ?',
      params[:id],
      params[:id]
    )
    render :json => @player_session_times
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
      flash[:notice] = {
        class: 'success',
        body: 'Role has been changed'
      }
      redirect_to '/players'
    else
      flash[:notice] = {
        :class => 'danger',
        :body => 'Role could not be changed, please try again'
      }
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
      flash[:notice] = {
        class: 'success',
        body: 'Role has been changed'
      }
      redirect_to '/players'
    else
      flash[:notice] = {
        :class => 'danger',
        :body => 'Role could not be changed, please try again'
      }
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
