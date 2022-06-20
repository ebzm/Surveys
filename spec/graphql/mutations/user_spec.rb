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
        'input' => {
          'userId' => make_global_id(user),
          'firstName' => 'First',
          'lastName' => 'Last',
          'email' => 'mail@gmail.com',
          'age' => 22
        }
      }
    end

    it 'updates User' do
      result && user.reload
      expect(user).to(have_attributes(first_name: 'First', last_name: 'Last', email: 'mail@gmail.com', age: 22))
    end
  end
end
