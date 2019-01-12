#このファイルでは、poker クラスを定義している。
require '.\app\models\check_input.rb'
require '.\app\models\judge_cards.rb'

module API
  module Ver1
    class Poker < Grape::API
      # include CheckInput
      prefix 'api'
      version 'ver1', using: :path
      format :json
      resources :poker do
        # APIではparamsを指定して、取得したい情報を受取る
        # 必ず取得したいもの requires nilでも問題ないもの optional
        get do
          return "ok"
        end
        #
        # prams do
        #   requires :@cards, type: String
        # end

        # getd
          # GET /api/ver1/poker
          desc "ポーカーの役を返す"
          # prefix 'poker'

          # ================================
          # postmanのbodyのところに書いている
          # 配列のかたちで代入
          # それをeach文で拾う
          # ================================
        post do
          cards = params[:cards]
          strongest = 0
          cards.each_with_index do |card_compare,i|
            point_each = JudgeCards.new.judge_cards(card_compare)[:point]
            if point_each > strongest
              strongest = point_each
            end
            return strongest
          end

          result = []
          cards.each_with_index do |card,i|
            result_each ={}
            result_each[:card] = card
            error = CheckInput.new.check(card)[0]
            if error.empty?
              result_each[:hand] = JudgeCards.new.judge_cards(card)[:hand]
              point_each = JudgeCards.new.judge_cards(card)[:point]
              if point_each >= strongest
                result_each[:best] = true
              else
                reult_each[:best] = false
              end
            else
              result_each[:error] = error
            end

            result.append(result_each)
            return result
          end
          binding.pry
          return {result: result}
        end
      end
    end
  end
end
