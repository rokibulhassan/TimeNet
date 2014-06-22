class AssociateTimeLogWithClient < ActiveRecord::Migration
  def change
    add_column :time_logs, :client_id, :integer
  end
end
