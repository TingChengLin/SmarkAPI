
def token
  @user = User.first
  token = @user.authorizations.find_by_provider("evernote").token
end

def create_notebook
  client = EvernoteOAuth::Client.new(token: token)
  note_store = client.note_store

  notebook = Evernote::EDAM::Type::Notebook.new
  notebook.name = "Smark"

  created_notbook = note_store.createNotebook(notebook)
  note_store.getNotebook(created_notebook.guid)
end

def get_smark_notebook_guid
  client = EvernoteOAuth::Client.new(token: token)
  note_store = client.note_store
  notebooks = note_store.listNotebooks(token)

  notebook_guid = nil
  notebooks.each do |nb|
    if nb.name == 'Smark'
      notebook_guid = nb.guid
    end
  end
  return notebook_guid
  #return note_store.getNotebook(created_notebook.guid)
end

def create_note_in_smark
  client_2 = EvernoteOAuth::Client.new(token: token)
  note_store = client_2.note_store

  note = Evernote::EDAM::Type::Note.new
  note.title = "Note"
  note.notebookGuid = get_smark_notebook_guid
  note.content =
  "<?xml version='1.0' encoding='UTF-8'?>" +
  "<!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'>" +
  "<en-note>Content</en-note>"

  note.tagNames = ["Evernote API Sample"]

  note_store.createNote(note)
end

