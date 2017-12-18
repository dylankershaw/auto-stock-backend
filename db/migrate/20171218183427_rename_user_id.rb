class RenameUserId < ActiveRecord::Migration[5.1]
  def change
    rename_column :image_labels, :imageId, :image_id
    rename_column :image_labels, :labelId, :label_id
    rename_column :images, :userId, :user_id
  end
end
