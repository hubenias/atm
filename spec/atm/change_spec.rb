require_relative '../../atm/change'

describe ATM::Change do
  subject { described_class }
  describe '#get' do
    context 'when change can not be done' do
      it 'returns nil' do
        expect(subject.get(2, '1' => 1)).to be_nil
      end
    end

    it 'makes proper change' do
      banknotes = { '5' => 2, '2' => 2, '1' => 2 }
      expect(subject.get(1, banknotes)).to eq('1' => 1)
      expect(subject.get(2, banknotes)).to eq('2' => 1)
      expect(subject.get(3, banknotes)).to eq('2' => 1, '1' => 1)
      expect(subject.get(4, banknotes)).to eq('2' => 2)
      expect(subject.get(5, banknotes)).to eq('5' => 1)
      expect(subject.get(6, banknotes)).to eq('5' => 1, '1' => 1)
    end
  end
end
