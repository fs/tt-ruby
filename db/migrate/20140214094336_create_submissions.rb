class CreateSubmissions < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'

    create_table :submissions, id: :uuid do |t|
      t.string :email
      t.text :source_code

      t.timestamps
    end
  end
end
