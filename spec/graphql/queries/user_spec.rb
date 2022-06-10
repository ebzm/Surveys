require "rails_helper"

RSpec.describe "query user" do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'one user' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:query) { <<~GQL
      query {
        user(id:#{user1.id}) {
          email
        }
      }
      GQL
      }

    it "returns first user's email" do
      expect(result.dig("data", "user", "email")).to eq(user1.email)
    end
  end

  describe 'all users' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
    let(:query) { <<~GQL
      query {
        users {
          email
        }
      }
      GQL
      }

    it "returns all users email" do
      expect(result.dig("data", "users").map{|x| x.values}.flatten).to eq([user1.email, user2.email])
    end
  end
end