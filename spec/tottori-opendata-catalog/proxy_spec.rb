require 'spec_helper'

describe TottoriOpenDataCatalog::Proxy do
  describe '#get' do
    it 'does not raise errors.' do
      expect do
        TottoriOpenDataCatalog::Proxy.get
      end.not_to raise_error
    end
  end
end
