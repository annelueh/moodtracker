class CreateFactors < ActiveRecord::Migration
  def change
    create_table :factors do |t|
      t.string :question
      t.boolean :yes_no
      t.integer :user_id

      t.timestamps
    end
  end
end
