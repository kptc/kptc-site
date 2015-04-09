class PlayersController < ApplicationController
  
  before_action :authenticate_player!
  
  def index
    @players = Player.all
  end

  def show
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
