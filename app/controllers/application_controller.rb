class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  include SessionsHelper

  rescue_from CanCan::AccessDenied do |exception|
    render_403
  end

  rescue_from ActiveRecord::RecordNotFound do |exception|
    render_404
  end

  def render_403(options={})
    render_error({:message => "你没有访问此内容的权限", :status => 403}.merge(options))
    return false
  end

  def render_404(options={})
    render_error({:message => "页面不存在", :status => 404}.merge(options))
    return false
  end

  # Renders an error response
  def render_error(arg)
    @status = arg[:status] || 500
    @message = arg[:message]

    render :template => 'common/error', :status => @status
  end
end
