# -*- encoding: utf-8 -*-

class NoticeMailer < ActionMailer::Base
  default from: "hokui93.net@gmail.com"

  def registration_confirm(user_mail, pass, invited_by)
    @mail=user_mail
    @pass=pass
    @invited_by=invited_by
    mail(to: user_mail, subject: 'メンバー登録完了 - ホクイネット93')
  end
end
