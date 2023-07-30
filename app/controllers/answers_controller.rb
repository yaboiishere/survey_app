class AnswersController < ApplicationController
  def create
    @survey = Survey.find(params[:survey_id])
    answers = answers_params.map do |answer|
      Answer.find_or_initialize_by(question_id: answer[:question_id], answer: answer[:answer])
            .increment(:count)
    end
    Answer.transaction do
      answers.each(&:save!)
    end

    respond_to do |format|
      if (@survey.questions.count == answers_params.count) && answers.all?(&:persisted?)
        format.html { redirect_to root_path, notice: 'Survey completed!' }
      else
        format.html { render 'surveys/show', survey: @survey, status: :unprocessable_entity }
      end
    end
  end

  def show
    @survey = Survey.find(params[:id])
  end

  private

  def answers_params
    params.require(:answers).map do |params|
      params.permit(:question_id, :answer)
    end
  end
end
