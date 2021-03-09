import { acceptance } from "discourse/tests/helpers/qunit-helpers";

acceptance("DiscordRolesync", { loggedIn: true });

test("DiscordRolesync works", async assert => {
  await visit("/admin/plugins/discord-rolesync");

  assert.ok(false, "it shows the DiscordRolesync button");
});
