// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:async';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Event Calendar',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const CustomCalendar(),
//     );
//   }
// }

// class CustomCalendar extends StatefulWidget {
//   const CustomCalendar({super.key});

//   @override
//   _CustomCalendarState createState() => _CustomCalendarState();
// }

// class _CustomCalendarState extends State<CustomCalendar> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   Map<DateTime, List<String>> _events = {};
//   Map<String, String> _eventUrls = {};
//   late final StreamSubscription _eventStreamSubscription;
//   CalendarFormat _calendarFormat = CalendarFormat.month;

//   DateTime _normalizeDate(DateTime date) =>
//       DateTime.utc(date.year, date.month, date.day);

//   // Keep your existing _fetchEvents and _subscribeToEventStream methods

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final screenSize = mediaQuery.size;
//     final isPortrait = screenSize.height > screenSize.width;
//     final isTinyScreen = screenSize.shortestSide < 350; // 4-inch phones
//     final isTablet = screenSize.shortestSide >= 600; // 7-inch and above

//     // Precise scaling factors
//     final double scaleFactor =
//         isTinyScreen
//             ? 0.75
//             : isTablet
//             ? 1.25
//             : 1.0;
//     final double paddingFactor =
//         isTinyScreen
//             ? 0.8
//             : isTablet
//             ? 1.2
//             : 1.0;

//     // Responsive dimensions
//     final double titleFontSize = 28.0 * scaleFactor;
//     final double dayFontSize = 14.0 * scaleFactor;
//     final double headerFontSize = 18.0 * scaleFactor;
//     final double weekdayFontSize = 12.0 * scaleFactor;
//     final double eventFontSize = 16.0 * scaleFactor;
//     final double horizontalPadding = 16.0 * paddingFactor;
//     final double calendarHeight =
//         isPortrait
//             ? screenSize.height *
//                 (isTinyScreen
//                     ? 0.5
//                     : isTablet
//                     ? 0.55
//                     : 0.52)
//             : screenSize.height * 0.7;

//     return Scaffold(
//       appBar: AppBar(
//         title: SizedBox(
//           height:
//               isTinyScreen
//                   ? 24
//                   : isTablet
//                   ? 44
//                   : 32,
//           child: Image.asset("assets/images/BA_Logo.png", fit: BoxFit.contain),
//         ),
//         backgroundColor: const Color.fromARGB(255, 253, 253, 253),
//         centerTitle: false,
//       ),
//       body: SafeArea(
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             return SingleChildScrollView(
//               physics: const ClampingScrollPhysics(),
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height:
//                           isTinyScreen
//                               ? 8
//                               : isTablet
//                               ? 24
//                               : 16,
//                     ),
//                     Text(
//                       "Book your place now!",
//                       style: TextStyle(
//                         fontFamily: 'Alegreya',
//                         color: const Color.fromARGB(255, 146, 18, 8),
//                         fontSize: titleFontSize,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(
//                       height:
//                           isTinyScreen
//                               ? 8
//                               : isTablet
//                               ? 24
//                               : 16,
//                     ),
//                     Container(
//                       height: calendarHeight,
//                       constraints: BoxConstraints(
//                         minHeight: isTinyScreen ? 300 : 400,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                             color: Colors.black.withOpacity(0.1),
//                             blurRadius: 8,
//                             offset: const Offset(0, 4),
//                           ),
//                         ],
//                       ),
//                       child: TableCalendar(
//                         firstDay: DateTime.utc(2000, 1, 1),
//                         lastDay: DateTime.utc(2100, 12, 31),
//                         focusedDay: _focusedDay,
//                         calendarFormat: _calendarFormat,
//                         onFormatChanged: (format) {
//                           setState(() => _calendarFormat = format);
//                         },
//                         availableCalendarFormats: const {
//                           CalendarFormat.month: 'Month',
//                           CalendarFormat.week: 'Week',
//                         },
//                         daysOfWeekHeight: isTinyScreen ? 24 : 32,
//                         rowHeight:
//                             isTinyScreen
//                                 ? 36
//                                 : isTablet
//                                 ? 48
//                                 : 42,
//                         headerVisible: true,
//                         headerStyle: HeaderStyle(
//                           formatButtonVisible: !isTinyScreen,
//                           titleCentered: true,
//                           titleTextStyle: TextStyle(
//                             fontSize: headerFontSize,
//                             fontWeight: FontWeight.bold,
//                           ),
//                           leftChevronIcon: Icon(
//                             Icons.chevron_left,
//                             size: isTinyScreen ? 18 : 24,
//                           ),
//                           rightChevronIcon: Icon(
//                             Icons.chevron_right,
//                             size: isTinyScreen ? 18 : 24,
//                           ),
//                           formatButtonShowsNext: false,
//                           formatButtonDecoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           formatButtonTextStyle: TextStyle(
//                             fontSize: weekdayFontSize,
//                             color: Colors.black,
//                           ),
//                         ),
//                         calendarStyle: CalendarStyle(
//                           isTodayHighlighted: true,
//                           selectedDecoration: const BoxDecoration(
//                             color: Colors.black,
//                             shape: BoxShape.circle,
//                           ),
//                           todayDecoration: BoxDecoration(
//                             color: Colors.red.shade400,
//                             shape: BoxShape.circle,
//                           ),
//                           markerDecoration: BoxDecoration(
//                             color: Colors.red.shade400,
//                             shape: BoxShape.circle,
//                           ),
//                           markerMargin: EdgeInsets.only(
//                             top: isTinyScreen ? 2 : 4,
//                             bottom: 1,
//                           ),
//                           outsideDaysVisible: false,
//                           cellMargin: EdgeInsets.zero,
//                           cellPadding: EdgeInsets.all(isTinyScreen ? 0 : 2),
//                           defaultTextStyle: TextStyle(fontSize: dayFontSize),
//                           weekendTextStyle: TextStyle(fontSize: dayFontSize),
//                         ),
//                         daysOfWeekStyle: DaysOfWeekStyle(
//                           weekdayStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: weekdayFontSize,
//                           ),
//                           weekendStyle: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: weekdayFontSize,
//                           ),
//                         ),
//                         selectedDayPredicate:
//                             (day) => isSameDay(_selectedDay, day),
//                         onDaySelected: (selectedDay, focusedDay) {
//                           setState(() {
//                             _selectedDay = selectedDay;
//                             _focusedDay = focusedDay;
//                           });
//                         },
//                         eventLoader:
//                             (day) => _events[_normalizeDate(day)] ?? [],
//                       ),
//                     ),
//                     if (_selectedDay != null) ...[
//                       SizedBox(
//                         height:
//                             isTinyScreen
//                                 ? 12
//                                 : isTablet
//                                 ? 24
//                                 : 16,
//                       ),
//                       Text(
//                         'Events on ${_selectedDay!.day}/${_selectedDay!.month}/${_selectedDay!.year}',
//                         style: TextStyle(
//                           fontSize:
//                               isTinyScreen
//                                   ? 14
//                                   : isTablet
//                                   ? 20
//                                   : 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height:
//                             isTinyScreen
//                                 ? 8
//                                 : isTablet
//                                 ? 16
//                                 : 12,
//                       ),
//                       ...(_events[_normalizeDate(_selectedDay!)] ?? []).map(
//                         (eventTitle) => Card(
//                           margin: EdgeInsets.only(
//                             bottom:
//                                 isTinyScreen
//                                     ? 8
//                                     : isTablet
//                                     ? 16
//                                     : 12,
//                           ),
//                           child: ListTile(
//                             contentPadding: EdgeInsets.symmetric(
//                               horizontal:
//                                   isTinyScreen
//                                       ? 12
//                                       : isTablet
//                                       ? 24
//                                       : 16,
//                               vertical:
//                                   isTinyScreen
//                                       ? 8
//                                       : isTablet
//                                       ? 16
//                                       : 12,
//                             ),
//                             title: Text(
//                               eventTitle,
//                               style: TextStyle(fontSize: eventFontSize),
//                             ),
//                             leading: Icon(
//                               Icons.event,
//                               size:
//                                   isTinyScreen
//                                       ? 18
//                                       : isTablet
//                                       ? 28
//                                       : 24,
//                               color: Colors.red,
//                             ),
//                             onTap:
//                                 () => Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder:
//                                         (context) => EventDetailPage(
//                                           eventTitle: eventTitle,
//                                           eventUrl:
//                                               _eventUrls[eventTitle] ??
//                                               'https://example.com',
//                                         ),
//                                   ),
//                                 ),
//                           ),
//                         ),
//                       ),
//                     ],
//                     SizedBox(
//                       height:
//                           isTinyScreen
//                               ? 12
//                               : isTablet
//                               ? 24
//                               : 16,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// class EventDetailPage extends StatefulWidget {
//   final String eventTitle;
//   final String eventUrl;

//   const EventDetailPage({
//     super.key,
//     required this.eventTitle,
//     required this.eventUrl,
//   });

//   @override
//   _EventDetailPageState createState() => _EventDetailPageState();
// }

// class _EventDetailPageState extends State<EventDetailPage> {
//   Future<void> _launchEventUrl() async {
//     try {
//       final parsedUrl = Uri.parse(widget.eventUrl);
//       if (!await launchUrl(parsedUrl, mode: LaunchMode.externalApplication)) {
//         _showLaunchError('Could not launch ${parsedUrl.toString()}');
//       }
//     } catch (e) {
//       _showLaunchError(e.toString());
//     }
//   }

//   void _showLaunchError(String error) {
//     if (mounted) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to open URL: $error'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//     print('URL Launch Error: $error');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final mediaQuery = MediaQuery.of(context);
//     final isTinyScreen = mediaQuery.size.shortestSide < 350;
//     final isTablet = mediaQuery.size.shortestSide >= 600;

//     final double scaleFactor =
//         isTinyScreen
//             ? 0.8
//             : isTablet
//             ? 1.2
//             : 1.0;
//     final double paddingFactor =
//         isTinyScreen
//             ? 0.8
//             : isTablet
//             ? 1.2
//             : 1.0;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           widget.eventTitle,
//           style: TextStyle(fontSize: 20.0 * scaleFactor),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//         backgroundColor: const Color.fromARGB(255, 253, 253, 253),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(16.0 * paddingFactor),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Event Details',
//                 style: TextStyle(
//                   fontFamily: 'Alegreya',
//                   color: Colors.red.shade700,
//                   fontSize: 28.0 * scaleFactor,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16.0 * paddingFactor),
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0 * paddingFactor),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         widget.eventTitle,
//                         style: TextStyle(
//                           fontSize: 24.0 * scaleFactor,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(height: 8.0 * paddingFactor),
//                       Text(
//                         'Website:',
//                         style: TextStyle(
//                           fontSize: 16.0 * scaleFactor,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                       SizedBox(height: 4.0 * paddingFactor),
//                       Text(
//                         Uri.parse(widget.eventUrl).host,
//                         style: TextStyle(
//                           fontSize: 18.0 * scaleFactor,
//                           color: Colors.blue.shade700,
//                           decoration: TextDecoration.underline,
//                         ),
//                       ),
//                       SizedBox(height: 24.0 * paddingFactor),
//                       SizedBox(
//                         width: double.infinity,
//                         child: ElevatedButton(
//                           onPressed: _launchEventUrl,
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             foregroundColor: Colors.white,
//                             padding: EdgeInsets.symmetric(
//                               vertical: 16.0 * scaleFactor,
//                             ),
//                             textStyle: TextStyle(
//                               fontSize: 18.0 * scaleFactor,
//                               fontWeight: FontWeight.bold,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                           ),
//                           child: const Text('VISIT EVENT WEBSITE'),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16.0 * paddingFactor),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};
  Map<String, String> _eventUrls = {};
  late final StreamSubscription _eventStreamSubscription;

  DateTime _normalizeDate(DateTime date) =>
      DateTime.utc(date.year, date.month, date.day);

  Future<void> _fetchEvents() async {
    try {
      final response = await Supabase.instance.client
          .from('events')
          .select('date, title, url');
      final data = response as List<dynamic>;
      final Map<DateTime, List<String>> fetchedEvents = {};
      final Map<String, String> fetchedUrls = {};

      for (var row in data) {
        final date = DateTime.parse(row['date'] as String);
        final title = row['title'] as String;
        final url = row['url'] as String? ?? 'https://example.com';
        final normalizedDate = _normalizeDate(date);

        fetchedEvents.update(
          normalizedDate,
          (list) => list..add(title),
          ifAbsent: () => [title],
        );
        fetchedUrls[title] = url;
      }

      setState(() {
        _events = fetchedEvents;
        _eventUrls = fetchedUrls;
      });
    } catch (e) {
      print('Error fetching events: $e');
    }
  }

  void _subscribeToEventStream() {
    _eventStreamSubscription = Supabase.instance.client
        .from('events')
        .stream(primaryKey: ['id'])
        .listen((payload) {
          final List<Map<String, dynamic>> data = payload;
          final Map<DateTime, List<String>> updatedEvents = {};
          final Map<String, String> updatedUrls = {};

          for (var row in data) {
            final date = DateTime.parse(row['date'] as String);
            final title = row['title'] as String;
            final url = row['url'] as String? ?? 'https://example.com';
            final normalizedDate = _normalizeDate(date);

            updatedEvents.update(
              normalizedDate,
              (list) => list..add(title),
              ifAbsent: () => [title],
            );
            updatedUrls[title] = url;
          }

          setState(() {
            _events = updatedEvents;
            _eventUrls = updatedUrls;
          });
        });
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents();
    _subscribeToEventStream();
  }

  @override
  void dispose() {
    _eventStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("assets/images/BA_Logo.png"),
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Book your place now!",
                style: TextStyle(
                  fontFamily: 'Alegreya',
                  color: Color.fromARGB(255, 146, 18, 8),
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 10.0),
              TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                eventLoader: (day) => _events[_normalizeDate(day)] ?? [],
                calendarStyle: CalendarStyle(
                  isTodayHighlighted: true,
                  selectedDecoration: const BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.red.shade400,
                    shape: BoxShape.circle,
                  ),
                  markerDecoration: BoxDecoration(
                    color: Colors.red.shade400,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  outsideDaysVisible: false,
                ),
                daysOfWeekStyle: const DaysOfWeekStyle(
                  weekdayStyle: TextStyle(fontWeight: FontWeight.bold),
                  weekendStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (_selectedDay != null)
                ...(_events[_normalizeDate(_selectedDay!)] ?? []).map(
                  (eventTitle) => ListTile(
                    title: Text(eventTitle),
                    leading: const Icon(Icons.event, color: Colors.red),
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => EventDetailPage(
                                  eventTitle: eventTitle,
                                  eventUrl:
                                      _eventUrls[eventTitle] ??
                                      'https://example.com',
                                ),
                          ),
                        ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class EventDetailPage extends StatefulWidget {
  final String eventTitle;
  final String eventUrl;

  const EventDetailPage({
    super.key,
    required this.eventTitle,
    required this.eventUrl,
  });

  @override
  _EventDetailPageState createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  Future<void> _launchEventUrl() async {
    try {
      final parsedUrl = Uri.parse(widget.eventUrl);

      if (!await launchUrl(parsedUrl, mode: LaunchMode.externalApplication)) {
        _showLaunchError('Could not launch ${parsedUrl.toString()}');
      }
    } catch (e) {
      _showLaunchError(e.toString());
    }
  }

  void _showLaunchError(String error) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to open URL: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
    print('URL Launch Error: $error');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.eventTitle),
        backgroundColor: const Color.fromARGB(255, 253, 253, 253),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Event Details',
              style: TextStyle(
                fontFamily: 'Alegreya',
                color: Colors.red.shade700,
                fontSize: 32,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.eventTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'URL: ${Uri.parse(widget.eventUrl).host}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _launchEventUrl,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 15,
                ),
              ),
              child: const Text('VISIT EVENT WEBSITE'),
            ),
          ],
        ),
      ),
    );
  }
}
