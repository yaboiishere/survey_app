class CreateAnswers < ActiveRecord::Migration[7.0]

  def change
    create_table :answers do |t|
      t.references :question, null: false, foreign_key: true
      t.string :answer, null: false
      t.integer :count, null: false, default: 0

      t.timestamps
    end

    add_index :answers, %i[question_id answer], unique: true
  end
end
