class RemoveCodeFromSessionTypes < ActiveRecord::Migration
  def change
    remove_column :session_types, :code, :string
  end
end
