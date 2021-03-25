import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:link_app/modules/store/pageable_controller.dart';
import 'package:link_app/utils/colors_default.dart';

class PageableDefault extends StatefulWidget with PreferredSizeWidget {
  PageableController pageableController;
  PageableDefault({Key key, @required this.pageableController})
      : super(key: key);

  @override
  _PageableDefaultState createState() => _PageableDefaultState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _PageableDefaultState extends State<PageableDefault> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Observer(
          builder: (_) => widget.pageableController.pageable != null &&
                  widget.pageableController.pageable.totalPages > 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    !widget.pageableController.pageable.first
                        ? GestureDetector(
                            child: Icon(
                              Icons.arrow_left,
                              color: Colors.grey,
                              size: 50,
                            ),
                            onTap: () {
                              widget.pageableController.decrement();
                            },
                          )
                        : Container(),
                    for (int i = 0;
                        i < widget.pageableController.pageable.totalPages;
                        i++)
                      widget.pageableController.pageable.number == i
                          ? GestureDetector(
                              child: Container(
                                alignment: Alignment.center,
                                width: 45,
                                height: 40,
                                color: Color(ColorsDefault.primary),
                                child: Text(
                                  "${i + 1}",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                              ),
                            )
                          : Visibility(
                              visible: (i >
                                      widget.pageableController.currentPage -
                                          4 &&
                                  i <=
                                      widget.pageableController.currentPage +
                                          3),
                              child: GestureDetector(
                                onTap: () {
                                  widget.pageableController.setCurrentPage(i);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 45,
                                  height: 40,
                                  color: Colors.white,
                                  child: Text(
                                    "${i + 1}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              )),
                    !widget.pageableController.pageable.last
                        ? GestureDetector(
                            child: Icon(
                              Icons.arrow_right,
                              color: Colors.grey,
                              size: 50,
                            ),
                            onTap: () {
                              widget.pageableController.increment();
                            },
                          )
                        : Container(),
                  ],
                )
              : Text("")),
    );
  }
}
