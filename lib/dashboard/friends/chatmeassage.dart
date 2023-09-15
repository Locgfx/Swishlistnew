import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constants/color.dart';

class ChatMessage extends StatefulWidget {
  const ChatMessage({Key? key}) : super(key: key);

  @override
  State<ChatMessage> createState() => _ChatMessageState();
}

class _ChatMessageState extends State<ChatMessage> {
  final sendMsgController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorSelect.colorFFFFFF,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/images/Rectangle3194.png'),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "PamRox23",
                  style: AppTextStyle().robotocolor1F1F1C14w500,
                ),
              ],
            ),
            Spacer(),
            Image.asset(
              "assets/images/Vector.png",
              height: 40,
              width: 40,
            )
          ],
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: InkWell(
              onTap: () {}, child: Image.asset('assets/images/Vector190.png')),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 285,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Today, 5:23 AM",
                  style: AppTextStyle().textColor70707012w400,
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 100),
              child: Container(
                width: 144.w,
                height: 108.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border:
                        Border.all(width: 1, color: ColorSelect.colorC2C2C2)),
                child: Center(
                  child: Image.asset("assets/images/image10.png"),
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "RESPAWN 110 Racing Style Gaming Chair, Reclining\nErgonomic Chair with Footrest, in Green",
              style: AppTextStyle().textColor8F8F8F10w400,
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                SizedBox(
                  width: 20,
                ),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      AssetImage('assets/images/Rectangle3194.png'),
                ),
                SizedBox(
                  width: 12,
                ),
                Container(
                  height: 58.h,
                  width: 231.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: ColorSelect.colorECEDF0),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Text("Send me this ASAP. You haven’t gifted me yet"),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 66,
            ),
            Container(
              width: 328.w,
              height: 52.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorSelect.colorFDFAE3),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Message",
                            hintStyle: AppTextStyle().textColor70707014w400,
                            suffixIcon:
                                Image.asset("assets/images/sentimage.png")),
                        keyboardType: TextInputType.text,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
