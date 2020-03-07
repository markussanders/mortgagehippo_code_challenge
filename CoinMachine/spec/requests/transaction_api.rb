require 'rails_helper'

RSpec.describe 'Transactions API', type: :request  do
    let!(:transactions) { create_list(:transaction, 5) }
    let(:transaction_id) { transactions.first.id }

    describe "GET #index" do
        before do
            get :index
        end

        it "returns http success" do
            expect(response).to have_http_status(:success)
        end

        it "JSON body response contains all transaction instances" do
            json_response = @json
            transactions = Transaction.all
            expect(json_response.count).to eq(transactions.count)
        end
        
    end

    describe 'GET /transactions/:id' do 
        before { get "transactions/#{transaction_id}" }

        context 'when the record exists' do 
            it 'returns the transaction' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(transaction_id)
            end

            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end
        end

        context 'when the record does not exist' do 
            let(:transaction_id) { 100 }

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end
        end
    end

    describe 'POST /transactions' do
        let (:valid_attributes) { { user_id: 1, coin_id: 1 } }

        context 'when the request is valid' do 
            before { post '/transactions', params: valid_attributes }
            
            it 'creates a transaction' do
                expect(json['name']).to eq('bitcoin')
            end

            it 'returns a status code 201' do 
                expect(resonse).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do 
            before { post '/transactions', params: { user_id: 1000 }}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end
        end
    end

end