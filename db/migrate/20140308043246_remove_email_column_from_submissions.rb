class RemoveEmailColumnFromSubmissions < ActiveRecord::Migration
  def up
    remove_column :submissions, :email
  end

  def down
    add_column :submissions, :email, :string, null: false, default: ''
  end
end
