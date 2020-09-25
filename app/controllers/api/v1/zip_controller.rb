module Api
  module V1
    class ZipController < BaseController
      def zip_images
        # binding.pry
        if !(email.present? && site_id.present?)
          render json: {notce: "Ensure you are logged in, and have selected a site"}
        else
          SubmissionZipWorker.perform_async(site_id, email, 'tmp_archive_dir')
          render json: {notce: "Zip job has been stated, you will be emailed the images soon"}
        end
      end

      private

      def permitted_params
        params.permit(:email, :site_name, :type, :tags)
      end

      def email
        @email ||= permitted_params[:email]
      end

      def site_id
        @site_id ||= Site.find_by(name: permitted_params[:site_name]).try(:id)
      end

      def type
        @type ||= permitted_params[:type]
      end

      def tags
        @tags ||= permitted_params[:tags]
      end
    end
  end
end