# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeEntries::Create do
  describe "#call" do
    let!(:line_item) { create(:line_item) }

    it "creates a new time entry" do
      result = described_class.call(params: { started_at: Time.current, line_item: line_item.id })
      expect(result).to be_success
      expect(TimeEntry.count).to eq 1
    end

    it "does not allow stopped_at to be in the past" do
      result = described_class.call(params: { started_at: Time.current, stopped_at: 1.hour.ago, line_item: line_item.id })
      expect(result).to be_failure
    end
  end
end
