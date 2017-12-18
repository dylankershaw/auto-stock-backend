class DeleteFileFromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column(:images, :file)
  end
end
