require 'spec_helper'

describe TottoriOpenDataCatalog::Command do

  describe '#to_csv' do

    it 'does not raise errors.' do
      expect do
        TottoriOpenDataCatalog::Command.to_csv
      end.not_to raise_error
    end

  end

  describe '#to_json' do

    it 'does not raise errors.' do
      expect do
        TottoriOpenDataCatalog::Command.to_json
      end.not_to raise_error
    end

  end

end
