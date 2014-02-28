require "date"

TRIGGER = ["", "\r"]

class PostsController < ApplicationController
  def create
    klass = Klass.find_by_title(params[:title])
    klass.posts.create(:body => params[:body], :stu_id => params[:stu_id])
    render :json => {:status => "done"}
  end

  def generate
    render :json => { :post => geneator_2(params[:speaker]) }
  end

  def geneator_1(speaker)
    posts = Post.where("title like '%#{speaker}%'")
    paragraphs = []
    posts.each do |p|
      body = p.body
      segments = body.split("\n")
      segments.map { |s| s.gsub!("\r", "") }
      segments.map { |s| s.gsub!("-", "") }

      segments.reject! { |s| !qulified?(s) }
      paragraphs += segments
    end

    return paragraphs.sample(5).join("\n\n")
  end

  def geneator_2(speaker)
    posts = Post.where("title like '%#{speaker}%'")
    sentences = []
    posts.each do |p|
      body = p.body
      body = body.delete("\n\r「」 ")
      sentences += body.scan(/.+?[。？]/).map(&:lstrip)
    end

    paragraphs = [sentences.sample(4).join(""), 
                  sentences.sample(6).join(""), 
                  sentences.sample(7).join(""), 
                  sentences.sample(4).join("")]
    return paragraphs.join("\n\n")
  end


  def qulified?(segment)
    if TRIGGER.include? segment
      return false
    end
    if segment.length < 50
      return false
    end
    return true
  end

end


