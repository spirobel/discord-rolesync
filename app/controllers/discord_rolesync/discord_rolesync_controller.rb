module DiscordRolesync
  class DiscordRolesyncController < ::ApplicationController
    requires_plugin DiscordRolesync

    before_action :ensure_logged_in

    def index
    end
  end
end
