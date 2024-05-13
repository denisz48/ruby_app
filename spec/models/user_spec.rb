require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user" do
    it "create user" do
      user = User.create(email: "user@example.com", password: "password")
      expect(user).to be_persisted
    end

  end
end

