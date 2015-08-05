class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|

      t.column :user_id, :integer

      t.timestamps null: false
    end
  end
end
