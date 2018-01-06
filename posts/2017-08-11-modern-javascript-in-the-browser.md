---
layout: post
title: "Modern Javascript in the Browser"
author: sebastien
locale: "en"
labels:
  - tutorial
thumbnail: 2017-08-11-modern-javascript-in-the-browser.jpg
description: |
  When it comes to working with JavaScript in the browser, there is only 3 concepts you need to master. DOM selection, Event Handling and AJAX
---

When it comes to working with JavaScript in the browser, there's three concepts you need to master. First, you should know how to **select and query** elements in the DOM, and store them in variables. Then, you should be able to **add event listeners** to some elements to react to specific events. At last, you should know how to perform AJAX requests to **fetch** some information after the initial page load.

## 1 - DOM Selection

Suppose you have the following HTML:

```html
<ul id="cities">
  <li class="europe">Paris</li>
  <li class="europe">London</li>
  <li class="europe">Berlin</li>
  <li class="asia">Shanghai</li>
  <li class="america">Montreal</li>
</ul>
```

The easiest way to select a DOM element is using its `id` attribute:

```js
const list = document.getElementById("cities");
```

There is another way, using a CSS selector:

```js
const list = document.querySelector("#cities");
```

Those two methods will always return a **single** element. Guaranteed. If you want to select all the `li`s with the `europe` class inside your list, you will use a fancier CSS query selector:

```js
const europeanCities = document.querySelectorAll("#cities .europe");

europeanCities.forEach((city) => {
  city.classList.add('highlight');
});
```

In the code above, notice that `querySelectorAll` **always** returns a [**`NodeList`**](https://developer.mozilla.org/en-US/docs/Web/API/NodeList) (which may contain only one element). You can call the `forEach` method on this list. We also used an [ES6 arrow function](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Functions/Arrow_functions) which has a [wide support](http://caniuse.com/#search=arrow%20function). You should consider [Babel](https://babeljs.io/) to support the remaining ones or revert to a classic anonymous `function` definition.

To walk the DOM from a given element, have a look at [parentElement](https://developer.mozilla.org/en/docs/Web/API/Node/parentElement), [children](https://developer.mozilla.org/en-US/docs/Web/API/ParentNode/children) and [nextElementSibling](https://developer.mozilla.org/en-US/docs/Web/API/NonDocumentTypeChildNode/nextElementSibling). It's a big family tree!

## 2 - Binding and handling Events

The browser is a Graphical User Interface (GUI). It means that a user will interact with it, and you can't predict what her action will be. Will she click on button A first? Or scroll a bit to click on this link? Or hover that image?

When using a website, the browser emits tons of events. Every time you scroll one pixel down with your trackpad or mouse, a [`scroll`](https://developer.mozilla.org/en-US/docs/Web/Events/scroll) event is fired. You can test it yourself! Open your Browser Console (using the Web Inspector) and type this JavaScript line (then press Enter):

```js
document.addEventListener('scroll', () => console.log(document.body.scrollTop));
```

And now, scroll! Crazy isn't it? Each event logged represents one pixel scrolled down or up since the page was loaded

Suppose you have the following HTML:

```html
<button id="openModal"></button>
```

You can bind a **callback** to the `click` event on that button with the following JavaScript code:

```js
const button = document.getElementById('openModal');
button.addEventListener("click", (event) => {
  console.log(event.target);
  // `event.target` is the element on which the user clicked

  alert("You clicked me!");
  // TODO: implement a modal opening logic instead of this alert :)
});
```

You can read more about [`addEventListener`](https://developer.mozilla.org/en-US/docs/Web/API/EventTarget/addEventListener) on the MDN web docs 👌

## 3 - AJAX

AJAX is the cornerstone of the modern Web. Thanks to this technology, a web page can be refreshed in the background with new information. You can think of Gmail's new emails showing up in the Inbox, Facebook notifying you that new content is available in your timeline, etc.

With modern web browsers, we can use [`fetch`](http://caniuse.com/#search=fetch). Here is an example of calling a JSON API with a `GET` request:

```js
fetch(url)
  .then((response) => response.json())
  .then((data) => {
    console.log(data); // data will be the JSON fetched from the API
  })
```

Sometimes, we need to `POST` information to an API:

```js
// Some info to POST
const payload = { name: 'Name', email: 'Email' };

fetch(url, {
  method: "POST",
  headers: {
    "Content-Type": "application/json"
  },
  body: JSON.stringify(payload)
})
  .then(response => response.json())
  .then((data) => {
    console.log(data); // JSON from the API response.
  });
```

## Conclusion

You can now combine these three techniques to create dynamic web pages! You will select elements thanks to one of the three methods (`getElementById`, `querySelector` or the one returning an `NodeList`: `querySelectorAll`). With an element at hand, you can `addEventListener` on a given event type (`click`, `focus`, `blur`, `submit`, etc.). The callback passed to this listener could contain an AJAX call using `fetch`.

Happy JavaScripting!
