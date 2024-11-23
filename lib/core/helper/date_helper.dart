import 'package:intl/intl.dart';

String formatDateHelper(DateTime dueDate) {
return 'Due Date: ${DateFormat('EEE. dd/MM/yyyy hh:mm a').format(dueDate)}';
}