class TopicsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "TopicsChannel:#{params[:request_id]}"
    LoadTopicsJob.perform_later params[:request_id]
  end

  def unsubscribed
    stop_all_streams
  end
end
