require 'rails_helper'
describe 'Notes', type: :request do

  let!(:note) { create(:note) }
  let!(:sample_note) { create(:note) }

  describe 'POST /api/v1/notes' do
    context 'creates a record' do
      it 'returns serialized note record' do
        post '/api/v1/notes',
            params: { note: { title: 'Test Note', content: 'Test Content' } },
            headers: {}

        expect(response).to have_http_status(:created)
        expect(response.body).to include_json(
          {
            "title": "Test Note",
            "content": "Test Content",
          }
        )
      end
    end

    context 'fails to create a record due to validation' do
      it 'returns validation error message' do
        post '/api/v1/notes',
        params: {},
        headers: {}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(
          {
            "status": "unprocessable_entity",
            "message": "Please fill the fields"
          }
        )
      end
    end
  end

  describe 'PATCH /api/v1/notes/:id/' do

    context 'successfully updates record' do
      it 'updates record and returns updated attributes' do
        patch "/api/v1/notes/#{note.id}",
          params: { note: { title: 'Updated Title'}},
          headers: {}

        expect(response).to have_http_status(:success)
        expect(response.body).to include_json(
            { 'title': 'Updated Title'}
          )
      end
    end

    context 'fails to update record' do
      it "returns error message" do
        patch "/api/v1/notes/#{note.id}",
        params: {},
        headers: {}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include_json(
          {
            "status": "unprocessable_entity",
            "message": "Please fill the fields"
          }
        )
      end
    end
  end

  describe 'DELETE /api/v1/notes/:id' do
    it 'removes record from database' do
      delete "/api/v1/notes/#{note.id}",
      headers: {}

      expect(response).to have_http_status(:no_content)
      expect{ note.reload }.to raise_exception(ActiveRecord::RecordNotFound)
    end
  end
end
