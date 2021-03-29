class DiscordBot
  include Singleton
  attr_reader :ready

  def initialize
    @bot_mutex = Thread::Mutex.new
  end

  def start
    return if @bot.gateway.open?
    return if SiteSetting.discord_rolesync_token.empty? || SiteSetting.discord_rolesync_token.nil? || SiteSetting.discord_rolesync_bot_off
    @bot_mutex.synchronize {
      start_discord_bot unless @bot.gateway.open?
    }
    end
  end

  def discord_server
    @bot.servers[@bot.servers.keys.first]
  end
  private
  def start_discord_bot
    return if SiteSetting.discord_rolesync_token.empty? || SiteSetting.discord_rolesync_token.nil? || SiteSetting.discord_rolesync_bot_off
    @bot = Discordrb::Bot.new(token: SiteSetting.discord_rolyesync_token, intents: %i[servers server_members])

    at_exit { @bot.gateway.kill }
    @bot.run(true)
    #member sync on discord member update event
    @bot.member_update() do |event|
      uaa = UserAssociatedAccount.where(provider_uid: event.user.id,
        provider_name: "discord").includes(:user)
      if uaa.any?
        user = uaa.first.user
        groups_with_discord_role_id = GroupCustomField.where(name: "discord_role_id").where.not(value: "").includes(:group)
        groups_with_discord_role_id.each{ |gwdri|
            if event.roles.include?(gwdri.value)
              gwdri.group.add(user)
            else
              gwdri.group.remove(user)
            end
          }
      end
      #ready event
      @bot.ready {
        @ready = true
      }

      #disconnect event
      @bot.disconnected {
        @ready = false
      }
  end

end
