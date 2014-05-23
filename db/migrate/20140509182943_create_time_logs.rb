class CreateTimeLogs < ActiveRecord::Migration
  def change
    create_table :time_logs do |t|
      t.datetime :start_at
      t.datetime :end_at
      t.float :logged
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
