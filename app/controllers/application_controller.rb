class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  filter_parameter_logging :password, :password_confirmation
  helper_method :current_participant_session, :current_participant

  private
    def current_participant_session
      return @current_participant_session if defined?(@current_participant_session)
      @current_participant_session = ParticipantSession.find
    end

    def current_participant
      return @current_participant if defined?(@current_participant)
      @current_participant = current_participant_session && current_participant_session.participant
    end
  end
end
