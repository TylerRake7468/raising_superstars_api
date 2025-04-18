class CreateCompletions < ActiveRecord::Migration[7.1]
  def change
    create_table :completions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :daily_activity, null: false, foreign_key: true
      t.datetime :completed_at

      t.timestamps
    end
  end
end
