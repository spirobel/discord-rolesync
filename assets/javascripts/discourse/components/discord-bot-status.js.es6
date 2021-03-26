import { cancel, later, next } from '@ember/runloop';
import { ajax } from "discourse/lib/ajax";

export default Ember.Component.extend({
   poller: null,
   didInsertElement() {
     next(this, function(){
       this.poller = this.pollBotStats();
     })
   },
   willDestroyElement() {
     cancel(this.poller);
   },
   pollBotStats(){
     return later(this,function(){
       ajax('/discord-rolesync/botstats', { type: "GET" }).then(function(a){
         console.log("botstats",a )
         this.set("botstats",a.botstats)
         this.poller = this.pollBotStats();
       }.bind(this))
     },1000)

   }

})
