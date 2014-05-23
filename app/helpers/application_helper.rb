module ApplicationHelper
  
  def formated_date(data)
    return "" if data.nil?
    data.strftime("%b %d, %Y")
   end
 
   def formated_datetime(data)
    return "" if data.nil?    
    data.strftime("%b %d, %Y | %I:%M %p")
  end

  def total_time_logged_str(logged)
    seconds = logged.to_f % 60
    minutes = (logged.to_f / 60) % 60
    hours = logged.to_f / (60 * 60)
    return format("%02d:%02d:%02d", hours, minutes, seconds)
  end

  def country(id)
    Country.find(id).name rescue ""
  end

  def state(id)
    State.find(id).name rescue ""
  end

  def link_to_contact(contacts)
    items = ""
    contacts.collect do |contact|
      items += link_to(contact.name, contact_path(contact), :class => 'text-info', :target => '_blank')
      items += "<br>"
    end
    return items.html_safe
  end

  def link_to_user(users)
    items = ""
    users.collect do |user|
      items += link_to(user.name, users_admin_path(user), :class => 'text-info', :target => '_blank')
      items += "<br>"
    end
    return items.html_safe
  end
end
