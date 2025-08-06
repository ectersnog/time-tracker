# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lists::Destroy do
  describe '#call' do
    let!(:list) { create(:list) }

    it 'deletes an existing list' do
      result = described_class.call(params: { id: list.id })
      expect(result).to be_success
      expect(List.exists?(list.id)).to be false
    end
  end
end
