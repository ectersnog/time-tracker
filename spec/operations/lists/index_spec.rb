# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lists::Index do
  describe '#call' do
    let!(:list_a) { create(:list) }
    let!(:list_b) { create(:list) }
    let!(:list_c) { create(:list) }

    it "returns all lists" do
      result = described_class.call
      expect(result).to be_success
      expect(result.success).to include(list_a, list_b, list_c)
    end
  end
end
