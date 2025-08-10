# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItems::Create do
  describe "#call" do
    let(:list) { create(:list) }
    let(:existing_task) { create(:line_item, task: 'Yard work') }

    before do
      list
      existing_task
    end

    it "creates a new line item" do
      result = described_class.call(params: { task: 'chores', list: list.id })
      expect(result).to be_success
      expect(result.success.task).to eq('chores')
    end

    it "validates minimum task length" do
      result = described_class.call(params: { task: FFaker::Lorem.characters(3), list: list.id })
      expect(result).to be_failure
    end

    it "validates the task is unique" do
      result = described_class.call(params: { task: 'Yard work', list: list.id })
      expect(result).to be_failure
      expect(result.failure).to include("Task has already been taken")
    end
  end
end
