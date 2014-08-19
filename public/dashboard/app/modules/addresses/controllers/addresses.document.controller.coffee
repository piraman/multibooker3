define ['../addresses.module'], (addresses) ->
	'use strict'
	addresses.controller 'AddressesDocumentController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->

			Restangular
				.withConfig (RestangularConfigurer) -> RestangularConfigurer.setRestangularFields id: 'addr_id'
				.one 'addresses', $stateParams.address
				.get()
				.then (address) ->
					$scope.address = address

			$scope.update = -> $scope.address.put().then -> $state.go 'addresses.collection'
	]