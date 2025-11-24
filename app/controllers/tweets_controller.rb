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

  def update
    @tweet = Tweet.find(params[:id])
    if @tweet.update(tweet_params)  
      redirect_to @tweet
    else
      render :edit
    end

    # now it's better
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
