class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :commenter
      t.text :body
      t.references :myblog

      t.timestamps
    end
    add_index :comments, :myblog_id
  end
end
