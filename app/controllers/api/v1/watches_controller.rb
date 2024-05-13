class Api::V1::WatchesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :update, :destroy]
  before_action :set_watch, only: [:show, :update, :destroy]
  before_action :authorize_user!, only: [:update, :destroy]

  def index
    @watches = Watch.all

    # Filter by name_contains
    if params[:name_contains].present?
      @watches = @watches.where("name ILIKE ?", "%#{params[:name_contains]}%")
    end

    # Filter by price range
    if params[:min_price].present? && params[:max_price].present?
      @watches = @watches.where(price: params[:min_price]..params[:max_price])
    end

    # Filter by category
    if params[:category].present?
      @watches = @watches.where(category: params[:category])
    end

    # Sorting
    if params[:sort_by].present? && params[:order].present?
      case params[:sort_by]
      when "name"
        @watches = @watches.order(name: params[:order])
      when "price"
        @watches = @watches.order(price: params[:order])
      when "category"
        @watches = @watches.order(category: params[:order])
      else
        # Default sorting
        @watches = @watches.order(created_at: :desc)
      end
    end

    render json: @watches
  end

  def show
    render json: @watch
  end

  def create
    logger.info "Received request to create watch with params: #{params.inspect}"
    # Your create logic here
    @watch = current_user.watches.build(watch_params)

    if @watch.save
      render json: @watch, status: :created
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  def update
    if @watch.update(watch_params)
      render json: @watch
    else
      render json: @watch.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @watch.destroy
    head :no_content
  end

  private

  def set_watch
    @watch = Watch.find(params[:id])
  end

  def authorize_user!
    unless current_user == @watch.user
      render json: { error: "You are not authorized to perform this action" }, status: :unauthorized
    end
  end

  def watch_params
    params.require(:watch).permit(:name, :description, :category, :price, :image_url)
  end
end
