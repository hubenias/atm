require_relative 'machine'

module ATM
  class Change
    class << self
      def get(amount, banknotes)
        change(amount, banknotes.dup, Hash.new(0), avail_banknotes.first)
      end

      private

      def change(amount, banknotes, res, bill)
        return res if amount.zero?
        return unless bill

        if bill.to_i <= amount && banknotes.fetch(bill, 0) > 0
          banknotes[bill] -= 1
          res[bill] += 1
          return res if change(amount - bill.to_i, banknotes, res, bill)
        end
        bill = next_bill(bill)
        change(amount, banknotes, res, bill)
      end

      def next_bill(bill)
        curr_pos = avail_banknotes.index(bill)
        bill = avail_banknotes[curr_pos + 1]
      end

      def avail_banknotes
        ATM::Machine::BANKNOTES
      end
    end
  end
end
