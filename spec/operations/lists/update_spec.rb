# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lists::Update do
  describe "#call" do
    let!(:list) { create(:list, name: 'pizzas') }

    it "updates an existing list" do
      result = described_class.call(params: { id: list.id, name: 'burgers' })
      expect(result).to be_success
      expect(result.success.name).to eq('burgers')
    end
  end
end
