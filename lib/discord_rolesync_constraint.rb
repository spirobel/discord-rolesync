class DiscordRolesyncConstraint
  def matches?(request)
    SiteSetting.discord_rolesync_enabled
  end
end
