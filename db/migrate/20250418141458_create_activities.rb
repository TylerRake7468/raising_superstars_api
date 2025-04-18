class CreateActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :activities do |t|
      t.string :title
      t.text :description
      t.string :frequency
      t.integer :duration_in_sec
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
