module Api
  module V1
    class SubmissionsController < BaseController

      def index
        submissions_scope ||= reliable? ? Submission.with_attached_image.reliable : Submission.with_attached_image
        

        unsorted_sites.each do |id|
          submissions_scope = submissions_scope.exclude_unsorted(id)
        end

        submissions_scope = search_site(submissions_scope, site_filter) if site_filter?
        submissions_scope = type_search(submissions_scope, type_filter) if type_filter?
        paginate json: submissions_scope.order(record_taken: :desc), per_page: page_size
      end

      private

        def permitted_params
          params.permit(:reliable, 
                        :site_id,
                        :site_filter,
                        :type_filter,
                        :bespoke_size,
                        :page)
        end

        def page_size
          params[:bespoke_size] || (params[:page] && params[:page][:size]) || 10
        end

        def reliable?
          permitted_params[:reliable] == "true"
        end

        def site_filter?
          site_filter.present?
        end

        def type_filter?
          type_filter.present?
        end

        def site_filter
          permitted_params[:site_filter]
        end

        def type_filter
          permitted_params[:type_filter]
        end

        def search_site(collection, name)
          collection.where(site_id: Site.find_by(name: name))
        end
        
        def type_search(collection, type_name)
          type_name.upcase!
          collection = collection.joins(:type).where(types: { name: type_name})
          collection
        end

        def unsorted_sites
          @unsorted_sites||= Site::UNSORTED_SITES.map {|name| Site.find_by(name: name).try(:id) }
        end
    end
  end
end