'use strict'

config =
	sid: 'bwPxKUPqWMoCTWQoolBnXdSkYnxudrYuQyTUQcKIBEMSjxBsHN'
	port: 8080
	mbhost: 'http://192.168.1.101'
	mbendpoint: '/cgi-bin/b2e?request='
	createRequestUrl: (queryObject) ->
			@mbhost + @mbendpoint + @createRequestString queryObject
	createRequestString: (queryObject) ->
		string = '<query>'
		for key, value of queryObject then string += "<#{key}>#{value}</#{key}>"
		string += "<sid>#{config.sid}</sid></query>"
	trasformMbResponse: (mbResponse) ->
		mbres = JSON.parse mbResponse
		res =
			data: []
			meta: {}
		if mbres.results[0].data?
			fields = mbres.results[0].data_columns
				.join '|'
				.toLowerCase()
				.split '|'
			res.meta.fields = fields
			res.meta.info = mbres.results[0].data_info
			for doc, i in mbres.results[0].data
				doc2 = {}
				for column, ii in mbres.results[0].data_columns
					doc2[do column.toLowerCase] = doc[ii]
				res.data.push doc2
			return res
		else
			return mbres.results[0]

module.exports = config