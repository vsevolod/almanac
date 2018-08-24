# frozen_string_literal: true

class AddAverageMarkForPosts < ActiveRecord::Migration[5.2]
  def change
    change_table :posts, bulk: true do |t|
      t.float   :average_mark, null: false, default: 0
      t.integer :marks_count,  null: false, default: 0
    end
  end
end
