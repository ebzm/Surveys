require 'rails_helper'

RSpec.describe SurveysController, type: :controller do
  let!(:survey) { create(:survey, label: 'label') }

  describe "GET #index"do
    it "returns a success response" do
      get :index
      expect(response.successful?).to be true
    end
  end

  describe "GET #new" do
    subject(:http_request) { get :new }
    it 'returns a success response' do
      expect(http_request).to have_http_status(:success)
    end
  end

  describe "GET #show"do
    subject(:http_request) { get :show, params: params }

    context 'with valid params' do
      let(:params) { { id: survey } }

      it 'returns a success response' do
        expect(http_request).to have_http_status(:success)
      end
    end
  end
  
  describe '#create' do
    subject(:http_request) { post :create, params: params }

    context 'with valid attributes' do
      let(:params) { { id: 1, label: "label" } }

      it 'returns Found' do
        expect(http_request).to have_http_status(:found)
      end
    end

    context 'with invalid attributes' do
      let(:params) { { survey: build(:invalid_survey).attributes } }

      it 'does not save the new survey in the database' do
        expect { http_request }.to_not change(Survey, :count)
      end

      it 'redirects to root path' do
        expect(http_request).to redirect_to root_path
      end
    end
  end
end