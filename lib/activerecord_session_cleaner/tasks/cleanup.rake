require 'activerecord_session_cleaner/session'

namespace :activerecord_session_cleaner do
  namespace :cleanup do
    def puts_if_verbose(message)
      puts message if Rake.verbose
    end

    desc 'Delete old sessions from an Active Record session store'
    task :old, [:days_to_keep] => :environment do |t, args|
      keep_after = if !(/^[0-9]+$/ =~ args.days_to_keep)
                     10.days.ago
                   else
                     args.days_to_keep.to_i.days.ago
                   end
      puts_if_verbose "\e[1;33mDeleting sessions before #{keep_after}\e[0m"
      deleted_sessions = ActiverecordSessionCleaner::Session.delete_all(['updated_at < ?', keep_after])
      puts_if_verbose "\e[1;32m#{deleted_sessions} old sessions were deleted\e[0m"
    end

    desc 'Delete all session from an Active Record session store'
    task all: :environment do
      puts_if_verbose "\e[1;33mTruncating sessions table\e[0m"
      ActiverecordSessionCleaner::Session.truncate
      puts_if_verbose "\e[1;32mAll sessions were deleted\e[0m"
    end
  end
end
