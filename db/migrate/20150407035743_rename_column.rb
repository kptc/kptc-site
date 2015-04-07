class RenameColumn < ActiveRecord::Migration
  def change
    change_table :sessions do |t|
      t.rename :name, :time_of_day
    end
  end
end
