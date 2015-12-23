class NotificationMailer < ApplicationMailer

  default from: 'leave_tracker@nascenia.com'
  CC = ["tomal04@iut-dhaka.edu"]

  def leave_request(holiday)
    @holiday = holiday
    @user = @holiday.user
    @days = @holiday.days
    @reason = @holiday.reason
    @description = @holiday.description
    mail(to: "nafiz@nascenia.com", subject: 'New Leave Request', cc: CC)
  end

  def leave_confirmation(holiday)

    @holiday = holiday
    @user = @holiday.user
    @days = @holiday.days
    @reason = @holiday.reason
    @feedback = @holiday.feedback
    mail(to: "nafiz@nascenia.com", subject: 'Leave Approved', cc: CC)

  end

  def leave_rejection(holiday)

    @holiday = holiday
    @user = @holiday.user
    @days = @holiday.days
    @reason = @holiday.reason
    @feedback = @holiday.feedback

    mail(to: "nafiz@nascenia.com", subject: 'Leave Request Rejected', cc: CC)
  end

end
