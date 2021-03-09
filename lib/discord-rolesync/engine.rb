module DiscordRolesync
  class Engine < ::Rails::Engine
    engine_name "DiscordRolesync".freeze
    isolate_namespace DiscordRolesync

    config.after_initialize do
      Discourse::Application.routes.append do
        mount ::DiscordRolesync::Engine, at: "/discord-rolesync"
      end
    end
  end
end
