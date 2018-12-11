module API
  module Ver1
    class Poker < Grape::API
      resource :poker do
        # GET /api/ver1/poker
        desc "ポーカーの役を返す"
        # prefix 'poker'
        post do
          # 入力したデータを受取る
          @cards = params[:cards]
          # データを加工してhomecontrollerが受け取れるようにする
          # コントローラに渡して約わおつける
          # 強さを判定する
          # 約とその強さを返す
        end
      end
    end
  end
end
