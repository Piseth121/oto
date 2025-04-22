
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({super.key});

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contact Us'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 1,

      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Icon(Icons.headset_mic, color: Colors.orange, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'សូមទាក់ទងមកយើងខ្ញុំ ដើម្បីស្វែងរកជំនួយពីសេវាកម្ម',
                    style: TextStyle(fontSize: 16,fontFamily: "battambang",),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('លេខទូរស័ព្ទ', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "battambang")),
            ),
            SizedBox(height: 10),
            contactCard(iconPath: 'assets/images/smart.png', number: '016 369 049',link: '', IsCopy: true),
            contactCard(iconPath: 'assets/images/cellcard.png', number: '095 333 003',link: '',IsCopy: true),


            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('សេវាបានប្រើកម្មវិធីសារអេឡិចត្រូនិច',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,fontFamily: "battambang")),
            ),
            SizedBox(height: 10),
            socialCard(icon: Icons.send, label: '016 369 049 (KH)',onTap: () {
              Uri uri = Uri.parse('https://t.me/vunvuthul');
              launchUrl(uri);
            }),
            socialCard(icon: Icons.facebook, label: 'otokhi'),
            socialCard(icon: Icons.backup_rounded, label: 'www.otokhi.com'),
          ],
        ),
      ),
    );
  }
  Widget contactCard(
      {required String iconPath, required String number,String? link, bool? IsCopy}) {
    void _handleTap(BuildContext context) async {
      if (IsCopy=true) {
        FlutterClipboard.copy(number).then((_) {
          Fluttertoast.showToast(msg: 'Copied to clipboard');
        });
      } else if (link != null) {
        final uri = Uri.parse(link);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          Fluttertoast.showToast(msg: 'Could not open link');
        }
      }
    }
    return InkWell(
      onTap: () => _handleTap(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Image.asset(iconPath, width: 28, height: 28,fit: BoxFit.cover),
            SizedBox(width: 12),
            Text(number, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }


  Widget socialCard({required IconData icon, required String label, VoidCallback? onTap,}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.blue),
            SizedBox(width: 12),
            Expanded(child: Text(label, style: TextStyle(fontSize: 16))),
            Icon(Icons.open_in_new, size: 18, color: Colors.orange),
          ],
        ),
      ),
    );
  }
}
