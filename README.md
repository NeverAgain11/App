```
RootPresenter: UITabBarController
 ├─ HomePresenter
 ├─ MarketsPresenter
 ├─ TradeNavigationPresenter: UINavigationController
 │   ├─ TradePagePresenter: UIPageViewController
 │   │   ├─ SpotPresenter
 │   │   ├─ ConvertPresenter: UIViewController
 │   │   │   ├─ ConvertViewController
 │   │   │   └─ ConvertOrderPresenter: UIViewController
 │   │   │       ├─ ConvertOrderTableViewController
 │   │   │       └─ ConvertOrderViewController
 │   │   └─ MarginPresenter
 │   └─ FiatPresenter
 ├─ FuturesPresenter
 └─ WalletsPresenter
```

这棵树的核心对象是 Presenter，什么是 Presenter？Presenter 就是 MVP 中的 Presenter。

🍎：*Unlike a content view controller that displays your app’s data, a container view controller displays other view controllers, arranging them onscreen and handling navigation between them*。是的，Presenter 由 container 担任，常见的有：UITabBarController、UINavigationController，自定义的 container 也可以担任。相对的 View 由 content 担任，常见的有：UIViewController、UITableViewController。
content 担任 View，那么 UIView 呢？就像 UIView 和 CALayer 组成的 MVC 中没有 UIViewController 的位置。在这一组 MVP 中，没有 UIView 的位置。架构应该是多层的，每一层用来解决不同纬度的问题，就像 TCP/IP 协议？

这棵树的依赖关系简单且统一：父节点持有子节点，父节点充当子节点的 Coordinator。Coordinator 其实就是 Delegate，专用化的 Delegate，就像 DataSource。

树是一种递归而非扁平的结构，它允许我们将所有节点拆成几个小的节点，只要有必要！比如 ConvertOrderPresenter 就是从 ConvertPresenter 中拆出来专门用来管理订单的一个小节点。

得益于简单且统一的依赖关系，所以用一 Workspace 多 Project 存放它们也非常简单（幸运的是 CocoaPods 支持这样做只需要在 Podfile 中加一句代码）。每个 Project 的配置文件都是独立的，意味着更少的冲突。跨 Project 只能访问到 public 和 open 的代码，非预期的访问被禁止了，向高内聚低耦合冲啊！

只需要加上 AppDelegate 和 SceneDelegate 一个子树就可以作为一个 App 独立运行！想象一下这样的开发流程：先在 Convert 中开发，运行 Convert.App 调试，完成后再接入 Trade.App，最后接入 App。一个 UI 改动再也不需要全局编译就可以看到效果！清晰的边界意味着易于 Mock，易于调试和测试。

哪怕还没有实际运用只是想想这棵树能做的事情就有很多，比如，它的要求很少，最大程度地保留了可能性，Fiat Project 就是用 SwiftUI 实现的；比如，Presenter 的生命周期灵活多样，用来做 Cache 非常合适！消除单例也不难；再比如，它允许分层处理 Networking 数据。还有我想到但没想明白的：DeepLink，埋点。
