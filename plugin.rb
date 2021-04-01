# frozen_string_literal: true

# name: DiscordRolesync
# about: sync roles of discord users to discourse
# version: 0.1
# authors: spirobel
# url: https://github.com/spirobel
gem 'event_emitter', '0.2.6'
gem 'websocket', '1.2.8'
gem 'websocket-client-simple', '0.3.0'
gem 'opus-ruby', '1.0.1', { require: false }
gem 'netrc', '0.11.0'
gem 'mime-types-data', '3.2019.1009'
gem 'mime-types', '3.3.1'
gem 'domain_name', '0.5.20180417'
gem 'http-cookie','1.0.3'
gem 'http-accept', '1.7.0', { require: false }
gem 'rest-client', '2.1.0.rc1'

gem 'discordrb-webhooks', '3.3.0', {require: false}
gem 'discordrb', '3.4.0'

#require 'discordrb'
register_asset 'stylesheets/common/discord-rolesync.scss'
register_asset 'stylesheets/desktop/discord-rolesync.scss', :desktop
register_asset 'stylesheets/mobile/discord-rolesync.scss', :mobile

enabled_site_setting :discord_rolesync_enabled

PLUGIN_NAME ||= 'DiscordRolesync'

load File.expand_path('lib/discord-rolesync/engine.rb', __dir__)
after_initialize do
  # https://github.com/discourse/discourse/blob/master/lib/plugin/instance.rb
  register_editable_group_custom_field(:discord_role_id)
  register_group_custom_field_type('discord_role_id', :integer)
  add_preloaded_group_custom_field("discord_role_id")
  add_to_serializer(:group_show, :custom_fields, false) {
    object.custom_fields
  }

  load File.expand_path('../lib/discord_bot_demon.rb', __FILE__)

  add_admin_route 'sync_discord.title', 'sync-discord'
  Discourse::Application.routes.append do
    get '/admin/plugins/sync-discord' => 'admin/plugins#index', constraints: StaffConstraint.new
  end
  register_demon_process(Demon::DiscordBot)
end
