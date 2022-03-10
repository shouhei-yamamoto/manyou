class AddPrioritiesToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :priority, :integer
  end
end
