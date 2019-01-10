class CheckInput
  def check_same_cards(card)
    @count_max = 0
    card_split = card.split(" ")
    card_split.each_with_index do |check, i|
      count_check = card_split.count(check)
      if count_check > @count_max
        @count_max = count_check
      end
    end
    return @count_max
  end

  def check_each_cards(card)
    @check_message = []
    @count_error = 0
    card_split = card.split(" ")
    card_split.each_with_index do |check, i|
      if check !~ (/^[HDSC](1[0123]|[1-9])$/)
        @check_message.push("#{i+1}番目のカードに不正があります →  #{check}")
        @count_error = @count_error + 1
      end
    end
    return @count_error
  end

  def check(card)
    @error_message = []
    if card.empty?
    # 値が入力されていない場合
      @error_message.push( "値が入力されていません" )
    end

    if card !~ (/^\w*\s\w*\s\w*\s\w*\s\w*$/)
    # 設定した入力形式にしたがっていない場合
      @error_message.push( "5枚のカードの指定文字を、半角スペースで区切って入力してください" )
    end
    if check_each_cards(card) >= 1
      @error_message.push(@check_message)
    end
    if check_same_cards(card) >= 2
      @error_message.push( "同じカードが2枚以上入力されています。" )
    end
    return @error_message
  end
end
