class ConversationsController < ApplicationController
  before_action :conversation, only: %i!show edit update destroy join!

  def index
    @conversations = Conversation.all
  end

  def new
    @users = User.all
  end

  def show
    @user_names = user_names
  end

  def edit
  end

  def join
    @conversation.users << current_user
    redirect_to conversation_path(@conversation)
  end

  def update
    @conversation.update(conversation_params) unless params[:conversation][:name].empty?
    redirect_to conversation_path(@conversation)
  end

  def create
    receiver = User.find(params[:receiver_id])
    @conversation = current_user.conversations.create
    @conversation.users << receiver

    # ConversationMailerPreview.new_conversation_email_preview(receiver).deliver

    render :edit
  end

  def destroy
    @conversation.destroy
    redirect_to conversations_path
  end

  private
  def user_names
    Hash[User.all.collect { |user| [user.id, user.username] }]
  end

  def conversation_params
    params.require(:conversation).permit(:receiver_id, :name, :status)
  end

  def conversation
    @conversation = Conversation.find(params[:id])
  end
end
