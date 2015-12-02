module Ruboty
  module Ragoon
    module Template
      class Context
        def get_binding
          binding
        end
      end

      def render_template(template_name, variables = {})
        template = File.read(File.join(TEMPLATE_DIR, "#{template_name}.erb"))
        context = Context.new
        variables.each { |k, v| context.instance_variable_set("@#{k}", v) }
        ::ERB.new(template, $SAFE, '<>').result(context.get_binding)
      end
    end
  end
end
