# DiscordRolesync

DiscordRolesync is a plugin for syncing your discord roles with discourse groups.

## Installation

Follow [Install a Plugin](https://meta.discourse.org/t/install-a-plugin/19157)
how-to from the official Discourse Meta, using `git clone https://github.com/spirobel/discord-rolesync.git`
as the plugin command. You need to create a personal access token according to: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token (with repo rights) and attach it to the git clone link as described int the "install a plugin" thread. If you need pictures for the next two steps look at the Getting Started section of this tutorial https://www.howtogeek.com/364225/how-to-make-your-own-discord-bot/

### setup discord login

you also need to setup discord login in your disource instance. This requires putting your discordapp clientid and your client secret in the respective settings in the discourse admin panel. The discourse admin panel will provide you with a link on how to create your discordapp if you search for the discord settings. You can also follow this guide: https://meta.discourse.org/t/configuring-discord-login-for-discourse/127129

### authorize your bot to access your discord server

Replace CLIENTID with the clientid of your dicordapp that you created when enabling the discord login in the discourse admin panel. You can find the clientid in your discourse admin settings or on: https://discord.com/developers/applications

```
https://discordapp.com/oauth2/authorize?client_id=CLIENTID&scope=bot
```

### create discordbot and copy the token

go to https://discord.com/developers/applications create a bot and copy the access token into the discord_rolyesync_token setting of this plugin.


## Usage

go to the the group that you would like to sync with your discord role and attach the discord role id you want to sync it with. If you don't know how to find the id of your role, check out this tutorial: https://discordhelp.net/role-id

Every time a user login happens he will be added / removed from the groups according to the discord roles he possesses. This affects only discourse groups that have a discord role id assigned.

## Troubleshooting

### wrong server

Make sure your bot is only connected to one (your) discord server. On discourse plugin initialization the bot will be created and check which discord server it is connected to.
This server will later be used to query which roles its members have when they login to your discourse.
