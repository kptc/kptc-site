class RemoveEndTimeFromSession < ActiveRecord::Migration
  def change
    remove_column :sessions, :start_time
    remove_column :sessions, :end_time
    
    rename_table :session_dates, :session_times
    
    rename_column :session_times, :dt, :start_time
    change_column :session_times, :start_time, :datetime
  end
end
