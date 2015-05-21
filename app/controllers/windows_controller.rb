class WindowsController < ApplicationController
  def index
  end

  def create
    app = RailsPushNotifications::MPNSApp.new
    app.cert = params[:cert]
    app.save

    if app.save
      notif = app.notifications.build(
        destinations: [params[:destination]],
        data: {
          title: 'Rails Push Test Notification',
          message: params[:message],
          type: :toast
        }
      )

      if notif.save
        app.push_notifications
        notif.reload
        flash[:notice] = "Notification successfully pushed through!. Results #{notif.results.success} succeded, #{notif.results.failed} failed"
        redirect_to :android_index
      else
        flash.now[:error] = notif.errors.full_messages
        render :index
      end
    else
      flash.now[:error] = app.errors.full_messages
      render :index
    end
  end
end
