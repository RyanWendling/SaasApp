class ContactsController < ApplicationController
    
    #GET request to /contact-us
    # Show new contact form
    def new
     @contact = Contact.new
    end
    
    #POST request to /contacts
    def create
      # Mass assignment of form field into COntact object.
      @contact = Contact.new(contact_params)
      # Save contact object to database
      if @contact.save
          # Store form fields via parameters, into variables
          name = params[:contact][:name]
          email = params[:contact][:email]
          body = params[:contact][:comments]
          #Plug variables into ContactMailer email method and send  email.
         ContactMailer.contact_email(name, email, body).deliver
         # Store success message in flash hash and redirect into new action.
         flash[:success] = "Message sent."
         redirect_to new_contact_path
      else
         # If contact object doesn't save, store errors in flash hash and redirect to new path.
         flash[:danger] = @contact.errors.full_messages.join(", ")
         redirect_to new_contact_path
      end
    end
      #To collect data from form, we need to use strong parameters and whitelist the form fields.Security!
      def contact_params
         params.require(:contact).permit(:name, :email, :comments)
      end
    
end