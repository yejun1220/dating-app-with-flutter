import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/freeboard_controller.dart';
import '../../../model/freeboard.dart';
import '../freeboard_view_model.dart';

class FreeBoardCardWidget extends StatefulWidget {
  final int index;

  FreeBoardCardWidget({required this.index});

  @override
  State<FreeBoardCardWidget> createState() => _FreeBoardCardWidgetState(index: this.index);
}

class _FreeBoardCardWidgetState extends State<FreeBoardCardWidget> {
  final FreeBoardController freeBoardController = Get.put(FreeBoardController());
  final freeBoardViewModel = FreeBoardViewModel();

  final int index;

  FreeBoard get _freeBoard => freeBoardController.freeBoardList[index];

  _FreeBoardCardWidgetState({required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 3, 5),
      child: InkWell(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _freeBoard.title,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                _freeBoard.content,
                style: TextStyle(
                  fontSize: 15.sp,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "${freeBoardViewModel.timeConvert(_freeBoard, index)}",
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                      Text(
                        '  ' + _freeBoard.userName,
                        style: TextStyle(
                          fontSize: 15.sp,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        EvaIcons.heart,
                        color: Colors.redAccent,
                      ),
                      Text(
                        "${_freeBoard.isPressedList.length}" + " ",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.redAccent,
                        ),
                      ),
                      Icon(
                        EvaIcons.messageCircleOutline,
                        color: Colors.blue,
                      ),
                      Text(
                        "${_freeBoard.comments}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
