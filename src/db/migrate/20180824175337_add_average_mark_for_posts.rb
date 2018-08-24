class AddAverageMarkForPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :average_mark, :float, null: false, default: 0
    add_column :posts, :marks_count, :integer, null: false, default: 0
  end
end
