require_dependency "discord_rolesync_constraint"

DiscordRolesync::Engine.routes.draw do
  get "/" => "discord_rolesync#index", constraints: DiscordRolesyncConstraint.new
  get "/actions" => "actions#index", constraints: DiscordRolesyncConstraint.new
  get "/actions/:id" => "actions#show", constraints: DiscordRolesyncConstraint.new
end
