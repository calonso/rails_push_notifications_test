class AppleController < ApplicationController
  def index
  end

  def create
    app = RailsPushNotifications::APNSApp.new
    app.apns_dev_cert = params[:cert]
    app.apns_prod_cert = params[:cert]
    app.sandbox_mode = !!params[:sandbox_mode]

    if app.save
      notif = app.notifications.build(
        destinations: [params[:destination]],
        data: { aps: { alert: params[:message], sound: 'true', badge: 1 } }
      )

      if notif.save
        app.push_notifications
        notif.reload
        flash.now[:notice] = "Notification successfully pushed through!. Results #{notif.results.success} succeded, #{notif.results.failed} failed"
      else
        flash.now[:error] = notif.errors.full_messages
      end
    else
      flash.now[:error] = app.errors.full_messages
    end

    render :index
  end
end
