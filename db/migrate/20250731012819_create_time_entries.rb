# frozen_string_literal: true

class CreateTimeEntries < ActiveRecord::Migration[8.0]
  def change
    create_table :time_entries, id: :uuid do |t|
      t.belongs_to :line_item, null: false, type: :uuid, foreign_key: true
      t.datetime :started_at, null: false
      t.datetime :stopped_at

      t.timestamps
    end
  end
end
