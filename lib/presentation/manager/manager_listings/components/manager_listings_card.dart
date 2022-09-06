import 'package:dating_app/domain/model/manager.dart';
import 'package:flutter/material.dart';

class ManagerListingsCard extends StatelessWidget {
  final Manager manager;

  const ManagerListingsCard({required this.manager, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(16.0)),
              image: DecorationImage(
                image: NetworkImage(manager.photoURL),
                fit: BoxFit.cover,
              ),
            ),
            width: 144,
            height: 144,
          ),
          const SizedBox(
            width: 10,
            height: 130,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                " ${manager.userName}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff241332)),
              ),
              Text(
                " ${manager.area} - ",
                style: const TextStyle(fontSize: 10, color: const Color(0xff6b6b6b)),
              ),
              Text(
                " ${manager.ageGroup}대",
                style: const TextStyle(fontSize: 10, color: const Color(0xff6b6b6b)),
              ),
              Text(
                " ${manager.description.substring(0, 26)}...",
                style: const TextStyle(fontSize: 10, color: const Color(0xff6b6b6b)),
                overflow: TextOverflow.ellipsis,
                // style: Theme.of(context).textTheme.bodyText2,
              ),
              // Row(
              //   children: [
              //     Text(
              //       "  60분 ${manager.profile!.price2} P",
              //       style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              //     ),
              //     Text(
              //       '${manager.heart}',
              //       style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xffa7a7a7)),
              //     ),
              //     InkWell(
              //       child: manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)
              //           ? Icon(
              //               EvaIcons.heart,
              //               color: Colors.red[500],
              //               size: 18.35,
              //             )
              //           : Icon(EvaIcons.heartOutline, color: Color(0xff878787), size: 18.35),
              //       onTap: () {
              //         if (manager.isPressedList!.contains(AuthController.instance.authentication.currentUser!.uid)) {
              //           manager.heart.value -= 1;
              //           manager.removeLike(AuthController.instance.authentication.currentUser!.uid);
              //         } else {
              //           manager.heart.value += 1;
              //           manager.addLike(AuthController.instance.authentication.currentUser!.uid);
              //         }
              //         managerController.managerList[0] = manager;
              //         managerController.updateHeartFirebase();
              //       },
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
