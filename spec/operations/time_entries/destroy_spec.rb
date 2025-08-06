# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeEntries::Destroy do
  describe '#call' do
    let!(:time_entry) { create(:time_entry) }

    it 'deletes an existing time_entry' do
      result = described_class.call(params: { id: time_entry.id })
      expect(result).to be_success
      expect(TimeEntry.exists?(time_entry.id)).to be false
    end
  end
end
