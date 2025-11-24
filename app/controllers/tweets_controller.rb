class TweetsController < ApplicationController
  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    chat = RubyLLM.chat.ask("give me a 100 character tweet version of this text: #{@tweet.long}").content
    @tweet.shortened = response.content

    if @tweet.save
      redirect_to @tweet
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  private

  def tweet_params
    params.require(:tweet).permit(:long)
  end
end

def index
  @tweet = Tweet.all
end
