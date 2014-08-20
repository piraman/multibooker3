# load dependencies
express = require 'express'
body = require 'body-parser'

app = do express
router = do express.Router

# configure app
app.use (err, req, res, next) -> if err then throw err else do next
app.use (express.static "#{__dirname}/public")
app.use do body.json
app.use (body.urlencoded extended: yes)

# load app routes controllers
addresses = require './routes/addresses.controllers'
halls = require './routes/halls.controllers'
events = require './routes/events.controllers'

# configure app routes
router.route '/addresses'
	.get addresses.find
	.post addresses.create
router.route '/addresses/:id'
	.get addresses.read
	.put addresses.update
	.delete addresses.delete

router.route '/halls'
	.get halls.find
	.post halls.create
router.route '/halls/:id'
	.get halls.read
	.put halls.update
	.delete halls.delete

router.route '/events'
	.get events.find
	.post events.create
router.route '/events/:id'
	.get events.read
	.put events.update
	.delete events.delete

app.use '/api/v1', router

# run app
app.listen 8090, -> console.log "started on port 8090"

