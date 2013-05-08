module ClientTemplateCompiler
  extend self

  def compile
    all_template_script_tags
  end

  def all_template_script_tags
    %w(ui todoList todoItem todoItemList).map do |template_name|
      template_script_tag(template_name)
    end.join
  end

  def template_script_tag(template_name)
    template_contents = File.read(
      Rails.root.join("app/views/ui/#{template_name}.html.mustache"))

    erb = <<-JS
      <script data-template data-name="#{template_name}" type="text/mustache">
        #{template_contents}
      </script>
    JS
  end

end
