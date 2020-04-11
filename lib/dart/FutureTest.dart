import 'dart:math';

///创建了一个延时任务(实际场景会是一个真正的耗时任务，比如一 次网络请求)，即2秒后返回结果字符串"hi world!"，
///然后我们在 then 中接收异步结果并打印结果
void future1() {
  Future.delayed(Duration(seconds: 2), () {
    return "hi world!";
  }).then((data) {
    print(data);
  });
}

///如果异步任务发生错误，我们可以在 catchError 中捕获错误
void future2() {
  Future.delayed(Duration(seconds: 2), () {
    throw AssertionError("Error");
  }).then((data) {
    print("Success");
  }).catchError((error) {
    print(error);
  });
}

///接受一个 Future 数组参数，只有数组中所有 Future 都执行成功后，才会触发 then 的成功回调， 只要有一个 执行失败，就会触发错误回调。
void future3() {
  Future.wait([
    Future.delayed(Duration(seconds: 2), () {
      return "hello ";
    }),
    Future.delayed(Duration(seconds: 3), () {
      return "world";
    })
  ]).then((results) {
    print(results[0] + results[1]);
  }).catchError((error) {
    print(error);
  });
}

Future<String> login(String userName, String password) {
  //用户登录
}

Future<String> getUserInfo(String id) {
  //获取用户信息
}

Future saveUserInfo(String userInfo) {
  //保存用户信息
}

///如果业务逻辑中有大量异步依赖的情况，将会出现上面这种在回调里面套回调的情况，
///过多的嵌套会导致的代码可读性下降以及出错率提高，并且非常难维护，这个问题被形象的称为回调地狱(Callback hell)
void future4() {
  login("userName", "123").then((id) {
    return getUserInfo(id);
  }).then((userInfo) {
    return saveUserInfo(userInfo);
  }).then((e) {
    //执行接下来的操作
  }).catchError((e) {
    //错误处理
    print(e);
  });
}

void future5() async {
  try {
    String id = await login("userName", "123");
    String userInfo = await getUserInfo(id);
    await saveUserInfo(userInfo);
    //执行接下来的操作
  } catch (e) {
    //错误处理
    print(e);
  }
}

///Stream 也是用于接收异步事件数据，和 Future 不同的是，它可以接收多个异步操作的结果(成功或失败)。
///也就是 说，在执行异步任务时，可以通过多次触发成功或失败事件来传递结果数据或错误异常。
/// Stream 常用于会多次读取数 据的异步任务场景，如网络内容下载、文件读写等。举个例子:
void future6() {
  Stream.fromFutures([
    Future.delayed(Duration(seconds: 1), () {
      return "hello 1";
    }),
    Future.delayed(Duration(seconds: 2), () {
      throw AssertionError("error");
    }),
    Future.delayed(Duration(seconds: 3), () {
      return "hello 3";
    })
  ]).listen((data) {
    print(data);
  }, onError: (e) {
    print(e);
  }, onDone: () {});
}

void main() {
  future6();
}
