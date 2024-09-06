import 'package:flutter/material.dart';
import 'package:water_tracker_app/water_track.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _glassNoTEController =
      TextEditingController(text: '1');
  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Water Tracker "),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildWaterTrackerCounter(),
          const SizedBox(height: 24),
          Expanded(child: _buildWaterTrackListView())
        ],
      ),
    );
  }

  Widget _buildWaterTrackListView() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final WaterTrack waterTrack = waterTrackList[index];
        return _buildWaterTrackListTile(waterTrack, index);
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  Widget _buildWaterTrackListTile(WaterTrack waterTrack, int index) {
    return ListTile(
        title:
            Text('${waterTrack.datetime.hour}:${waterTrack.datetime.minute}'),
        subtitle: Text(
            '${waterTrack.datetime.day}/${waterTrack.datetime.month}/${waterTrack.datetime.year}'),
        leading: CircleAvatar(child: Text('${waterTrack.noOfGlass}')),
        trailing:
            IconButton(onPressed: () {
              _onTapDeleteButton(index);
            }, icon: const Icon(Icons.delete)),
      );
  }

  Widget _buildWaterTrackerCounter() {
    return Column(
      children: [
        Text(
          getTotalGlassCount().toString(),
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
        const Text(
          'Glass/s',
          style: TextStyle(fontSize: 16),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: 50,
                child: TextField(
                  controller: _glassNoTEController,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                )),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      _onTapAddWaterTrack();
                    },
                    child: const Text('Add')),
                TextButton(
                    onPressed: () {
                      _resetOnTap();
                    },
                    child: const Text('Clear All')),

              ],
            ),
          ],
        ),
      ],
    );
  }

  int getTotalGlassCount() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlass;
    }
    return counter;
  }

  void _onTapAddWaterTrack() {
    if (_glassNoTEController.text.isEmpty) {
      _glassNoTEController.text = '1';
    }
    final int noOfGlass = int.tryParse(_glassNoTEController.text) ?? 1;

    WaterTrack waterTrack =
        WaterTrack(noOfGlass: noOfGlass, datetime: DateTime.now());
    waterTrackList.add(waterTrack);

    setState(() {});
  }

  void _onTapDeleteButton(int index){
    waterTrackList.removeAt(index);
    setState(() {});
  }

  void _resetOnTap(){
    waterTrackList.clear();
    setState(() {

    });
  }
}

