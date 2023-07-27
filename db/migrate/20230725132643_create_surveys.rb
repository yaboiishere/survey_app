class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys do |t|
      t.string :title, null: false
      t.text :author

      t.timestamps
    end
  end
end
