require 'rails_helper'
describe 'Notes', type: :request do

  let!(:note) { create(:note) }
  let!(:note_1) { create(:note, title: "New test title") }

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

  describe 'GET /api/v1/notes' do
    context 'list inclusions' do
      it 'shows list containing filter condition at title' do
        get '/api/v1/notes', params: { filter: "title", search: { title: "test" } }
        expect(response).to have_http_status(200)
        expect(response.body).to include_json(
          [
            {
              title: note_1.title,
              content: note_1.content
            }
          ]
        )
      end
    end

    context 'list exclusions' do
      it "doesn't show records that don't correspond to filter conditions" do
        get '/api/v1/notes', params: { filter: "title", search: { title: "test" } }

        expect(response).to have_http_status(200)
        expect(response.body).not_to include_json(
          [
            {
              title: note.title,
              content: note.content
            }
          ]
        )
      end
    end
  end

  describe 'POST /api/v1/notes/enqueue_templates' do
    let!(:result) { UpdateTemplatesWorker.perform_async }
    let!(:payload) { ImportTemplates.new.call }

    before { Sidekiq::Testing.inline! }

    after { Sidekiq::Testing.fake! }

    it 'performs job up to complete and returns result' do
      expect do
        post "/api/v1/notes/enqueue_templates"
        end.to change(SampleNote, :count).by(18)
      post "/api/v1/notes/enqueue_templates"
      expect(response).to have_http_status(202)
    end
  end
end
