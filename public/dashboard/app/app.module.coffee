define [
	# './modules/article/article.index'
	# './modules/category/category.index'
	# './modules/headbar/headbar.index'
	
	# './modules/news/news.index'
	# './modules/order/order.index'
	# './modules/product/product.index'
	# './modules/serie/serie.index'
	# './modules/user/user.index'
	# 'ngtagsinput'
	# 'textangularsanitize'
	'angular'
	'restangular'
	'uibootstrap'
	'uirouter'
	'contextmenu'
	# './modules/menu/menu.index'
	# './modules/kits/index'
	# './modules/products/index'
	'./modules/events/index'
	'./modules/halls/index'
	'./modules/addresses/index'
], (angular) ->
	'use strict'
	app = angular.module 'app', [
		# 'app.article'
		# 'app.category'
		# 'app.headbar'
		# 'app.menu'
		# 'app.categories'
		# 'app.kits'
		# 'app.reports'
		# 'app.articles'
		# 'app.news'
		# 'app.order'
		# 'app.serie'
		# 'app.user'
		# 'ngTagsInput'
		# 'app.menu'
		'app.addresses'
		'app.halls'
		'app.events'
		'ng-context-menu'
		'restangular'
		'ui.bootstrap'
		'ui.router'
	]
	app.directive 'typeaheadWatchChanges', ->
		require: ['ngModel']
		link: (s, e, a, c) ->
			console.log arguments
			s.$watch 'item', (value) ->
				c[0].$setViewValue value
				console.log 'value', value
				console.log '$setViewValue', c[0].$setViewValue.$viewValue
	app.constant 'API_URL', location.origin + '/api/v1'
	app.config [
		'$compileProvider'
		'$stateProvider'
		'$urlRouterProvider'
		'RestangularProvider'
		($compileProvider, $stateProvider, $urlRouterProvider, RestangularProvider) ->
			# $compileProvider.imgSrcSanitizationWhitelist /^\s*(https?|ftp|file|blob):|data:image\//
			$urlRouterProvider.otherwise '/home'
			$stateProvider
			.state 'home',
				template: '<div>home page</div>'
				url: '/home'
			RestangularProvider.setBaseUrl location.origin + '/api/v1'
			RestangularProvider.addRequestInterceptor (element, operation, route, url) ->
				if element? and element.meta?
					delete element.meta
					return element
				return element
			RestangularProvider.addResponseInterceptor (data, operation, what, url, response, deferred) ->
				if data.data?
					interceptedData = data.data
					interceptedData.meta = data.meta
					return interceptedData
				else
					return data
			# RestangularProvider.setRestangularFields id: '_id'
	]
	return app