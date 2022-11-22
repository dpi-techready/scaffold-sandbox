class AddTasksCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tasks_count, :integer
  end
end
