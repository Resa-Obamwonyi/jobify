defmodule JobifyWeb.Router do
  use JobifyWeb, :router

  import JobifyWeb.UserAuth
  import Tarams, only: [plug_scrub: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {JobifyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_user
    plug :plug_scrub
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", JobifyWeb do
    pipe_through :browser

    get "/", PageController, :home

    # TO-DO: Break down the authentication into a separate controller, create urls for view and single view for jobs and industries
    # TO-DO: For clean up, use libraries to make things cleaner, use taram to shorten filter fields controller
    # TO-DO: try not to mix controllers and db logics
  end

  # Other scopes may use custom stacks.
  # scope "/api", JobifyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:jobify, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: JobifyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", JobifyWeb do
    pipe_through [:browser, :redirect_if_user_is_authenticated]

    # get "/users/register", UserRegistrationController, :new
    # post "/users/register", UserRegistrationController, :create
    get "/users/log_in", UserSessionController, :new
    post "/users/log_in", UserSessionController, :create
    get "/users/reset_password", UserResetPasswordController, :new
    post "/users/reset_password", UserResetPasswordController, :create
    get "/users/reset_password/:token", UserResetPasswordController, :edit
    put "/users/reset_password/:token", UserResetPasswordController, :update
  end

  scope "/", JobifyWeb do
    pipe_through [:browser, :require_authenticated_user]

    get "/users/settings", UserSettingsController, :edit
    put "/users/settings", UserSettingsController, :update
    get "/users/settings/confirm_email/:token", UserSettingsController, :confirm_email

    resources "/jobs", JobController
    resources "/industries", IndustryController
  end

  scope "/", JobifyWeb do
    pipe_through [:browser]

    delete "/users/log_out", UserSessionController, :delete
    get "/users/confirm", UserConfirmationController, :new
    post "/users/confirm", UserConfirmationController, :create
    get "/users/confirm/:token", UserConfirmationController, :edit
    post "/users/confirm/:token", UserConfirmationController, :update

    # general url for public or unauthenticated users
    get "/openings", GeneralJobController, :index
    get "/openings/:id", GeneralJobController, :show
  end
end
