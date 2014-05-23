class ChangeDateTimeFieldType < ActiveRecord::Migration
  def up
    change_column :projects, :start_date, :date
    change_column :projects, :end_date, :date
  end

  def down
    change_column :projects, :start_date, :datetime
    change_column :projects, :end_date, :datetime
  end
end