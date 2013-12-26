module Jekyll
  module AssetsPlugin
    class Renderer

      IMAGE      = '<img src="%s">'


      def initialize context, logical_path
        @site = context.registers[:site]
        @path = logical_path.strip
        gzip = @site.assets_config.gzip_extension ? '.gz' : ''
        @stylesheet = "<link rel='stylesheet' href='%s#{gzip}'>"
        @javascript = "<script src='%s#{gzip}'></script>"
      end


      def render_asset
        @site.assets[@path].to_s
      end


      def render_asset_path
        @site.asset_path @path
      end


      def render_javascript
        @path << ".js" if File.extname(@path).empty?
        render_tag @javascript
      end


      def render_stylesheet
        @path << ".css" if File.extname(@path).empty?
        render_tag @stylesheet
      end


      def render_image
        render_tag IMAGE
      end


      protected


      def render_tag template
        asset = @site.assets[@path]
        (@site.assets_config.debug ? asset.to_a : [asset]).map{ |a|
          template % AssetPath.new(a).to_s
        }.join("\n")
      end

    end
  end
end

