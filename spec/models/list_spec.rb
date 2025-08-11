# frozen_string_literal: true

require 'rails_helper'

RSpec.describe List do
  describe 'validations' do
    it { is_expected.to allow_value(FFaker::Name).for(:name) }
    it { is_expected.not_to allow_value(nil).for(:name) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:line_items) }
  end
end
