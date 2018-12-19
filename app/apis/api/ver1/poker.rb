#このファイルでは、poker クラスを定義している。
module API
  module Ver1
    class Poker < Grape::API
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
        post do
          # 入力したデータを受取
          @cards = params[:cards]
          @test = params[:test]
          return @cards,@test
          # @cards = params[:cards]
        end
      end
    end
  end
end
