#このファイルでは、poker クラスを定義している。
module API
  module Ver1
    class Poker < Grape::API
      resources :poker do


        # APIではparamsを指定して、取得したい情報を受取る
        # 必ず取得したいもの requires nilでも問題ないもの optional

        get do
          puts "oke"
        end

        #
        # prams do
        #   requires :@cards, type: String
        # end

        # getd
          # GET /api/ver1/poker
          desc "ポーカーの役を返す"
          # prefix 'poker'
        post do
          # 入力したデータを受取る
          @cards = params[:cards]
        end
      end
    end
  end
end
