import 'package:flutter/material.dart';


class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Order List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderListScreen(),
    );
  }
}

class OrderListScreen extends StatelessWidget {
  final List<Order> pastOrders = [
    Order(orderId: '#12345', status: 'Completed', type: 'Past Orders'),
    Order(orderId: '#67890', status: 'In Progress', type: 'Past Orders'),
  ];

  final List<Order> currentOrders = [
    Order(orderId: '#11223', status: 'In Development', type: 'Current Orders'),
    Order(orderId: '#44556', status: 'Completed', type: 'Current Orders'),
    Order(orderId: '#77889', status: 'Delivered', type: 'Current Orders'),
  ];

  OrderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchBox(),
              const SizedBox(height: 16),
              OrderSection(title: 'Past Orders', orders: pastOrders),
              const SizedBox(height: 16),
              OrderSection(title: 'Current Orders', orders: currentOrders),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search orders by date range',
        prefixIcon: Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}

class OrderSection extends StatelessWidget {
  final String title;
  final List<Order> orders;

  OrderSection({required this.title, required this.orders});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: orders
              .map((order) => OrderCard(order: order))
              .toList(),
        ),
      ],
    );
  }
}

class OrderCard extends StatelessWidget {
  final Order order;

  OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.image, size: 32), // Placeholder for image
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order ${order.orderId}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(order.status),
                ],
              ),
            ),
            Column(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Download', style: TextStyle(color: Colors.blue)),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Order {
  final String orderId;
  final String status;
  final String type;

  Order({required this.orderId, required this.status, required this.type});
}
