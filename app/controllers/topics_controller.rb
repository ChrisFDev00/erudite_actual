class TopicsController < ApplicationController
  before_action :set_topic, only: [ :show, :update, :destroy ]

  def index
  end

  def show
    @messageable = Topic.find(params[:id])
    @taggable_users = User
                        .joins(:topics)
                        .where(topics: { id: @topic.id })
                        .where(account_type: %w[student teacher])
                        .where(taggable_by_students: true)
                        .distinct
                        .sort_by(&:account_type)
                        .reverse
  end
end
