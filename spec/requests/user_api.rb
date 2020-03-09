require 'rails_helper'

RSpec.describe 'Users API', type: :request  do
    let!(:users) { create_list(:user, 10) }
    let(:user_id) { users.first.id }

    describe "GET #index" do
        before do
            get :index
        end

        it "returns http success" do
            expect(response).to have_http_status(:success)
        end

        it "JSON body response contains all user instances" do
            json_response = @json
            users = User.all
            expect(json_response.count).to eq(users.count)
        end
    end

    # Test suite for GET /users/:id
    describe 'GET /users/:id' do 
        before { get "users/#{user_id}" }

        context 'when the record exists' do 
            it 'returns the user' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(user_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do 
            let(:user_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    # Test suite for POST /users
    describe 'POST /users' do
        # valid payload
        let (:valid_attributes) { { name: 'markus' } }

        context 'when the request is valid' do 
            before { post '/users', params: valid_attributes }
            
            it 'creates a user' do
                expect(json['name']).to eq('markus')
            end

            it 'returns a status code 201' do 
                expect(resonse).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before { post '/users', params: { name: '?' }}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect (response.body).to match(/Validation failed: Value can't be blank/)
            end
        end
    end

    # Test suite for PATCH /users/:id
    describe 'PATCH /users/:id' do
        let(:valid_attributes) { { name: 'new name' , email: 'newEmail@email.com'} }

        context 'when the record exists' do
            before { patch "/users/#{user_id}", params: valid_attributes }

            it 'updates the record' do
                expect(response.body).to_not be_empty
            end

            it 'updates the record with attribute' do
                expect(response.body.name).to eq('new name')
                expect(response.body.email).to eq('newEmail@email.com')
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /users/:id
    describe 'DELETE /users/:id' do
        before { delete "/users/#{user_id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end

        it 'returns a success message' do 
            json_response = JSON.parse(response.body)
            expect(json_response.message).to eq('Account deleted successfully')
        end
    end

end