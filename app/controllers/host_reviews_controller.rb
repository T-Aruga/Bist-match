class HostReviewsController < ApplicationController

  def create
      @reservation = Reservation.where(
                      id: host_review_params[:reservation_id],
                      plan_id: host_review_params[:plan_id],
                      user_id: host_review_params[:guest_id]
                    ).first
      # 対象の参加予約が存在するか確認する
      if @reservation.present?
        @already_review = HostReview.where(
                            reservation_id: @reservation.id,
                            guest_id: host_review_params[:guest_id]
                          ).first
          # 既にレビューを行っているか確認する
          if @already_review.nil?
            @host_review = current_user.host_reviews.create(host_review_params)
            flash[:notice] = "レビューを投稿しました!"
          else
            flash[:alert] = "既にレビュー済みです"
          end
      else
        flash[:alert] = "プランは見つかりませんでした"
      end

      redirect_back(fallback_location: request.referer)
  end

  def destroy
    @host_review = Review.find(params[:id])
    @host_review.destroy

    redirect_back(fallback_location: request.referer, notice: "レビューを削除しました!")
  end



  private
    def host_review_params
      params.require(:host_review).permit(:comment, :star, :plan_id, :reservation_id, :guest_id)
    end
end
