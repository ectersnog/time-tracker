# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LineItem do
  describe 'validations' do
    it { is_expected.to allow_value(FFaker::Lorem.characters(4)).for(:task) }
    it { is_expected.not_to allow_value(nil).for(:task) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:time_entries) }
  end
end
