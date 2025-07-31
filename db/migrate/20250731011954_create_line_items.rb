# frozen_string_literal: true

class CreateLineItems < ActiveRecord::Migration[8.0]
  def change
    create_table :line_items do |t|
      t.belongs_to :list, null: false, foreign_key: true
      t.string :task, null: false

      t.timestamps
    end
  end
end
