defmodule DpdActiveSubscriberCounterClientTest do
  use ExUnit.Case

  test "generates an ActiveSubscribers record" do
    assert active_subscribers.total_count > 0
  end

  test "extracts the data for each subscriber" do
    [first|rest] = active_subscribers.subscribers
    assert first.first_name != ""
    IO.puts first.first_name
    assert first.last_name != ""
  end

  def username do
    System.get_env("GETDPD_USERNAME")
  end

  def password do
    System.get_env("GETDPD_API_KEY")
  end

  def storefront_id do
    System.get_env("GETDPD_STORE_ID")
  end

  def active_subscribers do
    {:ok, response} = DpdActiveSubscriberCounter.client(storefront_id, username, password)
    response
  end
end
