module Api
  class GroupsController < Api::BaseController

    private

      def group_params
        params.require(:group).permit(:title)
      end

      def query_params
        # allowing us to filter by this
        params.permit(:title, :title)
      end

  end
end