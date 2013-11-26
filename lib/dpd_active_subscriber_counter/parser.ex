defmodule DpdActiveSubscriberCounter.Parser do
  defrecord ActiveSubscribers, subscribers: [] do
    def total_count(record) do
      Enum.count(record.subscribers)
    end
  end
  defrecord Subscriber, first_name: "", last_name: "", terms: "", next_invoice: "", email: "" do
    def active?(record) do
      record.next_invoice != ""
    end
  end

  def parse(string) do
    active_subscribers_record = ActiveSubscribers.new(subscribers: get_active_subscribers(string))
    {:ok, active_subscribers_record}
  end

  defp get_active_subscribers(string) do
    get_subscribers(string) |> Enum.filter(fn(x) -> x.active? end)
  end

  defp get_subscribers(string) do
    [headers|rest] = parse_csv(string)
    Enum.map(rest, fn(data) -> Subscriber.new(attributes_from_row(data)) end)
  end

  defp parse_csv(string) do
    strip_empty_last_line(string) |> CSV.read
  end

  defp strip_empty_last_line(string) do
    Regex.replace(%r/\n\Z/, string, '')
  end

  defp attributes_from_row(row) do
    [
      terms: Enum.at(row, 2),
      next_invoice: Enum.at(row, 5),
      first_name: Enum.at(row, 6),
      last_name: Enum.at(row, 7),
      email: Enum.at(row, 8)
    ]
  end
end
