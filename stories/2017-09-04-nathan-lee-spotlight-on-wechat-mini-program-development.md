---
layout: story
title: Spotlight on Wechat Mini Program Development
alumnus_github_nickname: kwnath
date: 2017-09-04T08:12:24Z
cover_picture: https://d1gofzrmx0fcbg.cloudfront.net/development/stories/pictures/000/000/020/cover/nathan-lee.jpg?1504512744
company_slug: freelancer
---

Nathan Lee is a Le Wagon alumni from **batch 76** in Shanghai. Before he was working at a **Fin Tech startup**, but he wanted to combine **creativity** in a more **analytical way** in his career. After 2 months' dedicated study, now shortly after finishing the bootcamp, Nathan successfully landed several freelance projects of building **wechat mini programs** while receiving other **offers as developers**.

We conducted an interview for Nathan to provide some **personal insights** on the development of wechat mini programs, including the **potential difficulties**, **useful toolkits** and **tricks** etc.

## Where and how did you learn to develop mini programs?

I started off learning the basics when I was a student at Le Wagon, such as, how to setup the WeChat IDE, what are the capabilities and some quick introductions to the APIs through quickly diving into building a mini program with a team. Luckily enough for us, Le Wagon had a white book for WeChat mini programs to help explain most of the fundamentals that we could quickly use to develop our own apps, and later dive deeper into the Chinese documentation. Even though our Chinese wasn’t the best, we were familiar enough with the concepts taught to us during the bootcamp to quickly understand **what API’s were available** and **how to utilise them**.
v
Good news is, WeChat team has just added an [English version of developer documentation for Mini Programs on open.wechat.com](http://open.wechat.com/cgi-bin/newreadtemplate?t=overseas_open/index).

What sparked my interest in mini programs was the fact that it is accessible to everyone using WeChat, requires **no download, no commitment** and we can rest assured the app is **always up-to-date**. Which was great to me, it meant we could just push the latest version without worrying about support legacy versions!

![Picteam](https://mmbiz.qpic.cn/mmbiz_png/qeODRF2RsrYNJ7A7sOx3JZvAEpYJXFmwVHLvLJmtYFOaxfoNvEiax5V6PqaA7VibbdfP2zySYmAPJG5kWIfMFiaiaA/0?wx_fmt=png)


## Did you take on any projects shortly after the bootcamp?

Right after the bootcamp I wanted to continue the intensity that I had at Le Wagon and keep the momentum going.  Through WeChat groups, I got involved in the mini program community in Shanghai, which led me to the freelance jobs I have now. Developing mini programs is still a relatively new thing, so many companies were willing to take me on to start their new projects.

To name a few, **Night+** was one of the startups looking to expand their reach through the mini program environment. Their whole app revolved around showing you the best deals for KTVs, bars and clubs. Another company, **Maijin**, was looking to create a mini program for generating sales leads.

With Night+ I was introduced to a new framework, which I would not have even heard of had I not taking these freelance projects. Because they were very early into development, we had the freedom to explore different kinds of frameworks and decided it would be best if we went with something similar to VueJS called Wepy.  Which is amazing because it allowed you to create sustainable and organized code by **promoting component division, reusability** and so on.

What was surprising to me was that although I was working with experienced developers, not many of them had that **mentality of writing reusable code**. Instead they would write long lines of code onto one file, as opposed to splitting them into components for the sake of reusability. So I decided not to follow that route and took more time to organize them into components and save time in the future by also creating documentation for each component; what parameters they use, how to use them, etc.

One of the greatest satisfactions being a developer is when you’re being complimented for your efforts:

![Being complimented for your efforts is always nice](https://raw.githubusercontent.com/lewagon/www-images/master/testimonials/nathanlee/nathan-lee-messaging.jpg)

In the end, I learnt a lot from taking on these projects, it helped me solidify the knowledge I had, introduced me to new frameworks and developed my understanding of  software engineering in general.

![Nathan first projects](https://raw.githubusercontent.com/lewagon/www-images/master/testimonials/nathanlee/nathan-lee-apps.jpg)

## What toolkit do you recommend to produce MPs?

If you’re just learning the in’s and out’s of mini programs, it’s best to stick with the WeChat IDE editor until you feel like you know it like the back of your hand, because it does offer the convenience of snippets and shortcuts to train your familiarity with the syntax.

However, having said that I personally do not like the WeChat IDE editor because it’s quite restrictive, there are functions I love to use in VS code or sublime that the editor just doesn’t have. For example, searching through files is a pain, you have to click and find the file, when it’s much easier to just “cmd + t“ in sublime. Another huge thing is split layouts which you can’t do on the editor, which is a shame because you’re constantly passing data from the logic layer to the view layer. Once you do get more familiar you can **combine the WeChat IDE (just for its display) with either VS code or sublime.** Both editors have an extensive range of snippets and auto-completion for mini program development.

- [WeChat Miniprogram wiki](https://github.com/apelegri/wechat-miniprogram-whitebook)
- [VScode snippets for wechat miniprograms](https://marketplace.visualstudio.com/items?itemName=qinjia.vscode-wechat)
- [VScode snippet for WXML files](https://marketplace.visualstudio.com/items?itemName=coderfee.vscode-wxml)

## What are the main issues you faced when developing a mini program?

There was mixture of difficulties I had, the first was picking up a new framework when I had only just got the hang of using Rails and the second was understanding what the documentation was trying to tell me!

There was definitely a lot of copy and pasting at the very start of our final project at Le Wagon because we were simply clueless. However, as more familiar we got with the **javascript ES6 syntax and concepts, reading the documentation** really started to help. We started to understand more about what the functions or API calls were actually doing. This gave us more knowledge to develop our ideas to explore crazier options and most importantly ask better questions. When we knew what we needed it was much easier to ask a question that would guide us to the right answer.

Additionally, I personally felt that **making mistakes early on in the project (and I made a ton) was a good thing**, it mean’t that I was able to debug things much quicker as I’ve either seen it before or know how the API works enough to debug it.

Having said all this, a majority of it was **trial and error**. If it didn’t work I would approach it another way, if it still didn’t want to work, I would try other ways or using other API’s that would still achieve the same result. And one of the things that helped massively was **pair programming**. I was able to learn a lot simply from understanding how other people worked, how they approached the problem and integrating it with how I solved my problems.

![Pic Coding](https://mmbiz.qpic.cn/mmbiz_jpg/qeODRF2RsrYwsyvhNGJFTiagE4ADrF6gfsaboxNItJhNeSsgky9TMLKtxLHMASY2cCbRAPS3r11sX2ib5TBIeHQQ/0?wx_fmt=jpeg)

## What are your suggestions for developers jumping into this new framework?

I learned the best when I just dove in and created an app and ran into a ton of errors. Not only did I become better at searching for the issue I was having, it gave me a deeper understanding of the connections between components, the architecture of the framework and now it makes it much easier to debug because I have either run into the error before or I know how it works to solve it.

> Read  enough of the documentation to create an app. Improve the app.

## What other inspirations did you gain in terms of web/ mini app development?

Definitely learning new frameworks, or learning in general, I felt more empowered to learn a new framework as I felt that I got better at reading documentation and understanding how to utilise and learn from it.

I am also more willing to dive into making an app to practice using the framework, using the documentation as a reference (not only purely as reading material) because I felt it was the best way for me to learn, making mistakes and learning from them. Additionally, I think reading just enough of the documentation where you can create a simple app is key and then trying to build on that with new features to improve your app to extend yourknowledge and give you more incentive to read the documentation.

Oh, and also giving functions/ variables proper names. I look at my code now and think, wow, who could possibly understand this but me. **Naming things is definitely important.**

![pics Batch 90 Demo day](https://mmbiz.qpic.cn/mmbiz_jpg/qeODRF2RsrYUZicMicnrVZ7JeGXYf3VfUrOZdeEF3OTicAzmACm6lFdNE90Iaib0dYCPyntyzWrEibD9DkOAibmGKibHw/0?wx_fmt=jpeg)

**Nathan Lee Wechat ID**: kwnath
