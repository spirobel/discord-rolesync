import { withPluginApi } from "discourse/lib/plugin-api";
function initializeDiscordRolesync(api) {
  // https://github.com/discourse/discourse/blob/master/app/assets/javascripts/discourse/lib/plugin-api.js.es6
  api.modifyClass('model:group', {
    asJSON(){
      let r = this._super()
      r.custom_fields = this.custom_fields;
      return r;
    }
  });
}

export default {
  name: "discord-rolesync",

  initialize() {
    withPluginApi("0.8.31", initializeDiscordRolesync);
  }
};
