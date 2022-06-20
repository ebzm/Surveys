# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'query user' do
  subject(:result) { execute_query(query, variables: variables).to_h }
  let(:variables) { {} }

  describe 'one user' do
    let(:user1) { FactoryBot.create(:user) }
    let(:user2) { FactoryBot.create(:user) }
    let(:query) { <<~GRAPHQL }
      query User($userId: ID!) {
        node(id: $userId) {
          ... on User {
            email
          }
        }
      }
    GRAPHQL

    let(:variables) { { 'userId' => make_global_id(user1) } }

    it "returns first user's email" do
      expect(result.dig('data', 'node', 'email')).to eq(user1.email)
    end
  end

  describe 'all users' do
    let!(:user1) { FactoryBot.create(:user) }
    let!(:user2) { FactoryBot.create(:user) }
    let(:query) { <<~GRAPHQL }
      query {#{' '}
        users{
          email
          }
        }
    GRAPHQL

    it 'returns all users email' do
      expect(result.dig('data', 'users').map(&:values).flatten).to eq([user1.email, user2.email])
    end
  end

  context 'sorting' do
    let!(:user1) { FactoryBot.create(:user, first_name: 'Stan', last_name: 'Williams', email: '3test@test.com') }
    let!(:user2) { FactoryBot.create(:user, first_name: 'Adam', last_name: 'Smith', email: '2test@test.com') }
    let!(:user3) { FactoryBot.create(:user, first_name: 'John', last_name: 'Doe', email: '1test@test.com') }
    let!(:user4) { FactoryBot.create(:user, first_name: 'Adam', last_name: 'Brown', email: '4test@test.com') }
    let(:query) { <<~GRAPHQL }
      query Users($sort: [UserSortInput!]) {
        users(sort: $sort) {
            firstName
          }
        }#{' '}
    GRAPHQL

    describe 'by first name' do
      context 'DESC direction' do
        let(:variables) { { 'sort' => [{ 'firstName' => 'DESC' }] } }

        it 'returns sorted users' do
          expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                            user1.first_name, user3.first_name,
                                                                            user2.first_name, user4.first_name
                                                                          ])
        end
      end

      context 'ASC direction' do
        let(:variables) { { 'sort' => [{ 'firstName' => 'ASC' }] } }

        it 'returns sorted users' do
          expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                            user4.first_name, user2.first_name,
                                                                            user3.first_name, user1.first_name
                                                                          ])
        end
      end
    end

    describe 'by last name' do
      context 'DESC direction' do
        let(:variables) { { 'sort' => [{ 'lastName' => 'DESC' }] } }

        it 'returns sorted users' do
          expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                            user1.first_name, user2.first_name,
                                                                            user3.first_name, user4.first_name
                                                                          ])
        end
      end

      context 'ASC direction' do
        let(:variables) { { 'sort' => [{ 'lastName' => 'ASC' }] } }

        it 'returns sorted users' do
          expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                            user4.first_name, user3.first_name,
                                                                            user2.first_name, user1.first_name
                                                                          ])
        end
      end
    end

    describe 'by email' do
      context 'DESC direction' do
        let(:variables) { { 'sort' => [{ 'email' => 'DESC' }] } }

        it 'returns sorted users' do
          expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                            user4.first_name, user1.first_name,
                                                                            user2.first_name, user3.first_name
                                                                          ])
        end
      end

      context 'ASC direction' do
        let(:variables) { { 'sort' => [{ 'email' => 'ASC' }] } }

        it 'returns sorted users' do
          expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                            user3.first_name, user2.first_name,
                                                                            user1.first_name, user4.first_name
                                                                          ])
        end
      end
    end

    describe 'by first name and email' do
      let(:variables) { { 'sort' => [{ 'firstName' => 'ASC' }, { 'email' => 'DESC' }] } }

      it 'returns sorted users' do
        expect(result.dig('data', 'users').map(&:values).flatten).to eq([
                                                                          user4.first_name, user2.first_name,
                                                                          user3.first_name, user1.first_name
                                                                        ])
      end
    end
  end

  context 'filtering' do
    let!(:user1) { FactoryBot.create(:user, first_name: 'Stan', last_name: 'Smith') }
    let!(:user2) { FactoryBot.create(:user, first_name: 'Adam', last_name: 'Smith') }
    let!(:user3) { FactoryBot.create(:user, first_name: 'Adam', last_name: 'Brown') }
    let(:query) { <<~GRAPHQL }
      query User($firstName: String, $lastName: String){
        users(firstName: $firstName, lastName: $lastName) {
            firstName
            lastName
          }
        }#{' '}
    GRAPHQL

    describe 'by first name' do
      let(:variables) { { 'firstName' => 'Adam' } }

      it 'returns filtered users' do
        expect(result.dig('data', 'users').map(&:values).flatten).to eq([user3.first_name, user3.last_name,
                                                                         user2.first_name, user2.last_name])
      end
    end

    describe 'by first and last name' do
      let(:variables) { { 'firstName' => 'Adam', 'lastName' => 'Smith' } }

      it 'returns filtered users' do
        expect(result.dig('data', 'users').map(&:values).flatten).to eq([user2.first_name, user2.last_name])
      end
    end
  end
end
