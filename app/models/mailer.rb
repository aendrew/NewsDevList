require 'dedent'

module Brisk
  module Models
    module Mailer extend self
      def user_invite!(invite)
        Mail.deliver do
          from    'NewsDevList <people@journohackers.com>'
          to      invite.email
          subject "An invitation to join NewsDevList from #{invite.user_name}."
          body    <<-EOF.dedent
            Hi there,

            #{invite.user_name} has invited you to join NewsDevList, a
            community for folks who write software for news.

            To learn more, and claim your invitation, visit:

            \thttp://www.journohackers.com/claim/#{invite.code}

            Thanks,
            Admin
          EOF
        end
      end

      def user_activate!(user)
        Mail.deliver do
          from    'NewsDevList <people@journohackers.com>'
          to      user.email
          subject 'Welcome to NewsDevList!'
          body    <<-EOF.dedent
            Hi there,

            Good news! #{user.parent_name || 'Admin'} has activated your NewsDevList account.

            Thanks,
            Admin
          EOF
        end
      end

      def feedback!(text, email = nil)
        Mail.deliver do
          from    'NewsDevList <people@journohackers.com>'
          to      'admins@journohackers.com'
          subject 'NewsDevList Feedback'
          reply_to email if email.present?
          body     text

          charset = 'UTF-8'
          content_transfer_encoding = '8bit'
        end
      end
    end
  end
end