module EventsHelper
  def link_to_eventable(event, options = {})
    evtable = event.eventable
    if evtable.class == Todo
      link_to evtable.content, project_todo_path(event.project, evtable) , options
    elsif evtable.class == Comment
      cmtable = evtable.commentable
      if cmtable.class == Todo 
        link_to cmtable.content, project_todo_path(event.project, cmtable) , options
      end
    elsif evtable.class == Project 
      link_to event.project.name, evtable, options
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

  def event_content(event)
    content = event.content
    action = content.delete(:action)
    if content 
      t(action, event.content)
    else
      t(action)
    end
  end
end
