class AddRankingToPlayerSession < ActiveRecord::Migration
  def change
    add_column :player_sessions, :rank_letter, :string
    add_column :player_sessions, :rank_number, :integer
    
    drop_table :rankings
  end
end
