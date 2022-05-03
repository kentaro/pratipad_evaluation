# An example implementation of Pratipad device

## Usage

Start a dataflow:

```sh
 $ iex --name device@device.pratipad.local --cookie pratipad_cookie --erl "-proto_dist inet_tls" --erl "-ssl_dist_optfile config/tls.conf" --erl "-start_epmd false" --erl "-erl_epmd_port 44300" -S mix
```
