class PublicController < ActionController::Base
  respond_to :json
  def index
  end

  def oembed
    url = params[:url]
    return render json: { status: :error } unless url
    m = url.match(%r'\Ahttp://media.ccc.de/browse/(.*)/(.*).html\z')
    return render json: { status: :error } unless m
    @event = Event.by_identifier(m[1], m[2])
    @recording = @event.recordings.downloaded.video.first
  end
end