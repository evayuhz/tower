module EventsHelper
  def link_to_eventable(event, options = {})
    if event.eventable.class == Todo
      link_to event.eventable.content, project_todo_path(event.project, event.eventable) , options
    elsif event.eventable.class == Project 
      link_to event.project.name, event.eventable, options
    end
  end
end
