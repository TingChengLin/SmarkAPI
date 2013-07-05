namespace :evernote do
  desc "push articles with the tag that user subscribed"
  task :push_tag_articles => :environment do
    User.all.each do |user|
      @user = user
      if token
        #create_notebook
        @user.tags.each do |tag|
          create_notes_of_a_tag(tag)
        end
      end
    end
  end
end
