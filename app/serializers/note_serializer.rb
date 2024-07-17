class NoteSerializer < ActiveModel::Serializer
  attributes :title, :content, :updated_at
end
