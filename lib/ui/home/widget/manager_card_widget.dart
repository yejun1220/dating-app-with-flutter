import 'package:dataing_app/controller/auth_controller.dart';
import 'package:dataing_app/controller/manager_controller.dart';
import 'package:dataing_app/model/manager.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManagerCardWidget extends StatelessWidget {
  final Manager manager;

  ManagerCardWidget({required this.manager, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: Row(
          children: [
            Container(
              decoration: ShapeDecoration(
                image: DecorationImage(image: NetworkImage(manager.profile!.imageUrl), fit: BoxFit.cover),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusDirectional.circular(15),
                ),
              ),
              height: 126,
              width: 132,
            ),
            SizedBox(
              width: 10,
              height: 130,
            ),
            Container(
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        " " + manager.userName!.value,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff241332)),
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      Text(
                        manager.profile!.star.toStringAsFixed(1),
                        style: TextStyle(fontSize: 15, color: Color(0xff8e8594)),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(" " + " ${manager.profile!.area} - ", style: TextStyle(fontSize: 10, color: Color(0xff6b6b6b))),
                      Text(" ${manager.profile!.year}대", style: TextStyle(fontSize: 10, color: Color(0xff6b6b6b))),
                    ],
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Text(" " + " 관심분야 - ${manager.profile!.like.substring(0, 6) + "..."}",
                      style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Color(0xff737373))),
                  Text(
                    " " + " ${manager.profile!.description.substring(0, 26)}...",
                    style: TextStyle(
                      fontSize: 11,
                      color: Color(0xff878787),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  ),
                  GetX<ManagerController>(
                    init: ManagerController(),
                    builder: (managerController) {
                      return Row(
                        children: [
                          Text(
                            "  60분 ${manager.profile!.price2} P",
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${manager.heart}',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xffa7a7a7)),
                          ),
                          InkWell(
                            child: manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)
                                ? Icon(
                                    EvaIcons.heart,
                                    color: Colors.red[500],
                                    size: 18.35,
                                  )
                                : Icon(EvaIcons.heartOutline, color: Color(0xff878787), size: 18.35),
                            onTap: () {
                              if (manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)) {
                                manager.heart.value -= 1;
                                manager.removeLike(AuthController.instance.authentication.currentUser!.uid);
                              } else {
                                manager.heart.value += 1;
                                manager.addLike(AuthController.instance.authentication.currentUser!.uid);
                              }
                              managerController.managerList[0] = manager;
                              managerController.updateHeartFirebase();
                            },
                          ),
                        ],
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
