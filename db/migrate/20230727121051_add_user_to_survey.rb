class AddUserToSurvey < ActiveRecord::Migration[7.0]
  def change
    remove_column :surveys, :author, :text
    add_reference :surveys, :user, null: false, foreign_key: true
  end
end
