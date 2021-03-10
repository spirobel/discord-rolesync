# DiscordRolesync

DiscordRolesync is a plugin for ...

## Installation

Follow [Install a Plugin](https://meta.discourse.org/t/install-a-plugin/19157)
how-to from the official Discourse Meta, using `git clone https://github.com/spirobel/discord-rolesync.git`
as the plugin command. You need to create a personal access token according to: https://docs.github.com/en/github/authenticating-to-github/creating-a-personal-access-token (with repo rights) and attach it to the git clone link as described int the "install a plugin" thread.

### setup discord login

you also need to setup discord login in your disource instance. This requires putting your discordapp clientid and your client secret in the respective settings in the discourse admin panel. The discourse admin panel will provide you with a link on how to create your discordapp if you search for the discord settings.

### authorize your bot to access your discord server

Replace CLIENTID with the clientid of your dicordapp that you created when enabling the discord login in the discourse admin panel. You can find the clientid in your discourse admin settings or on: https://discord.com/developers/applications

```
https://discordapp.com/oauth2/authorize?client_id=CLIENTID&scope=bot
```

### create discordbot and copy the token

go to https://discord.com/developers/applications create a bot and copy the access token into the discord_bot_token setting of this plugin.


## Usage

## Feedback
