module Jobs
  class StartDiscordBot < ::Jobs::Base
    def execute(args)
      bot = DiscordBot.instance
    end
  end
end
