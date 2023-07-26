class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.string :question
      t.text :options, array: true
      t.references :survey, null: false, foreign_key: true

      t.timestamps
    end
  end
end