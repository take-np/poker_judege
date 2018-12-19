require 'grape'

module API
  class Root < Grape::API
    # api を前に置く。api
    prefix 'api'
      version 'ver1', using: :path
      format :json
    mount API::Ver1::Poker
    # ver1もpokerも読み込んでくれ、がmountの意味

    get do

    end
  end
end
