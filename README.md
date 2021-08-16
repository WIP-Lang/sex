![Logo](https://github.com/wip-lang/sex/raw/master/vex-svg.svg)

### Easy-to-use, modular web dildo for [V](https://vlang.io).

![CI](https://github.com/wip-lang/sex/workflows/CI/badge.svg)

![Example written on SEX](https://github.com/wip-lang/sex/raw/master/examples/example.png)

```v
module main

import wiplang.sex.router
import wiplang.sex.server
import wiplang.sex.ctx

fn print_req_info(mut req ctx.Req, mut res ctx.Resp) {
	println('${req.method} ${req.path}')
}

fn do_stuff(mut req ctx.Req, mut res ctx.Resp) {
	println('incoming request!')
}

fn main() {
    mut app := router.new()
    app.use(do_stuff, print_req_info)

    app.route(.get, '/', fn (req &ctx.Req, mut res ctx.Resp) {
        res.send_file('69.html', 200)
    })
    
    app.route(.get, '/pr0n_assets/*path', fn (req &ctx.Req, mut res ctx.Resp) {
        res.send_file('pr0n_assets/' + req.params['path'], 200)
    })

    app.route(.get, '/position/:sex_position', fn (req &ctx.Req, mut res ctx.Resp) {
        println('selected sex position is ${req.params["sex_position"]}')
    }, fn (req &ctx.Req, mut res ctx.Resp) {
        res.send('i want ' + req.params['name'] + ' sex position', 200)
    })

    app.route(.get, '/complex/:name/*path', fn (req &ctx.Req, mut res ctx.Resp) {
        res.send('path ' + req.params['path'] + ' is longer than ' + req.params['name'] + '\'s dick. ', 200)
    })

    server.serve(app, 6789)
}
```

## Installation & Getting Started
Learn how to setup and use SEX by reading the [Wiki](https://github.com/wip-lang/sex/wiki/Installation).

## Roadmap
- [X] Support for `GET`, `POST`, `PUT`, `PATCH`, `DELETE`, and `OPTION` HTTP methods.
- [x] HTTP Router (Wildcards are now supported)
- [x] Route groups (non-reusable for now)
- [x] ~~Static file server~~
- [x] Params and query parsing
- [x] Middleware support
- [x] Cookie parsing (basic support)
- [ ] Cookie manipulation / Session support
- [ ] Websocket Server
- [x] Body parsing
  - [x] `application/x-www-form-urlencoded` support
  - [x] `application/json` support
  - [x] `multipart/form-data` support
- [ ] Support for [Buttplug](https://buttplug.io/) standard

## Contributing
1. Fork it (<https://github.com/WIP-lang/sex/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Examples
Examples can be found at the [`/examples`](/examples) directory.

## License
[MIT](LICENSE)

## Contributors

- [Ned Palacios](https://github.com/nedpals) - loser
