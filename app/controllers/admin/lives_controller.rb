module Admin
  class LivesController < BaseController
    before_action :set_live, only: [ :on, :off, :edit, :update ]
    before_action :set_city_slugs, only: [ :new, :edit ]

    def index
      @lives = Live.all.order(started_at: :desc, created_at: :desc)
    end

    def new
      if params[:category].blank?
        redirect_to admin_lives_path
      else
        @live = Live.new(category: params[:category])
      end
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
      Live.where.not(id: @live.id).where(ended_at: nil).update(ended_at: DateTime.now)
      render :show
    end

    def off
      @live.ended_at = DateTime.now
      @live.save
      render :show
    end

    private

    def live_params
      params.require(:live).permit(:category, :batch_slug, :city_slug, :started_at, :ended_at, :facebook_url, :batch_slug, :title, :subtitle, :description, :link, :meta_image)
    end

    def set_live
      @live = Live.find(params[:id])
    end

    def set_city_slugs
      @city_slugs = AlumniClient.new.city_slugs.sort
    end
  end
end
