require '.\app\models\check_input.rb'
require '.\app\models\judge_cards.rb'

class HomeController < ApplicationController

  def top
  end

  def judge
    @cards = params[:cards]
    check = CheckInput.new.check(@cards)
    if check.empty?
      judge = JudgeCards.new.judge_cards(@cards)
      @result = judge[:hand]
      render '\judge.html.erb'
    else
      @error_messages =  check
      render '\judge.html.erb'
    end
  end
end
