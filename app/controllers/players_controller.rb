class PlayersController < ApplicationController
  
  layout 'public', only: 'register'
  
  def index
    @players = Player.all
  end

  def show
  end

  def new
    form
  end

  def create
    @player = Player.new(post_params)
    
    if @player.save
      flash[:notice] = {:class => 'success', :body => 'You have been registered!'}
      PlayerMailer.registration_email(@player).deliver_now
      # send emails (player and admin)
      redirect_to '/'
    else
      @genders = Gender.all
      flash[:notice] = {:class => 'danger', :body => 'You could not be registered, please try again'}
      render :register, :layout => 'public'
    end
    
  end

  def edit
    form
  end

  def update
  end

  def destroy
  end
  
  def register
    @player = Player.new
    #@genders = Gender.all
    @genders = Gender.all
  end
  
  private
  
  def form
    
  end
  
  def post_params
    params.require(:player).permit(
      :first_name,
      :last_name,
      :email,
      :phone,
      :gender_id
    )
  end
end
