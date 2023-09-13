import 'package:flutter/material.dart';

class CustomDropdown extends StatefulWidget {
  final String text;
  final List itemList;
  final Function(int val) onTap;
  const CustomDropdown(
      {super.key,
      required this.text,
      required this.itemList,
      required this.onTap});

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  GlobalKey? actionKey;
  bool isDropdownOpen = false;
  double height = 0;
  double width = 0;
  double xPosition = 0;
  double yPosition = 0;
  OverlayEntry? floatingOverlayMenu;
  int? selectedIndex;
  @override
  void initState() {
    // TODO: implement initState
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void dropdownData() {
    RenderBox renderBox =
        actionKey!.currentContext?.findRenderObject() as RenderBox;
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(
        builder: (context) => Positioned(
            left: xPosition,
            width: width,
            top: yPosition + height + 20,
            child: SizedBox(
                height: height * 5,
                child: Column(
                  children: [
                    ClipPath(
                        clipper: ArrowClipper(),
                        child: Material(
                          elevation: 4,
                          color: Colors.grey,
                          child: Container(
                              height: 10, width: 20, color: Colors.white),
                        )),
                    Expanded(
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const ScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            itemCount: widget.itemList.length,
                            itemBuilder: (context, index) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = index;
                                      floatingOverlayMenu?.remove();
                                      floatingOverlayMenu = null;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: const BoxDecoration(
                                        // color:
                                        //     Color.fromARGB(255, 255, 255, 255),
                                        border: Border(
                                            bottom: BorderSide(
                                                style: BorderStyle.solid,
                                                width: 0.1,
                                                color: Color.fromARGB(
                                                    255, 237, 236, 236)))),
                                    child: Text(
                                      widget.itemList[index],
                                      style: const TextStyle(
                                          fontSize: 20, color: Colors.black),
                                    ),
                                  ),
                                )),
                      ),
                    ),
                  ],
                ))));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        setState(() {
          if (isDropdownOpen) {
            floatingOverlayMenu?.remove();
            floatingOverlayMenu = null;
          } else {
            dropdownData();
            floatingOverlayMenu = _createOverlayEntry();
            Overlay.of(context).insert(floatingOverlayMenu!);
          }
          isDropdownOpen = !isDropdownOpen;
        });
      },
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            border: Border.all(style: BorderStyle.solid)),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          children: [
            Text(selectedIndex != null
                ? widget.itemList[selectedIndex!]
                : widget.text),
          ],
        ),
      ),
    );
  }
}

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection? textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection? textDirection}) {
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection? textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    return path;
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
