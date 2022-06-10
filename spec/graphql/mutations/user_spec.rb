# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User queries' do
  subject(:result) { SurveysSchema.execute(query) }

  describe 'update User' do
    let!(:user) { create(:user) }
    let(:query) { <<~GQL
      mutation { 
        update_user(input:{
          id: 1
          firstName: "first"
          lastName: "last"
          email: "mail@gmail.com"
          age: 22}){
            user{
              first_name
              last_name
              email
              age
            }
          }
        }
    GQL
      }

    it 'updates User' do
      expect(user.id).to eq(1)
      expect(user.first_name).to eq('Test')
      expect(user.last_name).to eq('Test')
      expect(user.email).to eq('test1@test.com')
      expect(user.age).to eq(20)
      expect(result.dig('data', 'update_user')).to eq(
        "user"=>{"age"=>22, "email"=>"mail@gmail.com", "first_name"=>"first", "last_name"=>"last"}
      )
    end
  end
end