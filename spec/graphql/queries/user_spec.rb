require "rails_helper"

RSpec.describe "query user" do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one user' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:query) { <<~GRAPHQL }
      query User($userId: ID!) {
        user(id: $userId) {
          email
        }
      }
      GRAPHQL

    let(:variables) { { "userId" => user1.id.to_s } }

    it "returns first user's email" do
      expect(result.dig("data", "user", "email")).to eq(user1.email)
    end
  end

  describe 'all users' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
    let(:query) { <<~GRAPHQL }
    query { 
      users{
        email
        }
      }
      GRAPHQL

    it "returns all users email" do
      expect(result.dig("data", "users").map{|x| x.values}.flatten).to eq([user1.email, user2.email])
    end
  end
end