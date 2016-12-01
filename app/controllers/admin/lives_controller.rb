module Admin
  class LivesController < BaseController
    before_action :set_live, only: [ :on, :off, :edit, :update ]

    def index
      @lives = Live.all
    end

    def new
      @live = Live.new(category: 'aperotalk')
    end

    def create
      @live = Live.new(live_params)
      @live.user = current_user
      if @live.save
        redirect_to admin_root_path
      else
        render :new
      end
    end

    def edit
    end

    def update
      if @live.update(live_params)
        redirect_to admin_root_path
      else
        render :edit
      end
    end

    def on
      @live.started_at = DateTime.now
      @live.ended_at = nil
      @live.save
      render :show
    end

    def off
      @live.ended_at = DateTime.now
      @live.save
      render :show
    end

    private

    def live_params
      params.require(:live).permit(:category, :city_slug, :started_at, :ended_at, :url, :batch_slug, :title, :subtitle, :description, :link)
    end

    def set_live
      @live = Live.find(params[:id])
    end
  end
end
