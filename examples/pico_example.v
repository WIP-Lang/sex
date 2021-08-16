module main

import nedpals.vex.router
import nedpals.vex.picoserver
import nedpals.vex.ctx

fn main() {
	mut app := router.new()
	app.route(.get, '/', fn (req &ctx.Req, mut res ctx.Resp) {
		res.send('Boku no pico is my favorite anime', 200)
	})
	picoserver.serve(app, 8080)
}
