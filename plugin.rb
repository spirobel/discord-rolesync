# frozen_string_literal: true

# name: DiscordRolesync
# about: sync roles of discord users to discourse
# version: 0.1
# authors: spirobel
# url: https://github.com/spirobel

register_asset 'stylesheets/common/discord-rolesync.scss'
register_asset 'stylesheets/desktop/discord-rolesync.scss', :desktop
register_asset 'stylesheets/mobile/discord-rolesync.scss', :mobile

enabled_site_setting :discord_rolesync_enabled

PLUGIN_NAME ||= 'DiscordRolesync'

load File.expand_path('lib/discord-rolesync/engine.rb', __dir__)

after_initialize do
  # https://github.com/discourse/discourse/blob/master/lib/plugin/instance.rb
end
