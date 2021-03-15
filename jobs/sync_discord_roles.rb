module Jobs
  class SyncDiscordRoles < ::Jobs::Base
    def execute(args)
      bot = DiscordBot.instance
      groups_with_discord_role_id = GroupCustomField.where(name: "discord_role_id").where.not(value: "")
      groups_with_discord_role_id.each{ |gwdri|
        discourse_group = Group.find(gwdri.group_id)
        role = bot.discord_server.role(gwdri.value)
        if role
          #remove all users that do not have the discord role
          discourse_members = discourse_group.users.includes(:provider_uid).where(provider_name: "discord").references(:user_associated_accounts)
          discourse_members.each{|m|
            unless role.members.include? (m.provider_uid)
              discourse_group.remove(m)
            end
          }
          #add all users that have the discord role to the discourse group
          discord_members = User.joins(:user_associated_accounts).where(provider_uid: role.members.map{|m|m.id},
             provider_name: "discord")
          discord_members.each{|m|
            discourse_group.add(m)
          }
        end
      }
    end
  end
end
