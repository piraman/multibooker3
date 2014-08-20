define ['../events.module'], (events) ->

	# app.directive 'typeaheadWatchChanges', ->
	# 	require: ['ngModel']
	# 	link: (s, a, c) ->
	# 		console.log arguments
	# 		s.$watch 'item', (value) ->
	# 			c[0].$setViewValue value
	# 			console.log 'value', value
	# 			console.log '$setViewValue', c[0].$setViewValue.$viewValue

	events.controller 'EventsDocumentController', [
		'$scope'
		'$state'
		'$stateParams'
		'Restangular'
		($scope, $state, $stateParams, Restangular) ->

			$scope.item = ''

			$scope.input = (data, evt) ->
				$scope.item += data
				console.log('data', data)
				console.log('$scope.item', $scope.item)
				console.log('evt', evt)

			Restangular
				.one 'events', $stateParams.event
				.get().then (event) ->
					$scope.event = event

			$scope.update = -> $scope.event.put().then -> $state.go 'event.collection'

			# http://plnkr.co/edit/pFsPx0lTM7OZVwF97m1l?p=preview
			# $scope.format = (model) ->
			# 	for address, i in $scope.addresses
			# 		if model is address.addr_id then address.addr

			$scope.getAddresses = (val) ->
				Restangular
					.all 'addresses'
					.getList 'addr*': val
					.then (addresses) ->
						$scope.addresses = addresses
						console.log addresses
						addresses

			$scope.getAllAddresses = -> 6

				# $scope.getAddresses $scope.event.address.addr
				# ngModelCtrl = $element.find 'input'
				# var ngModelCtrl = $element.find('input').controller('ngModel');
    #     ngModelCtrl.$setViewValue(' ');

# app.directive("typeaheadWatchChanges", function() {
#   return {
#     require: ["ngModel"],
#     link: function(scope, element, attr, ctrls) {
#       scope.$watch('item', function(value) {
#         ctrls[0].$setViewValue(value);
#         console.log('value', value);
#         console.log('$setViewValue', ctrls[0].$setViewValue.$viewValue);
#       });
#     }
#   };
# });

# $scope.getLocation = function(val) {
#     return $http.get('http://maps.googleapis.com/maps/api/geocode/json', {
#       params: {
#         address: val,
#         sensor: false
#       }
#     }).then(function(res){
#       var addresses = [];
#       angular.forEach(res.data.results, function(item){
#         addresses.push(item.formatted_address);
#       });
#       return addresses;
#     });
#   };



	]