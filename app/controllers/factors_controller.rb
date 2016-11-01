class FactorsController < ApplicationController

  def index
    @factors = current_user.factors
  end

  def new
    @factor = Factor.new
  end

  def create
    if params[:custom]
      question = params[:factor]
      is_yes_no = true
      if params[:factor_type] == 'Numeric'
        is_yes_no = false
      end
      @factor = Factor.create(question: question, yes_no: is_yes_no, user_id: current_user.id)
    else
      case params[:name]
      when 'sleep'
        @question = 'Hours of sleep'
        @yes_no = false
      when 'workout'
        @question = 'Worked out'
        @yes_no = true
      else
        return render 'new'
      end
      if (current_user.factors.map {|c| c.question }).include?(@question)
        @flash = ['You are already tracking that factor.']
        return render 'new'
      end
      @factor = Factor.create(question: @question, yes_no: @yes_no, user_id: current_user.id)
    end
    redirect_to factors_path
  end

  def destroy
    @factor = Factor.find(params[:id])
    @factor.delete()
    redirect_to factors_path
  end
end
