# 中身を空で以下のテストを自校した結果、エラーは発生せず。
# home_controller.rb の記述で問題ありか
require 'rails_helper'
describe TestController do
  it "足し算" do
    expect(TestController.new.add(1, 1)).to eq 2
  end
end
