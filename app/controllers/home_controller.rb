class HomeController < ApplicationController

  def top
  end

  def judge
  # ================================
  # Validationのアイディア
  # render (url) and return で処理がそれ以降進まずにとまる
  # ================================
    cards = params[:cards]
    puts cards
    # 入力内容のエラー
    if cards == ""
      @error_message = "カードが入力されていません"
      puts @error_message
      render("home/top") and return
    end
=begin
  redirect_toとrenderのパスの指定の仕方が異なる
  renderはファイルパスを指定する
=end
=begin
正規表現に一致するかどうかの処理
"/[HSDC][1-13]\s[HSDC][1-13]\s/"
=end
# cardの数が足りません

    card_s = cards.split(" ")

      # [同じカードが2枚以上含まれているエラー]
      count_max = 0
      card_s.each do |check|
        count_check = card_s.count(check)
        if count_check > count_max
          count_max = count_check
        end
      end

      if count_max >= 2
        @error_message = "同じカードが2枚以上入力されています。"
        puts @error_message
        render("home/top") and return
      end
      # 入力内容が消されないように遷移する→
      # render_to("/")

      # 分割した数字を入れていく配列
      numbers = []
      # 分割したsuitを入れていく配列
      suits = []
      # 入力文字を配列に代入する処理
      card_s.each do |card|
         item = card.split(/\A(.{1,1})/,2)[1..-1]
         suits.push(item[0])
         numbers.push(item[1].to_i)
       end

       puts suits

       # 比較基準となるデータ
       number_s = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
       suit_s = ["H", "D", "S", "C"]
       # numbersを降りる順に並べ替える処理
       numbers = numbers.sort{|a, b| b<=>a}
       # 参考）sort!メソッドの場合には新しい配列を返すのではなく、対象の配列自身をブロック内で指定した比較方法でソートした配列に変更します。
       # https://www.javadrive.jp/ruby/array_class/index14.html

       # suitを数える処理
       suit_max = 0
       suit_s.each do |suit|
         count = suits.count(suit)
         if count > suit_max
           suit_max = count
         end
       end
       puts suit_max
       # 役判定
       # ================================
       if suit_max == 5 #5枚のスートが一種類で構成されている
         @result = judgeStraightFlash(numbers)
       else #5枚のスートが一種類で構成されてない
         if judgeStraight(numbers) == true
           @result = judgeStraight(numbers)
         else
           @result = nonStraight(numbers)
         end
       end
       # ================================
      render("home/top")
  end

  # ストレートフラッシュか判定する関数
  def judgeStraightFlash(numbers)
    numbers = numbers.sort{|a, b| b<=>a} # numbersを昇順に並べる式
    # ストレートかどうかの判定式。
    # 行末の "\" は命令内で改行を無視するための（改行を可能にする式）
    if numbers[0]-numbers[1] == 1 && numbers[1] - numbers[2] == 1 && numbers[2] - numbers[3] == 1 && numbers[3] - numbers[4] == 1  || numbers == [13, 12, 11, 10, 1]
       return "ストレートフラッシュ"
     else
       return "フラッシュ"
    end
  end

  # ストレートか判定する関数
  def judgeStraight(numbers)
    numbers = numbers.sort{|a, b| b<=>a}
    if numbers[0]-numbers[1] == 1 && numbers[1] - numbers[2] == 1 && numbers[2] - numbers[3] == 1 && numbers[3] - numbers[4] == 1
      return "ストレート"
    else
      return false
    end
  end

  # ストレート以外の役を判定する関数
  def nonStraight(numbers)
    # 数値を並べ替え、
    # 降りる順になれべ変えたときの、小さいインデックスから同じ数字の数を確認する
    # 同じ数字の数を数える関数
    number_s = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    number_array = []
    number_s.each do |number|
      count = numbers.count(number)
      number_array.append(count)
      number_array = number_array.sort{|a, b| b<=>a}
    end

    if number_array[0] == 4
      return "フォーオブアカインド"
    elsif number_array[0] ==3 && number_array[1]==2
      return "フルハウス"
    elsif number_array[0] == 3 && number_array[1] == 1
      return "スリー・オブ・ア・カインド"
    elsif number_array[0] == 2 && number_array[1] == 2
      return "ツーペア"
    elsif number_array[0] == 2 && number_array[1] == 1
      return "ワンペア"
    else
      return "役なし"
    end
  end

end
# def judgeStraight(numbers) # numbersは " 配列形式 "
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
