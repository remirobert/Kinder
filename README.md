<p align="center">
  <img src ="https://raw.githubusercontent.com/remirobert/Kinder/master/tindView/kinderBanner.png"/>
</p>
</br>
<br>


Written on Swift for iOS 7.0+.
<img src ="https://raw.githubusercontent.com/remirobert/Kinder/master/tindView/what.png"/>

It's a **UIViewController**, allows you to vote, to leave an opinion or know a point of view. The user must make a choice for each content, two possible, or view more information if necessary (dislike / like or deny / accept). Each content is represented by a **KinderCarView**.
The user has the choice between gesture or buttons.
Kinder is similar to the Tinder system. 

<br>
<p align="center">
  <img src ="https://raw.githubusercontent.com/remirobert/Kinder/master/tindView/animKinder.gif"/>
</p>
<br>
<br>

<img src ="https://raw.githubusercontent.com/remirobert/Kinder/master/tindView/how.png"/>

Kinder to a stack of content, only three of them are displayed.
Kinder uses **delegations** to informs action or seek more content.
You can gradually add content (**Lazy loading**).

<br>
Kinder protocol:
```swift
protocol KinderDelegate {
    func acceptCard(card: KinderModelCard?)
    func cancelCard(card: KinderModelCard?) // action signal
    func signalReload()                     // signal to load more data
    func reloadCard() -> [KinderModelCard]? //return your datas to the Kinder controller
}
```
