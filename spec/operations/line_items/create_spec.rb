# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItems::Create do
  describe "#call" do
    let!(:list) { create(:list) }

    it "creates a new line item" do
      result = described_class.call(params: { task: 'chores', list: list.id })
      expect(result).to be_success
      expect(LineItem.count).to eq 1
      expect(result.success.task).to eq('chores')
    end

    it "validates minimum task length" do
      result = described_class.call(params: { task: FFaker::Lorem.characters(3), list: list.id })
      expect(result).to be_failure
    end
  end
end
