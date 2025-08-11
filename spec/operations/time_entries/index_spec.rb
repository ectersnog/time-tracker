# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeEntries::Index do
  describe '#call' do
    let!(:time_entry_a) { create(:time_entry) }
    let!(:time_entry_b) { create(:time_entry) }
    let!(:time_entry_c) { create(:time_entry) }

    it "returns all time_entries" do
      result = described_class.call
      expect(result).to be_success
      expect(result.success).to include(time_entry_a, time_entry_b, time_entry_c)
    end
  end
end
