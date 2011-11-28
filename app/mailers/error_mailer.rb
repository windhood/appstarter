class ErrorMailer < ActionMailer::Base
  default from: "error@wenhu.com"
  default to: "error@wenhu.com"
  
  def error(err, req, user)
    @error = err
    @request = req
    @user = user

    @backtrace = clean_backtrace(err)
    mail(:subject => "Error: " + err.class.to_s)
  end

  def clean_backtrace(exception)
    if backtrace = exception.backtrace
      if defined?(RAILS_ROOT)
        backtrace.map { |line| line.sub RAILS_ROOT, '' }
      else
        backtrace
      end
    end
  end
end