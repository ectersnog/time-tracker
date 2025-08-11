# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeEntries::Update do
  describe "#call" do
    let!(:time_entry) { create(:time_entry, started_at: Time.current) }

    it "updates an existing time_entry" do
      result = described_class.call(params: { id: time_entry.id, started_at: Time.zone.local(1992, 12, 24, 11, 59, 0) })
      expect(result).to be_success
      expect(result.success.started_at).to eq(Time.zone.local(1992, 12, 24, 11, 59, 0))
    end

    it "fails to update stopped_at to before started_at" do
      result = described_class.call(params: { id: time_entry.id, stopped_at: 1.day.ago })
      expect(result).to be_failure
    end
  end
end
