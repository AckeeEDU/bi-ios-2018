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

- `UIScrollView`
    - slouží k zobrazení contentu většího než je velikost viewčka
    - vložím dovnitř `contentView`, jehož vnitřek musí být správně nalayoutovaný (top -> bottom, left -> right)
- `UITableView`
    - rozděleno do sekcí, buňky jsou v jednotlivých sekcích, identifikace buněk pomocí `IndexPath`
    - data se předávají přes `dataSource: UITableViewDataSource`, akce se odchytávají pomocí `delegate: UITableViewDelegate`
    - používá se `dequeue` buněk pro optimální výkon
    - selected a hightlighted stav změní background všech viewček v celle
    - lze vložit tableHeader, tableFooter, sectionHeader a sectionFooter
    - při nových datech lze tabulku refreshnout
        - `tableView.reloadData()`
        - `tableView.reloadAtIndexPath(:)`
        - `tableView.reloadSection(:)`
- `UICollectionView`
    - buňky nejsou přes celou šířku view, velikost je definovaná pomocí property nebo delegate metody
    - v rámci layoutu lze udělat naprosto všechno
    - selected stav na buňce je potřeba si ošetřit samostatně
    - stejně jako tabulka se používá dequeue

## 9. MapKit & Location
branch: `09-maps`

- frameworky MapKit a CoreLocation
- `MKMapView`
- `CLLocationManager`
  - získání povolení od uživatele (`NSLocationWhenInUseUsageDescription` v Info.plist)
  - start/stop získávání pozice
  - `CLLocationManagerDelegate`
- protokol `MKAnnotation`
- správa pinů na mapě, custom piny
- callouts
- geocoding/reverse geocoding - překlad GPS lokace na adresu a zpět

## 10. Networking
branch: ???

`// TODO:`

## 11. Firebase & CoreGraphics
branch: `11-coregraphics_firebase`

- `drawRect`, kreslení pomocí CoreGraphics
- konflikty mezi gesture recognizery
- Firebase
  - setup SDK, inicializace
  - práce s realtime DB
  - CodableFirebase (https://medium.com/@alickdikan/easy-custom-models-and-firebase-in-swift-4-with-codable-43bdb7805b31)
- jednoduchý example lokalizace

K lokalizaci storyboardů jsem si nakonec vzpomněl, že vlastně něco vím 💡 Zde zajímavé nápady jak to dělat sexy 😉
https://medium.com/@mario.negro.martin/easy-xib-and-storyboard-localization-b2794c69c9db
https://github.com/strvcom/localizenib-ios

## 12. CoreData
## 12. Tooling, schémata, konfigurace apod.
