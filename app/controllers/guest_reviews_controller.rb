class GuestReviewsController < ApplicationController

  def create
    @reservation = Reservation.where(
                    id: guest_review_params[:reservation_id],
                    plan_id: guest_review_params[:plan_id]
                   ).first

    if @reservation.present? && @reservation.plan.user.id == guest_review_params[:host_id].to_i

      @already_review = GuestReview.where(
                        reservation_id: @reservation.id,
                        host_id: guest_review_params[:host_id]
                      ).first

      if @already_review.nil?
          @guest_review = current_user.guest_reviews.create(guest_review_params)
          flash[:notice] = "レビューを投稿しました！"
      else
          flash[:alert] = "既にレビュー済みです"
      end
    else
      flash[:alert] = "プランは見つかりませんでした"
    end

    redirect_back(fallback_location: request.referer)
  end

  def destroy
    @guest_review = Review.find(params[:id])
    @guest_review.destroy

    redirect_back(fallback_location: request.referer, notice: "レビューを削除しました!")
  end

  private
    def guest_review_params
      params.require(:guest_review).permit(:comment, :star, :plan_id, :reservation_id, :host_id)
    end
end
