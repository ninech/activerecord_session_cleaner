module ActiverecordSessionCleaner
  class Railtie < Rails::Railtie
    rake_tasks { require 'activerecord_session_cleaner/tasks' }
  end
end
