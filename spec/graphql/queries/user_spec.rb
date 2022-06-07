require "rails_helper"

RSpec.describe "query user" do

  it "returns first user's email" do
    FactoryBot.create(:user)
    FactoryBot.create(:user)

    query = <<~GQL
    query {
      user(id:1) {
        email
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "user", "email")).to eq('test1@test.com')
  end

  it "returns all users email" do
    FactoryBot.create(:user)
    FactoryBot.create(:user)

    query = <<~GQL
    query {
      users {
        email
      }
    }
    GQL

    result = SurveysSchema.execute(query)

    expect(result.dig("data", "users").map{|x| x.values}.flatten).to eq(['test3@test.com', 'test4@test.com'])
  end
end