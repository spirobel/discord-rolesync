require 'rails_helper'

describe DiscordRolesync::ActionsController do
  before do
    Jobs.run_immediately!
  end

  it 'can list' do
    sign_in(Fabricate(:user))
    get "/discord-rolesync/list.json"
    expect(response.status).to eq(200)
  end
end
