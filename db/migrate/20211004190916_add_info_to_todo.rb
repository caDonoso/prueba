class AddInfoToTodo < ActiveRecord::Migration[6.1]
  def up
    add_column :todos, :name, :string, default: ''
    add_column :todos, :aasm_state, :string
  end

  def down
    remove_column :todos, :name
    remove_column :todos, :aasm_state
  end
end
