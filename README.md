# bi-ios-2018

## 1. Úvod
branch: není
- úvod do mobilního vývoje
- úvod do platformy iOS
- ukázka prostředí Xcode

## 2. Swift
branch: ???

`// TODO:`

## 3. Views
branch: `03-views`
- gitignore.io - užitečný nástroj pro generování .gitignore souborů
- App -> UIWindow -> rootViewController -> view -> subviews
- Views v Interface builderu (IB) - custom subclass, propojení do kódu (outlets, actions)
- Views v kódu - CGRect, `addSubview()`, `removeFromSuperView()`
- ARC, strong/weak reference
- Frame vs. bounds
- Pixels vs. points (https://www.paintcodeapp.com/news/ultimate-guide-to-iphone-resolutions)

## 4. Autolayout
branch: `04-autolayout`
- CocoaPods.org pro third party knihovny
- autolayout v interface builderu
- autolayout v kódu (`NSLayoutConstraint`)
- autolayout pomocí **SnapKitu**
- `intrinsicContentSize` a `contentHugging/contentCompressionResistance`
- Úprava constraints v runtime (update konstant)
- jednoduché animování autolayoutu
- UIStackView

## 5. Recognizers + controls
branch: ???

`// TODO:`

## 6. Architektura aplikace (MVC, MVVM)
branch: ???

`// TODO:`

## 7. Controllers (Modal / Navigation / Tab / Alert / split / …)
branch: `07-view_controllers`
- `UIViewController` lifecycle
  - init
  - loadView
  - viewDidLoad
  - willAppear/Disappear, didAppear/Disappear
  - dealloc
  - https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/WorkWithViewControllers.html
- `UINavigationController`
  - Kontejner zajišťující "stack" navigaci mezi viewControllery 
  - Princip stacku - push/pop
  - `UINavigationBar`, `UINavigationItem`, `UIBarButtonItem`
- `UITabBarController`
  - Kontejner pro přepínání viewControllerů na stejné úrovni
  - `UITabBar`, `UITabBarItem`
- Modální prezentace VC
  - break aktuálního flow
  - present/dismiss


## 8. ScrollView + TableView + CollectionView
## 9. Networking
## 10. MapKit & Location
## 11. CoreData + Realm
## 12. Tooling, schémata, konfigurace apod.
