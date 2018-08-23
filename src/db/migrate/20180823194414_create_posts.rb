class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.inet :user_ip

      t.timestamps
    end
  end
end
