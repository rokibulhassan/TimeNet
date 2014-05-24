class AddIdleTimeToTimeLog < ActiveRecord::Migration
  def change
    add_column :time_logs, :idle_time, :float
  end
end
