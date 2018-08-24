# frozen_string_literal: true

class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.references :post, index: true, foreign_key: true
      t.integer :value, null: false, limit: 1 # Max value 127

      t.timestamps
    end
  end
end
