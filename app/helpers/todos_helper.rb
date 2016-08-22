module TodosHelper
  def render_filter_links
    ['all', 'active', 'completed'].map{|state|
      content_tag(:li) do
        link_to state.classify, todos_path(state: state), class: (
        (params[:state].to_s.downcase == state) || (params[:state].blank? && state == 'all') ) ? 'selected' : nil
      end
    }.join.html_safe
  end
end
