class CreateImageLabels < ActiveRecord::Migration[5.1]
  def change
    create_table :image_labels do |t|
      t.integer :imageId
      t.integer :labelId
      t.float :relevancyScore

      t.timestamps
    end
  end
end
