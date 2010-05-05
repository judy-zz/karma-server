class CustomLinkRenderer < WillPaginate::LinkRenderer
  def page_link(page, text, attributes = {})
    attributes[:class] ? attributes[:class] += ' button' : attributes[:class] = 'button'
    @template.link_to text, url_for(page), attributes
  end
  def page_span(page, text, attributes = {})
    attributes[:class] ? attributes[:class] += ' button' : attributes[:class] = 'button'
    @template.content_tag :span, text, attributes
  end
end