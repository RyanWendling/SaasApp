class ProfilesController < ApplicationController
    #When the user makes a GET request to /users/:user_id/profile/new, we want to run the 'new' action
    def new
        #user will want to see a blank profile details screen.
        @profile = Profile.new
    end

    # POST to users//:user_id/profile
    def create
      # Ensure that we have the user who is filling out form
      @user = User.find( params[:user_id] )
      # Create profile linked to this specific user
      @profile = @user.build_profile( profile_params )
      if @profile.save
        flash[:success] = "Profile updated!"
        redirect_to user_path( params[:user_id] )
      else
        render action: :new
      end
    end
    
    # This is for get requests made to users/:uer_id/profile/edit
    def edit
      @user = User.find(params[:user_id])
      @profile = @user.profile
    end
    
    private
      def profile_params
        params.require(:profile).permit(:first_name, :last_name, :avatar, :job_title, :phone_number, :contact_email, :description)
      end
end