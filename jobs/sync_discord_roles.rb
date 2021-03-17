module Jobs
  class SyncDiscordRoles < ::Jobs::Base
    def execute(args)
      bot = DiscordBot.instance
      groups_with_discord_role_id = GroupCustomField.where(name: "discord_role_id").where.not(value: "").includes(:group)
      groups_with_discord_role_id.each{ |gwdri|
        discourse_group = gwdri.group
        role = bot.discord_server.role(gwdri.value)
        if role
          discourse_members = discourse_group.users.includes(:user_associated_accounts).where('user_associated_accounts.provider_name = ?','discord').references(:user_associated_accounts)
          discourse_group.users.each{|u|
            #remove all members that do not have a discord account connected
            unless discourse_members.ids.include? (u.id)
              discourse_group.remove(u)
            end
          }
          #remove all members that do not have the specific discord role
          discourse_members.each{|m|
            unless role.members.include? (m.user_associated_accounts[0].provider_uid)
              discourse_group.remove(m)
            end
          }
          #add all users that have the discord role to the discourse group
          discord_members = UserAssociatedAccount.where(provider_uid: role.members.map{|m|m.id},provider_name: "discord").includes(:user)
          discord_members.each{|m|
            discourse_group.add(m.user)
          }
        end
      }
    end
  end
end
