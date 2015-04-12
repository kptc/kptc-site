class SessionsController < ApplicationController
  
  before_action :authenticate_player!
  
  def index
    @sessions = Session.includes(:gender, :session_type)
  end

  def show
  end
  
  def new
    @session = Session.new
    form
  end

  def create
    @session = Session.new(post_params)
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
    @genders = Gender.select(:id, :name)
    @session_types = SessionType.select(:id, :name)
    render 'form'
  end

  def post_params
    params.require(:session).permit(
      :day_of_week,
      :time_of_day,
      :start_date,
      :end_date,
      :start_time,
      :end_time,
      :gender_id,
      :session_type_id
    )
  end
end
