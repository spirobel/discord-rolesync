import { ajax } from "discourse/lib/ajax";
export default Ember.Controller.extend({
  actions: {
    syncDiscord() {
        ajax('/discord-rolesync/sync', { type: "GET" }).then(function(){
          console.log(this, "roles synced")
        })
    }
  }
});
