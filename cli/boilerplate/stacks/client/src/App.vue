<template>
    <div id="app-container">
        <Header />
        <main class="page page__scrollable">
            <router-view />
        </main>
        <Footer />
    </div>
</template>

<script lang="ts">
import { defineComponent } from "vue"
import Header from "@/components/HeaderComponent.vue"
import Footer from "@/components/FooterComponent.vue"

export default defineComponent({
    components: {
        Header,
        Footer,
    },
})
</script>

<style lang="scss">
#app-container {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  flex: 1 1 0;
}

body {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  font-family: Helvetica Neue, sans-serif;
  background-color: $lightColor;
}

.page {
  margin-left: $page_gutter;
  margin-right: $page_gutter;
  display: flex;
  justify-content: center;
  &__scrollable {
    margin-top: $header_height;
  }
}

/* http://meyerweb.com/eric/tools/css/reset/
   v2.0 | 20110126
   License: none (public domain)
*/

html,
body,
div,
span,
applet,
object,
iframe,
h1,
h2,
h3,
h4,
h5,
h6,
p,
blockquote,
pre,
a,
abbr,
acronym,
address,
big,
cite,
code,
del,
dfn,
em,
img,
ins,
kbd,
q,
s,
samp,
small,
strike,
strong,
sub,
sup,
tt,
var,
b,
u,
i,
center,
dl,
dt,
dd,
ol,
ul,
li,
fieldset,
form,
label,
legend,
table,
caption,
tbody,
tfoot,
thead,
tr,
th,
td,
article,
aside,
canvas,
details,
embed,
figure,
figcaption,
footer,
header,
hgroup,
menu,
nav,
output,
ruby,
section,
summary,
time,
mark,
audio,
video {
	margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	vertical-align: baseline;
}

/* HTML5 display-role reset for older filterrs */
article,
aside,
details,
figcaption,
figure,
footer,
header,
hgroup,
menu,
nav,
section {
	display: block;
}

body {
	line-height: 1;
}

ol,
ul {
	list-style: none;
}

blockquote,
q {
	quotes: none;
}

blockquote:before,
blockquote:after,
q:before,
q:after {
	content: '';
	content: none;
}

table {
	border-collapse: collapse;
	border-spacing: 0;
}

input {
	padding: 0.5rem;
	border-radius: 5px;
	outline: none;
	border: 1px solid #ccc;
}
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button {
	-webkit-appearance: none;
}
input[type='number'] {
	-moz-appearance: textfield;
}
select {
	font-size: min(100%, 16px);
}

</style>