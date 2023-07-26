class CreateQuestionTypes < ActiveRecord::Migration[7.0]
  def change
    create_table :question_types, id: false, primary_key: :name do |t|
      t.string :name
      t.string :display_name
      t.timestamps

      t.index :name, unique: true
    end

    add_reference :questions, :question_types, index: true, type: :string, column_name: :name
  end
end
