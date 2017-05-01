require 'rugged'
require 'linguist'

class ApplicationController < ActionController::API
  def detect
    db = {}
    Linguist::Classifier.train!(db, 'Ruby', 'def hello puts "hello world" end')
    tokens = Linguist::Tokenizer.tokenize('def hello puts "hello world" end')
    language = Linguist::Classifier.classify(db, tokens)
    render json: {language: language}
  end
end
