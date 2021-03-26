require_dependency "discord_rolesync_constraint"

DiscordRolesync::Engine.routes.draw do
  get "/sync" => "syncs#sync", constraints: DiscordRolesyncConstraint.new
  get "/botstats" => "syncs#botstats", constraints: DiscordRolesyncConstraint.new
end
