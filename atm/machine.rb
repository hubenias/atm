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
      wrong_banknotes = banknotes.select {|k, v| !BANKNOTES.include?(k) }
      raise ArgumentError, "Wrong banknotes: (#{wrong_banknotes.keys.join(',')})." unless wrong_banknotes.empty?
      amount = banknotes.map { |b, qty| b.to_i * qty }.reduce(:+)
      banknotes.each do |b, qty|
        @banknotes[b] += qty
      end
      amount
    end

    def withdrawal(amount)
      res = Change.get(amount, banknotes)
      res.each { |k, v| banknotes[k] -= v } if res
      res
    end
  end
end