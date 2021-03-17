import { ajax } from "discourse/lib/ajax";
import {getOwner} from 'discourse-common/lib/get-owner';
export default Ember.Controller.extend({
  actions: {
    syncDiscord() {
        ajax('/discord-rolesync/sync', { type: "GET" }).then(function(a){
          alert("Discord member sync started!")
        })
    }
  }
});
