class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false 
      t.text :content

      t.timestamps
    end
  end
end
