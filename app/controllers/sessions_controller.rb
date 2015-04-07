class SessionsController < ApplicationController
  
  def index
    @sessions = Session.includes(:gender, :session_type)
  end

  def show
  end
  
  def new
    form
  end

  def create
    gendered = {1 => "Women's", 2 => "Men's"}
    @genders = Gender.all
    @session_types = SessionType.select(:id, :name).to_json
    @days = {
      1 => 'Monday',
      2 => 'Tuesday',
      3 => 'Wednesday',
      4 => 'Thursday',
      5 => 'Friday',
      6 => 'Saturday',
      7 => 'Sunday'
    }
    @session = Session.new(post_params)
    @session.name =
      @days[post_params[:day_of_week].to_i] + ' Night ' +
      gendered[post_params[:gender_id].to_i] + ' ' +
      @session_types[post_params[:session_type_id].to_i]
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
    form
  end

  def update
  end

private

  def destroy
  end
  
  def form
    @session = Session.new
    @days = {
      1 => 'Monday',
      2 => 'Tuesday',
      3 => 'Wednesday',
      4 => 'Thursday',
      5 => 'Friday',
      6 => 'Saturday',
      7 => 'Sunday'
    }
    @genders = Gender.select(:id, :name)
    @session_types = SessionType.select(:id, :name)
    render 'form'
  end

  def post_params
    params.require(:session).permit(
      :day_of_week,
      :start_date,
      :end_date,
      :start_time,
      :gender_id,
      :session_type_id
    )
  end
end
