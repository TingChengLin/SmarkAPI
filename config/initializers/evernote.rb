OAUTH_CONSUMER_KEY = "lintingy-0414"
OAUTH_CONSUMER_SECRET = "f24a88a58ffb61a4"

SANDBOX = false

def token
  #@user = User.first
  if auth = @user.authorizations.find_by_provider("evernote")
    token = auth.token
  else
    token = nil
  end
end

def client
  EvernoteOAuth::Client.new(token: token, consumer_key:OAUTH_CONSUMER_KEY, consumer_secret:OAUTH_CONSUMER_SECRET, sandbox: SANDBOX)
end

def create_notebook
  #client = EvernoteOAuth::Client.new(token: token)
  note_store = client.note_store

  notebook = Evernote::EDAM::Type::Notebook.new
  notebook.name = "Smark"

  created_notebook = note_store.createNotebook(notebook)
  note_store.getNotebook(created_notebook.guid)
end

def get_smark_notebook_guid
  # client = EvernoteOAuth::Client.new(token: token)
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

def create_notes_of_a_tag(tag)
  bookmarks = tag.bookmarks.where("created_at > ?", Time.now - 1.month)

  content = "<?xml version='1.0' encoding='UTF-8'?>" +
            "<!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'>" +
            "<en-note>"

  bookmarks.each do |bookmark|
    content += "<h2>#{bookmark.title}</h2>" +
               "<p>#{bookmark.description}</p>" +
               "<a href=\"#{bookmark.url}\">#{bookmark.url}</a><hr/>"
  end
  content += "</en-note>"

  note_store = client.note_store
  note = Evernote::EDAM::Type::Note.new
  note.title = "Smark-#{tag.name}-" + Time.now.strftime("%m%d%Y")
  note.notebookGuid = get_smark_notebook_guid
  note.content = content
  note.tagNames = [tag.name]
  note_store.createNote(note)
end

def create_note_in_smark
  # client_2 = EvernoteOAuth::Client.new(token: token)
  note_store = client.note_store

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

