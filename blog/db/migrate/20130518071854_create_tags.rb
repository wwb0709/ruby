class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :myblog

      t.timestamps
    end
    add_index :tags, :myblog_id
  end
end
