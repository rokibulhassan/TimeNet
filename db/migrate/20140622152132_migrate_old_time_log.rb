class MigrateOldTimeLog < ActiveRecord::Migration
  def change
    TimeLog.scoped.each do |time_log|
      next if time_log.client.present?
      time_log.update_column(:client_id, time_log.try(:user).try(:client_id))
    end
  end
end
