class RemoveColumn < ActiveRecord::Migration
  def change
    remove_column :genders, :code, :string
  end
end
