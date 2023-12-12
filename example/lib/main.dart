import 'package:flutter/material.dart';
import 'extension.dart';
import 'package:standard_markdown/standard_markdown.dart';

const markdown = r'''
# I'm h1 _sd_

## I'm h2  $dsda$

### I'm h3

#### I'm h4

##### I'm h5

###### I'm h6

```dart
class MarkdownHelper {


  Map<String, Widget> getTitleWidget(m.Node node) => title.getTitleWidget(node);

  Widget getPWidget(m.Element node) => p.getPWidget(node);

  Widget getPreWidget(m.Node node) => pre.getPreWidget(node);

}
```

_italic text_

**strong text**

`I'm code`

~~del~~

**_~~italic strong and del~~_**

> Test for blockquote and **strong**

- ul list
- one
  - aa _a_ a
  - bbbb
    - CCCC

1. ol list
2. aaaa
3. bbbb
   1. AAAA
   2. BBBB
   3. CCCC

[I&#39;m link](https://github.com/asjqkkkk/flutter-todos)

- [ ] I'm _CheckBox_
- [X] I'm _CheckBox_ too

Test for divider(hr):

---

Test for Table:

| header 1    | header 2    |
| ----------- | ----------- |
| row 1 col 1 | row 1 col 2 |
| row 2 col 1 | row 2 col 2 |

## Markdown example

Hello **Markdown**!

### Highlights

- [X] ==100%== conform to CommonMark.
- [X] ==100%== conform to GFM.
- [X] Easy to implement syntax **highlighting**, for example `flutter_prism`:

  ```dart

  // Dart language.

  void main() {

    print('Hello, World!');

  }

  ```
- [X] Easy to custom, for example:

  > This is a #custom_extension
  >

---

### Dependencies

| Name              | Required |
| ----------------- | -------: |
| `dart_markdown` |      Yes |
| `flutter_prism` |       No |

这是一篇讲解如何正确使用 **Markdown** 的排版示例，学会这个很有必要，能让你的文章有更佳清晰的排版。

> 引用文本：Markdown is a text formatting syntax inspired

## 语法指导

### 普通内容

这段内容展示了在内容里面一些排版格式，比如：

- **加粗** - `**加粗**`
- _倾斜_ - `*倾斜*`
- ~删除线~ - `~~删除线~~`
- `Code 标记` - `Code 标记`
- [超级链接](https://ld246.com/) - `[超级链接](https://ld246.com)`
- [username@gmail.com](mailto:username@gmail.com) - `[username@gmail.com](mailto:username@gmail.com)`

### 表情符号 Emoji

支持大部分标准的表情符号，可使用输入法直接输入。

#### 一些表情例子

😄 😆 😵 😭 😰 😅 😢 😤 😍 😌
👍 👎 💯 👏 🔔 🎁 ❓ 💣 ❤️ ☕️ 🌀 🙇 💋 🙏 💢

### 大标题 - Heading 3

你可以选择使用 H1 至 H6，使用 ##(N) 打头。建议帖子或回帖中的顶级标题使用 Heading 3，不要使用 1 或 2，因为 1 是系统站点级，2 是帖子标题级。

> NOTE: 别忘了 # 后面需要有空格！

#### Heading 4

##### Heading 5

###### Heading 6

### 图片

![图片描述是什么鬼？](https://s4.51cto.com/images/blog/202112/31120749_61ce82155047c46348.png?x-oss-process=image/watermark,size_16,text_QDUxQ1RP5Y2a5a6i,color_FFFFFF,t_30,g_se,x_10,y_10,shadow_20,type_ZmFuZ3poZW5naGVpdGk=)

```undefined
![alt 文本](http://image-path.png)
![alt 文本](http://image-path.png "图片 Title 值")

```

代码块

#### 普通

```undefined
*emphasize*    **strong**
_emphasize_    __strong__
var a = 1

```

#### 语法高亮支持

如果在 ``` 后面跟随语言名称，可以有语法高亮的效果哦，比如:

##### 演示 Go 代码高亮

```go
package main

import "fmt"

funcmain() {
	fmt.Println("Hello, 世界")
}

```

##### 演示 Java 高亮

```java
public classHelloWorld{

    publicstaticvoidmain(String[] args){
        System.out.println("Hello World!");
    }

}

```

> Tip: 语言名称支持下面这些: `ruby`, `python`, `js`, `html`, `erb`, `css`, `coffee`, `bash`, `json`, `yml`, `xml` ...

### 有序、无序、任务列表

#### 无序列表

- Java
  - Spring
    - IoC
    - AOP
- Go
  - gofmt
  - Wide
- Node.js
  - Koa
  - Express

#### 有序列表

1. Node.js
   1. Express
   2. Koa
   3. Sails
2. Go
   1. gofmt
   2. Wide
3. Java
   1. Latke
   2. IDEA

#### 任务列表

- [X] 发布 Sym
- [X] 发布 Solo
- [ ] 预约牙医

### 表格

如果需要展示数据什么的，可以选择使用表格。

| header 1 | header 2 |
| -------- | -------- |
| cell 1   | cell 2   |
| cell 3   | cell 4   |
| cell 5   | cell 6   |

### 隐藏细节

<details><summary>这里是摘要部分。</summary>

</details>

### 段落

空行可以将内容进行分段，便于阅读。（这是第一段）

使用空行在 Markdown 排版中相当重要。（这是第二段）

### 链接引用

[链接文本](https://b3log.org/)

```undefined
[链接文本][链接标识]

[链接标识]: https://b3log.org

```

### 数学公式

多行公式块：

$$
123123\pm 你
$$

行内公式：

公式$Em^2$是行内。
''';
var latex = r'''$$
123123\pm
$$

行内公式：

公式$Em^2$是行内。''';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      title: 'MarkdownViewer Demo',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('MarkdownViewer Demo')),
        body: ListView(padding: const EdgeInsets.all(20), children: [
          StandardMarkdown(
            markdown,
            enableTaskList: true,
            enableSuperscript: true,
            enableFootnote: true,
            enableKbd: true,
            syntaxExtensions: [ExampleSyntax()],
            elementBuilders: [
              ExampleBuilder(),
            ],
            styleSheet: const MarkdownStyle(
              listItemMarkerTrailingSpace: 12,
              codeSpan: TextStyle(
                fontFamily: 'RobotoMono',
              ),
              codeBlock: TextStyle(
                fontSize: 14,
                letterSpacing: -0.3,
                fontFamily: 'RobotoMono',
              ),
            ),
          )
        ]));
  }
}
