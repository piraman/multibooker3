define [
	'angular'
	'../events.module'
], (angular, events) ->

	events.controller 'EventsCollectionController', [
		'$scope'
		'$state'
		'$stateParams'
		'$location'
		'Restangular'
		'$filter'
		($scope, $state, $stateParams, $location, Restangular, $filter) ->

			search = do $location.search
			$scope.pagination = max: 5, total: null, pages: null, current: null, limit: search.limit or 10
			$scope.selected = null
			$scope.products = []

			Restangular
				.withConfig (RestangularConfigurer) -> RestangularConfigurer.setRestangularFields id: 'action_id'
				.all 'events'
				.getList search
				.then (events) ->
					$scope.events = events
					$scope.pagination.total = events.meta.info.rows_count
					$scope.pagination.pages = Math.ceil $scope.pagination.total / $scope.pagination.limit
					$scope.pagination.current = search.page or 1

			$scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
			$scope.create = -> $state.go 'events.create'
			$scope.read = (index) -> $state.go 'events.document', event: $scope.events[index].action_id
			$scope.readSelected = -> @read $scope.selected
			$scope.delete = (index) ->
				$scope.events[index]
					.remove objversion: $scope.events[index].objversion
					.then -> $state.transitionTo $state.current, search, reload: yes, inherit: no, notify: yes
			$scope.deleteSelected = -> @delete $scope.selected
			$scope.pagination.change = ->
				search = angular.copy search
				search.page = $scope.pagination.current
				$state.transitionTo $state.current, search, reload: yes, inherit: no, notify: yes
			# console.log do $location.search
			# search = do $location.search
			# # search defaults
			# unless search.limit then searches.limit = 10
			# unless search.page then searches.page = 1
			# unless search.sortby then searches.sortby = 'action_id'
			# unless search.sortdirection then search.sortdirection = 'desc'
			# if search.action_date_from is '' then delete search.action_date_from
			# if search.action_date_to is '' then delete search.action_date_to
			# console.log search
			# # pagination init
			# $scope.pagination =
			# 	max: 5
			# 	total: null
			# 	pages: null
			# 	current: null
			# # filters init
			# $scope.filters =
			# 	settings:
			# 		collapsed: yes
			# 		datepickerOptions: options: formatYear: 'yy', startingDay: 1
			# 		datepickerFormat: 'dd.MM.yyyy'
			# 	fields:
			# 		action_date_from: if search.action_date_from? then do -> from = search.action_date_from.split '.'; new Date from[2], from[1] - 1, from[0] else null
			# 		action_date_to: if search.action_date_from? then do -> to = search.action_date_to.split '.'; new Date to[2], to[1] - 1, to[0] else null
			# 		hall_id: if search.hall_id? then search.hall_id else null
			# # common init
			# $scope.selected = null
			# $scope.events = []
			# # Load data
			# Restangular
			# 	.withConfig (RestangularConfigurer) -> RestangularConfigurer.setRestangularFields id: 'action_id'
			# 	.all 'events'
			# 	.getList 
			# 	.then (events) ->
			# 		$scope.events = events
			# 		$scope.total = $scope.events.meta.info.rows_count
			# 		$scope.pages = Math.ceil $scope.total / $scope.limit
			# 		$scope.current = $scope.page
			# # Other stuff
			# $scope.create = -> $state.go 'event.create'
			# $scope.open = (index) -> $state.go 'event.document', id: $scope.events[index].event_id
			# $scope.openSelected = -> $state.go 'event.document', id: $scope.events[$scope.selected].event_id
			# $scope.toggle = (index) -> if $scope.selected is index then $scope.selected = !$scope.selected else $scope.selected = index
			# $scope.changeLimit = (limit) -> $state.transitionTo $state.current, limit: limit, reload: yes, inherit: no, notify: yes
			# $scope.changePage = -> $state.transitionTo $state.current, (angular.extend (do $location.search), page: $scope.current), reload: yes, inherit: no, notify: yes
			# $scope.action = (index) -> console.log index
			# $scope.openDateFrom = (event) ->
			# 	do event.preventDefault
			# 	do event.stopPropagation
			# 	$scope.dateFromIsOpen = true
			# $scope.openDateTo = (event) ->
			# 	do event.preventDefault
			# 	do event.stopPropagation
			# 	$scope.dateToIsOpen = true
			# $scope.deleteSelected = ->
			# 	$scope.events[$scope.selected]
			# 		.remove objversion: $scope.events[$scope.selected].objversion
			# 		.then -> $state.transitionTo $state.current, limit: $scope.limit, reload: yes, inherit: no, notify: yes
			# $scope.delete = (index) ->
			# 	$scope.events[index]
			# 		.remove objversion: $scope.events[index].objversion
			# 		.then -> $state.transitionTo $state.current, limit: $scope.limit, reload: yes, inherit: no, notify: yes
			# $scope.applyFilters = ->
			# 	queries = limit: $state.params.limit, from: (($filter 'date') $scope.dateFrom, $scope.dateFormat), to: (($filter 'date') $scope.dateTo, $scope.dateFormat)
			# 	$state.transitionTo $state.current, queries, reload: yes, inherit: no, notify: yes
			# $scope.resetFilters = ->
			# 	$state.transitionTo $state.current, limit: $state.params.limit, reload: yes, inherit: no, notify: yes
	]