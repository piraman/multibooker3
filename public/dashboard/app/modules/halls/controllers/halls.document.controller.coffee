define ['../halls.module'], (halls) ->
	'use strict'
	halls.controller 'HallsDocumentController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->

			Restangular
				.withConfig (RestangularConfigurer) -> RestangularConfigurer.setRestangularFields id: 'addr_id'
				.one 'halls', $stateParams.hall
				.get()
				.then (hall) ->
					$scope.hall = hall

			$scope.update = -> $scope.hall.put().then -> $state.go 'halls.collection'
	]