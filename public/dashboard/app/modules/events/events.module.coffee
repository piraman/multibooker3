define [
	'angular'
	'restangular'
	'uirouter'
	'contextmenu'
], (angular) ->
	'use strict'
	events = angular.module 'app.events', [
		'ui.router'
		'restangular'
		'ng-context-menu'
	]
	events.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
			.state 'events',
				abstract: yes
				template: '<ui-view class=\'events-view-container\'></ui-view>'
				url: '/events'
			.state 'events.collection',
				templateUrl: './app/modules/events/templates/events.collection.template.html'
				controller: 'EventsCollectionController'
				url: '?page'
			.state 'events.document',
				templateUrl: './app/modules/events/templates/events.document.template.html'
				controller: 'EventsDocumentController'
				url: '/{event:[0-9]{1,8}}'
			.state 'event.create',
				templateUrl: './app/modules/events/templates/events.create.template.html'
				controller: 'EventsCreateController'
				url: '/create'
	]
	return events