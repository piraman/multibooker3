define ['../events.module'], (events) ->

	events.controller 'EventsCreateController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->
			# events = Restangular.all 'events'
			# $scope.event = {}
			# $scope.saveDocument = ->
			# 	events
			# 	.post $scope.event
			# 	.then -> $state.go 'event.collection'
	]