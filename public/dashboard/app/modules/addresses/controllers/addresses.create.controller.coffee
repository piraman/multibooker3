define ['../addresses.module'], (addresses) ->
	'use strict'
	addresses.controller 'AddressesCreateController', [
		'$scope'
		'$state'
		'Restangular'
		($scope, $state, Restangular) ->

			$scope.address = {}

			$scope.create = ->
				Restangular
					.all 'addresses'
					.post $scope.address
					.then -> $state.go 'addresses.collection'
	]