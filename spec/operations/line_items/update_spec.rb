# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItems::Update do
  describe "#call" do
    let!(:line_item) { create(:line_item, task: 'eat pizza') }

    it "updates an existing line_item" do
      result = described_class.call(params: { id: line_item.id, task: 'eat burgers' })
      expect(result).to be_success
      expect(result.success.task).to eq('eat burgers')
    end
  end
end
