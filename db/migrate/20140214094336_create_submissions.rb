class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :email
      t.text :source_code

      t.timestamps
    end
  end
end
