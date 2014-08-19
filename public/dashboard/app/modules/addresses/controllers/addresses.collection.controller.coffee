define [
	'angular'
	'../addresses.module'
], (angular, addresses) ->
	'use strict'
	addresses.controller 'AddressesCollectionController', [
		'$scope'
		'$state'
		'$location'
		'Restangular'
		($scope, $state, $location, Restangular) ->
			# console.log '6666666'
			describe 'test2', ->
				it 'should be empty'
			search = do $location.search
			$scope.pagination = max: 5, total: null, pages: null, current: null, limit: search.limit or 10
			$scope.selected = null
			$scope.products = []
			describe 'test2', ->
				it 'proucts should be empty', ->
					expect $scope.products.length
					.toBe 1
			Restangular
				.withConfig (RestangularConfigurer) -> RestangularConfigurer.setRestangularFields id: 'addr_id'
				.all 'addresses'
				.getList search
				.then (addresses) ->
					$scope.addresses = addresses
					$scope.pagination.total = addresses.meta.info.rows_count
					$scope.pagination.pages = Math.ceil $scope.pagination.total / $scope.pagination.limit
					$scope.pagination.current = search.page or 1

			$scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
			$scope.create = -> $state.go 'addresses.create'
			$scope.read = (index) -> $state.go 'addresses.document', address: $scope.addresses[index].addr_id
			$scope.readSelected = -> @read $scope.selected
			$scope.delete = (index) ->
				$scope.addresses[index]
					.remove objversion: $scope.addresses[index].objversion
					.then -> $state.transitionTo $state.current, search, reload: yes, inherit: no, notify: yes
			$scope.deleteSelected = -> @delete $scope.selected
			$scope.pagination.change = ->
				search = angular.copy search
				search.page = $scope.pagination.current
				$state.transitionTo $state.current, search, reload: yes, inherit: no, notify: yes

	]