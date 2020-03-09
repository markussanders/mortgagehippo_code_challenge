require 'rails_helper'

RSpec.describe 'Coins API', type: :request  do
    let!(:coins) { create_list(:coin, 10) }
    let(:coin_id) { coins.first.id }

    describe "GET #index" do
        before do
            get :index
        end

        it "returns http success" do
            expect(response).to have_http_status(:success)
        end

        it "JSON body response contains all coin instances" do
            json_response = @json
            coins = Coin.all
            expect(json_response.count).to eq(coins.count)
        end

        it "JSON body response contains total value of all coin instances" do
            json_response = @json
            total = Coin.total_values
            expect(json_response.total).to eq(total)    
        end
    end

    # Test suite for GET /coins/:id
    describe 'GET /coins/:id' do 
        before { get "coins/#{coin_id}" }

        context 'when the record exists' do 
            it 'returns the coin' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(coin_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do 
            let(:coin_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    # Test suite for POST /coins
    describe 'POST /coins' do
        # valid payload
        let (:valid_attributes) { { name: 'bitcoin', value: 1000 } }

        context 'when the request is valid' do 
            before { post '/coins', params: valid_attributes }
            
            it 'creates a coin' do
                expect(json['name']).to eq('bitcoin')
            end

            it 'returns a status code 201' do 
                expect(resonse).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before { post '/coins', params: { name: '?' }}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect (response.body).to match(/Validation failed: Value can't be blank/)
            end
        end
    end

    # Test suite for PATCH /coins/:id
    describe 'PATCH /coins/:id' do
        let(:valid_attributes) { { name: 'bitcoin' } }

        context 'when the record exists' do
            before { patch "/coins/#{coin_id}", params: valid_attributes }

            it 'updates the record' do
                expect(response.body).to_not be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    # Test suite for DELETE /coins/:id
    describe 'DELETE /coins/:id' do
        before { delete "/coins/#{coin_id}" }

        it 'returns status code 204' do
            expect(response).to have_http_status(204)
        end

        it 'returns a success message' do 
            json_response = JSON.parse(response.body)
            expect(json_response.message).to eq('The Coin has been deleted successfully')
        end
    end

end