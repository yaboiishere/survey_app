# frozen_string_literal: true

QuestionType.first_or_create!([
                                { name: 'closed_answer', display_name: 'Closed Answer' },
                                { name: 'true_false', display_name: 'True/False' },
                                { name: 'open_answer', display_name: 'Open Answer' }
                              ])

if Rails.env == 'development'
  users = User.create!([
                         { email: 'john.doe@example.com', password: '123456' },
                         { email: 'jane.smith@example.com', password: '123456' }
                       ])

  Survey.create!([
                   {
                     title: 'Favorite Color Survey',
                     user: users.first,
                     questions_attributes: [
                       { question: 'What is your favorite color?', question_types_id: 'open_answer' }
                     ]
                   },
                   {
                     title: 'Personality Quiz',
                     user: users.first,
                     questions_attributes: [
                       { question: 'Do you enjoy social gatherings?', question_types_id: 'true_false' },
                       {
                         question: 'Which animal do you relate to the most?',
                         question_types_id: 'closed_answer',
                         options: %w[Lion Dolphin Eagle Tortoise]
                       },
                       { question: 'What is your favorite book?', question_types_id: 'open_answer' }
                     ]
                   },
                   {
                     title: 'Food Preferences Survey',
                     user: users.second,
                     questions_attributes: [
                       {
                         question: 'Which cuisine do you enjoy the most?',
                         question_types_id: 'closed_answer',
                         options: %w[Italian Mexican Indian Japanese]
                       },
                       { question: 'Do you like spicy food?', question_types_id: 'true_false' }
                     ]
                   }
                 ])

  question_social_gatherings_id = Question.find_by(question: 'Do you enjoy social gatherings?').id
  question_animal_id = Question.find_by(question: 'Which animal do you relate to the most?').id
  question_favorite_book_id = Question.find_by(question: 'What is your favorite book?').id
  question_spicy_food_id = Question.find_by(question: 'Do you like spicy food?').id
  question_cuisine_id = Question.find_by(question: 'Which cuisine do you enjoy the most?').id

  # Add some answers to the questions
  Answer.create!([
                   { question_id: question_social_gatherings_id, answer: 'true', count: 10 },
                   { question_id: question_social_gatherings_id, answer: 'false', count: 7 },
                   { question_id: question_animal_id, answer: 'Lion', count: 8 },
                   { question_id: question_animal_id, answer: 'Dolphin', count: 4 },
                   { question_id: question_animal_id, answer: 'Eagle', count: 2 },
                   { question_id: question_animal_id, answer: 'Tortoise', count: 3 },
                   { question_id: question_favorite_book_id, answer: 'Pride and Prejudice', count: 3 },
                   { question_id: question_favorite_book_id, answer: 'To Kill a Mockingbird', count: 6 },
                   { question_id: question_favorite_book_id, answer: 'Harry Potter and the Philosopher\'s Stone',
                     count: 8 },
                   { question_id: question_spicy_food_id, answer: 'true', count: 10 },
                   { question_id: question_spicy_food_id, answer: 'false', count: 7 },
                   { question_id: question_cuisine_id, answer: 'Italian', count: 7 },
                   { question_id: question_cuisine_id, answer: 'Mexican', count: 5 },
                   { question_id: question_cuisine_id, answer: 'Indian', count: 3 },
                   { question_id: question_cuisine_id, answer: 'Japanese', count: 4 }
                 ])
end
