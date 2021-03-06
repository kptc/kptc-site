class SessionsController < ApplicationController
  
  before_action :authenticate_player!
  
  def index
    @upcoming_sessions = Session.includes(:session_type, :players).upcoming.page params[:page]
    @current_sessions = Session.includes(:session_type, :players).current.page params[:page]
    @past_sessions = Session.includes(:session_type, :players).past.page params[:page]
  end

  def show
    @session = Session.includes(:session_times).find(params[:id])
    time_dates = Session.get_dates_from_datetimes(@session.session_times)
  end
  
  def new
    @session = Session.new
    3.times do
      session_time = @session.session_times.build
    end
    form
  end

  def create
    
    set_start_date = Session.set_start_date(post_params[:start_date], post_params[:day_of_week])
    set_end_date = Session.set_end_date(post_params[:end_date], post_params[:day_of_week])
    generated_session_times = Session.generated_session_times(post_params[:session_times_attributes], set_start_date, set_end_date)
    
    @session = Session.new(post_params.merge(
      start_date: set_start_date,
      end_date: set_end_date,
      session_times_attributes: generated_session_times
    ))
    
    if @session.save
      flash[:notice] = {
        :class => 'success',
        :body => 'New sesssion added'
      }
      redirect_to '/sessions'
    else
      @session = Session.new
      flash[:notice] = {
        :class => 'danger',
        :body => 'Session could not be added, please try again'
      }
      render 'form'
    end
  end

  def edit
    @session = Session.find(params[:id])
    form
  end

  def update
    @session = Session.find(params[:id])
    if @session.update(post_params)
      redirect_to '/sessions'
    else
      render 'edit'
    end
  end
  
  def build
    @session = Session.includes(:session_times).find(params[:id])
    @available_players = Player.includes(
      {sessions: [
        :session_times,
        :player_sessions
      ]}
    ).gender(@session.gender).all
    
  end
  
  def update_session_players
    @session = Session.find(params[:id])
    
    @session.player_ids = params[:session][:player_ids]
    
    if @session.save
      redirect_to session_build_path
    else
      render build
    end
  end

  def destroy
    @session = Session.find(params[:id])
    if @session.destroy
      flash[:notice] = {
        :class => 'success',
        :body => 'Session has been deleted'
      }
    else
      flash[:notice] = {
        :class => 'danger',
        :body => 'Session could not be deleted, please try again'
      }
    end
    redirect_to '/sessions'
  end
  
private

  def form
    @times = {
     'N' => 'Night',
     'D' => 'Day'
    }
    @genders = Gender.all
    @session_types = SessionType.select(:id, :name)
    render 'form'
  end

  def post_params
    params.require(:session).permit(
      :day_of_week,
      :time_of_day,
      :start_date,
      :end_date,
      :gender,
      :session_type_id,
      session_times_attributes: [:start_time]
    )
  end
end
