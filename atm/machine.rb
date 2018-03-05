require 'singleton'
require_relative 'change'

module ATM
  class Machine
    include Singleton # TODO: consider removing this and use simple class/module approach instead

    attr_accessor :banknotes # TODO: looks like we don't need this, it should be private
    BANKNOTES = %w(50 25 10 5 2 1).freeze

    def initialize
      @banknotes = Hash.new(0)
    end

    def deposit(banknotes)
      # TODO: return error if there's no such banknote
      banknotes.each do |b, qty|
        @banknotes[b] += qty
      end
    end

    def withdrawal(amount)
      res = Change.get(amount, banknotes)
      res.each { |k, v| banknotes[k] -= v } if res
      res
    end

    def account
      @account ||= { amount: 200 } # TODO: assoc. with some real account
    end
  end
end