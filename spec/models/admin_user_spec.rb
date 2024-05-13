require 'rails_helper'

RSpec.describe AdminUser, type: :model do
  describe "admin user" do
    it "can be created as admin with admin_active" do
      admin_user = AdminUser.create(email: "admin@example.com", password: "password")
      expect(admin_user).to be_persisted
    end

  end
end
