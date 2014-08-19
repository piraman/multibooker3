define [
	'angular'
	'../halls.module'
], (angular, halls) ->
	'use strict'
	halls.controller 'HallsCollectionController', [
		'$scope'
		'$state'
		'$location'
		'Restangular'
		($scope, $state, $location, Restangular) ->

			search = do $location.search
			$scope.pagination = max: 5, total: null, pages: null, current: null, limit: search.limit or 10
			$scope.selected = null
			$scope.products = []

			Restangular
				.withConfig (RestangularConfigurer) -> RestangularConfigurer.setRestangularFields id: 'hall_id'
				.all 'halls'
				.getList search
				.then (halls) ->
					$scope.halls = halls
					$scope.pagination.total = halls.meta.info.rows_count
					$scope.pagination.pages = Math.ceil $scope.pagination.total / $scope.pagination.limit
					$scope.pagination.current = search.page or 1

			$scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
			$scope.create = -> $state.go 'halls.create'
			$scope.read = (index) -> $state.go 'halls.document', hall: $scope.halls[index].hall_id
			$scope.readSelected = -> @read $scope.selected
			$scope.delete = (index) ->
				$scope.halls[index]
					.remove objversion: $scope.halls[index].objversion
					.then -> $state.transitionTo $state.current, search, reload: yes, inherit: no, notify: yes
			$scope.deleteSelected = -> @delete $scope.selected
			$scope.pagination.change = ->
				search = angular.copy search
				search.page = $scope.pagination.current
				$state.transitionTo $state.current, search, reload: yes, inherit: no, notify: yes

	]