class LinkDecorator < Draper::Decorator
  delegate_all

  def short_url
    "#{h.request.base_url}/#{object.short_link}"
  end

  def short_decorator_url
    "#{h.request.host}/#{object.short_link}"
  end
end
