class TweetsController < ApplicationController
    before_action :authenticate_user!

    def index

        tweets = Tweet.left_joins(user: :follow_user_id)
        .select("Tweets.*", "users.name as user_name")
        .where(follows: { user_id: current_user.id})
        .page(params[:page] ||= 1)
        .per(10)
        .order(id: "DESC");

        totalTweets= Tweet.left_joins(user: :follow_user_id)
        .where(follows: { user_id: current_user.id})
        .count

        data = {
          'tweets': tweets,
          'totalTweets': totalTweets,
        }

        render json: data
    end

    def index_id
        tweets = Tweet.where(user_id: params[:user_id])
        .page(params[:page] ||= 1)
        .per(10)
        .order(id: "DESC");

        totalTweets = Tweet.where(user_id: params[:user_id])
        .count

        data = {
            'tweets': tweets,
            'totalTweets': totalTweets,
          }

        render json: data
    end

    def create
        tweet = Tweet.new(tweet_params.merge(user_id: current_user.id))
        if tweet.save!
            render json: tweet
        else
            ender json: tweet.errors, status: :unprocessable_entity
        end
    end

    def show
        tweet = Tweet.left_joins(:user)
        .select("Tweets.*", "users.name as user_name")
        .where("Tweets.id= ?", params[:id])

        data = {
            'tweets': tweet,
          }

        render json: data
    end

    def destroy 
        tweet = Tweet.find(params[:id])
        if tweet.delete
            render :no_content
        else
            render json: tweet.errors, status: :unprocessable_entity
        end
    end

    private 
    
    def tweet_params
        params.require(:tweet).permit(:post)
    end

    
end
