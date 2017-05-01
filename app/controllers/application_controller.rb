require 'rugged'
require 'linguist'

class ApplicationController < ActionController::API
  def detect
    tokens = Linguist::Tokenizer.tokenize(params[:code])
    languages = Linguist::Classifier.classify($db, tokens)
    render json: {language: languages}
  end
end
