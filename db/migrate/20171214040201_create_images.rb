class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.text :url
      t.string :userId
      t.string :integer

      t.timestamps
    end
  end
end
