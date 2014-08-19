define [
	'angular'
	'restangular'
	'uirouter'
	'uibootstrap'
], (angular) ->
	'use strict'
	halls = angular.module 'app.halls', [
		'ui.router'
		'restangular'
		'ui.bootstrap'
	]
	halls.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
				.state 'halls',
					abstract: yes
					template: '<ui-view class=\'halls-container\'></ui-view>'
					url: '/halls'
				.state 'halls.collection',
					templateUrl: './app/modules/halls/templates/halls.collection.template.html'
					controller: 'HallsCollectionController'
					url: '?page'
				.state 'halls.document',
					templateUrl: './app/modules/halls/templates/halls.document.template.html'
					controller: 'HallsDocumentController'
					url: '/{address:[0-9]{1,8}}'
				.state 'halls.create',
					templateUrl: './app/modules/halls/templates/halls.create.template.html'
					controller: 'HallsCreateController'
					url: '/create'
	]
	return halls