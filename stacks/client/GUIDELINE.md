# Guidelines for writing the client

## Adding new static file
Static files are added to the `assets` folder, and are served to the client.

**Note:** normalize the filename, it should not contain any special character, and should be kebab-cased (eg. `just-a-steack`), if you're not sure, use [this tool](https://slugify.online/).

If it's an image you could use it like:
```html
<img src="@/assets/images/my-favorite-super-hero.gif" />
```

## Creating Components
We use the [declaration API](https://v3.vuejs.org/api/composition-api.html) to create components, please see example in `/components` sub-folder before getting started.

## Styles
1. Font: Helvetica Neue
2. Always add `background: white;` to body.

## Behaviors
1. Each page should have an URI associated, and the URI should be the same as the folder name.
  exemple: `/home` should be associated to `/views/home.vue` while `/about/contact/email` should be associated to `/views/about/contact/email.vue`.
  This way, we can use the `router` to navigate between pages and we can reaload the browser at any stage and still be on the same page.
2. Each page should have a `back button` (`<router-link to="/my-back-uri-path">`) to go back to the previous page, this back strategy should not depend on any other datas than the current URI, else it won't work if we come from the URL directly (not following the full path from `Home`).
  You are free to create your own `path` (url) state strategy according to the mission needs. However, if you do not comes up with a 'good enough one', contact us, we'll think about it together.
3. Default router mode is [`hash-mode`](https://router.vuejs.org/guide/essentials/history-mode.html), that's what we want, do not change it please.
4. External link should be opened in a new tab (`target="_blank"`) and should not refer (`rel="noopener noreferrer"`).
5. External link on mobile should be in a [`deeplink`](https://neilpatel.com/blog/mobile-deep-linking/), you juste have to add `href="medics://viewer?m_source=MY_LINK_HERE"` to the `a` tag.
  In order to check if we're on mobile, we provided a function ```isMobile()``` in the `helpers` folder. Here is an example on how to use it:
    ```html
    <a rel="noopener noreferrer" v-if="!isMobile()" :href="LINK" target="blank">TEXTE</a>
    <a rel="noopener noreferrer" v-else :href="'medics://viewer?m_source=' + LINK">TEXTE</a>
    ```
    Note: Once you've implemented this, you might experience issue with devtools, just ignore them and consider the link is working.
5. On mobile only, you have to show a close button to close the webview:
    ```html
    <a v-if="isMobile()" href="cmd://webview-close">
      <img src="@/assets/close.svg" >
    </a>
    ```

## Datas
You will either have static or dynamic datas, depending on the needs of the project.

However, if you're using static datas, we recommand to use a smart data structure that fits the project needs. Exemple:
```json
{
  "appData": {
    "title": "My App",
    "description": "My App Description",
    "keywords": "My App Keywords",
    "author": "My App Author",
  },
  "tree": {
    "id": 1,
    "name": "Title 1",
    // ...
    "children": [
      {
        // ...
      },
      // ...
    ]
  }
}
```

## Pdf Viewer
If the application is showing `pdf` file(s), we recommend to use our pdf viewer in an `iframe`, here is an example:
```html
<iframe
 src="https://f.360medics.com/pdfviewer/index.html?f=https://med-cdn.ams3.digitaloceanspaces.com/assets/docs/dir69000-69299/69062/main-69062.pdf"
 width="100%"
 height="xxx"
 frameborder="0"
 scrolling="no"
 allowfullscreen="true"
 ></iframe>
```
Note: You just have to paste the origin `pdf` URL after `https://f.360medics.com/pdfviewer/index.html?f=`

### Alternative (when you want to open up a new page with PDF)
In order to open the PDF on a new page (new tab), create a link (`a`) that redirects to the PDF file (`href="LINK"`). On mobile, you have to use a `deeplink` as explained in the `Behaviors` section.