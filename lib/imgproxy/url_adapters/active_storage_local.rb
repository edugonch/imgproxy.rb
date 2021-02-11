require "imgproxy/url_adapters/active_storage"

module Imgproxy
  class UrlAdapters
    # Adapter for ActiveStorage with local imgprox server storage
    #
    #   Imgproxy.configure do |config|
    #     config.url_adapters.add Imgproxy::UrlAdapters::ActiveStorageLocal.new
    #   end
    #
    #   Imgproxy.url_for(user.avatar)
    class ActiveStorageLocal < Imgproxy::UrlAdapters::ActiveStorage
      def applicable?(image)
        super &&
          image.service.is_a?(::ActiveStorage::Service::S3Service)
      end

      def url(image)
        "local:///#{image.service.bucket.name}/#{image.key}"
      end
    end
  end
end
