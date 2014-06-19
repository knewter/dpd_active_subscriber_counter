defmodule DpdActiveSubscriberCounter.Client do
  alias DpdClient.DPD, as: DPD

  defmodule ActiveSubscribers do
    defstruct subscribers: []

    def total_count(struct) do
      Enum.count(struct.subscribers)
    end

    def monthly_revenue(struct) do
      total_count(struct) * subscription_cost
    end

    def yearly_revenue(struct) do
      monthly_revenue(struct) * 12
    end

    defp subscription_cost do
      9
    end
  end

  defmodule Subscriber do
   defstruct first_name: "", last_name: "", terms: "", next_invoice: "", email: "", status: "inactive", trial: true

    def active?(subscriber) do
      has_next_invoice?(subscriber) && (subscriber.status == "ACTIVE") && !subscriber.trial
    end

    def has_next_invoice?(subscriber) do
      subscriber.next_invoice != "" && subscriber.next_invoice != nil
    end
  end

  def get_active_subscribers(storefront_id, username, password) do
    subs = DPD.subscribers(storefront_id, username, password)
    active_subscribers_struct = %ActiveSubscribers{subscribers: get_active_subscribers(subs)}
    {:ok, active_subscribers_struct}
  end

  defp get_active_subscribers(subs) do
    get_subscribers(subs) |> Enum.filter(fn(x) -> Subscriber.active?(x) end)
  end

  defp get_subscribers(subs) do
    Enum.map(subs, fn(data) -> subscriber_for(data) end)
  end

  defp subscriber_for(sub) do
    %Subscriber{
      terms: "no clue",
      next_invoice: sub["subscription"]["next_payment_at"],
      first_name: sub["username"],
      last_name: sub["username"],
      email: sub["username"],
      status: sub["subscription"]["status"],
      trial: sub["subscription"]["period"] == 0
    }
  end
end
