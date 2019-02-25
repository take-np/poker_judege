require 'rails_helper'
# 異常系のテスト

# 異常系のパターンを作成
@error_number_alphabet = {
  no_input: "",
  nil_input: nil,
  ex_space: "h1",
  komoji: "h1 H2 H3 H4 H5",
  zenkaku_alphabet: "h１ H2 H3 H4 H5",
  zennkaku_number:	"H１ H2 H3 H4 H5",
  suit_except_HSDC:	"A1 H2 H3 H4 H5",
  number_over: "H11111 H3 H4 H5 H6",
  kigou_mix: "H1 H2 H3- H5 H6"
}
@error_space ={
  zenkaku_space: "H1　H2 H3 H4 H5",
  zenkaku_space_head: "H1 H2 H3 H4 H5",
  zenkaku_space_back: "H1 H2 H3 H4 H5　",
  comma: "H1,H2,H3, H4, H5"
}
@error_card ={
  card_shortage: "H1 H2",
  card_over: "H1 H2 H3 H4 H5 H6",
  same_card: "H1 H1 H1 H2 H7",
  same_card_all: "H1 H1 H1 H1 H1",
}

# バリデーションの設定
describe InputValidation do
  it "値が入力されていない場合" do
    expect(InputValidation.new.input_validation(@error_number_alphabet )).to eq "値が入力されていません"
  end

  it "nil が渡された場合" do
    expect(InputValidation.new.input_validation(@error_number_alphabet )).to eq "値が入力されていません"
  end

  it "形式のずれ" do
    expect(InputValidation.new.input_validation(@error_number_alphabet )).to eq "カードが指定された形式で入力されていません"
  end

  it "指定されていアルファベット" do
    expect(InputValidation.new.input_validation(@error_number_alphabet )).to eq "カードが指定された形式で入力されていません"
  end

  it "数字が超過している" do
    expect(InputValidation.new.input_validation(diff_number_over)).to eq "カードが指定された形式で入力されていません"
  end

  it "同じカードが2枚以上入力されている" do
    expect(InputValidation.new.input_validation(card_over)).to eq "同じカードが2枚以上入力されています。"
  end

end
