defmodule Jobify.Repo do
  use Ecto.Repo,
    otp_app: :jobify,
    adapter: Ecto.Adapters.Postgres
end
