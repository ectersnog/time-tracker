# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItems::Update do
  describe "#call" do
    let(:line_item) { create(:line_item, task: 'eat pizza') }
    let(:existing_task) { create(:line_item, task: 'eat nachos') }

    before do
      line_item
      existing_task
    end

    it "updates an existing line_item" do
      result = described_class.call(params: { id: line_item.id, task: 'eat burgers' })
      expect(result).to be_success
      expect(result.success.task).to eq('eat burgers')
    end

    it "doesn't allow update to an already existing task" do
      result = described_class.call(params: { id: line_item.id, task: 'eat nachos' })
      expect(result).to be_failure
      expect(result.failure).to include("Task has already been taken")
    end
  end
end
