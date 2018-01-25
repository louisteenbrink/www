class PostsController < ApplicationController
  before_action :hide_drift
  before_action :set_top_bar

  def index
    if request.format.html? || params[:post_page]
      posts = (Post.all + Story.all).sort_by { |p| p.date }.reverse
      @posts = posts.select(&:post?)
      @videos = posts.select(&:video?)
      @stories = posts.select(&:story?)

      if I18n.locale == :fr
        @videos = @videos.select { |m| m.locale == "fr" }
        select_content("fr")
      elsif I18n.locale == :"pt-BR"
        @videos = @videos.select { |m| m.locale == "pt-BR" }
        select_content("en")
      else
        @videos = @videos.select { |m| m.locale == "en" }
        select_content("en")
      end
    end

    if request.format.html?
      @statistics = Kitt::Client.query(Statistics::Query).data.statistics
    end
  end

  def rss
    @posts = (Post.all + Story.all).sort_by { |p| p.date }.reverse
    render layout: false
  end

  def show
    @post = Post.find(params[:slug])
    posts = Post.all
    @videos = (posts.select(&:video?) - [ @post ])
    @posts = (posts.select(&:post?) - [ @post ])

    if I18n.locale == :fr
      @videos = @videos.select { |m| m.locale == "fr" }.sample(2)
      @posts = @posts.select { |m| m.locale == "fr" }.sample(3)
    elsif I18n.locale == :"pt-BR"
      @videos = @videos.select { |m| m.locale == "pt-BR" }.sample(2)
      @posts = @posts.select { |m| m.locale == "en" }.sample(3)
    else
      @videos = @videos.select { |m| m.locale == "en" }.sample(2)
      @posts = @posts.select { |m| m.locale == "en" }.sample(3)
    end
    render_404 if @post.nil?
  end

  def videos
    posts = Post.all
    @videos = posts.select(&:video?)

    if I18n.locale == :fr
      select_video("fr")
    elsif I18n.locale == :"pt-BR"
      select_video("pt-BR")
    else
      select_video("en")
    end
  end

  def all
    posts = (Post.all + Story.all).sort_by { |p| p.date }.reverse
    @posts = posts.select(&:post?)

    if I18n.locale == :fr
      select_post("fr")
    else
      select_post("en")
    end
  end

  private

  def select_content(locale)
    @stories = @stories.select { |m| m.locale == locale }
    @posts = @posts.select { |m| m.locale == locale }
    @posts = Kaminari.paginate_array(@posts).page(params[:post_page]).per(3)
  end

  def select_video(locale)
    @videos = @videos.select { |m| m.locale == locale }
    if params[:category].present?
      @videos = @videos.select { |post| post.labels.include? params[:category] }
    end
    @videos = Kaminari.paginate_array(@videos).page(params[:post_page]).per(6)
  end

  def select_post(locale)
    @posts = @posts.select { |m| m.locale == locale }
    if params[:category].present?
      @posts = @posts.select { |post| post.labels.include? params[:category] }
    end
    @posts = Kaminari.paginate_array(@posts).page(params[:post_page]).per(9)
  end

  def set_top_bar
    if I18n.locale == :fr
      @top_bar_message = I18n.t('.top_bar_podcast_message')
      @top_bar_cta = I18n.t('.top_bar_podcast_cta')
      @top_bar_url = "https://itunes.apple.com/us/podcast/le-wagon/id1298074014?mt=2"
    end
  end

  def hide_drift
    @hide_drift = true
  end
end
