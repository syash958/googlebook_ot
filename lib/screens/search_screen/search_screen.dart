import 'package:flutter/material.dart';
import 'package:ozone_soft_task/models/book_search_model.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}
//flutter build apk --split-per-abi
TextEditingController _searchController = TextEditingController();

class _SearchScreenState extends State<SearchScreen> {
  BookSearchModel? booksrch;
  Future getProductsByQuery(var queryParameters) async {
    String baseUrl = "www.googleapis.com";
    String path = "/books/v1/volumes";
    var response = await http.get(Uri.https(baseUrl, path, queryParameters));
    print(response.statusCode);
    print(response.body);
    switch (response.statusCode) {
      case 200:
        booksrch = bookSearchModelFromJson(response.body);
        return booksrch;
      default:
        throw Exception('Failed to load products');
    }
  }

  @override
  void initState() {
    super.initState();
    getProductsByQuery({'q': 'intitle:Java'});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Search Online"),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {},
              child:
                  const Text("Cancel", style: TextStyle(color: Colors.white)))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(width: 1, color: Colors.grey),
                    ),
                    label: Text("Enter Title To Search")
                  ),
                  onChanged: (searchedText) {
                    String title = _searchController.text;
                    if (title.isNotEmpty) {
                      setState(() {
                        getProductsByQuery({'q': 'intitle:$title'});
                      });
                    }
                  },
                ),
              ),
            ),
            FutureBuilder(
              builder: (context, snapshot) {
                if (booksrch != null) {
                  return ListView.builder(
                    primary: false,
                    itemCount: booksrch!.items.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, index) {
                      Item itemModel = (booksrch!.items.elementAt(index));
                      VolumeInfo volInfo = itemModel.volumeInfo;
                      return Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.network(
                                volInfo.imageLinks.smallThumbnail,
                                scale: 1.5,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.7,
                                    child: Text(
                                      "Title: " + volInfo.title,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    )),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: Text(
                                    "Author: " + volInfo.authors.first,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  child: Text(
                                    "Publisher: " + volInfo.publisher,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
