# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from(ActiveRecord::RecordNotFound, with: :notfound)
  include Pagy::Backend
  include Authentication
  include Mails

  private

  def record_log(obj, action)
    if obj.instance_of?(Post)
      @log = obj.logs.build(status: action, log_obj_type: self, user_id: current_user.id, title: obj.title)
    else
      name = Post.find(obj[:post_id])
      @log = obj.logs.build(status: action, log_obj_type: self, user_id: current_user.id, title: name.title)
    end
    @log.save
  end

  def notfound
    render file: 'public/404.html', status: :not_found, layout: false
  end
end
