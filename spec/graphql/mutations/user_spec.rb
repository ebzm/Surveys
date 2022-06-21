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

  describe 'delete User' do
    let!(:user) { create(:user) }
    let(:query) { <<~GRAPHQL }
      mutation DestroyRecord($input: DestroyRecordInput!) {
        destroyRecord(input: $input) {
          errors
        }
        }
    GRAPHQL

    let(:variables) do
      {
        'input' => {
          'recordId' => make_global_id(user)
        }
      }
    end

    it 'deletes user' do
      expect { result }.to change { User.count }.by(-1)
    end
  end
end
