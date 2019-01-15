require '.\app\models\check_input.rb'

class JudgeCards
  # =============== 以下webアプリ・API共通メソッド ===============
  def split_suit_number(card)
    @card_split = card.split(" ")
    @numbers = []
    @suits = []
    @card_split.each do |split_number_suits|
      item = split_number_suits.split(/\A(.{1,1})/,2)[1..-1]
      @suits.push(item[0])
      @numbers.push(item[1].to_i)
    end
    return @numbers, @suits
  end
  # suit の数を数える
  def count_suit(suits)
    suit_data = ["H", "D", "S", "C"]
    @suit_max = 0
    suit_data.each do |suit|
      suit_count = suits.count(suit)
      if suit_count > @suit_max
        @suit_max = suit_count
      end
    end
    return @suit_max
  end

  def judge_number_except_straight_flash(numbers)
    number_data = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13]
    number_array = []
    number_data.each do |number|
      count = numbers.count(number)
      number_array.append(count)
      number_array = number_array.sort{|a, b| b<=>a}
    end

    if number_array[0] == 4
      @result = {hand: "フォーオブアカインド", point: 8}
    elsif number_array[0] ==3 && number_array[1]==2
      @result = {hand: "フルハウス", point: 7}
    elsif number_array[0] == 3 && number_array[1] == 1
      @result = {hand: "スリー・オブ・ア・カインド", point: 4}
    elsif number_array[0] == 2 && number_array[1] == 2
      @result = {hand: "ツーペア", point: 3}
    elsif number_array[0] == 2 && number_array[1] == 1
      @result = {hand: "ワンペア", point: 2}
    else
      @result = {hand: "ハイカード", point: 1}
    end
  end

  def judge_cards(card)
    split_suit_number(card)  # =>     @numbers,@suits}
    numbers = @numbers.sort{|a, b| b<=>a}
    if numbers == [13, 12, 11, 10, 1] && count_suit(@suits) == 5
      @result = {hand: "ストレートフラッシュ", point: 9}
    elsif numbers[0]-numbers[1] == 1 && numbers[1] - numbers[2] == 1 && numbers[2] - numbers[3] == 1 && numbers[3] - numbers[4] == 1
      if count_suit(@suits) == 5
        @result = {hand: "ストレートフラッシュ", point: 9}
      else
        @result = {hand: "ストレート", point: 5}
      end
    elsif count_suit(@suits) == 5
      @result = {hand: "フラッシュ", point: 6}
    else
      judge_number_except_straight_flash(numbers)
    end
    return @result
  end
  # =============== ここまでwebアプリ・API共通メソッド ===============

  # =============== 以下API用メソッド ===============
  def judge_strong_card(cards)
    strongest = 0
    cards.each_with_index do |card_compare,i|
      point_each = judge_cards(card_compare)[:point]
      if point_each > strongest
        strongest = point_each
      end
      return strongest
    end
  end

  def judge_cards_for_api(cards)
    result = []
    strongest_point = judge_strong_card(cards)
    cards.each_with_index do |card,i|
      result_each ={}
      result_each[:card] = card
      point_each = judge_cards(card)[:point]
      error = CheckInput.new.check(card)
      if error.empty?
        result_each[:hand] = judge_cards(card)[:hand]
        if point_each >= strongest_point
          result_each[:best] = true
        else
          result_each[:best] = false
        end
      else
        result_each[:error] = error
      end
      result.append(result_each)
    end
    return result
  end
  # =============== ここまでAPI用メソッド ===============
end
