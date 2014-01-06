storefront_id = System.get_env("GETDPD_STORE_ID")
username = System.get_env("GETDPD_USERNAME")
password = System.get_env("GETDPD_API_KEY")

{:ok, active_subscribers} = DpdActiveSubscriberCounter.client(storefront_id, username, password)
active = "active subscribers: #{active_subscribers.total_count}"
monthly_rev = "monthly revenue: #{active_subscribers.monthly_revenue}"
yearly_rev = "yearly revenue: #{active_subscribers.yearly_revenue}"
IO.puts "#{active} | #{monthly_rev} | #{yearly_rev}"
