class AddDefaultStatusToStories < ActiveRecord::Migration[5.2]
  def change
    change_column :stories, :status, :integer, default: 0
  end
end
