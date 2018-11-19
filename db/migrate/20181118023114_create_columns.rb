class CreateColumns < ActiveRecord::Migration[5.2]
  def change
    create_table :columns do |t|
      t.string :name
      t.references :board, foreign_key: true

      t.timestamps
    end
  end
end
