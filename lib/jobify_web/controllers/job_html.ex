defmodule JobifyWeb.JobHTML do
  use JobifyWeb, :html

  embed_templates "job_html/*"

  @doc """
  Renders a job form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def job_form(assigns)
end
