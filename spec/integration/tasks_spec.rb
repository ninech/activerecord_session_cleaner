require 'spec_helper'

require 'active_record'
require 'activerecord_session_cleaner/tasks'

describe 'activerecord_session_cleaner:cleanup', type: :rake do
  before do
    ActiveRecord::Base.establish_connection(
      adapter: "sqlite3",
      database: ":memory:"
    )

    ActiveRecord::Schema.verbose = false
    ActiveRecord::Schema.define do
      create_table :sessions do |table|
        table.column :title, :string
        table.timestamps
      end
    end

    Range.new(0, 14).each do |x|
      ActiverecordSessionCleaner::Session.create title: "#{x} days ago", updated_at: x.days.ago
    end
  end

  describe ':old' do
    let(:task_name) { 'activerecord_session_cleaner:cleanup:old' }

    it 'removes the oldest 5 sessions' do
      expect { subject.execute }.to change { ActiverecordSessionCleaner::Session.count }.by(-5)
    end
  end

  describe ':all' do
    let(:task_name) { 'activerecord_session_cleaner:cleanup:all' }

    it 'removes all the sessions' do
      expect { subject.execute }.to change { ActiverecordSessionCleaner::Session.count }.from(15).to(0)
    end
  end
end
