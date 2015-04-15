class ChangePlayerSessionsIdToPlayerSessionId < ActiveRecord::Migration
  def change
    rename_column :rankings, :player_sessions_id, :player_session_id
  end
end
