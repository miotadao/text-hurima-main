class TalksController < ApplicationController
  before_action :authenticate_user!

  def create
    @post = Post.find(params[:post_id])
    @talk = current_user.talks.new(talk_params)

    if @talk.save
      if current_user.id == @post.user_id
        receiver = User.find(@post.bought_id)
      elsif current_user.id == @post.bought_id
        receiver = User.find(@post.user_id)
      end
      NotifierMailer.talk_email(receiver, @post).deliver_now
      redirect_to [@post]
    else
      render 'posts/show'
    end
  end

  def destroy
    talk = current_user.talks.find(params[:id])
    talk.destroy

    redirect_to [:post, { id: params[:post_id] }]
  end

  private

  def talk_params
    params.require(:talk).permit(:body).merge(post_id: params[:post_id])
  end
end
