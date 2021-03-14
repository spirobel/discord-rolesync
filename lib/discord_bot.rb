class DiscordBot
  include Singleton
  attr_reader :bot

  def initialize
    @bot = Discordrb::Bot.new token: SiteSetting.discord_rolyesync_token
    at_exit { @bot.gateway.kill }
    @bot.run(true)
  end

  def discord_server
    @bot.servers[@bot.servers.keys.first]
  end

end
