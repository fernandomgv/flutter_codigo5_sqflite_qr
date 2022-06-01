import 'package:flutter/material.dart';
import 'package:flutter_codigo5_sqflite_qr/db/db_admin.dart';
import 'package:flutter_codigo5_sqflite_qr/models/license_model.dart';
import 'package:flutter_codigo5_sqflite_qr/pages/scaner_qr_page.dart';
import 'package:flutter_codigo5_sqflite_qr/ui/general/colors.dart';
import 'package:flutter_codigo5_sqflite_qr/ui/widget/item_list_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List licenses = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'No hemos podido abrir: $url';
    }
  }
  getData() async {
    licenses = await DBAdmin.db.getLincese();
    setState(() {});
  }

  showDetail( LicenseModel license) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Detalle del Carnet",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.0),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Nombre:",
                      style: TextStyle(
                          color: kFontPrimaryColor.withOpacity(0.7),
                          fontSize: 13.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      license.name,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Nro DNI:",
                      style: TextStyle(
                          color: kFontPrimaryColor.withOpacity(0.7),
                          fontSize: 13.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      license.dni,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Text(
                      "Código QR:",
                      style: TextStyle(
                          color: kFontPrimaryColor.withOpacity(0.7),
                          fontSize: 13.0),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: (){
                    /*
                  setState(() {
                    print("Link:" + Uri.parse(license.url).toString());
                    _launchInBrowser(Uri.parse(license.url));
                  });
                  */
                    final Uri _url = Uri.parse(license.url);
                    launchUrl(_url);
                  },
                  child: SizedBox(
                      height: 160,
                      width: 160,
                      child: QrImage(data: license.url)),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: kFontPrimaryColor),
        title: const Text(
          "VacunApp Storage",
          style: TextStyle(
            color: kFontPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mis carnets registrados",
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                licenses.isNotEmpty
                    ? Expanded(
                        child: RefreshIndicator(
                          strokeWidth: 2,
                          color: kBrandPrimaryColor,
                          onRefresh: () async {
                            getData();
                          },
                          child: ListView.builder(
                            //  physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: licenses.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ItemListWidget(
                                license: licenses[index],
                                onPressed: () {
                                  showDetail(licenses[index]);
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/open-box.png',
                              height: 100,
                            ),
                            Text("Aun no tienes carnets registrados"),
                          ],
                        ),
                      ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 52.0,
              width: double.infinity,
              margin: const EdgeInsets.all(12.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ScannerQRPage()));
                },
                style: ElevatedButton.styleFrom(
                  primary: kBrandPrimaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                ),
                label: const Text(
                  "Escaner QR",
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                icon: SvgPicture.asset(
                  'assets/icons/bx-qr-scan.svg',
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
