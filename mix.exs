defmodule DpdActiveSubscriberCounter.Mixfile do
  use Mix.Project

  def project do
    [ app: :dpd_active_subscriber_counter,
      version: "0.0.1",
      elixir: "~> 0.11.3-dev",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [mod: { DpdActiveSubscriberCounter, [] }]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:csvlixir, github: "jimm/csvlixir"}
    ]
  end
end
