class Admin::MessagesController < Admin::BaseController
  def index
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @message = @topic.messages.build
  end

  def create
    @topic = Topic.find(params[:message][:topic_id])
    @message = @topic.messages.create(message_params)
  end

  private
  def set_topic
    @topic =  Topic.find(params[:topic_id])
  end

  private
  def message_params
    params.expect(message: [ :title, :content, :topic_id ]).with_defaults(user: Current.user)
  end
end
