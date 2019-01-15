# このファイルでは、poker クラスを定義している。
require '.\app\models\judge_cards.rb'

module API
  module Ver1
    class Poker < Grape::API
      # include CheckInput
      prefix 'api'
      version 'ver1', using: :path
      format :json
      resources :poker do
        get do
          return 'ok'
        end

        post do
          cards = params[:cards]
          result = JudgeCards.new.judge_cards_for_api(cards)
          return { result: result }
        end
      end
    end
  end
end
