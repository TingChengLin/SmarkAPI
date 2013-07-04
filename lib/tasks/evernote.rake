namespace :evernote do
  desc "push articles with the tag that user subscribed"
  task :push_tag_articles => :environment do
    User.all.each do |user|
      @user = user
      if evernote_token
        create_notebook
      end
    end
  end

end
