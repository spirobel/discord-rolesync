class Demon::DiscordBot < ::Demon::Base
  def self.prefix
    "discord_bot"
  end

  private

  def suppress_stdout
    false
  end

  def suppress_stderr
    false
  end

  def handle_interrups
    at_exit { @bot.stop unless @bot.nil? }
    trap('INT')  { shutdown }
    trap('TERM') { shutdown }
    trap('HUP')  { shutdown }
  end
  #conditions
  def no_token
    SiteSetting.discord_rolesync_token.empty? ||
      SiteSetting.discord_rolesync_token.nil?
  end

  def already_running
    !@bot.nil? && !@bot.gateway.nil? && @bot.gateway.open?
  end

  #/conditions

  def setup_bot_events
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
    end
      #ready event
      @bot.ready {
        puts "ready"
        @ready = true
      }

      #disconnect event
      @bot.disconnected {
        puts "disconnected event"
        @ready = false
      }
  end

  def shutdown
    @running = false
    puts "discord bot shutting down "
    exit 0
  end

  def start_discord_bot
    return if no_token || already_running
    puts "discord bot started!"
    @bot = Discordrb::Bot.new(token: SiteSetting.discord_rolesync_token,
                                      intents: %i[servers server_members])
    setup_bot_events
    @bot.run(true)
  end

  def stop_discord_bot
    return unless already_running
    "discord bot stoped!"
    @ready = false
    @bot.stop unless @bot.nil?
  end

  def after_fork
    puts "[DiscordRolesync] Loading DiscordRolesync in process id #{Process.pid}"
    handle_interrups
    @bot = nil
    @running = true
    @ready = false
    @sync_lock = Mutex.new

    while @running
      puts "discord bot is running"
      puts @ready
      start_discord_bot unless  SiteSetting.discord_rolesync_bot_off
      stop_discord_bot if SiteSetting.discord_rolesync_bot_off
      sleep 1
    end

    exit 0
  rescue => e
    STDERR.puts e.message
    STDERR.puts e.backtrace.join("\n")
    exit 1
  end

end
