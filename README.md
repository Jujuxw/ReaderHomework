# ReaderHomework

1. 打开后看到文章列表![](https://github.com/Jujuxw/ReaderHomework/blob/master/home.PNG)
2. 点击列表某项，打开文章![](https://github.com/Jujuxw/ReaderHomework/blob/master/detail.PNG)
3. 文章界面有一个按钮，点击则在文章中高亮在单词列表中出现的单词![](https://github.com/Jujuxw/ReaderHomework/blob/master/highlight.PNG)
4. 文章界面有一个 slide-bar ，从0到6（对应单词表中每个单词信息的 level )，可以拖动过滤高亮的单词![](https://github.com/Jujuxw/ReaderHomework/blob/master/slider.PNG)
5. ** 点击文章界面任意一个单词，可以获取到所点击的单词及相对应的等级（可以做一个简单的弹出效果来显示或者其他可以表示获取到了的效果），对所点击的单词做高亮或者反色的选中效果。**(没有完成，实现思路如下：)
   - 通过实现TextView的代理回调`- (bool)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange`方法
   - 查看level：
     - 通过创建一个VIew展示数据
     - 用UIAlertController实现弹出提示框展示数据
   - 不能实现的原因：textView的delegate设置了，可以还是无法回调函数。