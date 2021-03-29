module Jobs
  class StartDiscordBot < ::Jobs::Scheduled
    every 1.minute

    def execute(args)
      bot = DiscordBot.instance
      bot.start
    end
  end
end
