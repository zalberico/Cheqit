module ApplicationHelper

  #Return a title on a per-page basis.
  def title
    base_title = "cheq.it"
    separator = "-"
    if @title.nil?
      base_title
    else
      "#{base_title} #{separator} #{@title}"
    end
  end
end
