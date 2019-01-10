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
          check = CheckInput.new.check(cards)
          # 入力したデータを受取
          if check.empty?
            judge = JudgeCards.new.judge_cards(cards)
            result = {
              card: cards,
              result: judge,
              error: check,
            }
            return result
          else
            result = {
              card: cards,
              error: check,
            }
            return result
            # @cards = params[:cards]
          end
        end
      end
    end
  end
end
