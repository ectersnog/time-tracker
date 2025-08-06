# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lists::Create do
  describe "#call" do
    it "creates a new list" do
      result = described_class.call(params: { name: 'pizzas' })
      expect(result).to be_success
      expect(List.count).to eq 1
      expect(result.success.name).to eq('pizzas')
    end

    it "validates minimum name length" do
      result = described_class.call(params: { name: FFaker::Lorem.characters(3) })
      expect(result).to be_failure
    end

    it "validates maximum name length" do
      result = described_class.call(params: { name: FFaker::Lorem.characters(21) })
      expect(result).to be_failure
    end
  end
end
