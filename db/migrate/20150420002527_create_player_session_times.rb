class CreatePlayerSessionTimes < ActiveRecord::Migration
  def change
    create_table :player_session_times do |t|
      t.references :player, index: true
      t.references :session_time, index: true
      t.integer :score, null: true

      t.timestamps null: false
    end
  end
end
