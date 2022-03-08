class AddDeadLineToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :date
  end
end
