require_relative '../../atm/machine'

describe ATM::Machine do
  subject { described_class.instance }

  describe '#deposit' do
    context 'with proper banknotes' do
      let(:banknotes) { { '2' => 1, '1' => 2 } }
      it 'returns deposit amount' do
        expect(subject.deposit(banknotes)).to eq(4)
      end

      it 'adds to existing banknotes' do
        subject.banknotes['1'] = 1
        subject.banknotes['2'] = 1
        subject.deposit(banknotes)
        expect(subject.banknotes['1']).to eq(3)
        expect(subject.banknotes['2']).to eq(2)
      end

      it 'does not change amount of other banknotes' do
        subject.banknotes['5'] = 1
        subject.deposit(banknotes)
        expect(subject.banknotes['5']).to eq(1)
      end
    end

    context 'non-existing banknotes' do
      it 'raises error' do
        expect { subject.deposit('3' => 1) }.to raise_error(ArgumentError, 'Wrong banknotes: (3).')
      end
    end
  end

  describe '#withdrawal' do
    let(:banknotes) { { '2' => 1, '1' => 2 } }
    context 'when there is not enough money' do
      it 'returns nil' do
        subject.banknotes = banknotes
        expect(subject.withdrawal(5)).to be_nil
      end
    end

    it 'returns proper result' do
      subject.banknotes = banknotes
      expect(subject.withdrawal(4)).to eq('2' => 1, '1' => 2)
    end

    it 'changes available banknotes amount' do
      subject.banknotes = banknotes
      subject.withdrawal(3)
      expect(subject.banknotes).to eq('2' => 0, '1' => 1)
    end
  end
end
