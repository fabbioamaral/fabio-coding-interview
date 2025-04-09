class TweetsController < ApplicationController
  def index
    tweets = Tweet
              .by_user_id(params[:user_id]).
              
    render json: tweets.all
  end
end
