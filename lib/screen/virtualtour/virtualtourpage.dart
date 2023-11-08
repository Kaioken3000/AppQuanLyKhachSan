import 'package:flutter/material.dart';
import 'package:khachsanb1910261/modal/virtualtour_modal.dart';
import 'package:panorama/panorama.dart';

import '../../service/virtualtour_service.dart';

class VirtualtourPage extends StatelessWidget {
  const VirtualtourPage({super.key, required this.phongid});

  final int phongid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff006df1),
        title: const Text("Xem virtual tour"),
      ),
      body: FutureBuilder<Virtualtour>(
        future: getVirtualtourByPhongId(phongid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('An error has occurred!'),
            );
          } else if (snapshot.hasData) {
            return Center(
              child: Panorama(
                child: Image.asset('assets/${snapshot.data!.hinh!.toString()}'),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
