class SessionDate < ActiveRecord::Base
  
  belongs_to :session
  
  default_scope {
    order(dt: :asc)
  }
  
  def text_date
    dt.strftime("%B #{dt.day.ordinalize}, %Y")
  end
  
end
