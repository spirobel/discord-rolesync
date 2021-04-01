module DiscordRolesync
  class SyncsController < ::ApplicationController
    requires_plugin DiscordRolesync
    requires_login
    before_action :ensure_staff
    def sync
      bot_sync!
      render_json_dump({ sucess: true })
    end

    def start
      SiteSetting.set_and_log('discord_rolesync_bot_on', true)
      render_json_dump({ sucess: true })
    end

    def stop
      SiteSetting.set_and_log('discord_rolesync_bot_on', false)
      render_json_dump({ sucess: true })
    end

    def botstats
      #TODO get ready and current action from redis and query and display info about discord members with ar
      render_json_dump({ botstats: bot_ready , current_action: Discourse.redis.get("discord_bot:current_action") })
    end

    private

    def bot_ready
      return "online" if Discourse.redis.get("discord_bot:ready") == "1"
      return "offline"
    end

    def bot_sync!
      Discourse.redis.set("discord_bot:sync", 1)
    end
  end
end
