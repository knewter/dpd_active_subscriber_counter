# DpdActiveSubscriberCounter

This is just a basic project to parse the CSV file that comes out of DPD and
estimate the number of actual active subscribers presently.

This is just to help me out, but figured I'd release it on GitHub as I worked on
it just because that's how I roll :)

## Development

`mix test`

## Use

Download only the active subscribers.  Something [like this.](https://getdpd.com/subscriber/list?filters%5Bfirst_name%5D=&filters%5Blast_name%5D=&filters%5Bemail%5D=&filters%5Bstatus%5D=ACTIVE&filters%5Bplan_id%5D=&search=Search)

Save that file as `subscribers.csv`

Then run the app on that file...

## Resources

Pulled in a CSV parser from [here](https://github.com/jimm/elixir/tree/master/csv).
