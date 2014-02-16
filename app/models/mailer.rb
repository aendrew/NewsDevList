require 'dedent'

module Brisk
  module Models
    module Mailer extend self
      def user_invite!(invite)
        Mail.deliver do
          from    'JournoHackers <people@journohackers.com>'
          to      invite.email
          subject "An invitation to join JournoHackers from #{invite.user_name}."
          body    <<-EOF.dedent
            Hi there,

            #{invite.user_name} has invited you to join JournoHackers, a
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
          from    'JournoHackers <people@journohackers.com>'
          to      user.email
          subject 'Welcome to JournoHackers!'
          body    <<-EOF.dedent
            Hi there,

            Good news! #{user.parent_name || 'Admin'} has activated your JournoHackers account.

            Thanks,
            Admin
          EOF
        end
      end

      def feedback!(text, email = nil)
        Mail.deliver do
          from    'JournoHackers <people@journohackers.com>'
          to      'admins@journohackers.com'
          subject 'JournoHackers Feedback'
          reply_to email if email.present?
          body     text

          charset = 'UTF-8'
          content_transfer_encoding = '8bit'
        end
      end
    end
  end
end