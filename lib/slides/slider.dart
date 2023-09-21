import "package:flutter/material.dart";

// ignore: must_be_immutable
class SliderTitle extends StatelessWidget {
  String? title;
  String? description;
  String? imagepath;

  SliderTitle({Key? key, this.title, this.description, this.imagepath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 50.0, top: 60.0, right: 50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                title ?? "",
                style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 40.0,
                    color: Colors.black54,
                    letterSpacing: 3.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                description ?? "",
                style: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(
                height: 60.0,
              ),
              Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {},
                  child: const CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Color(0xFFD03D2D),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                );
              })
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        Expanded(
          child: Image(
            fit: BoxFit.cover,
            width: 2000.0,
            // height: 30.0,
            image: AssetImage(imagepath ?? ""),
          ),
        ),
      ],
    );
  }
}
