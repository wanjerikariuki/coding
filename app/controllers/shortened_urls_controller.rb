class ShortenedUrlsController < ApplicationController
  before_action :find_url , only: [:show, :shortened]
  skip_before_action :verify_authenticity_token

  def index
    @url = Short.new
  end

  def show
    redirect_to @url.sanitize_url , allow_other_host: true
  end



  def create
    @url = Short.new
    @url.original_url = params[:original_url]
    @url.sanitize

    if @url.new_url?
      if @url.save
        redirect_to shortened_path(@url.short_url)

      else
        flash[:error] = "check the error below:"
        render 'index'
      end
    else
      flash[:notice] ="A short link for this url is already in our db"
      redirect_to shortened_path(@url.find_duplicate.short_url)


    end
  end
  def shortened
    # code here
    @url  = Short.find_by_short_url(params[:short_url])
    host = request.host_with_port
    @original_url = @url.sanitize_url
    @short_url = host +'/' + @url.short_url
  end
  private
  def find_url
    @url = Short.find_by_short_url(params[:short_url])
  end
  def url_params
    params.require(:url).permit(:original_url)
  end
end
