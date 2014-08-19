define ['../halls.module'], (halls) ->
	'use strict'
	halls.controller 'HallsCreateController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->

			$scope.hall = {}

			$scope.create = ->
				Restangular
					.all 'halls'
					.post $scope.hall
					.then -> $state.go 'halls.collection'
	]