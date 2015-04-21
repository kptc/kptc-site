class AddInSessionIsSubToPlayerSession < ActiveRecord::Migration
  def change
    add_column :player_sessions, :is_in_session, :boolean
    add_column :player_sessions, :is_sub, :boolean
    
    drop_table :sub_preferences
  end
end
