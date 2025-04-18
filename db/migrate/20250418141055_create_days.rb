class CreateDays < ActiveRecord::Migration[7.1]
  def change
    create_table :days do |t|
      t.references :program, null: false, foreign_key: true
      t.integer :day_number

      t.timestamps
    end
  end
end
