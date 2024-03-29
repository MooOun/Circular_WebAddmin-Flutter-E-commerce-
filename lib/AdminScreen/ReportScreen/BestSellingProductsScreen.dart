// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BestSellingProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('รายงานข้อมูลสินค้าขายดี'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Products').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.purple.shade500,
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Store information
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
              // Product information table
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('รหัสสินค้า', style: TextStyle(fontSize: 18))),
                    DataColumn(label: Text('ชื่อสินค้า', style: TextStyle(fontSize: 18))),
                    DataColumn(label: Text('หมวดหมู่หลัก', style: TextStyle(fontSize: 18))),
                    DataColumn(label: Text('ราคาสินค้า', style: TextStyle(fontSize: 18))),
                    DataColumn(label: Text('จำนวนชิ้นที่ขาย', style: TextStyle(fontSize: 18))),
                  ],
                  rows: _buildDataRows(snapshot.data!.docs),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<DataRow> _buildDataRows(List<QueryDocumentSnapshot<Object?>> docs) {
    return docs
        .where((doc) =>
            (doc.data() as Map<String, dynamic>)['soldCount'] != null &&
            (doc.data() as Map<String, dynamic>)['soldCount'] > 100)
        .map((doc) {
      var productData = doc.data() as Map<String, dynamic>;

      return DataRow(cells: [
        DataCell(Text(productData['productId'] ?? 'N/A', style: TextStyle(fontSize: 18))),
        DataCell(Text(productData['productName'] ?? 'N/A', style: TextStyle(fontSize: 18))),
        DataCell(Text(productData['category'] ?? 'N/A', style: TextStyle(fontSize: 18))),
        DataCell(Text('${productData['price'] ?? 'N/A'} บาท', style: TextStyle(fontSize: 18))),
        DataCell(Text('${productData['soldCount'] ?? 'N/A'} ชิ้น', style: TextStyle(fontSize: 18))),
      ]);
    }).toList();
  }
}
