module EventsHelper
  def link_to_eventable(event, options = {})
    if event.eventable.class == Todo
      todo = event.eventable
      link_to todo.content, project_todo_path(event.project, todo) , options
    elsif event.eventable.class == Comment
      todo = event.eventable.todo
      link_to todo.content, project_todo_path(event.project, todo) , options
    elsif event.eventable.class == Project 
      link_to event.project.name, event.eventable, options
    end
  end

  def group_event_by_project_and_time(events)
    before_project = events.first.project
    project_events = [events.first.project, [events.first]]
    events_group = []
    events[1..-1].each do |event|
      if event.project != before_project
        events_group << project_events
        project_events = [event.project, [event]]
        before_project = event.project
      else
        project_events[1] << event
      end
    end
    events_group << project_events
    events_group
  end
end
