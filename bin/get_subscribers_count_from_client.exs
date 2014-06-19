alias DpdActiveSubscriberCounter.Client.ActiveSubscribers

storefront_id = System.get_env("GETDPD_STORE_ID")
username = System.get_env("GETDPD_USERNAME")
password = System.get_env("GETDPD_API_KEY")

{:ok, active_subscribers} = DpdActiveSubscriberCounter.client(storefront_id, username, password)
active = "active subscribers: #{ActiveSubscribers.total_count(active_subscribers)}"
monthly_rev = "monthly revenue: #{ActiveSubscribers.monthly_revenue(active_subscribers)}"
yearly_rev = "yearly revenue: #{ActiveSubscribers.yearly_revenue(active_subscribers)}"
IO.puts "#{active} | #{monthly_rev} | #{yearly_rev}"
