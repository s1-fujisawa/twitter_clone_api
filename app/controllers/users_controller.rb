class UsersController < ApplicationController
    before_action :authenticate_user!

    def current_user_show
        user = User.find(current_user.id)
        render  json: {user: user}
    end

    def other_user_show
        user = User
        .select('id','name','nickname','created_at')
        .find(params[:id])
        render  json: {user: user}
    end

    def search
        users = User.select('id','name','nickname','created_at')
        .where('(name LIKE ?) or (nickname LIKE ?)',"%#{params[:val]}%","%#{params[:val]}%")
        .page(params[:page] ||= 1)
        .per(10)

        count = User.where('(name LIKE ?) or (nickname LIKE ?)',"%#{params[:val]}%","%#{params[:val]}%")
        .count

        data = {
          'result': users,
          'count': count,
        }

        #users = User.all
        render  json: data
    end

    def getFollowUsers
        users = User.left_joins(:follow_user_id)
            .where(follows: {user_id: params[:id]})
            .page(params[:page] ||= 1)
            .per(10)

        totalUser = User.left_joins(:follow_user_id)
            .where(follows: {user_id: params[:id]})
            .count

        data = {
            'users': users,
            'totalUser': totalUser,
            }

        render json: data
    end

    def getFollower
        users = User.includes(:follow)
        .where(follows:  {follow_user_id:  params[:id]})
        .page(params[:page] ||= 1)
        .per(10)

        totalUser = User.includes(:follow)
        .where(follows:  {follow_user_id:  params[:id]})

        data = {
          'users': users,
          'totalUser': totalUser,
        }

        render json: data
    end

end
