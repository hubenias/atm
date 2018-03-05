require 'grape'
require_relative 'machine'

module ATM
  class API < Grape::API
    prefix :api
    format :json

    get :status do
      Machine.instance.banknotes.to_json
    end

    post :deposit do
      Machine.instance.deposit(params[:amount])
      Machine.instance.banknotes.to_json # TODO: return some nice code here
    end

    post :withdrawal do
      Machine.instance.withdrawal(params[:amount]).to_json
    end
  end
end