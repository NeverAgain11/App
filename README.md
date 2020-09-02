## 多级 MVC 和项目最佳实践

### UIKit 中的 MVC

架构的首要目标是关注点分离（Separation of concerns, SoC）。MVC 用 Model，View 和 Controller 这三种角色将对象分成三类。每一种角色都被赋予了一个关注点，Model 关注数据和业务逻辑，View 为数据提供可视化的表示，Controller 作为桥梁负责两者的通信。在 UIKit 中 UIView 和 UIViewController 之间是 MVC 关系，除此之外 UIView 和 CALayer 之间也是 MVC 关系：CALayer 扮演 Model，UIView 扮演 Controller。

UIViewController 和 UIView 的 MVC 分离了模块内的关注点，但没有提及模块间的关系。

```swift
extension ViewController {

    @IBAction func buttonTapped(_ sender: UIButton) {
        let anotherVC = AnotherViewController(...)
        present(anotherVC, animated: true)
    }
}
```

通常我们会在 ViewController 中初始化 AnotherViewController，这使 ViewController 对 AnotherViewController 产生依赖。特别是在 UINavigationController 的 pushing 过程中，原本平级、同属于 UINavigationController 的 children 的几个 UIViewController 产生链状依赖😱。

### 新的 MVC

为了解决这个问题，我将在 UIViewController 之上引入一组新的 MVC 关系。先引用苹果的一段话：*Unlike a content view controller that displays your app’s data, a container view controller displays other view controllers, arranging them onscreen and handling navigation between them*。苹果将 UIViewController 分成 *content* 和 *container*。常见的 *content* 有：UIViewController、UITableViewController；常见的 *container* 有：UITabBarController、UINavigationController，还可以**自定义**！*container* 管理着 *content*，利用这个关系，将 *content* 归为 View ，将 *container* 归为 Controller，为了避免歧义，仍然称 *content* 为 Controller，称 *container* 为 Presenter。Presenter 持有 View，View 通过 Coordinator（为了便于区分所以不使用 Delegate 命名） 向 Presenter 通信。高一级的 Presenter 持有低级 Presenter，低级的 Presenter 通过 Coordinator 向高一级通信，Presenter-Controller 构成一棵树，在这棵树中父节点持有子节点，父节点作为子节点的 Coordinator。每个节点处理自己和子节点的逻辑，把和自己无关的逻辑抛给 Coordinator。

其实，前后端之间的关系也是 MVC，前端负责展示从后端传输过来的数据。每一级 MVC 关注一个维度的问题，低一级的 MVC 细化高一级的 MVC，就像 TCP/IP 协议一样。

### 多级 MVC 的应用：项目最佳实践

通过多级 MVC，将 App 拆分成单 Workspace，多 Project 的结构。每个 Project 都是一棵 Presenter-Controller 树，对外只需要暴露根 Presenter。

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

之所以敢说这样的结构是最佳实践，是因为它具有随着业务增长不断调整的能力。一开始 Convert 只是 Trade 的一个节点，随着它的规模逐渐变大，我选择将它从 Trade 中抽出来作为一个独立的 Project。

只需要在 Podfile 中加一行 `workspace 'App'` 就可以兼容 Cocoapods 了。

相对于单 Project 的项目，它有多个配置文件，这意味着更少的代码合并冲突。除此之外，必须是 `public` 或 `open` 才跨 Project 可见，大大降低了代码的耦合性，增强了内聚性。清晰的边界还意味着易于 Mock，易于调试和测试。

只需要加上一个 target，一个 Project 就可以作为一个 App 独立运行！想象一下这样的开发流程：先在 Convert Project 中开发，通过 Convert.App 调试，完成后再接入 Trade.App，最后接入 App。调整一个字体或颜色不需要全局编译就可以快速调试！

多级 MVC 的约束非常少，最大程度地保留了可能性。Objective-C 和 Swift 混编？UIKit 和 SwiftUI 混编？有何不可！每个 Project 都可以选择局部最优策略，港人治港！

在 Controller-Presenter 树中，Presenter 的生命周期比 Controller 长，让 Presenter 作 Controller 的数据缓存。而根 Presenter 的生命周期和单例是一样的，可以利用它消除单例。

还有全埋点，DeepLink，以及其他潜力！
