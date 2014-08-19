extend = require 'extend'
http = require 'http'
config = require './../config'

halls =
	find: (req, res) -> 
		query = command: 'get', object: 'hall'
		query.order_by = (req.query.sortby or 'hall_id') + ' ' + (req.query.sort or 'desc')
		query.page_no = req.query.page or 1
		query.rows_max_num = req.query.limit or 10
		where = []
		for key, value of req.query
			switch key
				when 'page', 'limit', 'sortby', 'sort' then continue
				else
					lastchar = key[key.length - 1]
					key = key.slice(0, -1)
					switch lastchar
						when '*' then where.push "upper(#{key}) like upper('%#{value}%')"
						when '>' then where.push "#{key} > '#{value}'"
						when '<' then where.push "#{key} < '#{value}'"
						else where.push "#{key} = '#{value}'"
		if where.length then query.where = where.join ' and '
		url = config.createRequestUrl query
		console.log url
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			chunks = ''
			mbres.on 'data', (chunk) ->
				chunks += chunk
			mbres.on 'end', ->
				res.json config.trasformMbResponse chunks
	create: (req, res) ->
		url = config.createRequestUrl extend command: 'new', object: 'hall', req.body
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) -> res.json chunk
	read: (req, res) ->
		url = config.createRequestUrl command: 'get', object: 'hall', where: 'hall_id = ' + req.params.id
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) ->
				transformedData = config.trasformMbResponse chunk
				data = transformedData.data
				transformedData.data = data[0]
				res.json transformedData
	update: (req, res) ->
		url = config.createRequestUrl (extend command: 'modify', object: 'hall', req.body)
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) -> res.json chunk
	'delete': (req, res) ->
		url = config.createRequestUrl command: 'remove', object: 'hall', hall_id: req.params.id, objversion: req.query.objversion
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) -> res.json chunk

module.exports = halls