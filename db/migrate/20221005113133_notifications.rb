class Notifications < ActiveRecord::Migration[7.0]
  def change
    drop_table :notifications
  end
end