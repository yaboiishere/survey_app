# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

QuestionType.first_or_create!([{ name: 'closed_answer', display_name: 'Closed Answer' },
                               { name: 'true_false', display_name: 'True/False' },
                               { name: 'open_answer', display_name: 'Open Answer' }])

if Rails.env == 'development'
  User.create!([{ email: 'test@gmail.com', password: '123456' }, { email: 'test2@gmail.com', password: '123456' }])
  Survey.create!([{ title: 'Test Survey', user_id: 1,
                    questions_attributes: [{ question: 'Test Question', question_types_id: 'open_answer' }] },
                  { title: 'Test Survey 2', user_id: 2,
                    questions_attributes: [
                      { question: 'Test Question 2', question_types_id: 'open_answer' },
                      { question: 'Test Question 3', question_types_id: 'true_false' }
                    ] }])

end
