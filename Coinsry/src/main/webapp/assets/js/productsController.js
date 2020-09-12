var app = angular.module('ShoppingApp', []);

app.controller('ProductController', function($http) {
	
	var me = this;
		
	me.mvProducts = [];
	me.mpProducts = [];
	
	me.fetchProducts = function() {
		
		
		$http.get('/Coinsry/json/data/mv/products')
			.then(function(response) {
				me.mvProducts = response.data;
		});
			
			
		$http.get('/Coinsry/json/data/mp/products')
		.then(function(response) {
			me.mpProducts = response.data;
		});
				
	}
	
});