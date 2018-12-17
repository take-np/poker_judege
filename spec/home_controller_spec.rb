# 参考URL http://qs.nndo.jp/unit-test-by-ruby-with-rspec

require 'rails_helper'

describe HomeController do
  sf = [5, 2, 3, 4, 1]
  it "ストレートフラッシュ" do
    expect(HomeController.new.judge_straight_flash(sf)).to eq "ストレートフラッシュ"
  end

  flash = [1, 3, 4, 13, 8]
  it "フラッシュ" do
    expect(HomeController.new.judge_straight_flash(flash)).to eq "フラッシュ"
  end

  straight = [13, 9, 10 ,12, 11]
  it "ストレート" do
    expect(HomeController.new.judge_straight(straight)).to eq "ストレート"
  end

  four=[1,1,2,1,1]
  it "フォーオブアカインド" do
    expect(HomeController.new.judge_no_straight(four)).to eq "フォーオブアカインド"
  end
  house = [3, 13, 3, 13, 13]
  it "フルハウス" do
    expect(HomeController.new.judge_no_straight(house)).to eq "フルハウス"
  end
  three = [13, 13, 13, 12, 11]
  it "スリー・オブ・ア・カインド" do
    expect(HomeController.new.judge_no_straight(three)).to eq "スリー・オブ・ア・カインド"
  end
  two = [13, 13, 11, 10, 11]
  it "ツーペア" do
    expect(HomeController.new.judge_no_straight(two)).to eq "ツーペア"
  end
  one = [13, 13, 10, 9, 8]
  it "ワンペア" do
    expect(HomeController.new.judge_no_straight(one)).to eq "ワンペア"
  end
  no = [1, 4, 5, 13, 10]
  it "役なし" do
    expect(HomeController.new.judge_no_straight(no)).to eq "役なし"
  end


 #  @numbers=[1, 2, 3, 4, 5]
 # it "足し算でできること" do
 #   expect(HomeController.new.judge_straight_flash(@numbers)).to eq true
 # end
end


# #
# 以下は記述のサンプル
# テストの実行はrspecコマンドをそのまま叩くことで実行できる。rspecコマンドは、作業ディレクトリ以下のテストスクリプトを探索し、それを実行して結果を標準出力する。
# ================================
# [/src/calc.rb]
# class Calc
#
#   def add(a, b)
#     a + b
#   end
#
#   def subtract(a, b)
#     a - b
#   end
#
#   def multiply(a, b)
#     a * b
#   end
#
#   def divide(a, b)
#     a / b
#   end
#
# end
#
# [/spec/calc_spec.rb]
# require 'rspec'
# require_relative '../src/calc'
#
# RSpec.describe Calc do
#   it "足し算できること" do
#     expect(Calc.new.add(1, 1)).to eq 2
#   end
# end
# # ================================
