# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItems::Index do
  describe '#call' do
    let!(:line_item_a) { create(:line_item) }
    let!(:line_item_b) { create(:line_item) }
    let!(:line_item_c) { create(:line_item) }

    it "returns all line_items" do
      result = described_class.call
      expect(result).to be_success
      expect(result.success).to include(line_item_a, line_item_b, line_item_c)
    end
  end
end
