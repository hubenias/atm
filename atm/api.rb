require 'grape'
require_relative 'machine'

module ATM
  class API < Grape::API
    prefix :api
    format :json

    get :status do
      Machine.instance.banknotes.to_json
    end

    params do
      requires :banknotes, type: Hash
    end
    post :deposit do
      begin
        amount = Machine.instance.deposit(params[:banknotes])
        amount.to_json
      rescue ArgumentError => e
        error! e, 400
      end
    end

    params do
      requires :amount, type: Integer
    end
    post :withdrawal do
      res = Machine.instance.withdrawal(params[:amount])
      error!('ATM does not have enough cash', 400) unless res
      res.to_json
    end
  end
end