class DiscordBot
  include Singleton
  attr_reader :bot

  def initialize
    @bot = Discordrb::Bot.new(token: SiteSetting.discord_rolyesync_token, intents: %i[servers server_members])
    at_exit { @bot.gateway.kill }
    @bot.run(true)
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
    end
  end

  def discord_server
    @bot.servers[@bot.servers.keys.first]
  end

end
