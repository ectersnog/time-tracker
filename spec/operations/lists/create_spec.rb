# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lists::Create do
  describe "#call" do
    let(:existing_list) { create(:list, name: 'Work') }

    before do
      existing_list
    end

    it "creates a new list" do
      result = described_class.call(params: { name: 'pizzas' })
      expect(result).to be_success
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

    it "validates the name is unique" do
      result = described_class.call(params: { name: 'Work' })
      expect(result).to be_failure
      expect(result.failure).to include("Name has already been taken")
    end
  end
end
