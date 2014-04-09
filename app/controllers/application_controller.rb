class ApplicationController < ActionController::Base
  protect_from_forgery

  include SimpleCaptcha::ControllerHelpers

  def robots
      robots = File.read(Rails.root + "config/robots.#{Rails.env}.txt")
      render :text => robots, :layout => false, :content_type => "text/plain"
  end


  def homepage
      render "homepage.html", :layout => false
  end

end
