module Ruboty
  module Ragoon
    module Template
      def render_template(template_name, variables = {})
        template = ::Tilt.new(File.join(TEMPLATE_DIR, "#{template_name}.erb"))
        template.render(nil, variables)
      end
    end
  end
end
