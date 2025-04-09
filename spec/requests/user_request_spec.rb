require 'rails_helper'

RSpec.describe "Users", type: :request do
  RSpec.shared_context 'with multiple companies' do
    let!(:company_1) { create(:company) }
    let!(:company_2) { create(:company) }

    before do
      5.times do
        create(:user, company: company_1)
      end
      5.times do
        create(:user, company: company_2)
      end
    end
  end

  describe "#index" do
    let(:result) { JSON.parse(response.body) }

    context 'when fetching users by company' do
      include_context 'with multiple companies'

      it 'returns only the users for the specified company' do
        get company_users_path(company_1)
        
        expect(result.size).to eq(company_1.users.size)
        expect(result.map { |element| element['id'] } ).to eq(company_1.users.ids)
      end
    end

    context 'when fetching all users' do
      include_context 'with multiple companies'

      it 'returns all the users' do

      end
    end

    context 'when fetching by username' do
      let!(:company_1) { create(:company) }
      let!(:user_1) {create(:user, username: 'user_1_1')}
      let!(:user_2) {create(:user, username: 'user_1_2')}
      let!(:user_3) {create(:user, username: 'user_3')}

      it 'returns all users that partially matches with the username param' do
        get users_path(username: 'user_1')

        expect(result.first['username']).to eq(user_1.username)
        expect(result.last['username']).to eq(user_2.username)
        expect(result.size).to eq(2)
      end
    end
  end
end
