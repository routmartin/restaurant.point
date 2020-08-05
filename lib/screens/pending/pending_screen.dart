import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  // final User sender;

  ChartScreen();

  @override
  _ChartScreenState createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        backgroundColor: Color(0xff090c11),
        appBar: AppBar(
          backgroundColor: Color(0xff090c11),
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1518806118471-f28b20a1d79d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                'Martin',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.blueGrey,
              ),
              iconSize: 20,
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onTap: () => Focus.of(context).unfocus(),
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    color: Color(0xff333640),
                    // boxShadow: [
                    // BoxShadow(
                    //   color: Colors.grey[300],
                    //   blurRadius: 10,
                    //   offset: Offset(0, 1),
                    // ),
                    // BoxShadow(
                    //   color: Colors.grey[200],
                    //   blurRadius: 15,
                    //   offset: Offset(0, 4),
                    // )
                    // ],
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35)),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(35),
                      topLeft: Radius.circular(35),
                    ),

                    child: Container(),
                    // child: ListView.builder(
                    //     padding: EdgeInsets.only(top: 15),
                    //     reverse: true,
                    //     itemCount: messages.length,
                    //     itemBuilder: (BuildContext context, int index) {
                    //       final Message msg = messages[index];
                    //       final bool isMe = msg.sender.id == currentUser.id;
                    //       return _buildMessage(msg, isMe);
                    //     }),
                  ),
                ),
              ),
            ),
            _buildMessageComposer()
          ],
        ));
  }

  // _buildMessage(Message msg, bool isMe) {
  //   final msgBody = Container(
  //       width: MediaQuery.of(context).size.width * 0.75,
  //       margin: isMe
  //           ? EdgeInsets.only(top: 8, bottom: 8, left: 80)
  //           : EdgeInsets.only(top: 8, bottom: 8),
  //       padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
  //       decoration: BoxDecoration(
  //           color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
  //           borderRadius: isMe
  //               ? BorderRadius.only(
  //                   topLeft: Radius.circular(10),
  //                   bottomLeft: Radius.circular(10))
  //               : BorderRadius.only(
  //                   topRight: Radius.circular(10),
  //                   bottomRight: Radius.circular(10))),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: <Widget>[
  //           Text(
  //             msg.time,
  //             style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.w500,
  //                 color: Colors.grey),
  //           ),
  //           SizedBox(
  //             height: 10,
  //           ),
  //           Text(
  //             msg.text,
  //             style: TextStyle(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w500,
  //               color: Colors.blueGrey,
  //             ),
  //           )
  //         ],
  //       ));
  //   if (isMe) {
  //     return msgBody;
  //   }
  //   return Row(
  //     children: <Widget>[
  //       msgBody,
  //       IconButton(
  //           onPressed: () {},
  //           icon: msg.isLiked
  //               ? Icon(Icons.favorite)
  //               : Icon(Icons.favorite_border),
  //           color:
  //               msg.isLiked ? Theme.of(context).primaryColor : Colors.blueGrey)
  //     ],
  //   );
  // }

  _buildMessageComposer() {
    return Container(
      height: 70,
      // padding: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              onChanged: (val) {
                print(val);
              },
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration.collapsed(
                  hintText: 'Send a Message',
                  hintStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.blueGrey),
                  border: InputBorder.none),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.send,
              size: 24,
              color: Colors.blueGrey,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
