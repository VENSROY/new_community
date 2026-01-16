import 'package:flutter/material.dart';

class RequestsTab extends StatelessWidget {
  const RequestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("My Requests", style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: const TabBar(
            labelColor: Color(0xFF7B0F1C),
            unselectedLabelColor: Colors.grey,
            indicatorColor: Color(0xFF7B0F1C),
            tabs: [Tab(text: "Received"), Tab(text: "Sent")],
          ),
        ),
        body: TabBarView(
          children: [_requestList(true), _requestList(false)],
        ),
      ),
    );
  }

  Widget _requestList(bool isReceived) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: 4,
      itemBuilder: (context, index) => _requestCard(isReceived),
    );
  }

  Widget _requestCard(bool isReceived) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          const CircleAvatar(radius: 35, child: Text('R')),
          const SizedBox(height: 5),
          const Text('Rohan Mehra', style: TextStyle(fontWeight: FontWeight.bold)),
          const Text('Relation: Brother', style: TextStyle(color: Colors.grey, fontSize: 11)),
          const Text('12 mutual connections', style: TextStyle(color: Colors.grey, fontSize: 10)),
          const Spacer(),
          if (isReceived)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFFFD54F), foregroundColor: Colors.black),
                  child: const Text('Confirm'),
                ),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                child: const Text('Edit', style: TextStyle(color: Color(0xFF7B0F1C))),
              ),
            ),
          ),
        ],
      ),
    );
  }
}