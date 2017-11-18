module Inviter
  class InitializerGenerator < Rails::Generators::NamedBase
    source_root File.expand_path('../templates', __FILE__)

    def install
      template 'inviations_migration.rb',
               "db/migrate/#{time_stamp}_inviter_create_invitations.rb",
               time_stamp: time_stamp,
               migration_version: migration_version
    end

    private

    def time_stamp
      Time.current.strftime('%Y%m%d%H%M%S')
    end

    def migration_version
      if Rails::VERSION::MAJOR == 5
        "[#{Rails::VERSION::MAJOR}.#{Rails::VERSION::MINOR}]"
      end
    end
  end
end
