import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({Key? key}) : super(key: key);

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final DateFormat _dayOfWeekFormat = DateFormat('E');
  final DateFormat _dayOfMonthFormat = DateFormat('d');

  DateTime selectedDay = DateTime.now(); // Variable para almacenar el día seleccionado

  Map<DateTime, String> events = {
    DateTime(DateTime.now().year, 5, 29): 'Evento del 29 de mayo', // Evento programado para el 29 de mayo
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text('Eventos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Acción al presionar el botón de add
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              DateFormat('MMMM').format(DateTime.now()),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  children: List.generate(7, (index) {
                    final DateTime now = DateTime.now();
                    final DateTime day = DateTime(now.year, now.month, index + 1);
                    return Container(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _dayOfWeekFormat.format(day),
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                ),
                itemCount: getDaysInMonth(DateTime.now()),
                itemBuilder: (BuildContext context, int index) {
                  final DateTime now = DateTime.now();
                  final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1);
                  final int daysBeforeMonth = firstDayOfMonth.weekday;
                  final int dayOfMonth = index + 1 - daysBeforeMonth;
                  final DateTime day = DateTime(now.year, now.month, dayOfMonth);
                  final bool isToday = now.day == day.day && now.month == day.month;
                  final bool isSelectedDay = selectedDay.day == day.day && selectedDay.month == day.month;

                  return GestureDetector(
                    onTap: () {
                      // Acción al pulsar en un día
                      setState(() {
                        if (isSelectedDay) {
                          selectedDay = DateTime(0); // Reiniciar el día seleccionado
                        } else {
                          selectedDay = day; // Almacenar el nuevo día seleccionado
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isToday ? Colors.blue : null,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          dayOfMonth > 0 && dayOfMonth <= getDaysInMonth(now)
                              ? _dayOfMonthFormat.format(day)
                              : '',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: isToday ? FontWeight.bold : null,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Visibility(
              visible: selectedDay != DateTime(0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  events[selectedDay] ?? 'No hay eventos programados para este día',
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int getDaysInMonth(DateTime dateTime) {
    final DateTime firstDayNextMonth = DateTime(dateTime.year, dateTime.month + 1, 1);
    final DateTime lastDayOfMonth = firstDayNextMonth.subtract(const Duration(days: 1));
    return lastDayOfMonth.day;
  }
}

void main() {
  runApp(const MaterialApp(
    home: EventsPage(),
  ));
}
