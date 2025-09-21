import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  group('API Contract Tests', () {
    const String baseUrl = 'https://api.itshop.com/v1';
    
    test('GET /products - should return product list with pagination', () async {
      // Arrange
      final response = await http.get(
        Uri.parse('$baseUrl/products?page=1&limit=20'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 200);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], true);
      expect(responseData['data'], isA<Map>());
      expect(responseData['data']['products'], isA<List>());
      expect(responseData['data']['pagination'], isA<Map>());
      
      // Validate pagination structure
      final pagination = responseData['data']['pagination'];
      expect(pagination['page'], isA<int>());
      expect(pagination['limit'], isA<int>());
      expect(pagination['total'], isA<int>());
      expect(pagination['hasNext'], isA<bool>());
      
      // Validate product structure if products exist
      if (responseData['data']['products'].isNotEmpty) {
        final product = responseData['data']['products'][0];
        expect(product['id'], isA<String>());
        expect(product['name'], isA<String>());
        expect(product['price'], isA<num>());
        expect(product['category'], isA<String>());
        expect(product['images'], isA<List>());
      }
    });
    
    test('GET /products/{id} - should return single product', () async {
      // Arrange
      const productId = 'prod_001';
      final response = await http.get(
        Uri.parse('$baseUrl/products/$productId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 200);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], true);
      expect(responseData['data'], isA<Map>());
      
      // Validate product structure
      final product = responseData['data'];
      expect(product['id'], productId);
      expect(product['name'], isA<String>());
      expect(product['description'], isA<String>());
      expect(product['price'], isA<num>());
      expect(product['category'], isA<String>());
      expect(product['images'], isA<List>());
      expect(product['brand'], isA<String>());
    });
    
    test('GET /products/{id} - should return 404 for non-existent product', () async {
      // Arrange
      const productId = 'non_existent_product';
      final response = await http.get(
        Uri.parse('$baseUrl/products/$productId'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 404);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], false);
      expect(responseData['error'], isA<Map>());
      expect(responseData['error']['code'], isA<String>());
      expect(responseData['error']['message'], isA<String>());
    });
    
    test('GET /products/featured - should return featured products', () async {
      // Arrange
      final response = await http.get(
        Uri.parse('$baseUrl/products/featured?type=both&limit=10'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 200);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], true);
      expect(responseData['data'], isA<Map>());
      expect(responseData['data']['bestSellers'], isA<List>());
      expect(responseData['data']['recommended'], isA<List>());
    });
    
    test('GET /categories - should return categories list', () async {
      // Arrange
      final response = await http.get(
        Uri.parse('$baseUrl/categories'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 200);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], true);
      expect(responseData['data'], isA<Map>());
      expect(responseData['data']['categories'], isA<List>());
      
      // Validate category structure if categories exist
      if (responseData['data']['categories'].isNotEmpty) {
        final category = responseData['data']['categories'][0];
        expect(category['id'], isA<String>());
        expect(category['name'], isA<String>());
        expect(category['description'], isA<String>());
        expect(category['icon'], isA<String>());
        expect(category['productCount'], isA<int>());
        expect(category['isActive'], isA<bool>());
      }
    });
    
    test('GET /categories/{id}/products - should return products by category', () async {
      // Arrange
      const categoryId = 'cat_001';
      final response = await http.get(
        Uri.parse('$baseUrl/categories/$categoryId/products?page=1&limit=20'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 200);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], true);
      expect(responseData['data'], isA<Map>());
      expect(responseData['data']['products'], isA<List>());
      expect(responseData['data']['pagination'], isA<Map>());
    });
    
    test('GET /search - should return search results', () async {
      // Arrange
      const query = 'MacBook';
      final response = await http.get(
        Uri.parse('$baseUrl/search?q=$query&page=1&limit=20'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 200);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], true);
      expect(responseData['data'], isA<Map>());
      expect(responseData['data']['products'], isA<List>());
      expect(responseData['data']['query'], query);
      expect(responseData['data']['pagination'], isA<Map>());
    });
    
    test('GET /search - should return 400 for empty query', () async {
      // Arrange
      final response = await http.get(
        Uri.parse('$baseUrl/search?q=&page=1&limit=20'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert
      expect(response.statusCode, 400);
      
      final responseData = json.decode(response.body);
      expect(responseData['success'], false);
      expect(responseData['error'], isA<Map>());
    });
    
    test('API Error Response Structure', () async {
      // Arrange - This test assumes we have a way to trigger an error
      final response = await http.get(
        Uri.parse('$baseUrl/products/invalid_endpoint'),
        headers: {'Content-Type': 'application/json'},
      );
      
      // Assert - Should be an error response
      if (response.statusCode >= 400) {
        final responseData = json.decode(response.body);
        expect(responseData['success'], false);
        expect(responseData['error'], isA<Map>());
        expect(responseData['error']['code'], isA<String>());
        expect(responseData['error']['message'], isA<String>());
        expect(responseData['error']['timestamp'], isA<String>());
      }
    });
  });
}
