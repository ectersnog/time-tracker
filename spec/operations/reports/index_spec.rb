# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Reports::Index do
  describe '#call' do
    let(:list_a) { create(:list) }
    let(:line_item_list_a) { create(:line_item, list: list_a) }

    let(:entry1_list_a) do
      create(
        :time_entry,
        line_item: line_item_list_a,
        started_at: Time.zone.parse('10:00 August 2nd, 1995'),
        stopped_at: Time.zone.parse('10:57 August 2nd, 1995')
      )
    end

    let(:entry2_list_a) do
      create(
        :time_entry,
        line_item: line_item_list_a,
        started_at: Time.zone.parse('10:00 August 3rd, 1995'),
        stopped_at: Time.zone.parse('10:57 August 3rd, 1995')
      )
    end

    let(:entry3_list_a) do
      create(
        :time_entry,
        line_item: line_item_list_a,
        started_at: Time.zone.parse('10:00 August 4th, 1995'),
        stopped_at: Time.zone.parse('10:57 August 4th, 1995')
      )
    end

    let(:list_b) { create(:list) }
    let(:line_item_list_b) { create(:line_item, list: list_b) }

    let(:entry1_list_b) do
      create(
        :time_entry,
        line_item: line_item_list_b,
        started_at: Time.zone.parse('11:00 August 2nd, 1995'),
        stopped_at: Time.zone.parse('11:57 August 2nd, 1995')
      )
    end

    let(:entry2_list_b) do
      create(
        :time_entry,
        line_item: line_item_list_b,
        started_at: Time.zone.parse('11:00 August 3rd, 1995'),
        stopped_at: Time.zone.parse('11:57 August 3rd, 1995')
      )
    end

    let(:entry3_list_b) do
      create(
        :time_entry,
        line_item: line_item_list_b,
        started_at: Time.zone.parse('11:00 August 4th, 1995'),
        stopped_at: Time.zone.parse('11:57 August 4th, 1995')
      )
    end

    before do
      entry1_list_a
      entry2_list_a
      entry3_list_a
      entry1_list_b
      entry2_list_b
      entry3_list_b
    end

    it "returns all lists" do
      result = described_class.call(params: { start: '10:00 August 2nd, 1995', end: '12:00 August 4th, 1995' })
      expect(result).to be_success
      expect(result.success.first.total_time_seconds).to eq(10_260)
      expect(result.success.second.total_time_seconds).to eq(10_260)
    end
  end
end
