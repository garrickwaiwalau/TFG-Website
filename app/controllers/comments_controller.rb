class CommentsController < ApplicationController
    # http_basic_authenticate_with name: "dhh", password: "secret", only: :destroy

    def create
      @article = Index.find(params[:article_id])
      @comment = @article.comments.create(comment_params)
      redirect_to article_path(@article)
    end

    def destroy
      @article = Index.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      # redirect_to article_path(@article), status: :see_other
      redirect_to article_path(@article)
    end

    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
      end
end
