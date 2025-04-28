import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pdfx/pdfx.dart';

class PDFViewerPage extends StatefulWidget {
  final String pdfUrl;

  const PDFViewerPage({super.key, required this.pdfUrl});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  PdfController? _pdfController;
  bool _loading = true;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  // Method to fetch the PDF data from the URL and load it into PdfController
  Future<void> _loadPdf() async {
    try {
      // Fetch the PDF file as bytes from the URL
      final response = await http.get(Uri.parse(widget.pdfUrl));

      if (response.statusCode == 200) {
        // Load the PDF document into PdfController using the byte data
        _pdfController = PdfController(
          document: PdfDocument.openData(response.bodyBytes),
        );
        setState(() {
          _loading = false;
          _currentPage = 1; // Start from the first page
        });
      } else {
        throw Exception('Failed to load PDF');
      }
    } catch (e) {
      setState(() {
        _loading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error loading PDF: $e")),
      );
    }
  }

  @override
  void dispose() {
    _pdfController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("PDF Viewer")),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: _pdfController == null
                      ? const Center(child: Text('No PDF available'))
                      : PdfView(
                          controller: _pdfController!,
                          scrollDirection: Axis.vertical,
                          onPageChanged: (page) {
                            setState(() {
                              _currentPage = page;
                            });
                          },
                        ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: _currentPage > 1
                          ? () {
                              _pdfController?.jumpToPage(_currentPage - 1);
                            }
                          : null, // Disable if on the first page
                    ),
                    Text('Page $_currentPage'),
                    IconButton(
                      icon: const Icon(Icons.arrow_forward),
                      onPressed:
                          (_pdfController?.pagesCount ?? 0) > _currentPage
                              ? () {
                                  _pdfController?.jumpToPage(_currentPage + 1);
                                }
                              : null, // Disable if on the last page
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
