extend = require 'extend'
http = require 'http'
config = require './../config'

addresses =
	find: (req, res) ->
		query = command: 'get', object: 'hall_addresses'
		query.order_by = (req.query.sortby or 'addr_id') + ' ' + (req.query.sort or 'desc')
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
			mbres.on 'data', (chunk) -> res.json config.trasformMbResponse chunk
	create: (req, res) ->
		url = config.createRequestUrl extend command: 'new', object: 'hall_addresses', req.body
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) -> res.json chunk
	read: (req, res) ->
		url = config.createRequestUrl command: 'get', object: 'hall_addresses', where: 'addr_id = ' + req.params.id
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) ->
				transformedData = config.trasformMbResponse chunk
				data = transformedData.data
				transformedData.data = data[0]
				res.json transformedData
	update: (req, res) ->
		url = config.createRequestUrl (extend command: 'modify', object: 'hall_addresses', req.body)
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) -> res.json chunk
	'delete': (req, res) ->
		url = config.createRequestUrl command: 'remove', object: 'hall_addresses', addr_id: req.params.id, objversion: req.query.objversion
		http.get url, (mbres) ->
			mbres.setEncoding 'utf8'
			mbres.on 'data', (chunk) -> res.json chunk

module.exports = addresses