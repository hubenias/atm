require_relative '../../atm/machine'

describe ATM::Machine do
  subject { described_class.instance }

  describe '#deposit' do
    # proper banknote
    # error for wrong banknote
    # + changes avail_banknotes
    let(:banknotes) { { '1' => 2 } }
    it 'changes available banknotes amount' do
      subject.feed(banknotes)
      expect(subject.banknotes['1']).to eq(2)
    end
  end
end
