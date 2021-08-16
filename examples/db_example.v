module main

import nedpals.vex.router
import nedpals.vex.server
import nedpals.vex.html
import nedpals.vex.ctx
import sqlite

fn layout(title string, body []html.Tag) html.Tag {
	template := html.html([
		html.block({
			name: 'head'
		}, [
			html.meta({
				'http-equiv': 'Content-Type'
				'content':    'text/html;charset=UTF-8'
			}),
			html.meta({
				'name':    'referrer'
				'content': 'origin-when-cross-origin'
			}),
			html.tag(name: 'title', text: '$title | Sex SQLite Test'),
			html.style('
                body {
                    width: 36rem;
                    margin: 0 auto;
                    font-size: 1.4rem;
                    font-family: Palatino, "Palatino Linotype", Georgia, "Lucida Bright",
                                    Cambria, Tahoma, Verdana, Arial, sans-serif;
                    color: #f3c3d9;
                }

								a { color: #ff5103; }
            '),
		]),
		html.block({
			name: 'body'
		}, body),
	])
	return template
}

fn main() {
	mut app := router.new()
	db := sqlite.connect(':memory:') ?
	db.exec('drop table if exists fuck_buddies;')
	db.exec('create table fuck_buddies (id integer primary key, name text default "");')
	app.inject(db)
	app.route(.get, '/', fn (req &ctx.Req, mut res ctx.Resp) {
		page := layout('', [
			html.tag(name: 'h1', text: 'It works!'),
			html.block({
				name: 'p'
			}, [
				html.tag(name: 'text', text: 'For online documentation please refer to '),
				html.tag(
					name: 'a'
					attr: {
						'href': 'https://github.com/WIP-lang/sex'
					}
					text: 'sex'
				),
				html.br(),
				html.block({
					name: 'em'
				}, [
					html.tag(name: 'text', text: "It's a web butthole that you can shove to your ass.")
				]),
			]),
			html.tag(
				name: 'a'
				attr: {
					'href': '/fuck_harder'
				}
				text: 'Quick! My parents are coming!'
			),
			html.br(),
			html.tag(
				name: 'a'
				attr: {
					'href': '/fuck_buddies/add'
				}
				text: 'Add a fuck buddy'
			),
		])
		res.send_html(page.html(), 200)
	})
	app.route(.get, '/fuck_harder', fn (req &ctx.Req, mut res ctx.Resp) {
		db2 := &sqlite.DB(req.ctx)
		fuck_buddies_from_db, _ := db2.exec('select * from fuck_buddies;')
		mut fuck_buddies := []html.Tag{}
		for row in fuck_buddies_from_db {
			tag := html.Tag{
				name: 'li'
				text: row.vals[1]
			}
			fuck_buddies << tag
		}
		page := layout('Fuck Buddies', [
			html.tag(name: 'h1', text: 'Fuck Buddies'),
			html.block({
				name: 'ul'
			}, fuck_buddies),
			html.tag(
				name: 'a'
				attr: {
					'href': '/'
				}
				text: 'Back to homepage'
			),
		])
		res.send_html(page.html(), 200)
	})
	app.route(.get, '/fuck_buddies/add', fn (req &ctx.Req, mut res ctx.Resp) {
		page := layout('Add new Fuck Buddy', [
			html.tag(
				name: 'a'
				attr: {
					'href': '/fuck_harder'
				}
				text: 'All fuck buddies'
			),
			html.tag(name: 'h1', text: 'Add Fuck Buddy'),
			html.block({
				name: 'form'
				attr: {
					'id':     'form'
					'method': 'post'
					'action': '/fuck_buddies/new'
				}
			}, [
				html.Tag{
					name: 'input'
					attr: {
						'id':    'name'
						'name':  'name'
						'value': ''
					}
				},
				html.Tag{
					name: 'button'
					attr: {
						'type': 'submit'
					}
					text: 'Add'
				},
			]),
		])
		res.send_html(page.html(), 200)
	})
	app.route(.post, '/fuck_buddies/new', fn (req &ctx.Req, mut res ctx.Resp) {
		db2 := &sqlite.DB(req.ctx)
		form_data := req.parse_form() or {
			map[string]string{}
		}
		name := form_data['name']
		db2.exec('insert into fuck_buddies (name) values ("$name");')
		res.permanent_redirect('/fuck_buddies')
	})
	server.serve(app, 8080)
}
