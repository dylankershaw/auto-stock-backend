class RemoveStringFromUser < ActiveRecord::Migration[5.1]
  def change
    remove_column(:users, :string)
  end
end
