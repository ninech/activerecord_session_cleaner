require 'erb'
require 'ostruct'
require 'tempfile'
require 'whenever'

require 'activerecord_session_cleaner/session'

namespace :activerecord_session_cleaner do
  namespace :crontab do
    class ERBStruct < OpenStruct
      def render(template)
        ERB.new(template).result(binding)
      end
    end

    DEFAULT_ENVIRONMENT = 'development'

    desc 'Setup/update cron for session cleanup'
    task :update, [:application_name, :days_to_keep] => :environment do |t, args|
      template_data = ERBStruct.new(days_to_keep: args.days_to_keep)
      template = File.read(File.expand_path('../../templates/schedule.rb.erb', __FILE__))
      schedule_file = Tempfile.new('activerecord_session_cleaner-schedule')
      schedule_file.write template_data.render(template)
      schedule_file.close(false)
      Whenever::CommandLine.execute({
        update: true,
        identifier: "#{args.application_name}-activerecord_session_cleaner",
        file: schedule_file.path,
        set: "environment=#{ENV['RAILS_ENV'] || DEFAULT_ENVIRONMENT}",
      })
      schedule_file.unlink
    end

    desc 'Remove cleanup cron for session cleanup'
    task :clear, [:application_name] => :environment do |t, args|
      Whenever::CommandLine.execute({
        clear: true,
        identifier: "#{args.application_name}-activerecord_session_cleaner",
      })
    end
  end
end
