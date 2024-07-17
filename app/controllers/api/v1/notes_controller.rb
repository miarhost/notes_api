module Api
  module V1
    class NotesController < ApplicationController
      before_action :set_note, except: %i[create index]

      def index
        @notes = paginate_collection(notes_filtered(Note), params[:page], 5)
        render json: @notes, each_serializer: NoteSerializer
      end

      def create
        @note = Note.new(note_params)
        @note.save!
        render json: @note, serializer: , status: 201
      end

      def update
        @note.update!(note_params)
        render json: @note, serializer:
      end

      def destroy
        @note.destroy!
      end

      def show
        render json: @note, serializer:
      end

      private

      def set_note
        @note = Note.find(params[:id])
      end

      def serializer
        NoteSerializer
      end

      def note_params
        params.require(:note).permit(:title, :content)
      end

      def filter_params
        params[:filter] ? params.require[:search].permit() : {}
      end

      def filter
        filter_params[:search].present? ? filter_params[:search] : ''
      end

      def notes_filtered(model)
        FilterRecords.new(model).call(filter)
      end
    end
  end
end
