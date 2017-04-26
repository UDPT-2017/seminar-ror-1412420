class LinksController < ApplicationController
  before_action :authenticate_user!, except: [:new]
  def new
    @link = Link.new
  end

  def create
    # if link has already is a short link
    unless @link = current_user.links.find_by_full_link(link_params["full_link"])
      # unique short code
      while Link.find_by_short_link(short = SecureRandom.urlsafe_base64(5))
      end
      domain = Addressable::URI.parse(link_params["full_link"]).host
      @link = current_user.links.build({ full_link: link_params["full_link"], short_link: short, domain: domain })
      unless @link.save
        p @link.errors.messages
        flash[:alert] = "`#{link_params['full_link']}` is not a url"
        redirect_to root_path and return
      end
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
    def link_params
      params.require(:link).permit(:full_link)
    end
end
