# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'User queries' do
  subject(:result) { execute_query(query, variables: variables).to_h }

  describe 'update User' do
    let!(:user) { create(:user, first_name: 'Test', last_name: 'Test', email: 'test1@test.com', age: 20) }
    let(:query) { <<~GRAPHQL }
      mutation UpdateUser($input: UpdateUserInput!) { 
        updateUser(input: $input){
            user{
              firstName
              lastName
              email
              age
            }
          }
        }
        GRAPHQL

      let(:variables) do
        {
          "input" => {
            "id" => "#{user.id}",
            "firstName" => "First",
            "lastName" => "Last",
            "email" => "mail@gmail.com",
            "age" => 22
          },
        }
      end

    it 'updates User' do
      expect(result.dig('data', 'updateUser')).to eq(
        "user"=>{"age"=>22, "email"=>"mail@gmail.com", "firstName"=>"First", "lastName"=>"Last"}
      )
    end
  end
end