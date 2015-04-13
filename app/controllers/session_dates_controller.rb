class SessionDatesController < ApplicationController
  
  def new
    @session_date = SessionDate.new
    form
  end

  def create
  end

  def edit
    @session_date = SessionDate.find(params[:id])
    form
  end

  def update
    @session_date = SessionDate.find params[:id]
  
    respond_to do |format|
      if @session_date.update_attributes(post_params)
        format.html { redirect_to(@session_date, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@session_date) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@session_date) }
      end
    end
  end  
  private
  
  def form
    render 'form'
  end

  def destroy
  end
  
  def post_params
    params.require(:session_date).permit(
      :session_id,
      :dt
    )
  end
end
