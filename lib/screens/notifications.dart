import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum NotificationType {
  All,
  Type1,
  Type2,
  Type3,
}

class NotisPage extends StatefulWidget {
  const NotisPage({Key? key}) : super(key: key);

  @override
  _NotisPageState createState() => _NotisPageState();
}

class _NotisPageState extends State<NotisPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<NotificationType> _selectedTypes = [NotificationType.All];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: () {
              _showFilterMenu();
            },
            icon: Icon(Icons.filter_list),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          final DateTime now = DateTime.now();
          final DateTime notificationTime = now.subtract(Duration(minutes: index + 1));
          final String timeAgo = getTimeAgo(notificationTime);

          return _buildNotificationItem(index, timeAgo);
        },
      ),
    );
  }

  Widget _buildNotificationItem(int index, String timeAgo) {
    final bool showNotification = _shouldShowNotification(index);

    if (!showNotification) {
      return Container();
    }

    return Container(
      color: Colors.black,
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage('assets/myke.png'),
          ),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Título de la notificación $index',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  timeAgo,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Lógica para manejar el evento al hacer clic en el botón "Ver"
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.white,
              onPrimary: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            child: const Text(
              'Ver',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationTypeIndicator(int typeIndex) {
    final Color indicatorColor = _getNotificationTypeColor(typeIndex);

    return Container(
      width: 16.0,
      height: 16.0,
      decoration: BoxDecoration(
        color: indicatorColor,
        shape: BoxShape.circle,
      ),
    );
  }

  Color _getNotificationTypeColor(int typeIndex) {
    switch (typeIndex) {
      case 1:
        return Colors.green;
      case 2:
        return Colors.yellow;
      case 3:
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }

  String getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} s';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} h';
    } else {
      return DateFormat('dd/MM/yyyy').format(time);
    }
  }

  void _showFilterMenu() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  _buildFilterMenuItem('Todos', NotificationType.All, setState),
                  _buildFilterMenuItem('Tipo 1', NotificationType.Type1, setState),
                  _buildFilterMenuItem('Tipo 2', NotificationType.Type2, setState),
                  _buildFilterMenuItem('Tipo 3', NotificationType.Type3, setState),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _applyNotificationFilter();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                    child: const Text(
                      'Aceptar',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFilterMenuItem(String title, NotificationType type, StateSetter setState) {
    final bool isSelected = _selectedTypes.contains(type);

    return ListTile(
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
      trailing: Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? Colors.black : Colors.grey,
            width: 2.0,
          ),
        ),
        child: isSelected
            ? Icon(
                Icons.check,
                size: 16.0,
                color: Colors.black,
              )
            : null,
      ),
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedTypes.remove(type);
          } else {
            _selectedTypes.add(type);
          }
        });
      },
    );
  }

  bool _shouldShowNotification(int index) {
    if (_selectedTypes.contains(NotificationType.All)) {
      return true;
    } else {
      final NotificationType type = NotificationType.values[(index % 3) + 1];
      return _selectedTypes.contains(type);
    }
  }

  void _applyNotificationFilter() {
    setState(() {
      // Aplicar el filtro y volver a cargar las notificaciones
    });
  }
}
