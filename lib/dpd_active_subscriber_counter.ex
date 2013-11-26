defmodule DpdActiveSubscriberCounter do
  use Application.Behaviour

  # See http://elixir-lang.org/docs/stable/Application.Behaviour.html
  # for more information on OTP Applications
  def start(_type, _args) do
    DpdActiveSubscriberCounter.Supervisor.start_link
  end

  def parse(string) do
    DpdActiveSubscriberCounter.Parser.parse(string)
  end
end
