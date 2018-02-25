---
layout: post
title: "WeChat Mini Games Are Making Noise! How Can Developers Get Started Quickly?"
author: dounan
locale: "en"
labels:
  - wechat
thumbnail: 2018-02-24-20-wechat-mini-game-cover.png
description: |
  This article introduces WeChat Mini Games development and explains what they are, how to make them, and where they are heading.
---

![Tiao yi Tiao](blog_image_path 2018-02-24-01-tiaoyitiao.jpg)

When WeChat’s version 6.6.1 launched, a popup greeted users: “Playing a Mini Game is what matters.”  Suddenly, your friends were all playing the viral WeChat Mini Game "Tiao Yi Tiao" or “Jump and Jump.” 

**This article introduces WeChat Mini Games development and explains what they are, how to make them, and where they are heading.**

> *Important: At the time of this article, the WeChat platform has not opened release of Mini Games to the public. You can only experiment with this technology and play with the using the "Experience Mini Games" feature that comes with WeChat Development Tools (see part 4).* 

But don't worry, the WeChat team should open the Mini Game category to all developers eventually.

### Table of Contents:

- Mini Game Landscape
- Overview of Development 
- Low-level Development Understanding 
- Quick Start: Build and Debug Mini Games!
- Market Outlook: The future for Mini Games?
- Le Wagon’s perspective

## 1. The WeChat Mini Game Landscape

**What are the games available?**

So far there are *17 WeChat Mini Games released*, including six popular chess/card games.

![17 WeChat mini games released](blog_image_path 2018-02-24-02-released-mini-games.jpeg)

**How do you start playing these Mini Games?** 

Players enter the Mini Games mainly through these channels: 

- Invitation from friends or WeChat groups
- Scanning the game QR code 
- Recently played games displayed in Mini Program history, or after pulling down the chat inbox
- Discover > Mini Program, then search for a Mini Game
- Discover > Games > My Mini Games, then search for “小游戏” (Mini Game)

![How to start playing games](blog_image_path 2018-02-24-03-entry-mini-games.jpeg)

![How to start playing games](blog_image_path 2018-02-24-04-entry-mini-games.jpeg)

Searching for “小游戏” (Mini Game) will display a short list of Mini Games. Clicking on “show full list” takes you to a hidden Mini Games menu categorized by the hottest games and games friends are playing.

![How to start playing games](blog_image_path 2018-02-24-05-entry-mini-games.jpeg)

**How were these games built?**

From a technical perspective, WeChat Mini Games framework added gaming library APIs to the Mini Program framework. As a result, Mini Games can only run in the Mini Program environment, and they are neither native games nor HTML5 games. 

That being said, Mini Games are closely associated with HTML5 games and targeted towards HTML5 game developers -- adopting WebGL, JavaScript, and other HTML5 technologies to a large extent, which minimizes the work in turning HTML5 games into WeChat Mini Games. 

![Comparison games types](blog_image_path 2018-02-24-06-comparison.jpeg)

**In a nutshell, WeChat Mini Games:**

1. Run in the WeChat environment 
2. Use HTML5 and related web technologies 
3. Provide a gaming experience similar to native games.

**Advantages**

WeChat Mini Games have many advantages over other types of games. The two biggest advantages are *stability and manageability. *

- Compared to native games, WeChat’s app serves as a self-contained platform that keeps users in the WeChat ecosystem. 
- Compared to HTML5 games, Mini Games players won’t be disturbed by popup advertisements, leading to a better experience.

A major advantage of the WeChat Mini Game environment is its compatibility with the HTML5 game ecosystem. In other words, *HTML5 games can be more easily converted into WeChat Mini Games*, no matter which game engine you used to develop them. This enables WeChat Mini Games to leverage the power of the large, existing HTML5 ecosystem.

In addition to tech strengths, WeChat Mini Games takes advantage of the fact that it is the most popular social platform in China with the ability to make apps viral. A crucial part of the *Mini Game design is to utilize the social aspect of WeChat to acquire new users*. 

WeChat Mini Games are discovered mainly through friends' recommendations or shared links. This makes Mini Games very different from previous web games that acquire users through ads or traditional channels that lead to app stores or download links.

**Conclusion**

WeChat Mini Games combine strong acquisition channels, social gaming and sharing, and a huge user-base -- all while enjoying near-native app experience without downloading anything.

All these features show a bright future for WeChat Mini Games. Now it’s up to you, game developers, to take advantage of this opportunity and create games most suitable for WeChat users!

## 2. The basics of developing a WeChat Mini Game

As mentioned above, the development of Mini Games involves HTML5, and developers familiar with that will get a quick start - turning HTML5 games into WeChat Mini Games in a short amount of time. 

More specifically, WeChat Mini Game development technologies can be divided into three parts:

![WeChat mini games technologies](blog_image_path 2018-02-24-07-technologies.jpeg)

### Part 1. Low-level Technologies

First, the programming language -- WeChat Mini Games only supports JavaScript (the main programming language of the Web), but also languages that can be compiled to *JavaScript*, such as *TypeScript* and *CoffeeScript*. 

Second are the JavaScript APIs (application programming interfaces) that the WeChat Mini Games framework supports: *Canvas 2D* and *WebGL 1.0*.  Any of these APIs can be used to draw graphics, create animations, or render in real time. But you don’t want to use more than one technology at the same time. Also note that only WebGL supports 3D rendering.

### Part 2. Middleware: Game Engine

There is a steep learning curve to making Mini Games using Canvas 2D or WebGL directly. Since you probably don’t want to spend more than a year developing just one game, using an HTML5 game engine is a very smart choice. The high-level functions that the game engine provides can greatly reduce the barrier to entry for developers and shorten their development time. 

Already, the three major game engine makers in China: *Cocos Creator*, *Egret*, and *Laya* support WeChat Mini Games. For now, popular foreign HTML5 game engines such as *Phaser.js*, *Three.js* do not yet offer direct support, but can still be used with adaptations (like this [Phaser port for Mini Games](https://github.com/littlee/wechat-small-game-phaser)).

![WeChat mini games engines](blog_image_path 2018-02-24-08-engines.jpeg)

### Part 3. WeChat SDK (software development kit)

WeChat Mini Games provide a wide range of tools for developers to use WeChat features such as WeChat login, sharing, leaderboards, and other social functions.

**Mini Game Social Feature Case: Friend Ranking**

![WeChat mini games leaderboards](blog_image_path 2018-02-24-09-leaderboard.jpeg)

> Leaderboards showing scores from your friends. From YueDong Yinfu (left) and XingTu WeGoing (right).

Players can form a team by simply sending a game invitation to their friends through a WeChat message. With one click they can open the game and join the team! This makes the team-building more convenient than ever.

**Mini Game Social Feature Case: Sending Invitation**

![WeChat mini games sending invitations](blog_image_path 2018-02-24-10-sending-invitation.png)

> It's super easy to invite friends to join a mini game. This invite button is from "Happy Tank Battle".

**Mini Game Social Feature Case: Receiving Invitation**

![WeChat mini games receiving invitations](blog_image_path 2018-02-24-11-receiving-invitation.png)

> Friends who receive an invitation then simply click to start the game and join the team. No signups or downloads needed!

This “forward-to-friend" + "click-and-play” mechanism enables a whole new world of social gaming. Strangers from Wechat Groups can also join in by clicking group invites. This allows multiplayer games that can be turn-based or live action.

![WeChat mini games multiplayer](blog_image_path 2018-02-24-12-multiplayer.gif)

> Tiao Yi Tiao also has a multiplayer version that allows inviting up to 9 friends

## 3. Understanding the Low-level Structure of WeChat Mini Games

Mini Games are neither native games nor equivalent to HTML5 games. However, its development environment relates to both types of games. Mini Games use the same rendering interfaces of HTML5. 

**But how do Mini Games relate to native games?**

Let us explain the relationships with a diagram:

![WeChat mini games framework](blog_image_path 2018-02-24-13-framework.jpeg)

Mini Games actually run in the WeChat App’s native environment. The JavaScript code of the game is *not executed in a browser* environment, but an independent JavaScript engine on the JS VM layer of the mobile device. On the Android platform, it uses *Google's V8 engine* while on iOS it uses *Apple's JavaScript Core engine*. 

Of course, the JS (JavaScript) engine is only responsible for the compilation and running of the JS logic but does not have rendering interfaces. 

**How do Mini Game developers connect their games to the rendering interface, and to many other functions available in the WeChat framework?** 

![WeChat mini games framework](blog_image_path 2018-02-24-14-framework.jpeg)

In comes JS-Native script bindings. This technology can bridge native language interface (iOS / Android libraries) to a script interface (JavaScript libraries) and forwards API calls from the script layer to the native layer to use native platform functions.

WeChat JavaScript SDK already is using binding technology to allow WeChat Official Accounts and Mini Programs to reach native device functions like photo album and sensors through JavaScript APIs. 

WeChat Mini Games also use binding technology to connect the services from the native platform (iOS / Android):  rendering, user data, networking, audio, and video to a JavaScript environment. This is how the Mini Game layer module accesses the native functions in the diagram above.

By supporting a JavaScript environment, WeChat thus provides a framework that allows HTML5 games to be converted to WeChat Mini Games. But some API compatibility issues might arise from the lack of a real browser environment and DOM.

In order to reduce the cost of converting HTML5 games to Mini Games, *WeChat team also provided an “Adapter” script to support browser APIs*. Most browser functions needed by HTML5 games are supported - thus improving compatibility. 

![WeChat mini games framework](blog_image_path 2018-02-24-15-framework.jpeg)

**The Adapter script provides most browser interfaces that HTML5 games rely on.** 

The diagram above shows all the interfaces available to developers in WeChat Mini Games

* Rendering interface
* Browser Adapter interface
* WeChat API for WeChat Services

Note that the Browser Adapter interface is no longer officially maintained, so any additional functions are up to the developers. Also most of its functions that rely on the DOM do not work in the Mini Game environment. 

**Using Game Engines**

Because of the intricacies of the development stack, one option is to use game engine to develop Mini Games. The game engine not only encapsulates common gaming functions on a high-level interface but also tries to eliminate the incompatibilities between games in the H5 Browser and the WeChat Mini Games environment. 

![WeChat mini games framework](blog_image_path 2018-02-24-16-framework.jpeg)

Developers might need to work with different layers of libraries - depending on the complexity of the game. When using a game engine, it provides the functionalities at a high level to the developer, while calling those same libraries. The developer then needs to learn the engine, and handle cases for when the engine does not provide all the functions needed.

Here is a summary of benefits game engines provide:

Framework features:

* High-level encapsulation of common game development features
* Resource loading
* Event processing
* Media and broadcasting
* Screen display and control
* User input
* Additional interfaces, such as DOM Parser for TileMap

Editor: 

* Optimizes collaboration between the programmer, designer, and manager. 
* A good game editor can significantly shorten the development cycle. 

General: 

* Excellent game engines can provide high device compatibility and stable performance; 
* Cross-platform game engines can allow developers to publish a HTML5 game, a WeChat Mini Game, and a native game at the same time.

Highly-efficient game editors can bring down development cost and maintenance cost. For game developers, these factors can be the key to profitability.

![WeChat mini games game editor](blog_image_path 2018-02-24-17-game-editor.jpeg)

## 4. Start building and debugging Mini Games!

### Step 1. Get WeChat Developer Tools

The WeChat Mini Program Developer Tools provides the framework to code, debug, and run your Mini Game. [Download here](https://mp.weixin.qq.com/debug/wxagame/dev/devtools/download.html) on the wechat developer site.

When you first run the developer tools, you will be asked to sign in with your WeChat account. Then you will see the form to create your first project. 

Click on: “小游戏” to the right of “体验” (Try: Mini Games)

And select a location for the source code 项目目录, then name your project under 项目名称. 

![WeChat mini games quickstart](blog_image_path 2018-02-24-18-quickstart.jpeg)

Here is the basic layout of the Developer Tool for WeChat Mini Games development:

![WeChat mini games IDE](blog_image_path 2018-02-24-19-layout-IDE.jpeg)

* At the top of the page is the toolbar. It can configure, compile, preview, and deploy the game. 
* On the left is the simulator. Game runs and updates as the code changes.
* On the upper right is the code editor. 
* To the left of the editor is the file menu. It lists the project files.
* On the lower right is the debugger. Its functions are similar to the Chrome developer tool! 


### Step 2. WeChat game configuration and file importing

In the WeChat Mini Game project, add the configuration file *project.config.json* and *game.json*. 

- *project.config.json* defines your game AppID, name, version, IDE settings, and runtime configurations. 

- *game.json* provides configurations internal to the app and code, for example device orientation and network timeout. This is similar to the *app.json* file in WeChat Mini Programs!

Since Mini Games do not support HTML files, the entry point is in *game.js*. You can start the game by bringing in the game engine and game scripts into the *game.js* file with the require function. Note: The usage of *require* function follows the specification of Node.js!

### Step 3. Compile, Test, and Submit

The WeChat development tool will monitor changes in the scripts and configurations and update the game live. You can also click the compile button at the top of the page to manually recompile. When you need to preview the game and test on your smartphone, you can click the preview button to generate a QR code and scan to play the game! 

The process of generating a QR code is actually compressing and uploading a small package to the WeChat CDN, so it will take some time. 

If WeChat Mini Games follow the same distribution rules as Mini Programs, then WeChat will likely review Mini Games after they are submitted - before they can be released publically. There will also be rules on how Mini Games can be discovered or shared like with Mini Programs.

## 5. The market for WeChat Mini Games and future outlook

In terms of market, the HTML5 development stack, which is favored by WeChat Mini Games, has a great potential. 

Many JavaScript game engines support cross-platform games. Take Cocos Creator for example: **you can code the game in their editor and seamlessly publish as an HTML5 mobile web  game, HTML5 PC web game, mobile native game, and WeChat Mini Game.** 

> According to the CNG 2017 gaming industry report, the Chinese market size for native mobile games is 116 billion RMB. 

PC games and PC web game markets are 65 billion RMB and 16 billion RMB respectively. Therefore, assuming same proportion of web games to total for PC and mobile platforms, the market size for mobile web game is  28 billion RMB each year (from ratio of PC games that are web-based times the whole market size for mobile games). 

Considering that Flash will stop support after 2020, a large number of PC web games will be switching to the HTML5 technology, with many native mobile games as well following the trend towards lighter client-side apps.

Game developers who want to enter this field would be smart to master the HTML5 development stack, and social gaming techniques (from WeChat, QQ, Facebook). They should also truly understand each social network’s users to leverage each of these unique social platforms.

## 6. Le Wagon’s perspective

**Mini Games are bringing more people into gaming**

WeChat Mini Games expand the already lucrative gaming market - and despite limits of H5 games - they could bring gaming to more people - even just the bottle-flipping, fidget-spinning kind. With social functions like form teams with friends and the ease of launching on the spot - WeChat Mini Games could open new niches for gaming in time people usually spend idle.  

Exchanging games amongst users in WeChat, in addition to messages, stickers, videos, and money, adds one more dimension to connecting people together. Its yet another way that WeChat is becoming the platform for people’s lives.

WeChat already has 980 million users globally - each a potential gamer. The Jump and Jump game attracted 400 million players in less than three days. It’s a reason that gaming powerhouses like Ubisoft are partnering with Tencent, bring its diverse portfolio of successful games from Ketchapp (who popularized the viral game “2048”) to increase its reach in China. 

With Google Play app store blocked, there is a need for centralised app distribution for Android users. WeChat could meet this need, or work together with native app stores - the simplified Mini Games can be great teasers for original native app store games. 

**Mini Games are bringing more developers and businesses into games**

WeChat Mini Programs attracted 1 million developers producing over 580,000 Mini Programs in just one year, compared to the 500,000 mobile apps that Apple's App Store published from 2008 to 2012. Could this be the same path for Mini Games? 

Social entrepreneurs can leverage WeChat Mini Games and use game elements to solve problems in everyday tasks socially. For example recycling could earn you gaming credits if you scan a Mini Game code at a deposit bin that launches a slot machine game. The speed of accessing the app when you need it puts Mini Games in the perfect position because they can be run instantly within WeChat from any phone, opened by the context of the task. This saves users from searching through an app store of a specific operating system and then waiting to download and register for an account. 

Connecting WeChat and the real world in more powerful ways.

As the founder of WeChat said, "The Mini Program is a new product model which can seamlessly link the offline and the online together." The real value and purpose of WeChat Mini Programs lies in empowering online to offline transactions and interactions. Could WeChat Mini Games be another way to link offline and online together? There are many ways it could add games to the real world - maybe playing for a free ticket while waiting at bus stop, or playing to win a coupon while waiting at a restaurant?

One thing is for sure, with an estimated 550 million players in the country, China is already the largest and most profitable gaming market in the world. WeChat Mini Games could improve on these already impressive stats, and add another unique twist to China’s digital landscape. 

> This article was written by Ling Huabin, translated and expanded by Le Wagon China

**About Ling Hua Bin**

Ling Hua Bin, Cocos Creator main programmer, Game Jamer, player. He was responsible for Cocos2d-JS, heat update framework, JSB framework. Now he is mainly responsible for the WeChat Mini Game publishing process and Cocos Creator engine renderer architecture. 

**About Le Wagon China**

Le Wagon is a global coding bootcamp and network of tech professionals founded in Paris in 2013, operating in Chengdu and Shanghai since late 2016. They offer an intensive nine-week training program that was awarded Best Coding Bootcamp 2017 by the rankings site Switchup.org. 

In only two months, students build several web apps, including an Online-to-Offline (O2O) platform, and a minimal-viable-product (MVP) for their own startup idea. They also learn how to develop within the Chinese internet ecosystem, including how to build highly sought after WeChat mini programs (小程序). Students deploy these apps and build a solid portfolio which they can use to apply to jobs and internships, as well as kickstarting their own businesses.

Le Wagon's 2500+ graduates have a track-record in founding successful startups or becoming project managers, front or back-end developers, freelance WeChat mini program developers. They work at companies in Chengdu, Shanghai, Ningbo, Hong Kong, Taiwan and much more.

**Sources**

- https://www.cnbc.com/2018/01/22/tencent-WeChat-mini-program-push-takes-aim-at-apple-and-google.html
- https://www.linkedin.com/pulse/what-brands-missing-new-gaming-trend-china-emilie-arrouf/
- https://36kr.com/p/5119078.html
- https://mp.weixin.qq.com/s/B0CrpLbVfnECatgwPES3fQ













 
























