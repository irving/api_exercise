class CreateStories < ActiveRecord::Migration[5.2]
  def change
    create_table :stories do |t|
      t.string :name
      t.text :description
      t.references :column
      t.integer :status
      t.datetime :due_date

      t.timestamps
    end
  end
end
