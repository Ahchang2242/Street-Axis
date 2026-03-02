class HomeController < ApplicationController
  def index
  end
  
  def categories
    @dance_styles = DanceStyle.ordered
  end
  
  def events
    @events = Event.all
  end
  
  def about
    @about_us = AboutUs.instance
  end
  
  def contact
    @contact_info = ContactInfo.instance
  end
end
