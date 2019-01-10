require '.\app\models\check_input.rb'
require '.\app\models\judge_cards.rb'

class HomeController < ApplicationController

  def top
  end

  def judge
    @cards = params[:cards]
    check = CheckInput.new.check(@cards)
    # 入力したデータを受取
    if check.empty?
      judge = JudgeCards.new.judge_cards(@cards)
      @result = judge[:yaku]
      render '\judge.html.erb'
    else
      @error_messages =  check
      render '\judge.html.erb'
    end
  end
end
# def judge_straight(numbers) # numbersは " 配列形式 "
#   numbers = numbers.sort{|a, b| b<=>a} # numbersを降順に並べ替える式
#   # ストレートかどうかの判定式。行末の "\" は命令命令内で改行を無視するための四季（改行を可能にする式）
#   if ( \
#       ( \
#       ( (numbers[4]-numbers[3]) == 1 )     \
#       && ( (numbers[3] - numbers[2] )== 1 ) \
#       && ( (numbers[2] - numbers[1]) == 1 ) \
#       && ( (numbers[1] - numbers[0]) == 1 ) \
#       ) \
#     || \
#      ( numbers == [1, 10, 11, 12, 13] ) \ # 配列でも昇順で並べ替えれば、条件分として使用可能
#    )
#      return "true"
#    else
#      return "false"
#    end
# end
# suitの種類が1種類で構成されている場合
# "class"で型判定ができる。型はString
