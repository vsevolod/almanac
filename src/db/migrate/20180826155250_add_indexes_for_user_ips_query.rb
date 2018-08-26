# frozen_string_literal: true

class AddIndexesForUserIpsQuery < ActiveRecord::Migration[5.2]
  def change
    add_index :posts, %i[user_ip user_id]
  end
end
