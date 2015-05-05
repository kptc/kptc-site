class AddPlayerSubIdToPlayerSessionTimes < ActiveRecord::Migration
  def change
    add_column :player_session_times, :sub_requested, :boolean
    add_column :player_session_times, :sub_player_id, :integer
  end
end
