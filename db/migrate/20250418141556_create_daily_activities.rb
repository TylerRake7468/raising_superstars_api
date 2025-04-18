class CreateDailyActivities < ActiveRecord::Migration[7.1]
  def change
    create_table :daily_activities do |t|
      t.references :day, null: false, foreign_key: true
      t.references :activity, null: false, foreign_key: true

      t.timestamps
    end
  end
end
