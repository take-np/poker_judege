require 'grape'

module API
  class Root < Grape::API
    prefix "api"
    # api を前に置く。api
    mount API::Ver1::Poker
    # ver1もpokerも読み込んでくれ、がmountの意味

    get do

    end
  end
end
