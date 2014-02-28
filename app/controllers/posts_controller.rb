require "date"

TRIGGER = ["", "\r"]

class PostsController < ApplicationController
  def status
    render :json => [
      {:title => "資種駭客鬆的第一堂課",
       :speaker => "駭客",
       :info => "1. 跟資種有關",
       :dealine => DateTime.new(2014,2,28,21,0,0,'+8'),
       :finished => 8}
    ]
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
