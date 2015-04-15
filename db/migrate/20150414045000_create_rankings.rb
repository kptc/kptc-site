class CreateRankings < ActiveRecord::Migration
  def change
    create_table :rankings do |t|
      t.references :player_sessions, index: true
      t.string :rank_letter
      t.integer :rank_number

      t.timestamps null: false
    end
    add_foreign_key :rankings, :player_sessions
  end
end
