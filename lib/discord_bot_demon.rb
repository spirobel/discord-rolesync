class Demon::DiscordBot < ::Demon::Base
  def self.prefix
    "discord_bot"
  end

  private
  def after_fork
    puts "[DiscordRolesync] Loading DiscordRolesync in process id #{Process.pid}"
  end

end
