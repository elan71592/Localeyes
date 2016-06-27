class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def upload_pic( image )
    image = Cloudinary::Uploader.upload( Rails.root.join( 'public', 'uploads', image ), CLOUDINARY_AUTH )
    image[ 'url' ]
  end

  helper_method :mailbox, :conversation

  private
    def mailbox
      @mailbox ||= current_user.mailbox
    end

    def conversation
      @conversation ||= mailbox.conversations.find(params[:id])
    end

  protected
    protect_from_forgery with: :exception
  include ApplicationHelper
end
