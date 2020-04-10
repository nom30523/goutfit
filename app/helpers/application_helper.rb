module ApplicationHelper

  # コントローラーとアクション名の真偽値をチェック
  def check_page(controller_name, action_name)
    controller.controller_name == controller_name && controller.action_name == action_name
  end

end
