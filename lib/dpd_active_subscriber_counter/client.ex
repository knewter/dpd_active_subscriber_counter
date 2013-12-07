defmodule DpdActiveSubscriberCounter.Client do
  alias DpdClient.DPD, as: DPD

  defrecord ActiveSubscribers, subscribers: [] do
    def total_count(record) do
      Enum.count(record.subscribers)
    end

    def monthly_revenue(record) do
      record.total_count * subscription_cost
    end

    def yearly_revenue(record) do
      record.monthly_revenue * 12
    end

    defp subscription_cost do
      9
    end
  end
  defrecord Subscriber, first_name: "", last_name: "", terms: "", next_invoice: "", email: "", status: "inactive", trial: true do
    def active?(record) do
      record.has_next_invoice? && (record.status == "ACTIVE") && !record.trial
    end

    def has_next_invoice?(record) do
      record.next_invoice != "" && record.next_invoice != nil
    end
  end

  def get_active_subscribers(storefront_id, username, password) do
    subs = DPD.subscribers(storefront_id, username, password)
    active_subscribers_record = ActiveSubscribers.new(subscribers: get_active_subscribers(subs))
    {:ok, active_subscribers_record}
  end

  defp get_active_subscribers(subs) do
    get_subscribers(subs) |> Enum.filter(fn(x) -> x.active? end)
  end

  defp get_subscribers(subs) do
    Enum.map(subs, fn(data) -> Subscriber.new(attributes_from_sub(data)) end)
  end

  defp attributes_from_sub(sub) do
    [
      terms: "no clue",
      next_invoice: sub["subscription"]["next_payment_at"],
      first_name: sub["username"],
      last_name: sub["username"],
      email: sub["username"],
      status: sub["subscription"]["status"],
      trial: sub["subscription"]["period"] == 0
    ]
  end
end
