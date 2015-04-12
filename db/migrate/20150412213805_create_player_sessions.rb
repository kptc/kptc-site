class CreatePlayerSessions < ActiveRecord::Migration
  def change
    create_table :player_sessions do |t|
      t.references :player, index: true
      t.references :session, index: true

      t.timestamps null: false
    end
    add_foreign_key :player_sessions, :players
    add_foreign_key :player_sessions, :sessions
  end
end
