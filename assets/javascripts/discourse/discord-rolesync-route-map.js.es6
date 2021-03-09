export default function() {
  this.route("discord-rolesync", function() {
    this.route("actions", function() {
      this.route("show", { path: "/:id" });
    });
  });
};
