module JobsHelper
  def responsible_for(job)
    assignee_links = []

    job.assignees.each do |assignee|
      assignee_link = ""
      assignee_link << link_to(assignee.profile.name, assignee.profile)
      assignee_links << assignee_link
    end

    out = assignee_links.to_sentence

    out.html_safe
  end
end
