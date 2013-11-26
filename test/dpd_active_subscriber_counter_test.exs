defmodule DpdActiveSubscriberCounterTest do
  use ExUnit.Case

  def input_file_string do
    """
ID, Plan, Terms, Total Payments, Start Date, Next Invoice, First Name, Last Name, Email
5509,"Elixir Sips, Elixir Sips","$9.00 / 1 Month",$9.00,"Nov 19, 2013","Dec 19, 2013",First,Subscriber1,subscriber1@example.com
5037,"Elixir Sips, Elixir Sips","$0.00 / indefinite",$0.00,"Oct 9, 2013",,Second,FreeSubscriber,freesubscriber@example.com
4361,"Elixir Sips, Elixir Sips","$9.00 / 1 Month",$0.00,"Aug 19, 2013","Aug 19, 2013",Fourth,Subscriber4,subscriber4@example.com
    """
  end

  setup do
    {:ok, active_subscribers} = DpdActiveSubscriberCounter.parse(input_file_string)
    {:ok, active_subscribers: active_subscribers}
  end

  test "generates an ActiveSubscribers record", meta do
    # The FreeSubscriber doesn't count as active
    assert meta[:active_subscribers].total_count == 2
  end

  test "extracts the data for each subscriber", meta do
    [first|rest] = meta[:active_subscribers].subscribers
    assert first.first_name == "First"
    assert first.last_name == "Subscriber1"
    assert first.email == "subscriber1@example.com"
    assert first.terms == "$9.00 / 1 Month"
    assert first.next_invoice == "Dec 19, 2013"
  end
end
