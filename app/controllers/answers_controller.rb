class AnswersController < ApplicationController

  def create
    @survey = Survey.find(params[:survey_id])
    answers = answers_params[:questions_attributes].values.map do |answer|
      Answer.find_or_initialize_by(question_id: answer[:question_id], answer: answer[:answer])
            .increment(:count)
    end
    Answer.transaction do
      answers.each(&:save!)
    end
    if @survey.questions.count == answers_params[:questions_attributes].values.count
      redirect_to root_path, notice: 'Survey completed!'
    end

  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.message
    render 'surveys/fill_out', survey: @survey, status: :unprocessable_entity
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def answers_params
    params.require(:survey).permit(questions_attributes: %i[question_id answer id])
  end

end
