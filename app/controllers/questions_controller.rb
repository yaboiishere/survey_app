class QuestionsController < ApplicationController
  before_action :authenticate_user!
  def partial_form
    question_types = QuestionType.pluck(:display_name, :name)
    render partial: 'form', locals: { id: params[:id], question: nil, question_types: }
  end

  def partial_closed
    render partial: 'closed', locals: { id: params[:id] }
  end

  def partial_true_false
    render partial: 'true_false', locals: { id: params[:id] }
  end
end
