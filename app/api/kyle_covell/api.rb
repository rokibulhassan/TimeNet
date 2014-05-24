require 'grape-swagger'

module KyleCovell
  class API < Grape::API
    version 'v1', :using => :path, :vendor => 'kyle_covell', :format => :json
    helpers do
      def current_user
        return false unless params[:auth_token]
        @current_user ||= User.where(authentication_token: params[:auth_token]).first
      end

      def authenticate!
        error!('401 Unauthorized', 401) unless current_user
      end
    end

    before do
      authenticate! unless ['/users/authenticate'].any? { |w| request.path_info =~ /#{w}/ }
    end

    resources :users do
      desc "Authenticate user and return user object, access token, and permissions(on demand)"
      params do
        requires :email, :type => String, :desc => "User email"
        requires :password, :type => String, :desc => "User password"
      end

      post 'authenticate' do
        user = User.where(:email => params[:email]).first
        if user && user.valid_password?(params[:password])
          {:user => user.as_json, :status => true, :message => "Authentication Successful."}
        else
          {:id => nil, :status => false, :message => "Authentication Failed.", :errors => "Invalid User!"}
        end
      end
    end

    resource :time_logs do

      desc "Return all time logs."
      get do
        current_user.time_log_records
      end

      desc "It will create time logs for corresponding user and project"
      params do
        requires :user_id, :type => Integer, :desc => "User id"
        requires :project_id, :type => Integer, :desc => "Project id"
        requires :start_at, :type => String, :desc => "Starting date and time"
        requires :end_at, :type => String, :desc => "Ending date and time"
        requires :idle_time, :type => Float, :desc => "Idle Time, Floating value"
      end
      post do
        begin
          time_log = TimeLog.new(user_id: params[:user_id], project_id: params[:project_id], start_at: params[:start_at],
                                 end_at: params[:end_at], idle_time: params[:idle_time])
          time_log.save!
        rescue Exception => ex
          errors = ex.message
        end
        if time_log.save
          {:time_log => time_log.as_json, :status => true, :message => "Time log was successfully created."}
        else
          {:id => nil, :status => false, :message => "Can not create Time log.", :errors => errors}
        end
      end

    end

    resource :customers do

      desc "Return all Customers."
      get do
        current_user.customers.as_json
      end

    end

    resource :projects do

      desc "Return all Projects."
      get do
        current_user.projects.as_json
      end

    end

  end
end