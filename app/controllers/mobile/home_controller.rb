class Mobile::HomeController < ApplicationController
  #layout 'mobile', :except => :main
  #layout 'none', :only => :main
  layout :resolve_layout

  def main

  end

  def index

  end

  def search

  end

  private
  def resolve_layout
    case action_name
      when "main"
        false
      else
        "mobile"
    end
  end

end
