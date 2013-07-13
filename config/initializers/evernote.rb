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
  bookmarks = tag.bookmarks.where("created_at > ?", Time.now - 1.week)
  return if bookmarks.empty?

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

def create_intro_note
  # client_2 = EvernoteOAuth::Client.new(token: token)
  note_store = client.note_store

  note = Evernote::EDAM::Type::Note.new
  note.title = "Welcome to Smark!"
  note.notebookGuid = get_smark_notebook_guid
  video_link = "http://goo.gl/CPy2L"
  note.content =
  "<?xml version='1.0' encoding='UTF-8'?>" +
  "<!DOCTYPE en-note SYSTEM 'http://xml.evernote.com/pub/enml2.dtd'>" +
  "<en-note>" +
  "<h1>Welcome to Smark!</h1>" + "<br/>" +
  "Smark is a social bookmark which leverage the power of the community to make learning much easier." + "<br/><br/>" +
  "With the help of Smark, we can collect all the useful information together and find the most useful webpages and tutorials. All the webpages on Smark are filtered by the crowd, only the best things could survive." + "<br/><br/>" +
  "More over, learning just became something much easier and smarter. We just need to subscribe to some topics, then Smark will simply keep us updated with the latest trends! All the newest stuff would automatically came into our evernote. All we need to do is read it, and learn from it." + "<br/><br/>" +
  "Start from the programming field, Smark will expand to education, travel, and a lot more. Not only learning, everything is just so easy!" + "<br/><br/><br/>" +
  "To know more about Smark, why not just give it a try?" + "<br/>" +
  "<b><a href=\"http://goo.gl/CPy2L\">Demo Video</a></b>" + "<br/>" +
  "<b><a href=\"http://smark.cc/\">Website</a></b>" + "<br/>" +
  "<b><a href=\"https://chrome.google.com/webstore/detail/smark/ieaadpckafloockbcbjapjfiidppkidh\">Google Chrome Extension</a></b>" + "<br/><br/>" +
  "For any quetions, just contact us at: lintingy@gmail.com. Thanks!" +
  "</en-note>"

  note.tagNames = ["smark"]

  note_store.createNote(note)
end

