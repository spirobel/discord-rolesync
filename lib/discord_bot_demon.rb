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

  def shutdown_bot
    @running = false
    puts "discord bot shutting down "
    exit 0
  end
  def after_fork
    puts "[DiscordRolesync] Loading DiscordRolesync in process id #{Process.pid}"
    @running = true
    @sync_lock = Mutex.new
    trap('INT')  { shutdown_bot }
    trap('TERM') { shutdown_bot }
    trap('HUP')  { shutdown_bot }
    while @running
      puts "discord bot is running"
      sleep 1
    end
    @sync_lock.synchronize { shutdown_bot }
    #Discourse.redis.del(HEARTBEAT_KEY)
  rescue => e
    STDERR.puts e.message
    STDERR.puts e.backtrace.join("\n")
    exit 1
  end

end
