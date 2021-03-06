class QuestionsController < ApplicationController
  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "Question successfully created!"
      redirect_to question_path(@question)
    else
      flash[:errors] = @question.errors.full_messages.join(', ')
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = "Question successfully updated!"
      redirect_to question_path(@question)
    else
      flash[:errors] = @question.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = "Question deleted!"
    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(
      :title,
      :description
    )
  end
end
