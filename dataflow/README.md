# An example implementation of Pratipad dataflow

## Usage

Start a dataflow:

```sh
 $ iex --name dataflow@dataflow.pratipad.local --cookie pratipad_cookie --erl "-proto_dist inet_tls" --erl "-ssl_dist_optfile config/tls.conf" --erl "-start_epmd false" --erl "-erl_epmd_port 44300" -S mix
```
