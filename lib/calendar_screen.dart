import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime _normalizeDate(DateTime date) => DateTime(date.year, date.month, date.day);

  final Map<DateTime, List<Map<String, dynamic>>> _events = {};

  final _eventTypes = {
    'Session': Colors.blue,
    'Reminder': Colors.orange,
    'Assignment': Colors.green,
  };

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

  }

  void _addOrEditEvent({Map<String, dynamic>? existingEvent, int? index}) {
    final titleController = TextEditingController(
      text: existingEvent != null ? existingEvent['title'] : '',
    );
    String selectedType = existingEvent != null ? existingEvent['type'] : 'Session';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(existingEvent == null ? 'Add Event' : 'Edit Event'),
        content: StatefulBuilder(
          builder: (context, setModalState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Event Title'),
                ),
                const SizedBox(height: 10),
                DropdownButton<String>(
                  value: selectedType,
                  isExpanded: true,
                  items: _eventTypes.keys
                      .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setModalState(() {
                        selectedType = value;
                      });
                    }
                  },
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (titleController.text.isEmpty) return;

              final event = {
                'title': titleController.text,
                'type': selectedType,
              };

              setState(() {
                final normalizedDay = _normalizeDate(_selectedDay!);
                final eventsForDay = _events[normalizedDay] ?? [];
                if (existingEvent != null && index != null) {
                  eventsForDay[index] = event;
                } else {
                  eventsForDay.add(event);
                }
                _events[normalizedDay] = eventsForDay;
              });

              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _deleteEvent(int index) {
    setState(() {
      final normalizedDay = _normalizeDate(_selectedDay!);
      _events[normalizedDay]!.removeAt(index);
      if (_events[normalizedDay]!.isEmpty) {
        _events.remove(normalizedDay);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final selectedEvents = _events[_normalizeDate(_selectedDay!)] ?? [];


    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.blueAccent,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addOrEditEvent(),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TableCalendar(
              firstDay: DateTime.utc(2000, 1, 1),
              lastDay: DateTime.utc(2100, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });
              },
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_selectedDay != null)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Events on ${_selectedDay!.toLocal()}'.split(' ')[0],
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: selectedEvents.length,
                itemBuilder: (context, index) {
                  final event = selectedEvents[index];
                  final color = _eventTypes[event['type']] ?? Colors.grey;

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(backgroundColor: color),
                      title: Text(event['title']),
                      subtitle: Text(event['type']),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _deleteEvent(index),
                      ),
                      onTap: () => _addOrEditEvent(
                        existingEvent: event,
                        index: index,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
