import 'package:dating_app/domain/model/manager.dart';
import 'package:flutter/material.dart';

class ManagerInfoScreen extends StatelessWidget {
  final Manager manager;

  const ManagerInfoScreen(this.manager, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        iconTheme: const IconThemeData(
          color: Color(0xff324755),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: SizedBox(
              height: 500,
              child: ListView(
                children: [
                  Container(
                    width: double.infinity,
                    height: 408,
                    decoration: BoxDecoration(border: Border.all(color: Colors.white)),
                    child: ShaderMask(
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(manager.photoURL),
                          ),
                        ),
                      ),
                      shaderCallback: (Rect bounds) {
                        return const LinearGradient(
                            colors: [Colors.white, Colors.transparent],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.7, 1]).createShader(bounds);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(manager.userName,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            )),
                        Text(
                          "${manager.area} / ${manager.ageGroup}대",
                          style: const TextStyle(fontSize: 15, color: Colors.grey, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Text(
                              "MBTI",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "  ${manager.MBTI}",
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              "관심분야",
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "  ${manager.pastTime.toString()}",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xff93e3e6), width: 2),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Center(
                          child: Text(
                            manager.description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(color: Colors.blue.shade300, width: 2),
                      ),
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("'${manager.userName}' 의 추천 코스 !",
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                )),
                            Container(
                              height: 7,
                            ),
                            Text(manager.course,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 102,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 5.0,
                  spreadRadius: 3.0,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: InkWell(
                    onTap: () {
                      // TODO : 채팅 연결 구현해야 함.
                    },
                    child: Container(
                      height: 76,
                      width: 76,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xff93e3e6), style: BorderStyle.solid, width: 2),
                      ),
                      child: const Icon(
                        Icons.message,
                        color: Color(0xffa9a9a9),
                        size: 27,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                  child: InkWell(
                    onTap: () {
                      // TODO : 산책 예약 페이지 구현해야 함.
                    },
                    child: Container(
                      height: 76,
                      width: 208,
                      decoration: BoxDecoration(
                        color: const Color(0xff93e3e6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          "산책 예약하기",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21, color: Color(0xffffffff)),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                  child: InkWell(
                    onTap: () {
                      // TODO : 좋아요 기능 구현해야 함.
                    },
                    child: Container(
                      height: 76,
                      width: 76,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xff93e3e6), style: BorderStyle.solid, width: 2),
                      ),
                      child:
                          Icon(
                        Icons.favorite_border_outlined,
                        color: Colors.red[500],
                        size: 27,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
