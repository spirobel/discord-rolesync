module DiscordRolesync
  class SyncsController < ::ApplicationController
    requires_plugin DiscordRolesync
    requires_login
    before_action :ensure_staff
    def sync
      Jobs.enqueue(:sync_discord_roles, {})
      render_json_dump({ sucess: true })
    end
    def botstats
      bot = DiscordBot.instance
      render_json_dump({ botstats: bot.inspect })
    end
  end
end
