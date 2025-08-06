# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TimeEntry do
  subject { build(:time_entry, line_item: create(:line_item)) }

  describe 'validations' do
    it { is_expected.to allow_value(Time.current).for(:started_at) }
    it { is_expected.not_to allow_value(nil).for(:started_at) }
    it { is_expected.to allow_value(1.hour.from_now).for(:stopped_at) }
    it { is_expected.to allow_value(nil).for(:stopped_at) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:line_item) }
  end
end
