require 'rails_helper'

describe InputValidation do
  judge_nill = ""
  it "値が空" do
    expect(InputValidation.new.input_validation(judge_nill)).to eq "値が入力されていません"
  end

  judge_nil = nil
  it "値が空" do
    expect(InputValidation.new.input_validation(judge_nil)).to eq "値が入力されていません"
  end

  diff_space = "H12,H13,D1,D4,D6"
  it "形式のずれ" do
    expect(InputValidation.new.input_validation(diff_space)).to eq "カードが指定された形式で入力されていません"
  end

  diff_alphabet = "A12,H13,D1,D4,D6"
  it "指定されていアルファベット" do
    expect(InputValidation.new.input_validation(diff_alphabet)).to eq "カードが指定された形式で入力されていません"
  end

  diff_number_over = "H44 H12 D5 D4 D6"
  it "数字が超過している" do
    expect(InputValidation.new.input_validation(diff_number_over)).to eq "カードが指定された形式で入力されていません"
  end

  card_over = "H12 H12 D6 D7 S8"
  it "同じカードが2枚以上入力されている" do
    expect(InputValidation.new.input_validation(card_over)).to eq "同じカードが2枚以上入力されています。"
  end

end
