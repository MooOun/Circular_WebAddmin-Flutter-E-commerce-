// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductInformationScreen extends StatefulWidget {
  @override
  _ProductInformationScreenState createState() =>
      _ProductInformationScreenState();
}

class _ProductInformationScreenState extends State<ProductInformationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานข้อมูลสินค้า'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getProductInformation(),
        builder: (context, productInfoSnapshot) {
          if (productInfoSnapshot.connectionState ==
              ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple.shade500,
              ),
            );
          } else if (productInfoSnapshot.hasError) {
            return Center(
              child: Text(
                  'Error fetching product information: ${productInfoSnapshot.error}'),
            );
          } else if (productInfoSnapshot.data == null ||
              productInfoSnapshot.data!.isEmpty) {
            return Center(
              child: Text('Product information not found'),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                padding: EdgeInsets.all(16),
                color: Colors.grey.shade200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Store Name: CircularMall',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Address: UDRU อำเภอเมืองอุดรธานี อุดรธานี 41000',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Phone: 063-5415971',
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      'Email: Circularmall@gmail.com',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
                SingleChildScrollView(
                  child: 
                  DataTable(
                    columns: [
                      DataColumn(label: Text('รหัสสินค้า', style: TextStyle(fontSize: 18),)),
                      DataColumn(label: Text('ชื่อสินค้า', style: TextStyle(fontSize: 18))),
                      DataColumn(label: Text('หมวดหมู่สินค้า', style: TextStyle(fontSize: 18))),
                      DataColumn(label: Text('จำนวนสินค้าทั้งหมดในสต็อก', style: TextStyle(fontSize: 18))),
                      DataColumn(label: Text('จำนวนสินค้าคงเหลือในสต็อก', style: TextStyle(fontSize: 18))),
                    ],
                    rows: _buildDataRows(productInfoSnapshot.data!),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<List<Map<String, dynamic>>> _getProductInformation() async {
    try {
      var productsSnapshot =
          await FirebaseFirestore.instance.collection('Products').get();

      if (productsSnapshot.docs.isNotEmpty) {
        List<Map<String, dynamic>> productsList = [];

        productsSnapshot.docs.forEach((productDoc) {
          var productData = productDoc.data() as Map<String, dynamic>;
          var productId = productData['productId'] ?? '';
          var productName = productData['productName'] ?? '';
          var category = productData['category'] ?? '';
          var totalStock = _calculateTotalStock(productData['sizes']);

          var productInfo = {
            'productId': productId,
            'productName': productName,
            'category': category,
            'totalStock': totalStock.toString(),
          };
          productsList.add(productInfo);
        });

        return productsList;
      }
    } catch (error) {
      print('Error fetching product information: $error');
    }

    // Return empty if product data is not found or an error occurs
    return [];
  }

  int _calculateTotalStock(Map<String, dynamic>? sizes) {
  if (sizes == null) return 0;

  int totalStock = 0;
  sizes.forEach((key, value) {
    if (value['hasQuantity'] && value['quantity'] != null) {
      totalStock += (value['quantity'] ?? 0) as int; // Casting to int
    }
  });
  return totalStock;
}


  List<DataRow> _buildDataRows(List<Map<String, dynamic>> products) {
    List<DataRow> dataRows = products.map((productInfo) {
      return DataRow(cells: [
        DataCell(Text(productInfo['productId'] ?? 'N/A', style: TextStyle(fontSize: 18))),
        DataCell(Text(productInfo['productName'] ?? 'N/A', style: TextStyle(fontSize: 18))),
        DataCell(Text(productInfo['category'] ?? 'N/A', style: TextStyle(fontSize: 18))),
        DataCell(Text('1000 ชิ้น', style: TextStyle(fontSize: 18))),
        DataCell(Text('${productInfo['totalStock'] ?? 'N/A'} ชิ้น', style: TextStyle(fontSize: 18))),
      ]);
    }).toList();

    return dataRows;
  }
}
