module Ruboty
  module Ragoon
    module Template
      def render_template(template_name, variables = {})
        template = ::Tilt.new(find_template(template_name))
        template.render(nil, variables)
      end

      def find_template(template_name)
        [File.join(ENV['PWD'], 'templates'), TEMPLATE_DIR].each do |dirname|
          template_file = Dir.glob(File.join(dirname, "#{template_name}*")).first
          return template_file unless template_file.nil?
        end
        raise "Template Missing : #{template_name} is not found"
      end
    end
  end
end
