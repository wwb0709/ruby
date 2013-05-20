class AddColumnToMyblog < ActiveRecord::Migration
  def change
    add_column :myblogs, :myfile, :string
  end
end
