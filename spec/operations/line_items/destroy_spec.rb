# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItems::Destroy do
  describe '#call' do
    let!(:line_item) { create(:line_item) }

    it 'deletes an existing line_item' do
      result = described_class.call(params: { id: line_item.id })
      expect(result).to be_success
      expect(LineItem.exists?(line_item.id)).to be false
    end
  end
end
