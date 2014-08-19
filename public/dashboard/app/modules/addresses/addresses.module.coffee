define [
	'angular'
	'restangular'
	'uirouter'
	'uibootstrap'
], (angular) ->
	'use strict'
	addresses = angular.module 'app.addresses', [
		'ui.router'
		'restangular'
		'ui.bootstrap'
	]
	addresses.config [
		'$stateProvider'
		($stateProvider) ->
			$stateProvider
				.state 'addresses',
					abstract: yes
					template: '<ui-view class=\'addresses-container\'></ui-view>'
					url: '/addresses'
				.state 'addresses.collection',
					templateUrl: './app/modules/addresses/templates/addresses.collection.template.html'
					controller: 'AddressesCollectionController'
					url: ''
				.state 'addresses.document',
					templateUrl: './app/modules/addresses/templates/addresses.document.template.html'
					controller: 'AddressesDocumentController'
					url: '/{address:[0-9]{1,8}}'
				.state 'addresses.create',
					templateUrl: './app/modules/addresses/templates/addresses.create.template.html'
					controller: 'AddressesCreateController'
					url: '/create'
	]
	return addresses