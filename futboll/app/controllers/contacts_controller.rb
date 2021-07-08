class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      contact = Contact.new(contact_params)
      ContactMailer.contact_mail(contact).deliver
      flash[:success] = "お問い合わせを受け付けました"
      redirect_to root_path
    else
      render :new
      flash[:denger] = "メールアドレスを正しく入力してください"
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:email, :message)
  end
end
