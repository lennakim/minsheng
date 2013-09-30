# encoding: utf-8

class SuggestionsController < ApplicationController

  def create
    @suggestion = Suggestion.new(params[:suggestion])
    if @suggestion.save
      # redirect_to ucenter_suggestion_path
      render json: {msg: 'success'}
    else
      # todo
      #redirect_to ucenter_suggestion_path
      render json: {msg: (@suggestion.errors.first || []).last }
    end
  end
end
