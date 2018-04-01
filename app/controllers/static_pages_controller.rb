class StaticPagesController < ApplicationController
  def home
  end

  def contact
  end

  def hospreq
  end

  def path
   data = params[:body]
   subject=params[:subject]
   user = params[:email]
   Mailer.mail_method(data,user,subject).deliver
  end
end
