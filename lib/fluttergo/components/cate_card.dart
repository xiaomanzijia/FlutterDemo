import 'package:flutter/material.dart';
import 'package:flutter_app_demo/fluttergo/components/widget_item_container.dart';
import 'package:flutter_app_demo/fluttergo/model/cat.dart';

class CateCard extends StatefulWidget {
  final Cat category;

  CateCard({@required this.category});

  @override
  State<StatefulWidget> createState() {
    return new _CateCardState();
  }
}

class _CateCardState extends State<CateCard> {
  CatControlModel catControl = new CatControlModel();

  List<Cat> _firstChildList = new List();

  @override
  void initState() {
    super.initState();
    getFirstChildCategoriesByParentId();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    widget.category.name = widget.category.name.replaceFirst(
        //首字母转为大写
        widget.category.name.substring(0, 1),
        widget.category.name.substring(0, 1).toUpperCase());

    return new Container(
      width: screenWidth,
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: screenWidth - 20,
            margin: const EdgeInsets.only(top: 30.0, bottom: 0.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  width: screenWidth - 20,
                  padding: const EdgeInsets.only(left: 65.0, top: 3.0),
                  height: 30.0,
                  child: Text(
                    widget.category.name,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18.0,
                    ),
                  ),
                ),
                _buildWidgetContainer(),
              ],
            ),
          )
        ],
      ),
    );
  }

  //获取一层目录下的二级内容
  getFirstChildCategoriesByParentId() async {
    int parendId = widget.category.parentId;
    //构建查询条件
    Cat childCateCondition = new Cat(parentId: parendId);

    List<Cat> list = await catControl.getList(childCateCondition);
    if (list.isNotEmpty && list.length >= 1 && this.mounted) {
      setState(() {
        _firstChildList = list;
      });
    }
  }

  Widget _buildWidgetContainer() {
    if (this._firstChildList.length == 0) {
      return Container();
    }
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0, top: 5.0),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/paimaiLogo.png'),
              alignment: Alignment.bottomRight)),
      child: WidgetItemContainer(
          categories: this._firstChildList,
          columnCount: 3,
          isWidgetPoint: false),
    );
  }
}
