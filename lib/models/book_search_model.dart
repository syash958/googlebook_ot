import 'dart:convert';

BookSearchModel bookSearchModelFromJson(String str) =>
    BookSearchModel.fromJson(json.decode(str));

String bookSearchModelToJson(BookSearchModel data) =>
    json.encode(data.toJson());

class BookSearchModel {
  BookSearchModel({
    required this.totalItems,
    required this.items,
  });

  final int totalItems;
  final List<Item> items;

  factory BookSearchModel.fromJson(Map<String, dynamic> json) =>
      BookSearchModel(
        totalItems: json["totalItems"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalItems": totalItems,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

class Item {
  Item({
    required this.id,
    required this.etag,
    required this.selfLink,
    required this.volumeInfo,
    // required this.saleInfo,
    // required this.accessInfo,
    // required this.searchInfo,
  });
  final String id;
  final String etag;
  final String selfLink;
  final VolumeInfo volumeInfo;
  // final SaleInfo saleInfo;
  // final AccessInfo accessInfo;
  // final SearchInfo searchInfo;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        etag: json["etag"],
        selfLink: json["selfLink"],
        volumeInfo: VolumeInfo.fromJson(json["volumeInfo"]),
        // saleInfo: SaleInfo.fromJson(json["saleInfo"]),
        // accessInfo: AccessInfo.fromJson(json["accessInfo"]),
        // searchInfo: SearchInfo.fromJson(json["searchInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "etag": etag,
        "selfLink": selfLink,
        "volumeInfo": volumeInfo.toJson(),
        // "saleInfo": saleInfo.toJson(),
        // "accessInfo": accessInfo.toJson(),
        // "searchInfo": searchInfo == null ? null : searchInfo.toJson(),
      };
}

class AccessInfo {
  AccessInfo({
    required this.country,
    required this.viewability,
    required this.embeddable,
    required this.publicDomain,
    required this.textToSpeechPermission,
    required this.epub,
    required this.pdf,
    required this.webReaderLink,
    required this.accessViewStatus,
    required this.quoteSharingAllowed,
  });

  final Country country;
  final Viewability viewability;
  final bool embeddable;
  final bool publicDomain;
  final TextToSpeechPermission textToSpeechPermission;
  final Epub epub;
  final Epub pdf;
  final String webReaderLink;
  final AccessViewStatus accessViewStatus;
  final bool quoteSharingAllowed;

  factory AccessInfo.fromJson(Map<String, dynamic> json) => AccessInfo(
        country: countryValues.map[json["country"]] as Country,
        viewability: viewabilityValues.map[json["viewability"]] as Viewability,
        embeddable: json["embeddable"],
        publicDomain: json["publicDomain"],
        textToSpeechPermission: textToSpeechPermissionValues
            .map[json["textToSpeechPermission"]] as TextToSpeechPermission,
        epub: Epub.fromJson(json["epub"]),
        pdf: Epub.fromJson(json["pdf"]),
        webReaderLink: json["webReaderLink"],
        accessViewStatus: accessViewStatusValues.map[json["accessViewStatus"]]
            as AccessViewStatus,
        quoteSharingAllowed: json["quoteSharingAllowed"],
      );

  Map<String, dynamic> toJson() => {
        "country": countryValues.reverse[country],
        "viewability": viewabilityValues.reverse[viewability],
        "embeddable": embeddable,
        "publicDomain": publicDomain,
        "textToSpeechPermission":
            textToSpeechPermissionValues.reverse[textToSpeechPermission],
        "epub": epub.toJson(),
        "pdf": pdf.toJson(),
        "webReaderLink": webReaderLink,
        "accessViewStatus": accessViewStatusValues.reverse[accessViewStatus],
        "quoteSharingAllowed": quoteSharingAllowed,
      };
}

enum AccessViewStatus { NONE, SAMPLE }

final accessViewStatusValues = EnumValues(
    {"NONE": AccessViewStatus.NONE, "SAMPLE": AccessViewStatus.SAMPLE});

enum Country { IN }

final countryValues = EnumValues({"IN": Country.IN});

class Epub {
  Epub({
    required this.isAvailable,
    required this.acsTokenLink,
  });

  final bool isAvailable;
  final String acsTokenLink;

  factory Epub.fromJson(Map<String, dynamic> json) => Epub(
        isAvailable: json["isAvailable"],
        acsTokenLink:
            json["acsTokenLink"] == null ? null : json["acsTokenLink"],
      );

  Map<String, dynamic> toJson() => {
        "isAvailable": isAvailable,
        "acsTokenLink": acsTokenLink == null ? null : acsTokenLink,
      };
}

enum TextToSpeechPermission { ALLOWED, ALLOWED_FOR_ACCESSIBILITY }

final textToSpeechPermissionValues = EnumValues({
  "ALLOWED": TextToSpeechPermission.ALLOWED,
  "ALLOWED_FOR_ACCESSIBILITY": TextToSpeechPermission.ALLOWED_FOR_ACCESSIBILITY
});

enum Viewability { NO_PAGES, PARTIAL }

final viewabilityValues = EnumValues(
    {"NO_PAGES": Viewability.NO_PAGES, "PARTIAL": Viewability.PARTIAL});

enum Kind { BOOKS_VOLUME }

final kindValues = EnumValues({"books#volume": Kind.BOOKS_VOLUME});

class SaleInfo {
  SaleInfo({
    // required this.country,
    // required this.saleability,
    required this.isEbook,
    required this.listPrice,
    required this.retailPrice,
    required this.buyLink,
    required this.offers,
  });

  // final Country country;
  // final Saleability saleability;
  final bool isEbook;
  final SaleInfoListPrice listPrice;
  final SaleInfoListPrice retailPrice;
  final String buyLink;
  final List<Offer> offers;

  factory SaleInfo.fromJson(Map<String, dynamic> json) => SaleInfo(
        // country: countryValues.map[json["country"]] as Country,
        // saleability: saleabilityValues.map[json["saleability"]] as Saleability,
        isEbook: json["isEbook"],
        listPrice: json["listPrice"] == null
            ? null
            : SaleInfoListPrice.fromJson(json["listPrice"]) as dynamic,
        retailPrice: json["retailPrice"] == null
            ? null
            : SaleInfoListPrice.fromJson(json["retailPrice"]) as dynamic,
        buyLink: json["buyLink"] == null ? null : json["buyLink"],
        offers: json["offers"] == null
            ? null
            : List<Offer>.from(json["offers"].map((x) => Offer.fromJson(x)))
                as dynamic,
      );

  Map<String, dynamic> toJson() => {
        // "country": countryValues.reverse[country],
        // "saleability": saleabilityValues.reverse[saleability],
        "isEbook": isEbook,
        "listPrice": listPrice == null ? null : listPrice.toJson(),
        "retailPrice": retailPrice == null ? null : retailPrice.toJson(),
        "buyLink": buyLink == null ? null : buyLink,
        "offers": offers == null
            ? null
            : List<dynamic>.from(offers.map((x) => x.toJson())),
      };
}

class SaleInfoListPrice {
  SaleInfoListPrice({
    required this.amount,
    required this.currencyCode,
  });

  final double amount;
  final String currencyCode;

  factory SaleInfoListPrice.fromJson(Map<String, dynamic> json) =>
      SaleInfoListPrice(
        amount: json["amount"].toDouble(),
        currencyCode: json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "currencyCode": currencyCode,
      };
}

class Offer {
  Offer({
    required this.finskyOfferType,
    required this.listPrice,
    required this.retailPrice,
  });

  final int finskyOfferType;
  final OfferListPrice listPrice;
  final OfferListPrice retailPrice;

  factory Offer.fromJson(Map<String, dynamic> json) => Offer(
        finskyOfferType: json["finskyOfferType"],
        listPrice: OfferListPrice.fromJson(json["listPrice"]),
        retailPrice: OfferListPrice.fromJson(json["retailPrice"]),
      );

  Map<String, dynamic> toJson() => {
        "finskyOfferType": finskyOfferType,
        "listPrice": listPrice.toJson(),
        "retailPrice": retailPrice.toJson(),
      };
}

class OfferListPrice {
  OfferListPrice({
    required this.amountInMicros,
    required this.currencyCode,
  });

  final int amountInMicros;
  final String currencyCode;

  factory OfferListPrice.fromJson(Map<String, dynamic> json) => OfferListPrice(
        amountInMicros: json["amountInMicros"],
        currencyCode: json["currencyCode"],
      );

  Map<String, dynamic> toJson() => {
        "amountInMicros": amountInMicros,
        "currencyCode": currencyCode,
      };
}

enum Saleability { NOT_FOR_SALE, FOR_SALE }

final saleabilityValues = EnumValues({
  "FOR_SALE": Saleability.FOR_SALE,
  "NOT_FOR_SALE": Saleability.NOT_FOR_SALE
});

class SearchInfo {
  SearchInfo({
    required this.textSnippet,
  });

  final String textSnippet;

  factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
        textSnippet: json["textSnippet"],
      );

  Map<String, dynamic> toJson() => {
        "textSnippet": textSnippet,
      };
}

class VolumeInfo {
  VolumeInfo({
    required this.title,
    required this.authors,
    required this.publisher,
    required this.publishedDate,
    required this.description,
    // required this.industryIdentifiers,
    // required this.readingModes,
    required this.pageCount,
    // required this.printType,
    // required this.categories,
    required this.averageRating,
    required this.ratingsCount,
    // required this.maturityRating,
    required this.allowAnonLogging,
    required this.contentVersion,
    required this.panelizationSummary,
    required this.imageLinks,
    // required this.language,
    required this.previewLink,
    required this.infoLink,
    required this.canonicalVolumeLink,
    required this.subtitle,
  });

  final String title;
  final List<String> authors;
  final String publisher;
  final String publishedDate;
  final String description;
  // final List<IndustryIdentifier> industryIdentifiers;
  // final ReadingModes readingModes;
  final int pageCount;
  // final PrintType printType;
  // final List<Category> categories;
  final double averageRating;
  final int ratingsCount;
  // final MaturityRating maturityRating;
  final bool allowAnonLogging;
  final String contentVersion;
  final PanelizationSummary panelizationSummary;
  final ImageLinks imageLinks;
  // final Language language;
  final String previewLink;
  final String infoLink;
  final String canonicalVolumeLink;
  final String subtitle;

  factory VolumeInfo.fromJson(Map<String, dynamic> json) => VolumeInfo(
        title: json["title"],
        authors: List<String>.from(json["authors"].map((x) => x)),
        publisher: json["publisher"] == null ? "" : json["publisher"],
        publishedDate:
            json["publishedDate"] == null ? "" : json["publishedDate"],
        description: json["description"] == null ? "" : json["description"],
        // industryIdentifiers: List<IndustryIdentifier>.from(
        //     json["industryIdentifiers"]
//                .map((x) => IndustryIdentifier.fromJson(x))),
        // readingModes: ReadingModes.fromJson(json["readingModes"]),
        pageCount: json["pageCount"] == null ? 0 : json["pageCount"],
        // printType: printTypeValues.map[json["printType"]] as PrintType,
        // categories: json["categories"] == null
        //     ? null
        //     : List<Category>.from(
        //             json["categories"].map((x) => categoryValues.map[x]))
        //         as dynamic,
        averageRating: json["averageRating"] == null
            ? 0.0
            : json["averageRating"].toDouble(),
        ratingsCount:
            json["ratingsCount"] == null ? 0 : json["ratingsCount"],
        // maturityRating:
        //     maturityRatingValues.map[json["maturityRating"]] as MaturityRating,
        allowAnonLogging: json["allowAnonLogging"],
        contentVersion: json["contentVersion"],
        panelizationSummary: json["panelizationSummary"] == null
            ? "null" as PanelizationSummary
            : PanelizationSummary.fromJson(json["panelizationSummary"])
                as dynamic,
        imageLinks: ImageLinks.fromJson(json["imageLinks"]),
        // language: languageValues.map[json["language"]] as Language,
        previewLink: json["previewLink"],
        infoLink: json["infoLink"],
        canonicalVolumeLink: json["canonicalVolumeLink"],
        subtitle: json["subtitle"] == null ? " " : json["subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "publisher": publisher == null ? null : publisher,
        "publishedDate": publishedDate == null ? null : publishedDate,
        "description": description == null ? null : description,
        // "industryIdentifiers":
        // List<dynamic>.from(industryIdentifiers.map((x) => x.toJson())),
        // "readingModes": readingModes.toJson(),
        "pageCount": pageCount == null ? null : pageCount,
        // "printType": printTypeValues.reverse[printType],
        // "categories": categories == null
        //     ? null
        //     : List<dynamic>.from(
        //         categories.map((x) => categoryValues.reverse[x])),
        "averageRating": averageRating == null ? null : averageRating,
        "ratingsCount": ratingsCount == null ? null : ratingsCount,
        // "maturityRating": maturityRatingValues.reverse[maturityRating],
        "allowAnonLogging": allowAnonLogging,
        "contentVersion": contentVersion,
        "panelizationSummary":
            panelizationSummary == null ? null : panelizationSummary.toJson(),
        "imageLinks": imageLinks.toJson(),
        // "language": languageValues.reverse[language],
        "previewLink": previewLink,
        "infoLink": infoLink,
        "canonicalVolumeLink": canonicalVolumeLink,
        "subtitle": subtitle == null ? null : subtitle,
      };
}

enum Category { COMPUTERS, JAVA_COMPUTER_PROGRAM_LANGUAGE }

final categoryValues = EnumValues({
  "Computers": Category.COMPUTERS,
  "Java (Computer program language)": Category.JAVA_COMPUTER_PROGRAM_LANGUAGE
});

class ImageLinks {
  ImageLinks({
    required this.smallThumbnail,
    required this.thumbnail,
  });

  final String smallThumbnail;
  final String thumbnail;

  factory ImageLinks.fromJson(Map<String, dynamic> json) => ImageLinks(
        smallThumbnail: json["smallThumbnail"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "smallThumbnail": smallThumbnail,
        "thumbnail": thumbnail,
      };
}

// class IndustryIdentifier {
//   IndustryIdentifier({
//     required this.type,
//     required this.identifier,
//   });

//   final Type type;
//   final String identifier;

//   factory IndustryIdentifier.fromJson(Map<String, dynamic> json) =>
//       IndustryIdentifier(
//         type: typeValues.map[json["type"]] as Type,
//         identifier: json["identifier"],
//       );

//   Map<String, dynamic> toJson() => {
//         "type": typeValues.reverse[type],
//         "identifier": identifier,
//       };
// }

enum Type { ISBN_13, ISBN_10, OTHER }

final typeValues = EnumValues(
    {"ISBN_10": Type.ISBN_10, "ISBN_13": Type.ISBN_13, "OTHER": Type.OTHER});

enum Language { EN, JA }

final languageValues = EnumValues({"en": Language.EN, "ja": Language.JA});

enum MaturityRating { NOT_MATURE }

final maturityRatingValues =
    EnumValues({"NOT_MATURE": MaturityRating.NOT_MATURE});

class PanelizationSummary {
  PanelizationSummary({
    required this.containsEpubBubbles,
    required this.containsImageBubbles,
  });

  final bool containsEpubBubbles;
  final bool containsImageBubbles;

  factory PanelizationSummary.fromJson(Map<String, dynamic> json) =>
      PanelizationSummary(
        containsEpubBubbles: json["containsEpubBubbles"],
        containsImageBubbles: json["containsImageBubbles"],
      );

  Map<String, dynamic> toJson() => {
        "containsEpubBubbles": containsEpubBubbles,
        "containsImageBubbles": containsImageBubbles,
      };
}

enum PrintType { BOOK }

final printTypeValues = EnumValues({"BOOK": PrintType.BOOK});

// class ReadingModes {
//   ReadingModes({
//     required this.text,
//     required this.image,
//   });

//   final bool text;
//   final bool image;

//   factory ReadingModes.fromJson(Map<String, dynamic> json) => ReadingModes(
//         text: json["text"],
//         image: json["image"],
//       );

//   Map<String, dynamic> toJson() => {
//         "text": text,
//         "image": image,
//       };
// }

class EnumValues<T> {
  Map<String, T> map;
  EnumValues(this.map);

  // Map<T, String> reverseMap;
  var a;
  Map<T, String> get reverse {
    a = map.map((k, v) => new MapEntry(v, k));

    return a;
  }
}
