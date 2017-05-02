class TrendingController < ApplicationController
  before_action :authenticate_user!

  def index
    if(current_user.links_count&.positive?)
      prepare_links
      @link = @links.first
      @id = @link.id
      get_info_chart(@link)
    else
      render template: "shared/empty" and return
    end
  end

  def show
    prepare_links
    @link = @links.find(params[:id])
    @id = @link.id
    get_info_chart(@link)
    render :index and return
  end

  private

  def get_info_chart(link)
    @data_line = link.hits.group_by_date_within_days(30)
    @data_country = link.hits.group_by_location
    @data_ip = link.hits.group_by_ip
  end

  def prepare_links
    @links = current_user.links
  end
end
