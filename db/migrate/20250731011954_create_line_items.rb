# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items, id: :uuid do |t|
      t.belongs_to :list, null: false, type: :uuid, foreign_key: true
      t.string :task, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
