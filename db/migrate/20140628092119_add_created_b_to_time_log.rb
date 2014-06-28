class AddCreatedBToTimeLog < ActiveRecord::Migration
  def change
    add_column :time_logs, :created_by, :integer
  end
end
