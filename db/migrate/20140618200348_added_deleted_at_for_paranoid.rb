class AddedDeletedAtForParanoid < ActiveRecord::Migration
  def change
    add_column :users, :deleted_at, :datetime
    add_column :contacts, :deleted_at, :datetime
    add_column :customers, :deleted_at, :datetime
    add_column :clients, :deleted_at, :datetime
    add_column :projects, :deleted_at, :datetime
    add_column :request_infos, :deleted_at, :datetime
    add_column :time_logs, :deleted_at, :datetime
  end
end
