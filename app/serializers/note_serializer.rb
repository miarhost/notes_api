class NoteSerializer < ActiveModel::Serializer
  atributes :title, :content, :updated_at
end
