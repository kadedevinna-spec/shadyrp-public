/*! jQuery v3.7.1 | (c) OpenJS Foundation and other contributors | jquery.org/license */
!function(e,t){"use strict";"object"==typeof module&&"object"==typeof module.exports?module.exports=e.document?t(e,!0):function(e){if(!e.document)throw new Error("jQuery requires a window with a document");return t(e)}:t(e)}("undefined"!=typeof window?window:this,function(ie,e){"use strict";var oe=[],r=Object.getPrototypeOf,ae=oe.slice,g=oe.flat?function(e){return oe.flat.call(e)}:function(e){return oe.concat.apply([],e)},s=oe.push,se=oe.indexOf,n={},i=n.toString,ue=n.hasOwnProperty,o=ue.toString,a=o.call(Object),le={},v=function(e){return"function"==typeof e&&"number"!=typeof e.nodeType&&"function"!=typeof e.item},y=function(e){return null!=e&&e===e.window},C=ie.document,u={type:!0,src:!0,nonce:!0,noModule:!0};function m(e,t,n){var r,i,o=(n=n||C).createElement("script");if(o.text=e,t)for(r in u)(i=t[r]||t.getAttribute&&t.getAttribute(r))&&o.setAttribute(r,i);n.head.appendChild(o).parentNode.removeChild(o)}function x(e){return null==e?e+"":"object"==typeof e||"function"==typeof e?n[i.call(e)]||"object":typeof e}var t="3.7.1",l=/HTML$/i,ce=function(e,t){return new ce.fn.init(e,t)};function c(e){var t=!!e&&"length"in e&&e.length,n=x(e);return!v(e)&&!y(e)&&("array"===n||0===t||"number"==typeof t&&0<t&&t-1 in e)}function fe(e,t){return e.nodeName&&e.nodeName.toLowerCase()===t.toLowerCase()}ce.fn=ce.prototype={jquery:t,constructor:ce,length:0,toArray:function(){return ae.call(this)},get:function(e){return null==e?ae.call(this):e<0?this[e+this.length]:this[e]},pushStack:function(e){var t=ce.merge(this.constructor(),e);return t.prevObject=this,t},each:function(e){return ce.each(this,e)},map:function(n){return this.pushStack(ce.map(this,function(e,t){return n.call(e,t,e)}))},slice:function(){return this.pushStack(ae.apply(this,arguments))},first:function(){return this.eq(0)},last:function(){return this.eq(-1)},even:function(){return this.pushStack(ce.grep(this,function(e,t){return(t+1)%2}))},odd:function(){return this.pushStack(ce.grep(this,function(e,t){return t%2}))},eq:function(e){var t=this.length,n=+e+(e<0?t:0);return this.pushStack(0<=n&&n<t?[this[n]]:[])},end:function(){return this.prevObject||this.constructor()},push:s,sort:oe.sort,splice:oe.splice},ce.extend=ce.fn.extend=function(){var e,t,n,r,i,o,a=arguments[0]||{},s=1,u=arguments.length,l=!1;for("boolean"==typeof a&&(l=a,a=arguments[s]||{},s++),"object"==typeof a||v(a)||(a={}),s===u&&(a=this,s--);s<u;s++)if(null!=(e=arguments[s]))for(t in e)r=e[t],"__proto__"!==t&&a!==r&&(l&&r&&(ce.isPlainObject(r)||(i=Array.isArray(r)))?(n=a[t],o=i&&!Array.isArray(n)?[]:i||ce.isPlainObject(n)?n:{},i=!1,a[t]=ce.extend(l,o,r)):void 0!==r&&(a[t]=r));return a},ce.extend({expando:"jQuery"+(t+Math.random()).replace(/\D/g,""),isReady:!0,error:function(e){throw new Error(e)},noop:function(){},isPlainObject:function(e){var t,n;return!(!e||"[object Object]"!==i.call(e))&&(!(t=r(e))||"function"==typeof(n=ue.call(t,"constructor")&&t.constructor)&&o.call(n)===a)},isEmptyObject:function(e){var t;for(t in e)return!1;return!0},globalEval:function(e,t,n){m(e,{nonce:t&&t.nonce},n)},each:function(e,t){var n,r=0;if(c(e)){for(n=e.length;r<n;r++)if(!1===t.call(e[r],r,e[r]))break}else for(r in e)if(!1===t.call(e[r],r,e[r]))break;return e},text:function(e){var t,n="",r=0,i=e.nodeType;if(!i)while(t=e[r++])n+=ce.text(t);return 1===i||11===i?e.textContent:9===i?e.documentElement.textContent:3===i||4===i?e.nodeValue:n},makeArray:function(e,t){var n=t||[];return null!=e&&(c(Object(e))?ce.merge(n,"string"==typeof e?[e]:e):s.call(n,e)),n},inArray:function(e,t,n){return null==t?-1:se.call(t,e,n)},isXMLDoc:function(e){var t=e&&e.namespaceURI,n=e&&(e.ownerDocument||e).documentElement;return!l.test(t||n&&n.nodeName||"HTML")},merge:function(e,t){for(var n=+t.length,r=0,i=e.length;r<n;r++)e[i++]=t[r];return e.length=i,e},grep:function(e,t,n){for(var r=[],i=0,o=e.length,a=!n;i<o;i++)!t(e[i],i)!==a&&r.push(e[i]);return r},map:function(e,t,n){var r,i,o=0,a=[];if(c(e))for(r=e.length;o<r;o++)null!=(i=t(e[o],o,n))&&a.push(i);else for(o in e)null!=(i=t(e[o],o,n))&&a.push(i);return g(a)},guid:1,support:le}),"function"==typeof Symbol&&(ce.fn[Symbol.iterator]=oe[Symbol.iterator]),ce.each("Boolean Number String Function Array Date RegExp Object Error Symbol".split(" "),function(e,t){n["[object "+t+"]"]=t.toLowerCase()});var pe=oe.pop,de=oe.sort,he=oe.splice,ge="[\\x20\\t\\r\\n\\f]",ve=new RegExp("^"+ge+"+|((?:^|[^\\\\])(?:\\\\.)*)"+ge+"+$","g");ce.contains=function(e,t){var n=t&&t.parentNode;return e===n||!(!n||1!==n.nodeType||!(e.contains?e.contains(n):e.compareDocumentPosition&&16&e.compareDocumentPosition(n)))};var f=/([\0-\x1f\x7f]|^-?\d)|^-$|[^\x80-\uFFFF\w-]/g;function p(e,t){return t?"\0"===e?"\ufffd":e.slice(0,-1)+"\\"+e.charCodeAt(e.length-1).toString(16)+" ":"\\"+e}ce.escapeSelector=function(e){return(e+"").replace(f,p)};var ye=C,me=s;!function(){var e,b,w,o,a,T,r,C,d,i,k=me,S=ce.expando,E=0,n=0,s=W(),c=W(),u=W(),h=W(),l=function(e,t){return e===t&&(a=!0),0},f="checked|selected|async|autofocus|autoplay|controls|defer|disabled|hidden|ismap|loop|multiple|open|readonly|required|scoped",t="(?:\\\\[\\da-fA-F]{1,6}"+ge+"?|\\\\[^\\r\\n\\f]|[\\w-]|[^\0-\\x7f])+",p="\\["+ge+"*("+t+")(?:"+ge+"*([*^$|!~]?=)"+ge+"*(?:'((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\"|("+t+"))|)"+ge+"*\\]",g=":("+t+")(?:\\((('((?:\\\\.|[^\\\\'])*)'|\"((?:\\\\.|[^\\\\\"])*)\")|((?:\\\\.|[^\\\\()[\\]]|"+p+")*)|.*)\\)|)",v=new RegExp(ge+"+","g"),y=new RegExp("^"+ge+"*,"+ge+"*"),m=new RegExp("^"+ge+"*([>+~]|"+ge+")"+ge+"*"),x=new RegExp(ge+"|>"),j=new RegExp(g),A=new RegExp("^"+t+"$"),D={ID:new RegExp("^#("+t+")"),CLASS:new RegExp("^\\.("+t+")"),TAG:new RegExp("^("+t+"|[*])"),ATTR:new RegExp("^"+p),PSEUDO:new RegExp("^"+g),CHILD:new RegExp("^:(only|first|last|nth|nth-last)-(child|of-type)(?:\\("+ge+"*(even|odd|(([+-]|)(\\d*)n|)"+ge+"*(?:([+-]|)"+ge+"*(\\d+)|))"+ge+"*\\)|)","i"),bool:new RegExp("^(?:"+f+")$","i"),needsContext:new RegExp("^"+ge+"*[>+~]|:(even|odd|eq|gt|lt|nth|first|last)(?:\\("+ge+"*((?:-\\d)?\\d*)"+ge+"*\\)|)(?=[^-]|$)","i")},N=/^(?:input|select|textarea|button)$/i,q=/^h\d$/i,L=/^(?:#([\w-]+)|(\w+)|\.([\w-]+))$/,H=/[+~]/,O=new RegExp("\\\\[\\da-fA-F]{1,6}"+ge+"?|\\\\([^\\r\\n\\f])","g"),P=function(e,t){var n="0x"+e.slice(1)-65536;return t||(n<0?String.fromCharCode(n+65536):String.fromCharCode(n>>10|55296,1023&n|56320))},M=function(){V()},R=J(function(e){return!0===e.disabled&&fe(e,"fieldset")},{dir:"parentNode",next:"legend"});try{k.apply(oe=ae.call(ye.childNodes),ye.childNodes),oe[ye.childNodes.length].nodeType}catch(e){k={apply:function(e,t){me.apply(e,ae.call(t))},call:function(e){me.apply(e,ae.call(arguments,1))}}}function I(t,e,n,r){var i,o,a,s,u,l,c,f=e&&e.ownerDocument,p=e?e.nodeType:9;if(n=n||[],"string"!=typeof t||!t||1!==p&&9!==p&&11!==p)return n;if(!r&&(V(e),e=e||T,C)){if(11!==p&&(u=L.exec(t)))if(i=u[1]){if(9===p){if(!(a=e.getElementById(i)))return n;if(a.id===i)return k.call(n,a),n}else if(f&&(a=f.getElementById(i))&&I.contains(e,a)&&a.id===i)return k.call(n,a),n}else{if(u[2])return k.apply(n,e.getElementsByTagName(t)),n;if((i=u[3])&&e.getElementsByClassName)return k.apply(n,e.getElementsByClassName(i)),n}if(!(h[t+" "]||d&&d.test(t))){if(c=t,f=e,1===p&&(x.test(t)||m.test(t))){(f=H.test(t)&&U(e.parentNode)||e)==e&&le.scope||((s=e.getAttribute("id"))?s=ce.escapeSelector(s):e.setAttribute("id",s=S)),o=(l=Y(t)).length;while(o--)l[o]=(s?"#"+s:":scope")+" "+Q(l[o]);c=l.join(",")}try{return k.apply(n,f.querySelectorAll(c)),n}catch(e){h(t,!0)}finally{s===S&&e.removeAttribute("id")}}}return re(t.replace(ve,"$1"),e,n,r)}function W(){var r=[];return function e(t,n){return r.push(t+" ")>b.cacheLength&&delete e[r.shift()],e[t+" "]=n}}function F(e){return e[S]=!0,e}function $(e){var t=T.createElement("fieldset");try{return!!e(t)}catch(e){return!1}finally{t.parentNode&&t.parentNode.removeChild(t),t=null}}function B(t){return function(e){return fe(e,"input")&&e.type===t}}function _(t){return function(e){return(fe(e,"input")||fe(e,"button"))&&e.type===t}}function z(t){return function(e){return"form"in e?e.parentNode&&!1===e.disabled?"label"in e?"label"in e.parentNode?e.parentNode.disabled===t:e.disabled===t:e.isDisabled===t||e.isDisabled!==!t&&R(e)===t:e.disabled===t:"label"in e&&e.disabled===t}}function X(a){return F(function(o){return o=+o,F(function(e,t){var n,r=a([],e.length,o),i=r.length;while(i--)e[n=r[i]]&&(e[n]=!(t[n]=e[n]))})})}function U(e){return e&&"undefined"!=typeof e.getElementsByTagName&&e}function V(e){var t,n=e?e.ownerDocument||e:ye;return n!=T&&9===n.nodeType&&n.documentElement&&(r=(T=n).documentElement,C=!ce.isXMLDoc(T),i=r.matches||r.webkitMatchesSelector||r.msMatchesSelector,r.msMatchesSelector&&ye!=T&&(t=T.defaultView)&&t.top!==t&&t.addEventListener("unload",M),le.getById=$(function(e){return r.appendChild(e).id=ce.expando,!T.getElementsByName||!T.getElementsByName(ce.expando).length}),le.disconnectedMatch=$(function(e){return i.call(e,"*")}),le.scope=$(function(){return T.querySelectorAll(":scope")}),le.cssHas=$(function(){try{return T.querySelector(":has(*,:jqfake)"),!1}catch(e){return!0}}),le.getById?(b.filter.ID=function(e){var t=e.replace(O,P);return function(e){return e.getAttribute("id")===t}},b.find.ID=function(e,t){if("undefined"!=typeof t.getElementById&&C){var n=t.getElementById(e);return n?[n]:[]}}):(b.filter.ID=function(e){var n=e.replace(O,P);return function(e){var t="undefined"!=typeof e.getAttributeNode&&e.getAttributeNode("id");return t&&t.value===n}},b.find.ID=function(e,t){if("undefined"!=typeof t.getElementById&&C){var n,r,i,o=t.getElementById(e);if(o){if((n=o.getAttributeNode("id"))&&n.value===e)return[o];i=t.getElementsByName(e),r=0;while(o=i[r++])if((n=o.getAttributeNode("id"))&&n.value===e)return[o]}return[]}}),b.find.TAG=function(e,t){return"undefined"!=typeof t.getElementsByTagName?t.getElementsByTagName(e):t.querySelectorAll(e)},b.find.CLASS=function(e,t){if("undefined"!=typeof t.getElementsByClassName&&C)return t.getElementsByClassName(e)},d=[],$(function(e){var t;r.appendChild(e).innerHTML="<a id='"+S+"' href='' disabled='disabled'></a><select id='"+S+"-\r\\' disabled='disabled'><option selected=''></option></select>",e.querySelectorAll("[selected]").length||d.push("\\["+ge+"*(?:value|"+f+")"),e.querySelectorAll("[id~="+S+"-]").length||d.push("~="),e.querySelectorAll("a#"+S+"+*").length||d.push(".#.+[+~]"),e.querySelectorAll(":checked").length||d.push(":checked"),(t=T.createElement("input")).setAttribute("type","hidden"),e.appendChild(t).setAttribute("name","D"),r.appendChild(e).disabled=!0,2!==e.querySelectorAll(":disabled").length&&d.push(":enabled",":disabled"),(t=T.createElement("input")).setAttribute("name",""),e.appendChild(t),e.querySelectorAll("[name='']").length||d.push("\\["+ge+"*name"+ge+"*="+ge+"*(?:''|\"\")")}),le.cssHas||d.push(":has"),d=d.length&&new RegExp(d.join("|")),l=function(e,t){if(e===t)return a=!0,0;var n=!e.compareDocumentPosition-!t.compareDocumentPosition;return n||(1&(n=(e.ownerDocument||e)==(t.ownerDocument||t)?e.compareDocumentPosition(t):1)||!le.sortDetached&&t.compareDocumentPosition(e)===n?e===T||e.ownerDocument==ye&&I.contains(ye,e)?-1:t===T||t.ownerDocument==ye&&I.contains(ye,t)?1:o?se.call(o,e)-se.call(o,t):0:4&n?-1:1)}),T}for(e in I.matches=function(e,t){return I(e,null,null,t)},I.matchesSelector=function(e,t){if(V(e),C&&!h[t+" "]&&(!d||!d.test(t)))try{var n=i.call(e,t);if(n||le.disconnectedMatch||e.document&&11!==e.document.nodeType)return n}catch(e){h(t,!0)}return 0<I(t,T,null,[e]).length},I.contains=function(e,t){return(e.ownerDocument||e)!=T&&V(e),ce.contains(e,t)},I.attr=function(e,t){(e.ownerDocument||e)!=T&&V(e);var n=b.attrHandle[t.toLowerCase()],r=n&&ue.call(b.attrHandle,t.toLowerCase())?n(e,t,!C):void 0;return void 0!==r?r:e.getAttribute(t)},I.error=function(e){throw new Error("Syntax error, unrecognized expression: "+e)},ce.uniqueSort=function(e){var t,n=[],r=0,i=0;if(a=!le.sortStable,o=!le.sortStable&&ae.call(e,0),de.call(e,l),a){while(t=e[i++])t===e[i]&&(r=n.push(i));while(r--)he.call(e,n[r],1)}return o=null,e},ce.fn.uniqueSort=function(){return this.pushStack(ce.uniqueSort(ae.apply(this)))},(b=ce.expr={cacheLength:50,createPseudo:F,match:D,attrHandle:{},find:{},relative:{">":{dir:"parentNode",first:!0}," ":{dir:"parentNode"},"+":{dir:"previousSibling",first:!0},"~":{dir:"previousSibling"}},preFilter:{ATTR:function(e){return e[1]=e[1].replace(O,P),e[3]=(e[3]||e[4]||e[5]||"").replace(O,P),"~="===e[2]&&(e[3]=" "+e[3]+" "),e.slice(0,4)},CHILD:function(e){return e[1]=e[1].toLowerCase(),"nth"===e[1].slice(0,3)?(e[3]||I.error(e[0]),e[4]=+(e[4]?e[5]+(e[6]||1):2*("even"===e[3]||"odd"===e[3])),e[5]=+(e[7]+e[8]||"odd"===e[3])):e[3]&&I.error(e[0]),e},PSEUDO:function(e){var t,n=!e[6]&&e[2];return D.CHILD.test(e[0])?null:(e[3]?e[2]=e[4]||e[5]||"":n&&j.test(n)&&(t=Y(n,!0))&&(t=n.indexOf(")",n.length-t)-n.length)&&(e[0]=e[0].slice(0,t),e[2]=n.slice(0,t)),e.slice(0,3))}},filter:{TAG:function(e){var t=e.replace(O,P).toLowerCase();return"*"===e?function(){return!0}:function(e){return fe(e,t)}},CLASS:function(e){var t=s[e+" "];return t||(t=new RegExp("(^|"+ge+")"+e+"("+ge+"|$)"))&&s(e,function(e){return t.test("string"==typeof e.className&&e.className||"undefined"!=typeof e.getAttribute&&e.getAttribute("class")||"")})},ATTR:function(n,r,i){return function(e){var t=I.attr(e,n);return null==t?"!="===r:!r||(t+="","="===r?t===i:"!="===r?t!==i:"^="===r?i&&0===t.indexOf(i):"*="===r?i&&-1<t.indexOf(i):"$="===r?i&&t.slice(-i.length)===i:"~="===r?-1<(" "+t.replace(v," ")+" ").indexOf(i):"|="===r&&(t===i||t.slice(0,i.length+1)===i+"-"))}},CHILD:function(d,e,t,h,g){var v="nth"!==d.slice(0,3),y="last"!==d.slice(-4),m="of-type"===e;return 1===h&&0===g?function(e){return!!e.parentNode}:function(e,t,n){var r,i,o,a,s,u=v!==y?"nextSibling":"previousSibling",l=e.parentNode,c=m&&e.nodeName.toLowerCase(),f=!n&&!m,p=!1;if(l){if(v){while(u){o=e;while(o=o[u])if(m?fe(o,c):1===o.nodeType)return!1;s=u="only"===d&&!s&&"nextSibling"}return!0}if(s=[y?l.firstChild:l.lastChild],y&&f){p=(a=(r=(i=l[S]||(l[S]={}))[d]||[])[0]===E&&r[1])&&r[2],o=a&&l.childNodes[a];while(o=++a&&o&&o[u]||(p=a=0)||s.pop())if(1===o.nodeType&&++p&&o===e){i[d]=[E,a,p];break}}else if(f&&(p=a=(r=(i=e[S]||(e[S]={}))[d]||[])[0]===E&&r[1]),!1===p)while(o=++a&&o&&o[u]||(p=a=0)||s.pop())if((m?fe(o,c):1===o.nodeType)&&++p&&(f&&((i=o[S]||(o[S]={}))[d]=[E,p]),o===e))break;return(p-=g)===h||p%h==0&&0<=p/h}}},PSEUDO:function(e,o){var t,a=b.pseudos[e]||b.setFilters[e.toLowerCase()]||I.error("unsupported pseudo: "+e);return a[S]?a(o):1<a.length?(t=[e,e,"",o],b.setFilters.hasOwnProperty(e.toLowerCase())?F(function(e,t){var n,r=a(e,o),i=r.length;while(i--)e[n=se.call(e,r[i])]=!(t[n]=r[i])}):function(e){return a(e,0,t)}):a}},pseudos:{not:F(function(e){var r=[],i=[],s=ne(e.replace(ve,"$1"));return s[S]?F(function(e,t,n,r){var i,o=s(e,null,r,[]),a=e.length;while(a--)(i=o[a])&&(e[a]=!(t[a]=i))}):function(e,t,n){return r[0]=e,s(r,null,n,i),r[0]=null,!i.pop()}}),has:F(function(t){return function(e){return 0<I(t,e).length}}),contains:F(function(t){return t=t.replace(O,P),function(e){return-1<(e.textContent||ce.text(e)).indexOf(t)}}),lang:F(function(n){return A.test(n||"")||I.error("unsupported lang: "+n),n=n.replace(O,P).toLowerCase(),function(e){var t;do{if(t=C?e.lang:e.getAttribute("xml:lang")||e.getAttribute("lang"))return(t=t.toLowerCase())===n||0===t.indexOf(n+"-")}while((e=e.parentNode)&&1===e.nodeType);return!1}}),target:function(e){var t=ie.location&&ie.location.hash;return t&&t.slice(1)===e.id},root:function(e){return e===r},focus:function(e){return e===function(){try{return T.activeElement}catch(e){}}()&&T.hasFocus()&&!!(e.type||e.href||~e.tabIndex)},enabled:z(!1),disabled:z(!0),checked:function(e){return fe(e,"input")&&!!e.checked||fe(e,"option")&&!!e.selected},selected:function(e){return e.parentNode&&e.parentNode.selectedIndex,!0===e.selected},empty:function(e){for(e=e.firstChild;e;e=e.nextSibling)if(e.nodeType<6)return!1;return!0},parent:function(e){return!b.pseudos.empty(e)},header:function(e){return q.test(e.nodeName)},input:function(e){return N.test(e.nodeName)},button:function(e){return fe(e,"input")&&"button"===e.type||fe(e,"button")},text:function(e){var t;return fe(e,"input")&&"text"===e.type&&(null==(t=e.getAttribute("type"))||"text"===t.toLowerCase())},first:X(function(){return[0]}),last:X(function(e,t){return[t-1]}),eq:X(function(e,t,n){return[n<0?n+t:n]}),even:X(function(e,t){for(var n=0;n<t;n+=2)e.push(n);return e}),odd:X(function(e,t){for(var n=1;n<t;n+=2)e.push(n);return e}),lt:X(function(e,t,n){var r;for(r=n<0?n+t:t<n?t:n;0<=--r;)e.push(r);return e}),gt:X(function(e,t,n){for(var r=n<0?n+t:n;++r<t;)e.push(r);return e})}}).pseudos.nth=b.pseudos.eq,{radio:!0,checkbox:!0,file:!0,password:!0,image:!0})b.pseudos[e]=B(e);for(e in{submit:!0,reset:!0})b.pseudos[e]=_(e);function G(){}function Y(e,t){var n,r,i,o,a,s,u,l=c[e+" "];if(l)return t?0:l.slice(0);a=e,s=[],u=b.preFilter;while(a){for(o in n&&!(r=y.exec(a))||(r&&(a=a.slice(r[0].length)||a),s.push(i=[])),n=!1,(r=m.exec(a))&&(n=r.shift(),i.push({value:n,type:r[0].replace(ve," ")}),a=a.slice(n.length)),b.filter)!(r=D[o].exec(a))||u[o]&&!(r=u[o](r))||(n=r.shift(),i.push({value:n,type:o,matches:r}),a=a.slice(n.length));if(!n)break}return t?a.length:a?I.error(e):c(e,s).slice(0)}function Q(e){for(var t=0,n=e.length,r="";t<n;t++)r+=e[t].value;return r}function J(a,e,t){var s=e.dir,u=e.next,l=u||s,c=t&&"parentNode"===l,f=n++;return e.first?function(e,t,n){while(e=e[s])if(1===e.nodeType||c)return a(e,t,n);return!1}:function(e,t,n){var r,i,o=[E,f];if(n){while(e=e[s])if((1===e.nodeType||c)&&a(e,t,n))return!0}else while(e=e[s])if(1===e.nodeType||c)if(i=e[S]||(e[S]={}),u&&fe(e,u))e=e[s]||e;else{if((r=i[l])&&r[0]===E&&r[1]===f)return o[2]=r[2];if((i[l]=o)[2]=a(e,t,n))return!0}return!1}}function K(i){return 1<i.length?function(e,t,n){var r=i.length;while(r--)if(!i[r](e,t,n))return!1;return!0}:i[0]}function Z(e,t,n,r,i){for(var o,a=[],s=0,u=e.length,l=null!=t;s<u;s++)(o=e[s])&&(n&&!n(o,r,i)||(a.push(o),l&&t.push(s)));return a}function ee(d,h,g,v,y,e){return v&&!v[S]&&(v=ee(v)),y&&!y[S]&&(y=ee(y,e)),F(function(e,t,n,r){var i,o,a,s,u=[],l=[],c=t.length,f=e||function(e,t,n){for(var r=0,i=t.length;r<i;r++)I(e,t[r],n);return n}(h||"*",n.nodeType?[n]:n,[]),p=!d||!e&&h?f:Z(f,u,d,n,r);if(g?g(p,s=y||(e?d:c||v)?[]:t,n,r):s=p,v){i=Z(s,l),v(i,[],n,r),o=i.length;while(o--)(a=i[o])&&(s[l[o]]=!(p[l[o]]=a))}if(e){if(y||d){if(y){i=[],o=s.length;while(o--)(a=s[o])&&i.push(p[o]=a);y(null,s=[],i,r)}o=s.length;while(o--)(a=s[o])&&-1<(i=y?se.call(e,a):u[o])&&(e[i]=!(t[i]=a))}}else s=Z(s===t?s.splice(c,s.length):s),y?y(null,t,s,r):k.apply(t,s)})}function te(e){for(var i,t,n,r=e.length,o=b.relative[e[0].type],a=o||b.relative[" "],s=o?1:0,u=J(function(e){return e===i},a,!0),l=J(function(e){return-1<se.call(i,e)},a,!0),c=[function(e,t,n){var r=!o&&(n||t!=w)||((i=t).nodeType?u(e,t,n):l(e,t,n));return i=null,r}];s<r;s++)if(t=b.relative[e[s].type])c=[J(K(c),t)];else{if((t=b.filter[e[s].type].apply(null,e[s].matches))[S]){for(n=++s;n<r;n++)if(b.relative[e[n].type])break;return ee(1<s&&K(c),1<s&&Q(e.slice(0,s-1).concat({value:" "===e[s-2].type?"*":""})).replace(ve,"$1"),t,s<n&&te(e.slice(s,n)),n<r&&te(e=e.slice(n)),n<r&&Q(e))}c.push(t)}return K(c)}function ne(e,t){var n,v,y,m,x,r,i=[],o=[],a=u[e+" "];if(!a){t||(t=Y(e)),n=t.length;while(n--)(a=te(t[n]))[S]?i.push(a):o.push(a);(a=u(e,(v=o,m=0<(y=i).length,x=0<v.length,r=function(e,t,n,r,i){var o,a,s,u=0,l="0",c=e&&[],f=[],p=w,d=e||x&&b.find.TAG("*",i),h=E+=null==p?1:Math.random()||.1,g=d.length;for(i&&(w=t==T||t||i);l!==g&&null!=(o=d[l]);l++){if(x&&o){a=0,t||o.ownerDocument==T||(V(o),n=!C);while(s=v[a++])if(s(o,t||T,n)){k.call(r,o);break}i&&(E=h)}m&&((o=!s&&o)&&u--,e&&c.push(o))}if(u+=l,m&&l!==u){a=0;while(s=y[a++])s(c,f,t,n);if(e){if(0<u)while(l--)c[l]||f[l]||(f[l]=pe.call(r));f=Z(f)}k.apply(r,f),i&&!e&&0<f.length&&1<u+y.length&&ce.uniqueSort(r)}return i&&(E=h,w=p),c},m?F(r):r))).selector=e}return a}function re(e,t,n,r){var i,o,a,s,u,l="function"==typeof e&&e,c=!r&&Y(e=l.selector||e);if(n=n||[],1===c.length){if(2<(o=c[0]=c[0].slice(0)).length&&"ID"===(a=o[0]).type&&9===t.nodeType&&C&&b.relative[o[1].type]){if(!(t=(b.find.ID(a.matches[0].replace(O,P),t)||[])[0]))return n;l&&(t=t.parentNode),e=e.slice(o.shift().value.length)}i=D.needsContext.test(e)?0:o.length;while(i--){if(a=o[i],b.relative[s=a.type])break;if((u=b.find[s])&&(r=u(a.matches[0].replace(O,P),H.test(o[0].type)&&U(t.parentNode)||t))){if(o.splice(i,1),!(e=r.length&&Q(o)))return k.apply(n,r),n;break}}}return(l||ne(e,c))(r,t,!C,n,!t||H.test(e)&&U(t.parentNode)||t),n}G.prototype=b.filters=b.pseudos,b.setFilters=new G,le.sortStable=S.split("").sort(l).join("")===S,V(),le.sortDetached=$(function(e){return 1&e.compareDocumentPosition(T.createElement("fieldset"))}),ce.find=I,ce.expr[":"]=ce.expr.pseudos,ce.unique=ce.uniqueSort,I.compile=ne,I.select=re,I.setDocument=V,I.tokenize=Y,I.escape=ce.escapeSelector,I.getText=ce.text,I.isXML=ce.isXMLDoc,I.selectors=ce.expr,I.support=ce.support,I.uniqueSort=ce.uniqueSort}();var d=function(e,t,n){var r=[],i=void 0!==n;while((e=e[t])&&9!==e.nodeType)if(1===e.nodeType){if(i&&ce(e).is(n))break;r.push(e)}return r},h=function(e,t){for(var n=[];e;e=e.nextSibling)1===e.nodeType&&e!==t&&n.push(e);return n},b=ce.expr.match.needsContext,w=/^<([a-z][^\/\0>:\x20\t\r\n\f]*)[\x20\t\r\n\f]*\/?>(?:<\/\1>|)$/i;function T(e,n,r){return v(n)?ce.grep(e,function(e,t){return!!n.call(e,t,e)!==r}):n.nodeType?ce.grep(e,function(e){return e===n!==r}):"string"!=typeof n?ce.grep(e,function(e){return-1<se.call(n,e)!==r}):ce.filter(n,e,r)}ce.filter=function(e,t,n){var r=t[0];return n&&(e=":not("+e+")"),1===t.length&&1===r.nodeType?ce.find.matchesSelector(r,e)?[r]:[]:ce.find.matches(e,ce.grep(t,function(e){return 1===e.nodeType}))},ce.fn.extend({find:function(e){var t,n,r=this.length,i=this;if("string"!=typeof e)return this.pushStack(ce(e).filter(function(){for(t=0;t<r;t++)if(ce.contains(i[t],this))return!0}));for(n=this.pushStack([]),t=0;t<r;t++)ce.find(e,i[t],n);return 1<r?ce.uniqueSort(n):n},filter:function(e){return this.pushStack(T(this,e||[],!1))},not:function(e){return this.pushStack(T(this,e||[],!0))},is:function(e){return!!T(this,"string"==typeof e&&b.test(e)?ce(e):e||[],!1).length}});var k,S=/^(?:\s*(<[\w\W]+>)[^>]*|#([\w-]+))$/;(ce.fn.init=function(e,t,n){var r,i;if(!e)return this;if(n=n||k,"string"==typeof e){if(!(r="<"===e[0]&&">"===e[e.length-1]&&3<=e.length?[null,e,null]:S.exec(e))||!r[1]&&t)return!t||t.jquery?(t||n).find(e):this.constructor(t).find(e);if(r[1]){if(t=t instanceof ce?t[0]:t,ce.merge(this,ce.parseHTML(r[1],t&&t.nodeType?t.ownerDocument||t:C,!0)),w.test(r[1])&&ce.isPlainObject(t))for(r in t)v(this[r])?this[r](t[r]):this.attr(r,t[r]);return this}return(i=C.getElementById(r[2]))&&(this[0]=i,this.length=1),this}return e.nodeType?(this[0]=e,this.length=1,this):v(e)?void 0!==n.ready?n.ready(e):e(ce):ce.makeArray(e,this)}).prototype=ce.fn,k=ce(C);var E=/^(?:parents|prev(?:Until|All))/,j={children:!0,contents:!0,next:!0,prev:!0};function A(e,t){while((e=e[t])&&1!==e.nodeType);return e}ce.fn.extend({has:function(e){var t=ce(e,this),n=t.length;return this.filter(function(){for(var e=0;e<n;e++)if(ce.contains(this,t[e]))return!0})},closest:function(e,t){var n,r=0,i=this.length,o=[],a="string"!=typeof e&&ce(e);if(!b.test(e))for(;r<i;r++)for(n=this[r];n&&n!==t;n=n.parentNode)if(n.nodeType<11&&(a?-1<a.index(n):1===n.nodeType&&ce.find.matchesSelector(n,e))){o.push(n);break}return this.pushStack(1<o.length?ce.uniqueSort(o):o)},index:function(e){return e?"string"==typeof e?se.call(ce(e),this[0]):se.call(this,e.jquery?e[0]:e):this[0]&&this[0].parentNode?this.first().prevAll().length:-1},add:function(e,t){return this.pushStack(ce.uniqueSort(ce.merge(this.get(),ce(e,t))))},addBack:function(e){return this.add(null==e?this.prevObject:this.prevObject.filter(e))}}),ce.each({parent:function(e){var t=e.parentNode;return t&&11!==t.nodeType?t:null},parents:function(e){return d(e,"parentNode")},parentsUntil:function(e,t,n){return d(e,"parentNode",n)},next:function(e){return A(e,"nextSibling")},prev:function(e){return A(e,"previousSibling")},nextAll:function(e){return d(e,"nextSibling")},prevAll:function(e){return d(e,"previousSibling")},nextUntil:function(e,t,n){return d(e,"nextSibling",n)},prevUntil:function(e,t,n){return d(e,"previousSibling",n)},siblings:function(e){return h((e.parentNode||{}).firstChild,e)},children:function(e){return h(e.firstChild)},contents:function(e){return null!=e.contentDocument&&r(e.contentDocument)?e.contentDocument:(fe(e,"template")&&(e=e.content||e),ce.merge([],e.childNodes))}},function(r,i){ce.fn[r]=function(e,t){var n=ce.map(this,i,e);return"Until"!==r.slice(-5)&&(t=e),t&&"string"==typeof t&&(n=ce.filter(t,n)),1<this.length&&(j[r]||ce.uniqueSort(n),E.test(r)&&n.reverse()),this.pushStack(n)}});var D=/[^\x20\t\r\n\f]+/g;function N(e){return e}function q(e){throw e}function L(e,t,n,r){var i;try{e&&v(i=e.promise)?i.call(e).done(t).fail(n):e&&v(i=e.then)?i.call(e,t,n):t.apply(void 0,[e].slice(r))}catch(e){n.apply(void 0,[e])}}ce.Callbacks=function(r){var e,n;r="string"==typeof r?(e=r,n={},ce.each(e.match(D)||[],function(e,t){n[t]=!0}),n):ce.extend({},r);var i,t,o,a,s=[],u=[],l=-1,c=function(){for(a=a||r.once,o=i=!0;u.length;l=-1){t=u.shift();while(++l<s.length)!1===s[l].apply(t[0],t[1])&&r.stopOnFalse&&(l=s.length,t=!1)}r.memory||(t=!1),i=!1,a&&(s=t?[]:"")},f={add:function(){return s&&(t&&!i&&(l=s.length-1,u.push(t)),function n(e){ce.each(e,function(e,t){v(t)?r.unique&&f.has(t)||s.push(t):t&&t.length&&"string"!==x(t)&&n(t)})}(arguments),t&&!i&&c()),this},remove:function(){return ce.each(arguments,function(e,t){var n;while(-1<(n=ce.inArray(t,s,n)))s.splice(n,1),n<=l&&l--}),this},has:function(e){return e?-1<ce.inArray(e,s):0<s.length},empty:function(){return s&&(s=[]),this},disable:function(){return a=u=[],s=t="",this},disabled:function(){return!s},lock:function(){return a=u=[],t||i||(s=t=""),this},locked:function(){return!!a},fireWith:function(e,t){return a||(t=[e,(t=t||[]).slice?t.slice():t],u.push(t),i||c()),this},fire:function(){return f.fireWith(this,arguments),this},fired:function(){return!!o}};return f},ce.extend({Deferred:function(e){var o=[["notify","progress",ce.Callbacks("memory"),ce.Callbacks("memory"),2],["resolve","done",ce.Callbacks("once memory"),ce.Callbacks("once memory"),0,"resolved"],["reject","fail",ce.Callbacks("once memory"),ce.Callbacks("once memory"),1,"rejected"]],i="pending",a={state:function(){return i},always:function(){return s.done(arguments).fail(arguments),this},"catch":function(e){return a.then(null,e)},pipe:function(){var i=arguments;return ce.Deferred(function(r){ce.each(o,function(e,t){var n=v(i[t[4]])&&i[t[4]];s[t[1]](function(){var e=n&&n.apply(this,arguments);e&&v(e.promise)?e.promise().progress(r.notify).done(r.resolve).fail(r.reject):r[t[0]+"With"](this,n?[e]:arguments)})}),i=null}).promise()},then:function(t,n,r){var u=0;function l(i,o,a,s){return function(){var n=this,r=arguments,e=function(){var e,t;if(!(i<u)){if((e=a.apply(n,r))===o.promise())throw new TypeError("Thenable self-resolution");t=e&&("object"==typeof e||"function"==typeof e)&&e.then,v(t)?s?t.call(e,l(u,o,N,s),l(u,o,q,s)):(u++,t.call(e,l(u,o,N,s),l(u,o,q,s),l(u,o,N,o.notifyWith))):(a!==N&&(n=void 0,r=[e]),(s||o.resolveWith)(n,r))}},t=s?e:function(){try{e()}catch(e){ce.Deferred.exceptionHook&&ce.Deferred.exceptionHook(e,t.error),u<=i+1&&(a!==q&&(n=void 0,r=[e]),o.rejectWith(n,r))}};i?t():(ce.Deferred.getErrorHook?t.error=ce.Deferred.getErrorHook():ce.Deferred.getStackHook&&(t.error=ce.Deferred.getStackHook()),ie.setTimeout(t))}}return ce.Deferred(function(e){o[0][3].add(l(0,e,v(r)?r:N,e.notifyWith)),o[1][3].add(l(0,e,v(t)?t:N)),o[2][3].add(l(0,e,v(n)?n:q))}).promise()},promise:function(e){return null!=e?ce.extend(e,a):a}},s={};return ce.each(o,function(e,t){var n=t[2],r=t[5];a[t[1]]=n.add,r&&n.add(function(){i=r},o[3-e][2].disable,o[3-e][3].disable,o[0][2].lock,o[0][3].lock),n.add(t[3].fire),s[t[0]]=function(){return s[t[0]+"With"](this===s?void 0:this,arguments),this},s[t[0]+"With"]=n.fireWith}),a.promise(s),e&&e.call(s,s),s},when:function(e){var n=arguments.length,t=n,r=Array(t),i=ae.call(arguments),o=ce.Deferred(),a=function(t){return function(e){r[t]=this,i[t]=1<arguments.length?ae.call(arguments):e,--n||o.resolveWith(r,i)}};if(n<=1&&(L(e,o.done(a(t)).resolve,o.reject,!n),"pending"===o.state()||v(i[t]&&i[t].then)))return o.then();while(t--)L(i[t],a(t),o.reject);return o.promise()}});var H=/^(Eval|Internal|Range|Reference|Syntax|Type|URI)Error$/;ce.Deferred.exceptionHook=function(e,t){ie.console&&ie.console.warn&&e&&H.test(e.name)&&ie.console.warn("jQuery.Deferred exception: "+e.message,e.stack,t)},ce.readyException=function(e){ie.setTimeout(function(){throw e})};var O=ce.Deferred();function P(){C.removeEventListener("DOMContentLoaded",P),ie.removeEventListener("load",P),ce.ready()}ce.fn.ready=function(e){return O.then(e)["catch"](function(e){ce.readyException(e)}),this},ce.extend({isReady:!1,readyWait:1,ready:function(e){(!0===e?--ce.readyWait:ce.isReady)||(ce.isReady=!0)!==e&&0<--ce.readyWait||O.resolveWith(C,[ce])}}),ce.ready.then=O.then,"complete"===C.readyState||"loading"!==C.readyState&&!C.documentElement.doScroll?ie.setTimeout(ce.ready):(C.addEventListener("DOMContentLoaded",P),ie.addEventListener("load",P));var M=function(e,t,n,r,i,o,a){var s=0,u=e.length,l=null==n;if("object"===x(n))for(s in i=!0,n)M(e,t,s,n[s],!0,o,a);else if(void 0!==r&&(i=!0,v(r)||(a=!0),l&&(a?(t.call(e,r),t=null):(l=t,t=function(e,t,n){return l.call(ce(e),n)})),t))for(;s<u;s++)t(e[s],n,a?r:r.call(e[s],s,t(e[s],n)));return i?e:l?t.call(e):u?t(e[0],n):o},R=/^-ms-/,I=/-([a-z])/g;function W(e,t){return t.toUpperCase()}function F(e){return e.replace(R,"ms-").replace(I,W)}var $=function(e){return 1===e.nodeType||9===e.nodeType||!+e.nodeType};function B(){this.expando=ce.expando+B.uid++}B.uid=1,B.prototype={cache:function(e){var t=e[this.expando];return t||(t={},$(e)&&(e.nodeType?e[this.expando]=t:Object.defineProperty(e,this.expando,{value:t,configurable:!0}))),t},set:function(e,t,n){var r,i=this.cache(e);if("string"==typeof t)i[F(t)]=n;else for(r in t)i[F(r)]=t[r];return i},get:function(e,t){return void 0===t?this.cache(e):e[this.expando]&&e[this.expando][F(t)]},access:function(e,t,n){return void 0===t||t&&"string"==typeof t&&void 0===n?this.get(e,t):(this.set(e,t,n),void 0!==n?n:t)},remove:function(e,t){var n,r=e[this.expando];if(void 0!==r){if(void 0!==t){n=(t=Array.isArray(t)?t.map(F):(t=F(t))in r?[t]:t.match(D)||[]).length;while(n--)delete r[t[n]]}(void 0===t||ce.isEmptyObject(r))&&(e.nodeType?e[this.expando]=void 0:delete e[this.expando])}},hasData:function(e){var t=e[this.expando];return void 0!==t&&!ce.isEmptyObject(t)}};var _=new B,z=new B,X=/^(?:\{[\w\W]*\}|\[[\w\W]*\])$/,U=/[A-Z]/g;function V(e,t,n){var r,i;if(void 0===n&&1===e.nodeType)if(r="data-"+t.replace(U,"-$&").toLowerCase(),"string"==typeof(n=e.getAttribute(r))){try{n="true"===(i=n)||"false"!==i&&("null"===i?null:i===+i+""?+i:X.test(i)?JSON.parse(i):i)}catch(e){}z.set(e,t,n)}else n=void 0;return n}ce.extend({hasData:function(e){return z.hasData(e)||_.hasData(e)},data:function(e,t,n){return z.access(e,t,n)},removeData:function(e,t){z.remove(e,t)},_data:function(e,t,n){return _.access(e,t,n)},_removeData:function(e,t){_.remove(e,t)}}),ce.fn.extend({data:function(n,e){var t,r,i,o=this[0],a=o&&o.attributes;if(void 0===n){if(this.length&&(i=z.get(o),1===o.nodeType&&!_.get(o,"hasDataAttrs"))){t=a.length;while(t--)a[t]&&0===(r=a[t].name).indexOf("data-")&&(r=F(r.slice(5)),V(o,r,i[r]));_.set(o,"hasDataAttrs",!0)}return i}return"object"==typeof n?this.each(function(){z.set(this,n)}):M(this,function(e){var t;if(o&&void 0===e)return void 0!==(t=z.get(o,n))?t:void 0!==(t=V(o,n))?t:void 0;this.each(function(){z.set(this,n,e)})},null,e,1<arguments.length,null,!0)},removeData:function(e){return this.each(function(){z.remove(this,e)})}}),ce.extend({queue:function(e,t,n){var r;if(e)return t=(t||"fx")+"queue",r=_.get(e,t),n&&(!r||Array.isArray(n)?r=_.access(e,t,ce.makeArray(n)):r.push(n)),r||[]},dequeue:function(e,t){t=t||"fx";var n=ce.queue(e,t),r=n.length,i=n.shift(),o=ce._queueHooks(e,t);"inprogress"===i&&(i=n.shift(),r--),i&&("fx"===t&&n.unshift("inprogress"),delete o.stop,i.call(e,function(){ce.dequeue(e,t)},o)),!r&&o&&o.empty.fire()},_queueHooks:function(e,t){var n=t+"queueHooks";return _.get(e,n)||_.access(e,n,{empty:ce.Callbacks("once memory").add(function(){_.remove(e,[t+"queue",n])})})}}),ce.fn.extend({queue:function(t,n){var e=2;return"string"!=typeof t&&(n=t,t="fx",e--),arguments.length<e?ce.queue(this[0],t):void 0===n?this:this.each(function(){var e=ce.queue(this,t,n);ce._queueHooks(this,t),"fx"===t&&"inprogress"!==e[0]&&ce.dequeue(this,t)})},dequeue:function(e){return this.each(function(){ce.dequeue(this,e)})},clearQueue:function(e){return this.queue(e||"fx",[])},promise:function(e,t){var n,r=1,i=ce.Deferred(),o=this,a=this.length,s=function(){--r||i.resolveWith(o,[o])};"string"!=typeof e&&(t=e,e=void 0),e=e||"fx";while(a--)(n=_.get(o[a],e+"queueHooks"))&&n.empty&&(r++,n.empty.add(s));return s(),i.promise(t)}});var G=/[+-]?(?:\d*\.|)\d+(?:[eE][+-]?\d+|)/.source,Y=new RegExp("^(?:([+-])=|)("+G+")([a-z%]*)$","i"),Q=["Top","Right","Bottom","Left"],J=C.documentElement,K=function(e){return ce.contains(e.ownerDocument,e)},Z={composed:!0};J.getRootNode&&(K=function(e){return ce.contains(e.ownerDocument,e)||e.getRootNode(Z)===e.ownerDocument});var ee=function(e,t){return"none"===(e=t||e).style.display||""===e.style.display&&K(e)&&"none"===ce.css(e,"display")};function te(e,t,n,r){var i,o,a=20,s=r?function(){return r.cur()}:function(){return ce.css(e,t,"")},u=s(),l=n&&n[3]||(ce.cssNumber[t]?"":"px"),c=e.nodeType&&(ce.cssNumber[t]||"px"!==l&&+u)&&Y.exec(ce.css(e,t));if(c&&c[3]!==l){u/=2,l=l||c[3],c=+u||1;while(a--)ce.style(e,t,c+l),(1-o)*(1-(o=s()/u||.5))<=0&&(a=0),c/=o;c*=2,ce.style(e,t,c+l),n=n||[]}return n&&(c=+c||+u||0,i=n[1]?c+(n[1]+1)*n[2]:+n[2],r&&(r.unit=l,r.start=c,r.end=i)),i}var ne={};function re(e,t){for(var n,r,i,o,a,s,u,l=[],c=0,f=e.length;c<f;c++)(r=e[c]).style&&(n=r.style.display,t?("none"===n&&(l[c]=_.get(r,"display")||null,l[c]||(r.style.display="")),""===r.style.display&&ee(r)&&(l[c]=(u=a=o=void 0,a=(i=r).ownerDocument,s=i.nodeName,(u=ne[s])||(o=a.body.appendChild(a.createElement(s)),u=ce.css(o,"display"),o.parentNode.removeChild(o),"none"===u&&(u="block"),ne[s]=u)))):"none"!==n&&(l[c]="none",_.set(r,"display",n)));for(c=0;c<f;c++)null!=l[c]&&(e[c].style.display=l[c]);return e}ce.fn.extend({show:function(){return re(this,!0)},hide:function(){return re(this)},toggle:function(e){return"boolean"==typeof e?e?this.show():this.hide():this.each(function(){ee(this)?ce(this).show():ce(this).hide()})}});var xe,be,we=/^(?:checkbox|radio)$/i,Te=/<([a-z][^\/\0>\x20\t\r\n\f]*)/i,Ce=/^$|^module$|\/(?:java|ecma)script/i;xe=C.createDocumentFragment().appendChild(C.createElement("div")),(be=C.createElement("input")).setAttribute("type","radio"),be.setAttribute("checked","checked"),be.setAttribute("name","t"),xe.appendChild(be),le.checkClone=xe.cloneNode(!0).cloneNode(!0).lastChild.checked,xe.innerHTML="<textarea>x</textarea>",le.noCloneChecked=!!xe.cloneNode(!0).lastChild.defaultValue,xe.innerHTML="<option></option>",le.option=!!xe.lastChild;var ke={thead:[1,"<table>","</table>"],col:[2,"<table><colgroup>","</colgroup></table>"],tr:[2,"<table><tbody>","</tbody></table>"],td:[3,"<table><tbody><tr>","</tr></tbody></table>"],_default:[0,"",""]};function Se(e,t){var n;return n="undefined"!=typeof e.getElementsByTagName?e.getElementsByTagName(t||"*"):"undefined"!=typeof e.querySelectorAll?e.querySelectorAll(t||"*"):[],void 0===t||t&&fe(e,t)?ce.merge([e],n):n}function Ee(e,t){for(var n=0,r=e.length;n<r;n++)_.set(e[n],"globalEval",!t||_.get(t[n],"globalEval"))}ke.tbody=ke.tfoot=ke.colgroup=ke.caption=ke.thead,ke.th=ke.td,le.option||(ke.optgroup=ke.option=[1,"<select multiple='multiple'>","</select>"]);var je=/<|&#?\w+;/;function Ae(e,t,n,r,i){for(var o,a,s,u,l,c,f=t.createDocumentFragment(),p=[],d=0,h=e.length;d<h;d++)if((o=e[d])||0===o)if("object"===x(o))ce.merge(p,o.nodeType?[o]:o);else if(je.test(o)){a=a||f.appendChild(t.createElement("div")),s=(Te.exec(o)||["",""])[1].toLowerCase(),u=ke[s]||ke._default,a.innerHTML=u[1]+ce.htmlPrefilter(o)+u[2],c=u[0];while(c--)a=a.lastChild;ce.merge(p,a.childNodes),(a=f.firstChild).textContent=""}else p.push(t.createTextNode(o));f.textContent="",d=0;while(o=p[d++])if(r&&-1<ce.inArray(o,r))i&&i.push(o);else if(l=K(o),a=Se(f.appendChild(o),"script"),l&&Ee(a),n){c=0;while(o=a[c++])Ce.test(o.type||"")&&n.push(o)}return f}var De=/^([^.]*)(?:\.(.+)|)/;function Ne(){return!0}function qe(){return!1}function Le(e,t,n,r,i,o){var a,s;if("object"==typeof t){for(s in"string"!=typeof n&&(r=r||n,n=void 0),t)Le(e,s,n,r,t[s],o);return e}if(null==r&&null==i?(i=n,r=n=void 0):null==i&&("string"==typeof n?(i=r,r=void 0):(i=r,r=n,n=void 0)),!1===i)i=qe;else if(!i)return e;return 1===o&&(a=i,(i=function(e){return ce().off(e),a.apply(this,arguments)}).guid=a.guid||(a.guid=ce.guid++)),e.each(function(){ce.event.add(this,t,i,r,n)})}function He(e,r,t){t?(_.set(e,r,!1),ce.event.add(e,r,{namespace:!1,handler:function(e){var t,n=_.get(this,r);if(1&e.isTrigger&&this[r]){if(n)(ce.event.special[r]||{}).delegateType&&e.stopPropagation();else if(n=ae.call(arguments),_.set(this,r,n),this[r](),t=_.get(this,r),_.set(this,r,!1),n!==t)return e.stopImmediatePropagation(),e.preventDefault(),t}else n&&(_.set(this,r,ce.event.trigger(n[0],n.slice(1),this)),e.stopPropagation(),e.isImmediatePropagationStopped=Ne)}})):void 0===_.get(e,r)&&ce.event.add(e,r,Ne)}ce.event={global:{},add:function(t,e,n,r,i){var o,a,s,u,l,c,f,p,d,h,g,v=_.get(t);if($(t)){n.handler&&(n=(o=n).handler,i=o.selector),i&&ce.find.matchesSelector(J,i),n.guid||(n.guid=ce.guid++),(u=v.events)||(u=v.events=Object.create(null)),(a=v.handle)||(a=v.handle=function(e){return"undefined"!=typeof ce&&ce.event.triggered!==e.type?ce.event.dispatch.apply(t,arguments):void 0}),l=(e=(e||"").match(D)||[""]).length;while(l--)d=g=(s=De.exec(e[l])||[])[1],h=(s[2]||"").split(".").sort(),d&&(f=ce.event.special[d]||{},d=(i?f.delegateType:f.bindType)||d,f=ce.event.special[d]||{},c=ce.extend({type:d,origType:g,data:r,handler:n,guid:n.guid,selector:i,needsContext:i&&ce.expr.match.needsContext.test(i),namespace:h.join(".")},o),(p=u[d])||((p=u[d]=[]).delegateCount=0,f.setup&&!1!==f.setup.call(t,r,h,a)||t.addEventListener&&t.addEventListener(d,a)),f.add&&(f.add.call(t,c),c.handler.guid||(c.handler.guid=n.guid)),i?p.splice(p.delegateCount++,0,c):p.push(c),ce.event.global[d]=!0)}},remove:function(e,t,n,r,i){var o,a,s,u,l,c,f,p,d,h,g,v=_.hasData(e)&&_.get(e);if(v&&(u=v.events)){l=(t=(t||"").match(D)||[""]).length;while(l--)if(d=g=(s=De.exec(t[l])||[])[1],h=(s[2]||"").split(".").sort(),d){f=ce.event.special[d]||{},p=u[d=(r?f.delegateType:f.bindType)||d]||[],s=s[2]&&new RegExp("(^|\\.)"+h.join("\\.(?:.*\\.|)")+"(\\.|$)"),a=o=p.length;while(o--)c=p[o],!i&&g!==c.origType||n&&n.guid!==c.guid||s&&!s.test(c.namespace)||r&&r!==c.selector&&("**"!==r||!c.selector)||(p.splice(o,1),c.selector&&p.delegateCount--,f.remove&&f.remove.call(e,c));a&&!p.length&&(f.teardown&&!1!==f.teardown.call(e,h,v.handle)||ce.removeEvent(e,d,v.handle),delete u[d])}else for(d in u)ce.event.remove(e,d+t[l],n,r,!0);ce.isEmptyObject(u)&&_.remove(e,"handle events")}},dispatch:function(e){var t,n,r,i,o,a,s=new Array(arguments.length),u=ce.event.fix(e),l=(_.get(this,"events")||Object.create(null))[u.type]||[],c=ce.event.special[u.type]||{};for(s[0]=u,t=1;t<arguments.length;t++)s[t]=arguments[t];if(u.delegateTarget=this,!c.preDispatch||!1!==c.preDispatch.call(this,u)){a=ce.event.handlers.call(this,u,l),t=0;while((i=a[t++])&&!u.isPropagationStopped()){u.currentTarget=i.elem,n=0;while((o=i.handlers[n++])&&!u.isImmediatePropagationStopped())u.rnamespace&&!1!==o.namespace&&!u.rnamespace.test(o.namespace)||(u.handleObj=o,u.data=o.data,void 0!==(r=((ce.event.special[o.origType]||{}).handle||o.handler).apply(i.elem,s))&&!1===(u.result=r)&&(u.preventDefault(),u.stopPropagation()))}return c.postDispatch&&c.postDispatch.call(this,u),u.result}},handlers:function(e,t){var n,r,i,o,a,s=[],u=t.delegateCount,l=e.target;if(u&&l.nodeType&&!("click"===e.type&&1<=e.button))for(;l!==this;l=l.parentNode||this)if(1===l.nodeType&&("click"!==e.type||!0!==l.disabled)){for(o=[],a={},n=0;n<u;n++)void 0===a[i=(r=t[n]).selector+" "]&&(a[i]=r.needsContext?-1<ce(i,this).index(l):ce.find(i,this,null,[l]).length),a[i]&&o.push(r);o.length&&s.push({elem:l,handlers:o})}return l=this,u<t.length&&s.push({elem:l,handlers:t.slice(u)}),s},addProp:function(t,e){Object.defineProperty(ce.Event.prototype,t,{enumerable:!0,configurable:!0,get:v(e)?function(){if(this.originalEvent)return e(this.originalEvent)}:function(){if(this.originalEvent)return this.originalEvent[t]},set:function(e){Object.defineProperty(this,t,{enumerable:!0,configurable:!0,writable:!0,value:e})}})},fix:function(e){return e[ce.expando]?e:new ce.Event(e)},special:{load:{noBubble:!0},click:{setup:function(e){var t=this||e;return we.test(t.type)&&t.click&&fe(t,"input")&&He(t,"click",!0),!1},trigger:function(e){var t=this||e;return we.test(t.type)&&t.click&&fe(t,"input")&&He(t,"click"),!0},_default:function(e){var t=e.target;return we.test(t.type)&&t.click&&fe(t,"input")&&_.get(t,"click")||fe(t,"a")}},beforeunload:{postDispatch:function(e){void 0!==e.result&&e.originalEvent&&(e.originalEvent.returnValue=e.result)}}}},ce.removeEvent=function(e,t,n){e.removeEventListener&&e.removeEventListener(t,n)},ce.Event=function(e,t){if(!(this instanceof ce.Event))return new ce.Event(e,t);e&&e.type?(this.originalEvent=e,this.type=e.type,this.isDefaultPrevented=e.defaultPrevented||void 0===e.defaultPrevented&&!1===e.returnValue?Ne:qe,this.target=e.target&&3===e.target.nodeType?e.target.parentNode:e.target,this.currentTarget=e.currentTarget,this.relatedTarget=e.relatedTarget):this.type=e,t&&ce.extend(this,t),this.timeStamp=e&&e.timeStamp||Date.now(),this[ce.expando]=!0},ce.Event.prototype={constructor:ce.Event,isDefaultPrevented:qe,isPropagationStopped:qe,isImmediatePropagationStopped:qe,isSimulated:!1,preventDefault:function(){var e=this.originalEvent;this.isDefaultPrevented=Ne,e&&!this.isSimulated&&e.preventDefault()},stopPropagation:function(){var e=this.originalEvent;this.isPropagationStopped=Ne,e&&!this.isSimulated&&e.stopPropagation()},stopImmediatePropagation:function(){var e=this.originalEvent;this.isImmediatePropagationStopped=Ne,e&&!this.isSimulated&&e.stopImmediatePropagation(),this.stopPropagation()}},ce.each({altKey:!0,bubbles:!0,cancelable:!0,changedTouches:!0,ctrlKey:!0,detail:!0,eventPhase:!0,metaKey:!0,pageX:!0,pageY:!0,shiftKey:!0,view:!0,"char":!0,code:!0,charCode:!0,key:!0,keyCode:!0,button:!0,buttons:!0,clientX:!0,clientY:!0,offsetX:!0,offsetY:!0,pointerId:!0,pointerType:!0,screenX:!0,screenY:!0,targetTouches:!0,toElement:!0,touches:!0,which:!0},ce.event.addProp),ce.each({focus:"focusin",blur:"focusout"},function(r,i){function o(e){if(C.documentMode){var t=_.get(this,"handle"),n=ce.event.fix(e);n.type="focusin"===e.type?"focus":"blur",n.isSimulated=!0,t(e),n.target===n.currentTarget&&t(n)}else ce.event.simulate(i,e.target,ce.event.fix(e))}ce.event.special[r]={setup:function(){var e;if(He(this,r,!0),!C.documentMode)return!1;(e=_.get(this,i))||this.addEventListener(i,o),_.set(this,i,(e||0)+1)},trigger:function(){return He(this,r),!0},teardown:function(){var e;if(!C.documentMode)return!1;(e=_.get(this,i)-1)?_.set(this,i,e):(this.removeEventListener(i,o),_.remove(this,i))},_default:function(e){return _.get(e.target,r)},delegateType:i},ce.event.special[i]={setup:function(){var e=this.ownerDocument||this.document||this,t=C.documentMode?this:e,n=_.get(t,i);n||(C.documentMode?this.addEventListener(i,o):e.addEventListener(r,o,!0)),_.set(t,i,(n||0)+1)},teardown:function(){var e=this.ownerDocument||this.document||this,t=C.documentMode?this:e,n=_.get(t,i)-1;n?_.set(t,i,n):(C.documentMode?this.removeEventListener(i,o):e.removeEventListener(r,o,!0),_.remove(t,i))}}}),ce.each({mouseenter:"mouseover",mouseleave:"mouseout",pointerenter:"pointerover",pointerleave:"pointerout"},function(e,i){ce.event.special[e]={delegateType:i,bindType:i,handle:function(e){var t,n=e.relatedTarget,r=e.handleObj;return n&&(n===this||ce.contains(this,n))||(e.type=r.origType,t=r.handler.apply(this,arguments),e.type=i),t}}}),ce.fn.extend({on:function(e,t,n,r){return Le(this,e,t,n,r)},one:function(e,t,n,r){return Le(this,e,t,n,r,1)},off:function(e,t,n){var r,i;if(e&&e.preventDefault&&e.handleObj)return r=e.handleObj,ce(e.delegateTarget).off(r.namespace?r.origType+"."+r.namespace:r.origType,r.selector,r.handler),this;if("object"==typeof e){for(i in e)this.off(i,t,e[i]);return this}return!1!==t&&"function"!=typeof t||(n=t,t=void 0),!1===n&&(n=qe),this.each(function(){ce.event.remove(this,e,n,t)})}});var Oe=/<script|<style|<link/i,Pe=/checked\s*(?:[^=]|=\s*.checked.)/i,Me=/^\s*<!\[CDATA\[|\]\]>\s*$/g;function Re(e,t){return fe(e,"table")&&fe(11!==t.nodeType?t:t.firstChild,"tr")&&ce(e).children("tbody")[0]||e}function Ie(e){return e.type=(null!==e.getAttribute("type"))+"/"+e.type,e}function We(e){return"true/"===(e.type||"").slice(0,5)?e.type=e.type.slice(5):e.removeAttribute("type"),e}function Fe(e,t){var n,r,i,o,a,s;if(1===t.nodeType){if(_.hasData(e)&&(s=_.get(e).events))for(i in _.remove(t,"handle events"),s)for(n=0,r=s[i].length;n<r;n++)ce.event.add(t,i,s[i][n]);z.hasData(e)&&(o=z.access(e),a=ce.extend({},o),z.set(t,a))}}function $e(n,r,i,o){r=g(r);var e,t,a,s,u,l,c=0,f=n.length,p=f-1,d=r[0],h=v(d);if(h||1<f&&"string"==typeof d&&!le.checkClone&&Pe.test(d))return n.each(function(e){var t=n.eq(e);h&&(r[0]=d.call(this,e,t.html())),$e(t,r,i,o)});if(f&&(t=(e=Ae(r,n[0].ownerDocument,!1,n,o)).firstChild,1===e.childNodes.length&&(e=t),t||o)){for(s=(a=ce.map(Se(e,"script"),Ie)).length;c<f;c++)u=e,c!==p&&(u=ce.clone(u,!0,!0),s&&ce.merge(a,Se(u,"script"))),i.call(n[c],u,c);if(s)for(l=a[a.length-1].ownerDocument,ce.map(a,We),c=0;c<s;c++)u=a[c],Ce.test(u.type||"")&&!_.access(u,"globalEval")&&ce.contains(l,u)&&(u.src&&"module"!==(u.type||"").toLowerCase()?ce._evalUrl&&!u.noModule&&ce._evalUrl(u.src,{nonce:u.nonce||u.getAttribute("nonce")},l):m(u.textContent.replace(Me,""),u,l))}return n}function Be(e,t,n){for(var r,i=t?ce.filter(t,e):e,o=0;null!=(r=i[o]);o++)n||1!==r.nodeType||ce.cleanData(Se(r)),r.parentNode&&(n&&K(r)&&Ee(Se(r,"script")),r.parentNode.removeChild(r));return e}ce.extend({htmlPrefilter:function(e){return e},clone:function(e,t,n){var r,i,o,a,s,u,l,c=e.cloneNode(!0),f=K(e);if(!(le.noCloneChecked||1!==e.nodeType&&11!==e.nodeType||ce.isXMLDoc(e)))for(a=Se(c),r=0,i=(o=Se(e)).length;r<i;r++)s=o[r],u=a[r],void 0,"input"===(l=u.nodeName.toLowerCase())&&we.test(s.type)?u.checked=s.checked:"input"!==l&&"textarea"!==l||(u.defaultValue=s.defaultValue);if(t)if(n)for(o=o||Se(e),a=a||Se(c),r=0,i=o.length;r<i;r++)Fe(o[r],a[r]);else Fe(e,c);return 0<(a=Se(c,"script")).length&&Ee(a,!f&&Se(e,"script")),c},cleanData:function(e){for(var t,n,r,i=ce.event.special,o=0;void 0!==(n=e[o]);o++)if($(n)){if(t=n[_.expando]){if(t.events)for(r in t.events)i[r]?ce.event.remove(n,r):ce.removeEvent(n,r,t.handle);n[_.expando]=void 0}n[z.expando]&&(n[z.expando]=void 0)}}}),ce.fn.extend({detach:function(e){return Be(this,e,!0)},remove:function(e){return Be(this,e)},text:function(e){return M(this,function(e){return void 0===e?ce.text(this):this.empty().each(function(){1!==this.nodeType&&11!==this.nodeType&&9!==this.nodeType||(this.textContent=e)})},null,e,arguments.length)},append:function(){return $e(this,arguments,function(e){1!==this.nodeType&&11!==this.nodeType&&9!==this.nodeType||Re(this,e).appendChild(e)})},prepend:function(){return $e(this,arguments,function(e){if(1===this.nodeType||11===this.nodeType||9===this.nodeType){var t=Re(this,e);t.insertBefore(e,t.firstChild)}})},before:function(){return $e(this,arguments,function(e){this.parentNode&&this.parentNode.insertBefore(e,this)})},after:function(){return $e(this,arguments,function(e){this.parentNode&&this.parentNode.insertBefore(e,this.nextSibling)})},empty:function(){for(var e,t=0;null!=(e=this[t]);t++)1===e.nodeType&&(ce.cleanData(Se(e,!1)),e.textContent="");return this},clone:function(e,t){return e=null!=e&&e,t=null==t?e:t,this.map(function(){return ce.clone(this,e,t)})},html:function(e){return M(this,function(e){var t=this[0]||{},n=0,r=this.length;if(void 0===e&&1===t.nodeType)return t.innerHTML;if("string"==typeof e&&!Oe.test(e)&&!ke[(Te.exec(e)||["",""])[1].toLowerCase()]){e=ce.htmlPrefilter(e);try{for(;n<r;n++)1===(t=this[n]||{}).nodeType&&(ce.cleanData(Se(t,!1)),t.innerHTML=e);t=0}catch(e){}}t&&this.empty().append(e)},null,e,arguments.length)},replaceWith:function(){var n=[];return $e(this,arguments,function(e){var t=this.parentNode;ce.inArray(this,n)<0&&(ce.cleanData(Se(this)),t&&t.replaceChild(e,this))},n)}}),ce.each({appendTo:"append",prependTo:"prepend",insertBefore:"before",insertAfter:"after",replaceAll:"replaceWith"},function(e,a){ce.fn[e]=function(e){for(var t,n=[],r=ce(e),i=r.length-1,o=0;o<=i;o++)t=o===i?this:this.clone(!0),ce(r[o])[a](t),s.apply(n,t.get());return this.pushStack(n)}});var _e=new RegExp("^("+G+")(?!px)[a-z%]+$","i"),ze=/^--/,Xe=function(e){var t=e.ownerDocument.defaultView;return t&&t.opener||(t=ie),t.getComputedStyle(e)},Ue=function(e,t,n){var r,i,o={};for(i in t)o[i]=e.style[i],e.style[i]=t[i];for(i in r=n.call(e),t)e.style[i]=o[i];return r},Ve=new RegExp(Q.join("|"),"i");function Ge(e,t,n){var r,i,o,a,s=ze.test(t),u=e.style;return(n=n||Xe(e))&&(a=n.getPropertyValue(t)||n[t],s&&a&&(a=a.replace(ve,"$1")||void 0),""!==a||K(e)||(a=ce.style(e,t)),!le.pixelBoxStyles()&&_e.test(a)&&Ve.test(t)&&(r=u.width,i=u.minWidth,o=u.maxWidth,u.minWidth=u.maxWidth=u.width=a,a=n.width,u.width=r,u.minWidth=i,u.maxWidth=o)),void 0!==a?a+"":a}function Ye(e,t){return{get:function(){if(!e())return(this.get=t).apply(this,arguments);delete this.get}}}!function(){function e(){if(l){u.style.cssText="position:absolute;left:-11111px;width:60px;margin-top:1px;padding:0;border:0",l.style.cssText="position:relative;display:block;box-sizing:border-box;overflow:scroll;margin:auto;border:1px;padding:1px;width:60%;top:1%",J.appendChild(u).appendChild(l);var e=ie.getComputedStyle(l);n="1%"!==e.top,s=12===t(e.marginLeft),l.style.right="60%",o=36===t(e.right),r=36===t(e.width),l.style.position="absolute",i=12===t(l.offsetWidth/3),J.removeChild(u),l=null}}function t(e){return Math.round(parseFloat(e))}var n,r,i,o,a,s,u=C.createElement("div"),l=C.createElement("div");l.style&&(l.style.backgroundClip="content-box",l.cloneNode(!0).style.backgroundClip="",le.clearCloneStyle="content-box"===l.style.backgroundClip,ce.extend(le,{boxSizingReliable:function(){return e(),r},pixelBoxStyles:function(){return e(),o},pixelPosition:function(){return e(),n},reliableMarginLeft:function(){return e(),s},scrollboxSize:function(){return e(),i},reliableTrDimensions:function(){var e,t,n,r;return null==a&&(e=C.createElement("table"),t=C.createElement("tr"),n=C.createElement("div"),e.style.cssText="position:absolute;left:-11111px;border-collapse:separate",t.style.cssText="box-sizing:content-box;border:1px solid",t.style.height="1px",n.style.height="9px",n.style.display="block",J.appendChild(e).appendChild(t).appendChild(n),r=ie.getComputedStyle(t),a=parseInt(r.height,10)+parseInt(r.borderTopWidth,10)+parseInt(r.borderBottomWidth,10)===t.offsetHeight,J.removeChild(e)),a}}))}();var Qe=["Webkit","Moz","ms"],Je=C.createElement("div").style,Ke={};function Ze(e){var t=ce.cssProps[e]||Ke[e];return t||(e in Je?e:Ke[e]=function(e){var t=e[0].toUpperCase()+e.slice(1),n=Qe.length;while(n--)if((e=Qe[n]+t)in Je)return e}(e)||e)}var et=/^(none|table(?!-c[ea]).+)/,tt={position:"absolute",visibility:"hidden",display:"block"},nt={letterSpacing:"0",fontWeight:"400"};function rt(e,t,n){var r=Y.exec(t);return r?Math.max(0,r[2]-(n||0))+(r[3]||"px"):t}function it(e,t,n,r,i,o){var a="width"===t?1:0,s=0,u=0,l=0;if(n===(r?"border":"content"))return 0;for(;a<4;a+=2)"margin"===n&&(l+=ce.css(e,n+Q[a],!0,i)),r?("content"===n&&(u-=ce.css(e,"padding"+Q[a],!0,i)),"margin"!==n&&(u-=ce.css(e,"border"+Q[a]+"Width",!0,i))):(u+=ce.css(e,"padding"+Q[a],!0,i),"padding"!==n?u+=ce.css(e,"border"+Q[a]+"Width",!0,i):s+=ce.css(e,"border"+Q[a]+"Width",!0,i));return!r&&0<=o&&(u+=Math.max(0,Math.ceil(e["offset"+t[0].toUpperCase()+t.slice(1)]-o-u-s-.5))||0),u+l}function ot(e,t,n){var r=Xe(e),i=(!le.boxSizingReliable()||n)&&"border-box"===ce.css(e,"boxSizing",!1,r),o=i,a=Ge(e,t,r),s="offset"+t[0].toUpperCase()+t.slice(1);if(_e.test(a)){if(!n)return a;a="auto"}return(!le.boxSizingReliable()&&i||!le.reliableTrDimensions()&&fe(e,"tr")||"auto"===a||!parseFloat(a)&&"inline"===ce.css(e,"display",!1,r))&&e.getClientRects().length&&(i="border-box"===ce.css(e,"boxSizing",!1,r),(o=s in e)&&(a=e[s])),(a=parseFloat(a)||0)+it(e,t,n||(i?"border":"content"),o,r,a)+"px"}function at(e,t,n,r,i){return new at.prototype.init(e,t,n,r,i)}ce.extend({cssHooks:{opacity:{get:function(e,t){if(t){var n=Ge(e,"opacity");return""===n?"1":n}}}},cssNumber:{animationIterationCount:!0,aspectRatio:!0,borderImageSlice:!0,columnCount:!0,flexGrow:!0,flexShrink:!0,fontWeight:!0,gridArea:!0,gridColumn:!0,gridColumnEnd:!0,gridColumnStart:!0,gridRow:!0,gridRowEnd:!0,gridRowStart:!0,lineHeight:!0,opacity:!0,order:!0,orphans:!0,scale:!0,widows:!0,zIndex:!0,zoom:!0,fillOpacity:!0,floodOpacity:!0,stopOpacity:!0,strokeMiterlimit:!0,strokeOpacity:!0},cssProps:{},style:function(e,t,n,r){if(e&&3!==e.nodeType&&8!==e.nodeType&&e.style){var i,o,a,s=F(t),u=ze.test(t),l=e.style;if(u||(t=Ze(s)),a=ce.cssHooks[t]||ce.cssHooks[s],void 0===n)return a&&"get"in a&&void 0!==(i=a.get(e,!1,r))?i:l[t];"string"===(o=typeof n)&&(i=Y.exec(n))&&i[1]&&(n=te(e,t,i),o="number"),null!=n&&n==n&&("number"!==o||u||(n+=i&&i[3]||(ce.cssNumber[s]?"":"px")),le.clearCloneStyle||""!==n||0!==t.indexOf("background")||(l[t]="inherit"),a&&"set"in a&&void 0===(n=a.set(e,n,r))||(u?l.setProperty(t,n):l[t]=n))}},css:function(e,t,n,r){var i,o,a,s=F(t);return ze.test(t)||(t=Ze(s)),(a=ce.cssHooks[t]||ce.cssHooks[s])&&"get"in a&&(i=a.get(e,!0,n)),void 0===i&&(i=Ge(e,t,r)),"normal"===i&&t in nt&&(i=nt[t]),""===n||n?(o=parseFloat(i),!0===n||isFinite(o)?o||0:i):i}}),ce.each(["height","width"],function(e,u){ce.cssHooks[u]={get:function(e,t,n){if(t)return!et.test(ce.css(e,"display"))||e.getClientRects().length&&e.getBoundingClientRect().width?ot(e,u,n):Ue(e,tt,function(){return ot(e,u,n)})},set:function(e,t,n){var r,i=Xe(e),o=!le.scrollboxSize()&&"absolute"===i.position,a=(o||n)&&"border-box"===ce.css(e,"boxSizing",!1,i),s=n?it(e,u,n,a,i):0;return a&&o&&(s-=Math.ceil(e["offset"+u[0].toUpperCase()+u.slice(1)]-parseFloat(i[u])-it(e,u,"border",!1,i)-.5)),s&&(r=Y.exec(t))&&"px"!==(r[3]||"px")&&(e.style[u]=t,t=ce.css(e,u)),rt(0,t,s)}}}),ce.cssHooks.marginLeft=Ye(le.reliableMarginLeft,function(e,t){if(t)return(parseFloat(Ge(e,"marginLeft"))||e.getBoundingClientRect().left-Ue(e,{marginLeft:0},function(){return e.getBoundingClientRect().left}))+"px"}),ce.each({margin:"",padding:"",border:"Width"},function(i,o){ce.cssHooks[i+o]={expand:function(e){for(var t=0,n={},r="string"==typeof e?e.split(" "):[e];t<4;t++)n[i+Q[t]+o]=r[t]||r[t-2]||r[0];return n}},"margin"!==i&&(ce.cssHooks[i+o].set=rt)}),ce.fn.extend({css:function(e,t){return M(this,function(e,t,n){var r,i,o={},a=0;if(Array.isArray(t)){for(r=Xe(e),i=t.length;a<i;a++)o[t[a]]=ce.css(e,t[a],!1,r);return o}return void 0!==n?ce.style(e,t,n):ce.css(e,t)},e,t,1<arguments.length)}}),((ce.Tween=at).prototype={constructor:at,init:function(e,t,n,r,i,o){this.elem=e,this.prop=n,this.easing=i||ce.easing._default,this.options=t,this.start=this.now=this.cur(),this.end=r,this.unit=o||(ce.cssNumber[n]?"":"px")},cur:function(){var e=at.propHooks[this.prop];return e&&e.get?e.get(this):at.propHooks._default.get(this)},run:function(e){var t,n=at.propHooks[this.prop];return this.options.duration?this.pos=t=ce.easing[this.easing](e,this.options.duration*e,0,1,this.options.duration):this.pos=t=e,this.now=(this.end-this.start)*t+this.start,this.options.step&&this.options.step.call(this.elem,this.now,this),n&&n.set?n.set(this):at.propHooks._default.set(this),this}}).init.prototype=at.prototype,(at.propHooks={_default:{get:function(e){var t;return 1!==e.elem.nodeType||null!=e.elem[e.prop]&&null==e.elem.style[e.prop]?e.elem[e.prop]:(t=ce.css(e.elem,e.prop,""))&&"auto"!==t?t:0},set:function(e){ce.fx.step[e.prop]?ce.fx.step[e.prop](e):1!==e.elem.nodeType||!ce.cssHooks[e.prop]&&null==e.elem.style[Ze(e.prop)]?e.elem[e.prop]=e.now:ce.style(e.elem,e.prop,e.now+e.unit)}}}).scrollTop=at.propHooks.scrollLeft={set:function(e){e.elem.nodeType&&e.elem.parentNode&&(e.elem[e.prop]=e.now)}},ce.easing={linear:function(e){return e},swing:function(e){return.5-Math.cos(e*Math.PI)/2},_default:"swing"},ce.fx=at.prototype.init,ce.fx.step={};var st,ut,lt,ct,ft=/^(?:toggle|show|hide)$/,pt=/queueHooks$/;function dt(){ut&&(!1===C.hidden&&ie.requestAnimationFrame?ie.requestAnimationFrame(dt):ie.setTimeout(dt,ce.fx.interval),ce.fx.tick())}function ht(){return ie.setTimeout(function(){st=void 0}),st=Date.now()}function gt(e,t){var n,r=0,i={height:e};for(t=t?1:0;r<4;r+=2-t)i["margin"+(n=Q[r])]=i["padding"+n]=e;return t&&(i.opacity=i.width=e),i}function vt(e,t,n){for(var r,i=(yt.tweeners[t]||[]).concat(yt.tweeners["*"]),o=0,a=i.length;o<a;o++)if(r=i[o].call(n,t,e))return r}function yt(o,e,t){var n,a,r=0,i=yt.prefilters.length,s=ce.Deferred().always(function(){delete u.elem}),u=function(){if(a)return!1;for(var e=st||ht(),t=Math.max(0,l.startTime+l.duration-e),n=1-(t/l.duration||0),r=0,i=l.tweens.length;r<i;r++)l.tweens[r].run(n);return s.notifyWith(o,[l,n,t]),n<1&&i?t:(i||s.notifyWith(o,[l,1,0]),s.resolveWith(o,[l]),!1)},l=s.promise({elem:o,props:ce.extend({},e),opts:ce.extend(!0,{specialEasing:{},easing:ce.easing._default},t),originalProperties:e,originalOptions:t,startTime:st||ht(),duration:t.duration,tweens:[],createTween:function(e,t){var n=ce.Tween(o,l.opts,e,t,l.opts.specialEasing[e]||l.opts.easing);return l.tweens.push(n),n},stop:function(e){var t=0,n=e?l.tweens.length:0;if(a)return this;for(a=!0;t<n;t++)l.tweens[t].run(1);return e?(s.notifyWith(o,[l,1,0]),s.resolveWith(o,[l,e])):s.rejectWith(o,[l,e]),this}}),c=l.props;for(!function(e,t){var n,r,i,o,a;for(n in e)if(i=t[r=F(n)],o=e[n],Array.isArray(o)&&(i=o[1],o=e[n]=o[0]),n!==r&&(e[r]=o,delete e[n]),(a=ce.cssHooks[r])&&"expand"in a)for(n in o=a.expand(o),delete e[r],o)n in e||(e[n]=o[n],t[n]=i);else t[r]=i}(c,l.opts.specialEasing);r<i;r++)if(n=yt.prefilters[r].call(l,o,c,l.opts))return v(n.stop)&&(ce._queueHooks(l.elem,l.opts.queue).stop=n.stop.bind(n)),n;return ce.map(c,vt,l),v(l.opts.start)&&l.opts.start.call(o,l),l.progress(l.opts.progress).done(l.opts.done,l.opts.complete).fail(l.opts.fail).always(l.opts.always),ce.fx.timer(ce.extend(u,{elem:o,anim:l,queue:l.opts.queue})),l}ce.Animation=ce.extend(yt,{tweeners:{"*":[function(e,t){var n=this.createTween(e,t);return te(n.elem,e,Y.exec(t),n),n}]},tweener:function(e,t){v(e)?(t=e,e=["*"]):e=e.match(D);for(var n,r=0,i=e.length;r<i;r++)n=e[r],yt.tweeners[n]=yt.tweeners[n]||[],yt.tweeners[n].unshift(t)},prefilters:[function(e,t,n){var r,i,o,a,s,u,l,c,f="width"in t||"height"in t,p=this,d={},h=e.style,g=e.nodeType&&ee(e),v=_.get(e,"fxshow");for(r in n.queue||(null==(a=ce._queueHooks(e,"fx")).unqueued&&(a.unqueued=0,s=a.empty.fire,a.empty.fire=function(){a.unqueued||s()}),a.unqueued++,p.always(function(){p.always(function(){a.unqueued--,ce.queue(e,"fx").length||a.empty.fire()})})),t)if(i=t[r],ft.test(i)){if(delete t[r],o=o||"toggle"===i,i===(g?"hide":"show")){if("show"!==i||!v||void 0===v[r])continue;g=!0}d[r]=v&&v[r]||ce.style(e,r)}if((u=!ce.isEmptyObject(t))||!ce.isEmptyObject(d))for(r in f&&1===e.nodeType&&(n.overflow=[h.overflow,h.overflowX,h.overflowY],null==(l=v&&v.display)&&(l=_.get(e,"display")),"none"===(c=ce.css(e,"display"))&&(l?c=l:(re([e],!0),l=e.style.display||l,c=ce.css(e,"display"),re([e]))),("inline"===c||"inline-block"===c&&null!=l)&&"none"===ce.css(e,"float")&&(u||(p.done(function(){h.display=l}),null==l&&(c=h.display,l="none"===c?"":c)),h.display="inline-block")),n.overflow&&(h.overflow="hidden",p.always(function(){h.overflow=n.overflow[0],h.overflowX=n.overflow[1],h.overflowY=n.overflow[2]})),u=!1,d)u||(v?"hidden"in v&&(g=v.hidden):v=_.access(e,"fxshow",{display:l}),o&&(v.hidden=!g),g&&re([e],!0),p.done(function(){for(r in g||re([e]),_.remove(e,"fxshow"),d)ce.style(e,r,d[r])})),u=vt(g?v[r]:0,r,p),r in v||(v[r]=u.start,g&&(u.end=u.start,u.start=0))}],prefilter:function(e,t){t?yt.prefilters.unshift(e):yt.prefilters.push(e)}}),ce.speed=function(e,t,n){var r=e&&"object"==typeof e?ce.extend({},e):{complete:n||!n&&t||v(e)&&e,duration:e,easing:n&&t||t&&!v(t)&&t};return ce.fx.off?r.duration=0:"number"!=typeof r.duration&&(r.duration in ce.fx.speeds?r.duration=ce.fx.speeds[r.duration]:r.duration=ce.fx.speeds._default),null!=r.queue&&!0!==r.queue||(r.queue="fx"),r.old=r.complete,r.complete=function(){v(r.old)&&r.old.call(this),r.queue&&ce.dequeue(this,r.queue)},r},ce.fn.extend({fadeTo:function(e,t,n,r){return this.filter(ee).css("opacity",0).show().end().animate({opacity:t},e,n,r)},animate:function(t,e,n,r){var i=ce.isEmptyObject(t),o=ce.speed(e,n,r),a=function(){var e=yt(this,ce.extend({},t),o);(i||_.get(this,"finish"))&&e.stop(!0)};return a.finish=a,i||!1===o.queue?this.each(a):this.queue(o.queue,a)},stop:function(i,e,o){var a=function(e){var t=e.stop;delete e.stop,t(o)};return"string"!=typeof i&&(o=e,e=i,i=void 0),e&&this.queue(i||"fx",[]),this.each(function(){var e=!0,t=null!=i&&i+"queueHooks",n=ce.timers,r=_.get(this);if(t)r[t]&&r[t].stop&&a(r[t]);else for(t in r)r[t]&&r[t].stop&&pt.test(t)&&a(r[t]);for(t=n.length;t--;)n[t].elem!==this||null!=i&&n[t].queue!==i||(n[t].anim.stop(o),e=!1,n.splice(t,1));!e&&o||ce.dequeue(this,i)})},finish:function(a){return!1!==a&&(a=a||"fx"),this.each(function(){var e,t=_.get(this),n=t[a+"queue"],r=t[a+"queueHooks"],i=ce.timers,o=n?n.length:0;for(t.finish=!0,ce.queue(this,a,[]),r&&r.stop&&r.stop.call(this,!0),e=i.length;e--;)i[e].elem===this&&i[e].queue===a&&(i[e].anim.stop(!0),i.splice(e,1));for(e=0;e<o;e++)n[e]&&n[e].finish&&n[e].finish.call(this);delete t.finish})}}),ce.each(["toggle","show","hide"],function(e,r){var i=ce.fn[r];ce.fn[r]=function(e,t,n){return null==e||"boolean"==typeof e?i.apply(this,arguments):this.animate(gt(r,!0),e,t,n)}}),ce.each({slideDown:gt("show"),slideUp:gt("hide"),slideToggle:gt("toggle"),fadeIn:{opacity:"show"},fadeOut:{opacity:"hide"},fadeToggle:{opacity:"toggle"}},function(e,r){ce.fn[e]=function(e,t,n){return this.animate(r,e,t,n)}}),ce.timers=[],ce.fx.tick=function(){var e,t=0,n=ce.timers;for(st=Date.now();t<n.length;t++)(e=n[t])()||n[t]!==e||n.splice(t--,1);n.length||ce.fx.stop(),st=void 0},ce.fx.timer=function(e){ce.timers.push(e),ce.fx.start()},ce.fx.interval=13,ce.fx.start=function(){ut||(ut=!0,dt())},ce.fx.stop=function(){ut=null},ce.fx.speeds={slow:600,fast:200,_default:400},ce.fn.delay=function(r,e){return r=ce.fx&&ce.fx.speeds[r]||r,e=e||"fx",this.queue(e,function(e,t){var n=ie.setTimeout(e,r);t.stop=function(){ie.clearTimeout(n)}})},lt=C.createElement("input"),ct=C.createElement("select").appendChild(C.createElement("option")),lt.type="checkbox",le.checkOn=""!==lt.value,le.optSelected=ct.selected,(lt=C.createElement("input")).value="t",lt.type="radio",le.radioValue="t"===lt.value;var mt,xt=ce.expr.attrHandle;ce.fn.extend({attr:function(e,t){return M(this,ce.attr,e,t,1<arguments.length)},removeAttr:function(e){return this.each(function(){ce.removeAttr(this,e)})}}),ce.extend({attr:function(e,t,n){var r,i,o=e.nodeType;if(3!==o&&8!==o&&2!==o)return"undefined"==typeof e.getAttribute?ce.prop(e,t,n):(1===o&&ce.isXMLDoc(e)||(i=ce.attrHooks[t.toLowerCase()]||(ce.expr.match.bool.test(t)?mt:void 0)),void 0!==n?null===n?void ce.removeAttr(e,t):i&&"set"in i&&void 0!==(r=i.set(e,n,t))?r:(e.setAttribute(t,n+""),n):i&&"get"in i&&null!==(r=i.get(e,t))?r:null==(r=ce.find.attr(e,t))?void 0:r)},attrHooks:{type:{set:function(e,t){if(!le.radioValue&&"radio"===t&&fe(e,"input")){var n=e.value;return e.setAttribute("type",t),n&&(e.value=n),t}}}},removeAttr:function(e,t){var n,r=0,i=t&&t.match(D);if(i&&1===e.nodeType)while(n=i[r++])e.removeAttribute(n)}}),mt={set:function(e,t,n){return!1===t?ce.removeAttr(e,n):e.setAttribute(n,n),n}},ce.each(ce.expr.match.bool.source.match(/\w+/g),function(e,t){var a=xt[t]||ce.find.attr;xt[t]=function(e,t,n){var r,i,o=t.toLowerCase();return n||(i=xt[o],xt[o]=r,r=null!=a(e,t,n)?o:null,xt[o]=i),r}});var bt=/^(?:input|select|textarea|button)$/i,wt=/^(?:a|area)$/i;function Tt(e){return(e.match(D)||[]).join(" ")}function Ct(e){return e.getAttribute&&e.getAttribute("class")||""}function kt(e){return Array.isArray(e)?e:"string"==typeof e&&e.match(D)||[]}ce.fn.extend({prop:function(e,t){return M(this,ce.prop,e,t,1<arguments.length)},removeProp:function(e){return this.each(function(){delete this[ce.propFix[e]||e]})}}),ce.extend({prop:function(e,t,n){var r,i,o=e.nodeType;if(3!==o&&8!==o&&2!==o)return 1===o&&ce.isXMLDoc(e)||(t=ce.propFix[t]||t,i=ce.propHooks[t]),void 0!==n?i&&"set"in i&&void 0!==(r=i.set(e,n,t))?r:e[t]=n:i&&"get"in i&&null!==(r=i.get(e,t))?r:e[t]},propHooks:{tabIndex:{get:function(e){var t=ce.find.attr(e,"tabindex");return t?parseInt(t,10):bt.test(e.nodeName)||wt.test(e.nodeName)&&e.href?0:-1}}},propFix:{"for":"htmlFor","class":"className"}}),le.optSelected||(ce.propHooks.selected={get:function(e){var t=e.parentNode;return t&&t.parentNode&&t.parentNode.selectedIndex,null},set:function(e){var t=e.parentNode;t&&(t.selectedIndex,t.parentNode&&t.parentNode.selectedIndex)}}),ce.each(["tabIndex","readOnly","maxLength","cellSpacing","cellPadding","rowSpan","colSpan","useMap","frameBorder","contentEditable"],function(){ce.propFix[this.toLowerCase()]=this}),ce.fn.extend({addClass:function(t){var e,n,r,i,o,a;return v(t)?this.each(function(e){ce(this).addClass(t.call(this,e,Ct(this)))}):(e=kt(t)).length?this.each(function(){if(r=Ct(this),n=1===this.nodeType&&" "+Tt(r)+" "){for(o=0;o<e.length;o++)i=e[o],n.indexOf(" "+i+" ")<0&&(n+=i+" ");a=Tt(n),r!==a&&this.setAttribute("class",a)}}):this},removeClass:function(t){var e,n,r,i,o,a;return v(t)?this.each(function(e){ce(this).removeClass(t.call(this,e,Ct(this)))}):arguments.length?(e=kt(t)).length?this.each(function(){if(r=Ct(this),n=1===this.nodeType&&" "+Tt(r)+" "){for(o=0;o<e.length;o++){i=e[o];while(-1<n.indexOf(" "+i+" "))n=n.replace(" "+i+" "," ")}a=Tt(n),r!==a&&this.setAttribute("class",a)}}):this:this.attr("class","")},toggleClass:function(t,n){var e,r,i,o,a=typeof t,s="string"===a||Array.isArray(t);return v(t)?this.each(function(e){ce(this).toggleClass(t.call(this,e,Ct(this),n),n)}):"boolean"==typeof n&&s?n?this.addClass(t):this.removeClass(t):(e=kt(t),this.each(function(){if(s)for(o=ce(this),i=0;i<e.length;i++)r=e[i],o.hasClass(r)?o.removeClass(r):o.addClass(r);else void 0!==t&&"boolean"!==a||((r=Ct(this))&&_.set(this,"__className__",r),this.setAttribute&&this.setAttribute("class",r||!1===t?"":_.get(this,"__className__")||""))}))},hasClass:function(e){var t,n,r=0;t=" "+e+" ";while(n=this[r++])if(1===n.nodeType&&-1<(" "+Tt(Ct(n))+" ").indexOf(t))return!0;return!1}});var St=/\r/g;ce.fn.extend({val:function(n){var r,e,i,t=this[0];return arguments.length?(i=v(n),this.each(function(e){var t;1===this.nodeType&&(null==(t=i?n.call(this,e,ce(this).val()):n)?t="":"number"==typeof t?t+="":Array.isArray(t)&&(t=ce.map(t,function(e){return null==e?"":e+""})),(r=ce.valHooks[this.type]||ce.valHooks[this.nodeName.toLowerCase()])&&"set"in r&&void 0!==r.set(this,t,"value")||(this.value=t))})):t?(r=ce.valHooks[t.type]||ce.valHooks[t.nodeName.toLowerCase()])&&"get"in r&&void 0!==(e=r.get(t,"value"))?e:"string"==typeof(e=t.value)?e.replace(St,""):null==e?"":e:void 0}}),ce.extend({valHooks:{option:{get:function(e){var t=ce.find.attr(e,"value");return null!=t?t:Tt(ce.text(e))}},select:{get:function(e){var t,n,r,i=e.options,o=e.selectedIndex,a="select-one"===e.type,s=a?null:[],u=a?o+1:i.length;for(r=o<0?u:a?o:0;r<u;r++)if(((n=i[r]).selected||r===o)&&!n.disabled&&(!n.parentNode.disabled||!fe(n.parentNode,"optgroup"))){if(t=ce(n).val(),a)return t;s.push(t)}return s},set:function(e,t){var n,r,i=e.options,o=ce.makeArray(t),a=i.length;while(a--)((r=i[a]).selected=-1<ce.inArray(ce.valHooks.option.get(r),o))&&(n=!0);return n||(e.selectedIndex=-1),o}}}}),ce.each(["radio","checkbox"],function(){ce.valHooks[this]={set:function(e,t){if(Array.isArray(t))return e.checked=-1<ce.inArray(ce(e).val(),t)}},le.checkOn||(ce.valHooks[this].get=function(e){return null===e.getAttribute("value")?"on":e.value})});var Et=ie.location,jt={guid:Date.now()},At=/\?/;ce.parseXML=function(e){var t,n;if(!e||"string"!=typeof e)return null;try{t=(new ie.DOMParser).parseFromString(e,"text/xml")}catch(e){}return n=t&&t.getElementsByTagName("parsererror")[0],t&&!n||ce.error("Invalid XML: "+(n?ce.map(n.childNodes,function(e){return e.textContent}).join("\n"):e)),t};var Dt=/^(?:focusinfocus|focusoutblur)$/,Nt=function(e){e.stopPropagation()};ce.extend(ce.event,{trigger:function(e,t,n,r){var i,o,a,s,u,l,c,f,p=[n||C],d=ue.call(e,"type")?e.type:e,h=ue.call(e,"namespace")?e.namespace.split("."):[];if(o=f=a=n=n||C,3!==n.nodeType&&8!==n.nodeType&&!Dt.test(d+ce.event.triggered)&&(-1<d.indexOf(".")&&(d=(h=d.split(".")).shift(),h.sort()),u=d.indexOf(":")<0&&"on"+d,(e=e[ce.expando]?e:new ce.Event(d,"object"==typeof e&&e)).isTrigger=r?2:3,e.namespace=h.join("."),e.rnamespace=e.namespace?new RegExp("(^|\\.)"+h.join("\\.(?:.*\\.|)")+"(\\.|$)"):null,e.result=void 0,e.target||(e.target=n),t=null==t?[e]:ce.makeArray(t,[e]),c=ce.event.special[d]||{},r||!c.trigger||!1!==c.trigger.apply(n,t))){if(!r&&!c.noBubble&&!y(n)){for(s=c.delegateType||d,Dt.test(s+d)||(o=o.parentNode);o;o=o.parentNode)p.push(o),a=o;a===(n.ownerDocument||C)&&p.push(a.defaultView||a.parentWindow||ie)}i=0;while((o=p[i++])&&!e.isPropagationStopped())f=o,e.type=1<i?s:c.bindType||d,(l=(_.get(o,"events")||Object.create(null))[e.type]&&_.get(o,"handle"))&&l.apply(o,t),(l=u&&o[u])&&l.apply&&$(o)&&(e.result=l.apply(o,t),!1===e.result&&e.preventDefault());return e.type=d,r||e.isDefaultPrevented()||c._default&&!1!==c._default.apply(p.pop(),t)||!$(n)||u&&v(n[d])&&!y(n)&&((a=n[u])&&(n[u]=null),ce.event.triggered=d,e.isPropagationStopped()&&f.addEventListener(d,Nt),n[d](),e.isPropagationStopped()&&f.removeEventListener(d,Nt),ce.event.triggered=void 0,a&&(n[u]=a)),e.result}},simulate:function(e,t,n){var r=ce.extend(new ce.Event,n,{type:e,isSimulated:!0});ce.event.trigger(r,null,t)}}),ce.fn.extend({trigger:function(e,t){return this.each(function(){ce.event.trigger(e,t,this)})},triggerHandler:function(e,t){var n=this[0];if(n)return ce.event.trigger(e,t,n,!0)}});var qt=/\[\]$/,Lt=/\r?\n/g,Ht=/^(?:submit|button|image|reset|file)$/i,Ot=/^(?:input|select|textarea|keygen)/i;function Pt(n,e,r,i){var t;if(Array.isArray(e))ce.each(e,function(e,t){r||qt.test(n)?i(n,t):Pt(n+"["+("object"==typeof t&&null!=t?e:"")+"]",t,r,i)});else if(r||"object"!==x(e))i(n,e);else for(t in e)Pt(n+"["+t+"]",e[t],r,i)}ce.param=function(e,t){var n,r=[],i=function(e,t){var n=v(t)?t():t;r[r.length]=encodeURIComponent(e)+"="+encodeURIComponent(null==n?"":n)};if(null==e)return"";if(Array.isArray(e)||e.jquery&&!ce.isPlainObject(e))ce.each(e,function(){i(this.name,this.value)});else for(n in e)Pt(n,e[n],t,i);return r.join("&")},ce.fn.extend({serialize:function(){return ce.param(this.serializeArray())},serializeArray:function(){return this.map(function(){var e=ce.prop(this,"elements");return e?ce.makeArray(e):this}).filter(function(){var e=this.type;return this.name&&!ce(this).is(":disabled")&&Ot.test(this.nodeName)&&!Ht.test(e)&&(this.checked||!we.test(e))}).map(function(e,t){var n=ce(this).val();return null==n?null:Array.isArray(n)?ce.map(n,function(e){return{name:t.name,value:e.replace(Lt,"\r\n")}}):{name:t.name,value:n.replace(Lt,"\r\n")}}).get()}});var Mt=/%20/g,Rt=/#.*$/,It=/([?&])_=[^&]*/,Wt=/^(.*?):[ \t]*([^\r\n]*)$/gm,Ft=/^(?:GET|HEAD)$/,$t=/^\/\//,Bt={},_t={},zt="*/".concat("*"),Xt=C.createElement("a");function Ut(o){return function(e,t){"string"!=typeof e&&(t=e,e="*");var n,r=0,i=e.toLowerCase().match(D)||[];if(v(t))while(n=i[r++])"+"===n[0]?(n=n.slice(1)||"*",(o[n]=o[n]||[]).unshift(t)):(o[n]=o[n]||[]).push(t)}}function Vt(t,i,o,a){var s={},u=t===_t;function l(e){var r;return s[e]=!0,ce.each(t[e]||[],function(e,t){var n=t(i,o,a);return"string"!=typeof n||u||s[n]?u?!(r=n):void 0:(i.dataTypes.unshift(n),l(n),!1)}),r}return l(i.dataTypes[0])||!s["*"]&&l("*")}function Gt(e,t){var n,r,i=ce.ajaxSettings.flatOptions||{};for(n in t)void 0!==t[n]&&((i[n]?e:r||(r={}))[n]=t[n]);return r&&ce.extend(!0,e,r),e}Xt.href=Et.href,ce.extend({active:0,lastModified:{},etag:{},ajaxSettings:{url:Et.href,type:"GET",isLocal:/^(?:about|app|app-storage|.+-extension|file|res|widget):$/.test(Et.protocol),global:!0,processData:!0,async:!0,contentType:"application/x-www-form-urlencoded; charset=UTF-8",accepts:{"*":zt,text:"text/plain",html:"text/html",xml:"application/xml, text/xml",json:"application/json, text/javascript"},contents:{xml:/\bxml\b/,html:/\bhtml/,json:/\bjson\b/},responseFields:{xml:"responseXML",text:"responseText",json:"responseJSON"},converters:{"* text":String,"text html":!0,"text json":JSON.parse,"text xml":ce.parseXML},flatOptions:{url:!0,context:!0}},ajaxSetup:function(e,t){return t?Gt(Gt(e,ce.ajaxSettings),t):Gt(ce.ajaxSettings,e)},ajaxPrefilter:Ut(Bt),ajaxTransport:Ut(_t),ajax:function(e,t){"object"==typeof e&&(t=e,e=void 0),t=t||{};var c,f,p,n,d,r,h,g,i,o,v=ce.ajaxSetup({},t),y=v.context||v,m=v.context&&(y.nodeType||y.jquery)?ce(y):ce.event,x=ce.Deferred(),b=ce.Callbacks("once memory"),w=v.statusCode||{},a={},s={},u="canceled",T={readyState:0,getResponseHeader:function(e){var t;if(h){if(!n){n={};while(t=Wt.exec(p))n[t[1].toLowerCase()+" "]=(n[t[1].toLowerCase()+" "]||[]).concat(t[2])}t=n[e.toLowerCase()+" "]}return null==t?null:t.join(", ")},getAllResponseHeaders:function(){return h?p:null},setRequestHeader:function(e,t){return null==h&&(e=s[e.toLowerCase()]=s[e.toLowerCase()]||e,a[e]=t),this},overrideMimeType:function(e){return null==h&&(v.mimeType=e),this},statusCode:function(e){var t;if(e)if(h)T.always(e[T.status]);else for(t in e)w[t]=[w[t],e[t]];return this},abort:function(e){var t=e||u;return c&&c.abort(t),l(0,t),this}};if(x.promise(T),v.url=((e||v.url||Et.href)+"").replace($t,Et.protocol+"//"),v.type=t.method||t.type||v.method||v.type,v.dataTypes=(v.dataType||"*").toLowerCase().match(D)||[""],null==v.crossDomain){r=C.createElement("a");try{r.href=v.url,r.href=r.href,v.crossDomain=Xt.protocol+"//"+Xt.host!=r.protocol+"//"+r.host}catch(e){v.crossDomain=!0}}if(v.data&&v.processData&&"string"!=typeof v.data&&(v.data=ce.param(v.data,v.traditional)),Vt(Bt,v,t,T),h)return T;for(i in(g=ce.event&&v.global)&&0==ce.active++&&ce.event.trigger("ajaxStart"),v.type=v.type.toUpperCase(),v.hasContent=!Ft.test(v.type),f=v.url.replace(Rt,""),v.hasContent?v.data&&v.processData&&0===(v.contentType||"").indexOf("application/x-www-form-urlencoded")&&(v.data=v.data.replace(Mt,"+")):(o=v.url.slice(f.length),v.data&&(v.processData||"string"==typeof v.data)&&(f+=(At.test(f)?"&":"?")+v.data,delete v.data),!1===v.cache&&(f=f.replace(It,"$1"),o=(At.test(f)?"&":"?")+"_="+jt.guid+++o),v.url=f+o),v.ifModified&&(ce.lastModified[f]&&T.setRequestHeader("If-Modified-Since",ce.lastModified[f]),ce.etag[f]&&T.setRequestHeader("If-None-Match",ce.etag[f])),(v.data&&v.hasContent&&!1!==v.contentType||t.contentType)&&T.setRequestHeader("Content-Type",v.contentType),T.setRequestHeader("Accept",v.dataTypes[0]&&v.accepts[v.dataTypes[0]]?v.accepts[v.dataTypes[0]]+("*"!==v.dataTypes[0]?", "+zt+"; q=0.01":""):v.accepts["*"]),v.headers)T.setRequestHeader(i,v.headers[i]);if(v.beforeSend&&(!1===v.beforeSend.call(y,T,v)||h))return T.abort();if(u="abort",b.add(v.complete),T.done(v.success),T.fail(v.error),c=Vt(_t,v,t,T)){if(T.readyState=1,g&&m.trigger("ajaxSend",[T,v]),h)return T;v.async&&0<v.timeout&&(d=ie.setTimeout(function(){T.abort("timeout")},v.timeout));try{h=!1,c.send(a,l)}catch(e){if(h)throw e;l(-1,e)}}else l(-1,"No Transport");function l(e,t,n,r){var i,o,a,s,u,l=t;h||(h=!0,d&&ie.clearTimeout(d),c=void 0,p=r||"",T.readyState=0<e?4:0,i=200<=e&&e<300||304===e,n&&(s=function(e,t,n){var r,i,o,a,s=e.contents,u=e.dataTypes;while("*"===u[0])u.shift(),void 0===r&&(r=e.mimeType||t.getResponseHeader("Content-Type"));if(r)for(i in s)if(s[i]&&s[i].test(r)){u.unshift(i);break}if(u[0]in n)o=u[0];else{for(i in n){if(!u[0]||e.converters[i+" "+u[0]]){o=i;break}a||(a=i)}o=o||a}if(o)return o!==u[0]&&u.unshift(o),n[o]}(v,T,n)),!i&&-1<ce.inArray("script",v.dataTypes)&&ce.inArray("json",v.dataTypes)<0&&(v.converters["text script"]=function(){}),s=function(e,t,n,r){var i,o,a,s,u,l={},c=e.dataTypes.slice();if(c[1])for(a in e.converters)l[a.toLowerCase()]=e.converters[a];o=c.shift();while(o)if(e.responseFields[o]&&(n[e.responseFields[o]]=t),!u&&r&&e.dataFilter&&(t=e.dataFilter(t,e.dataType)),u=o,o=c.shift())if("*"===o)o=u;else if("*"!==u&&u!==o){if(!(a=l[u+" "+o]||l["* "+o]))for(i in l)if((s=i.split(" "))[1]===o&&(a=l[u+" "+s[0]]||l["* "+s[0]])){!0===a?a=l[i]:!0!==l[i]&&(o=s[0],c.unshift(s[1]));break}if(!0!==a)if(a&&e["throws"])t=a(t);else try{t=a(t)}catch(e){return{state:"parsererror",error:a?e:"No conversion from "+u+" to "+o}}}return{state:"success",data:t}}(v,s,T,i),i?(v.ifModified&&((u=T.getResponseHeader("Last-Modified"))&&(ce.lastModified[f]=u),(u=T.getResponseHeader("etag"))&&(ce.etag[f]=u)),204===e||"HEAD"===v.type?l="nocontent":304===e?l="notmodified":(l=s.state,o=s.data,i=!(a=s.error))):(a=l,!e&&l||(l="error",e<0&&(e=0))),T.status=e,T.statusText=(t||l)+"",i?x.resolveWith(y,[o,l,T]):x.rejectWith(y,[T,l,a]),T.statusCode(w),w=void 0,g&&m.trigger(i?"ajaxSuccess":"ajaxError",[T,v,i?o:a]),b.fireWith(y,[T,l]),g&&(m.trigger("ajaxComplete",[T,v]),--ce.active||ce.event.trigger("ajaxStop")))}return T},getJSON:function(e,t,n){return ce.get(e,t,n,"json")},getScript:function(e,t){return ce.get(e,void 0,t,"script")}}),ce.each(["get","post"],function(e,i){ce[i]=function(e,t,n,r){return v(t)&&(r=r||n,n=t,t=void 0),ce.ajax(ce.extend({url:e,type:i,dataType:r,data:t,success:n},ce.isPlainObject(e)&&e))}}),ce.ajaxPrefilter(function(e){var t;for(t in e.headers)"content-type"===t.toLowerCase()&&(e.contentType=e.headers[t]||"")}),ce._evalUrl=function(e,t,n){return ce.ajax({url:e,type:"GET",dataType:"script",cache:!0,async:!1,global:!1,converters:{"text script":function(){}},dataFilter:function(e){ce.globalEval(e,t,n)}})},ce.fn.extend({wrapAll:function(e){var t;return this[0]&&(v(e)&&(e=e.call(this[0])),t=ce(e,this[0].ownerDocument).eq(0).clone(!0),this[0].parentNode&&t.insertBefore(this[0]),t.map(function(){var e=this;while(e.firstElementChild)e=e.firstElementChild;return e}).append(this)),this},wrapInner:function(n){return v(n)?this.each(function(e){ce(this).wrapInner(n.call(this,e))}):this.each(function(){var e=ce(this),t=e.contents();t.length?t.wrapAll(n):e.append(n)})},wrap:function(t){var n=v(t);return this.each(function(e){ce(this).wrapAll(n?t.call(this,e):t)})},unwrap:function(e){return this.parent(e).not("body").each(function(){ce(this).replaceWith(this.childNodes)}),this}}),ce.expr.pseudos.hidden=function(e){return!ce.expr.pseudos.visible(e)},ce.expr.pseudos.visible=function(e){return!!(e.offsetWidth||e.offsetHeight||e.getClientRects().length)},ce.ajaxSettings.xhr=function(){try{return new ie.XMLHttpRequest}catch(e){}};var Yt={0:200,1223:204},Qt=ce.ajaxSettings.xhr();le.cors=!!Qt&&"withCredentials"in Qt,le.ajax=Qt=!!Qt,ce.ajaxTransport(function(i){var o,a;if(le.cors||Qt&&!i.crossDomain)return{send:function(e,t){var n,r=i.xhr();if(r.open(i.type,i.url,i.async,i.username,i.password),i.xhrFields)for(n in i.xhrFields)r[n]=i.xhrFields[n];for(n in i.mimeType&&r.overrideMimeType&&r.overrideMimeType(i.mimeType),i.crossDomain||e["X-Requested-With"]||(e["X-Requested-With"]="XMLHttpRequest"),e)r.setRequestHeader(n,e[n]);o=function(e){return function(){o&&(o=a=r.onload=r.onerror=r.onabort=r.ontimeout=r.onreadystatechange=null,"abort"===e?r.abort():"error"===e?"number"!=typeof r.status?t(0,"error"):t(r.status,r.statusText):t(Yt[r.status]||r.status,r.statusText,"text"!==(r.responseType||"text")||"string"!=typeof r.responseText?{binary:r.response}:{text:r.responseText},r.getAllResponseHeaders()))}},r.onload=o(),a=r.onerror=r.ontimeout=o("error"),void 0!==r.onabort?r.onabort=a:r.onreadystatechange=function(){4===r.readyState&&ie.setTimeout(function(){o&&a()})},o=o("abort");try{r.send(i.hasContent&&i.data||null)}catch(e){if(o)throw e}},abort:function(){o&&o()}}}),ce.ajaxPrefilter(function(e){e.crossDomain&&(e.contents.script=!1)}),ce.ajaxSetup({accepts:{script:"text/javascript, application/javascript, application/ecmascript, application/x-ecmascript"},contents:{script:/\b(?:java|ecma)script\b/},converters:{"text script":function(e){return ce.globalEval(e),e}}}),ce.ajaxPrefilter("script",function(e){void 0===e.cache&&(e.cache=!1),e.crossDomain&&(e.type="GET")}),ce.ajaxTransport("script",function(n){var r,i;if(n.crossDomain||n.scriptAttrs)return{send:function(e,t){r=ce("<script>").attr(n.scriptAttrs||{}).prop({charset:n.scriptCharset,src:n.url}).on("load error",i=function(e){r.remove(),i=null,e&&t("error"===e.type?404:200,e.type)}),C.head.appendChild(r[0])},abort:function(){i&&i()}}});var Jt,Kt=[],Zt=/(=)\?(?=&|$)|\?\?/;ce.ajaxSetup({jsonp:"callback",jsonpCallback:function(){var e=Kt.pop()||ce.expando+"_"+jt.guid++;return this[e]=!0,e}}),ce.ajaxPrefilter("json jsonp",function(e,t,n){var r,i,o,a=!1!==e.jsonp&&(Zt.test(e.url)?"url":"string"==typeof e.data&&0===(e.contentType||"").indexOf("application/x-www-form-urlencoded")&&Zt.test(e.data)&&"data");if(a||"jsonp"===e.dataTypes[0])return r=e.jsonpCallback=v(e.jsonpCallback)?e.jsonpCallback():e.jsonpCallback,a?e[a]=e[a].replace(Zt,"$1"+r):!1!==e.jsonp&&(e.url+=(At.test(e.url)?"&":"?")+e.jsonp+"="+r),e.converters["script json"]=function(){return o||ce.error(r+" was not called"),o[0]},e.dataTypes[0]="json",i=ie[r],ie[r]=function(){o=arguments},n.always(function(){void 0===i?ce(ie).removeProp(r):ie[r]=i,e[r]&&(e.jsonpCallback=t.jsonpCallback,Kt.push(r)),o&&v(i)&&i(o[0]),o=i=void 0}),"script"}),le.createHTMLDocument=((Jt=C.implementation.createHTMLDocument("").body).innerHTML="<form></form><form></form>",2===Jt.childNodes.length),ce.parseHTML=function(e,t,n){return"string"!=typeof e?[]:("boolean"==typeof t&&(n=t,t=!1),t||(le.createHTMLDocument?((r=(t=C.implementation.createHTMLDocument("")).createElement("base")).href=C.location.href,t.head.appendChild(r)):t=C),o=!n&&[],(i=w.exec(e))?[t.createElement(i[1])]:(i=Ae([e],t,o),o&&o.length&&ce(o).remove(),ce.merge([],i.childNodes)));var r,i,o},ce.fn.load=function(e,t,n){var r,i,o,a=this,s=e.indexOf(" ");return-1<s&&(r=Tt(e.slice(s)),e=e.slice(0,s)),v(t)?(n=t,t=void 0):t&&"object"==typeof t&&(i="POST"),0<a.length&&ce.ajax({url:e,type:i||"GET",dataType:"html",data:t}).done(function(e){o=arguments,a.html(r?ce("<div>").append(ce.parseHTML(e)).find(r):e)}).always(n&&function(e,t){a.each(function(){n.apply(this,o||[e.responseText,t,e])})}),this},ce.expr.pseudos.animated=function(t){return ce.grep(ce.timers,function(e){return t===e.elem}).length},ce.offset={setOffset:function(e,t,n){var r,i,o,a,s,u,l=ce.css(e,"position"),c=ce(e),f={};"static"===l&&(e.style.position="relative"),s=c.offset(),o=ce.css(e,"top"),u=ce.css(e,"left"),("absolute"===l||"fixed"===l)&&-1<(o+u).indexOf("auto")?(a=(r=c.position()).top,i=r.left):(a=parseFloat(o)||0,i=parseFloat(u)||0),v(t)&&(t=t.call(e,n,ce.extend({},s))),null!=t.top&&(f.top=t.top-s.top+a),null!=t.left&&(f.left=t.left-s.left+i),"using"in t?t.using.call(e,f):c.css(f)}},ce.fn.extend({offset:function(t){if(arguments.length)return void 0===t?this:this.each(function(e){ce.offset.setOffset(this,t,e)});var e,n,r=this[0];return r?r.getClientRects().length?(e=r.getBoundingClientRect(),n=r.ownerDocument.defaultView,{top:e.top+n.pageYOffset,left:e.left+n.pageXOffset}):{top:0,left:0}:void 0},position:function(){if(this[0]){var e,t,n,r=this[0],i={top:0,left:0};if("fixed"===ce.css(r,"position"))t=r.getBoundingClientRect();else{t=this.offset(),n=r.ownerDocument,e=r.offsetParent||n.documentElement;while(e&&(e===n.body||e===n.documentElement)&&"static"===ce.css(e,"position"))e=e.parentNode;e&&e!==r&&1===e.nodeType&&((i=ce(e).offset()).top+=ce.css(e,"borderTopWidth",!0),i.left+=ce.css(e,"borderLeftWidth",!0))}return{top:t.top-i.top-ce.css(r,"marginTop",!0),left:t.left-i.left-ce.css(r,"marginLeft",!0)}}},offsetParent:function(){return this.map(function(){var e=this.offsetParent;while(e&&"static"===ce.css(e,"position"))e=e.offsetParent;return e||J})}}),ce.each({scrollLeft:"pageXOffset",scrollTop:"pageYOffset"},function(t,i){var o="pageYOffset"===i;ce.fn[t]=function(e){return M(this,function(e,t,n){var r;if(y(e)?r=e:9===e.nodeType&&(r=e.defaultView),void 0===n)return r?r[i]:e[t];r?r.scrollTo(o?r.pageXOffset:n,o?n:r.pageYOffset):e[t]=n},t,e,arguments.length)}}),ce.each(["top","left"],function(e,n){ce.cssHooks[n]=Ye(le.pixelPosition,function(e,t){if(t)return t=Ge(e,n),_e.test(t)?ce(e).position()[n]+"px":t})}),ce.each({Height:"height",Width:"width"},function(a,s){ce.each({padding:"inner"+a,content:s,"":"outer"+a},function(r,o){ce.fn[o]=function(e,t){var n=arguments.length&&(r||"boolean"!=typeof e),i=r||(!0===e||!0===t?"margin":"border");return M(this,function(e,t,n){var r;return y(e)?0===o.indexOf("outer")?e["inner"+a]:e.document.documentElement["client"+a]:9===e.nodeType?(r=e.documentElement,Math.max(e.body["scroll"+a],r["scroll"+a],e.body["offset"+a],r["offset"+a],r["client"+a])):void 0===n?ce.css(e,t,i):ce.style(e,t,n,i)},s,n?e:void 0,n)}})}),ce.each(["ajaxStart","ajaxStop","ajaxComplete","ajaxError","ajaxSuccess","ajaxSend"],function(e,t){ce.fn[t]=function(e){return this.on(t,e)}}),ce.fn.extend({bind:function(e,t,n){return this.on(e,null,t,n)},unbind:function(e,t){return this.off(e,null,t)},delegate:function(e,t,n,r){return this.on(t,e,n,r)},undelegate:function(e,t,n){return 1===arguments.length?this.off(e,"**"):this.off(t,e||"**",n)},hover:function(e,t){return this.on("mouseenter",e).on("mouseleave",t||e)}}),ce.each("blur focus focusin focusout resize scroll click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select submit keydown keypress keyup contextmenu".split(" "),function(e,n){ce.fn[n]=function(e,t){return 0<arguments.length?this.on(n,null,e,t):this.trigger(n)}});var en=/^[\s\uFEFF\xA0]+|([^\s\uFEFF\xA0])[\s\uFEFF\xA0]+$/g;ce.proxy=function(e,t){var n,r,i;if("string"==typeof t&&(n=e[t],t=e,e=n),v(e))return r=ae.call(arguments,2),(i=function(){return e.apply(t||this,r.concat(ae.call(arguments)))}).guid=e.guid=e.guid||ce.guid++,i},ce.holdReady=function(e){e?ce.readyWait++:ce.ready(!0)},ce.isArray=Array.isArray,ce.parseJSON=JSON.parse,ce.nodeName=fe,ce.isFunction=v,ce.isWindow=y,ce.camelCase=F,ce.type=x,ce.now=Date.now,ce.isNumeric=function(e){var t=ce.type(e);return("number"===t||"string"===t)&&!isNaN(e-parseFloat(e))},ce.trim=function(e){return null==e?"":(e+"").replace(en,"$1")},"function"==typeof define&&define.amd&&define("jquery",[],function(){return ce});var tn=ie.jQuery,nn=ie.$;return ce.noConflict=function(e){return ie.$===ce&&(ie.$=nn),e&&ie.jQuery===ce&&(ie.jQuery=tn),ce},"undefined"==typeof e&&(ie.jQuery=ie.$=ce),ce});
!(function () {
  const S = {
      page: "main",
      locale: "en",
      locales: {},
      selectedItem: null,
      selectedItems: [],
      selectedCategory: null,
      selectedGender: null,
      menuMode: null,
      categories: [],
      genders: {},
      items: {},
      attached: {},
      previewConfig: {},
      currentSide: "right",
      canSwitchSide: !1,
      activeMenu: null,
      playerGender: null,
      isDragging: !1,
      dragOffset: {
        x: 0,
        y: 0,
      },
      isRotateHolding: !1,
      attachedFanRadiusPx: 72,
      revealStepMs: 250,
      revealDurationMs: 200,
      radialSpeedMs: 600,
      radialAnimationEffect: "attachedChipRadialOpen",
      chipCascadeMs: 100,
      detachHoldMs: 4e3,
      itemImageBaseUrl: null,
      attachedRevealTimers: [],
      accRevealTimers: [],
      attachedChipHold: null,
      suppressAttachedChipClick: !1,
      openKey: null,
    },
    UI = {
      $menu: null,
      $attachedMenu: null,
      $accPanel: null,
    };
  function post(name, data = {}) {
    $.post(`https://${GetParentResourceName()}/${name}`, JSON.stringify(data));
  }
  function menuAction(action, payload = {}) {
    post("menuAction", {
      action: action,
      ...payload,
    });
  }
  // Fire accadminSpawn and, only after it confirms success, fire accadminEnterCalib.
  // Firing both simultaneously caused a race: accadminSpawn yields (Wait loop) while
  // loading the model, and accadminEnterCalib would execute against accadminProp=nil,
  // leaving bone/camera state partially initialised for the wrong prop.
  // _spawnToken ensures stale callbacks from a superseded spawn never fire enterCalib.
  let _spawnToken = null;
function spawnThenCalib(spawnData, calibData) {
  const token = {};
  _spawnToken = token;

  $.post(
    `https://${GetParentResourceName()}/accadminSpawn`,
    JSON.stringify(spawnData),
    function(responseText) {
      if (_spawnToken !== token) return;
      let result;
      try { result = typeof responseText === "string" ? JSON.parse(responseText) : responseText; } catch(e) { result = {}; }
      if (result && result.success) {
        $.post(`https://${GetParentResourceName()}/accadminEnterCalib`, JSON.stringify(calibData));
        if (AC.animKey) {
          setTimeout(() => $.post(`https://${GetParentResourceName()}/accadminPreviewAnim`, JSON.stringify({ key: AC.animKey })), 300);
        }
      }
    }
  );
}
function spawnByKey(key, calGender, calibData) {
  const token = {};
  _spawnToken = token;

  $.post(
    `https://${GetParentResourceName()}/accadminSpawnByKey`,
    JSON.stringify({ key, calGender, boneName: calibData.boneName || null, boneId: calibData.boneId !== undefined ? calibData.boneId : -1 }),
    function(responseText) {
      if (_spawnToken !== token) return;
      let result;
      try { result = typeof responseText === "string" ? JSON.parse(responseText) : responseText; } catch(e) { result = {}; }
      if (result && result.success && result.v) {
        // Prefer the bone the user selected in P2; fall back to server response only if not set
        const useBone   = calibData.boneName || result.boneName;
        const useBoneId = (calibData.boneId !== undefined && calibData.boneId >= 0) ? calibData.boneId : result.boneId;
        if (useBone)   { AC.bone = useBone; $("#c-accadminBoneTag").text("Bone: " + AC.bone); }
        if (useBoneId !== undefined && useBoneId >= 0) { AC.boneId = useBoneId; }
        if (result.fixedRot !== undefined) { AC.fixedRot = result.fixedRot; }
        if (result.modelName) { $("#c-iModel").val(result.modelName); $("#c-iModelVal").text(result.modelName); $("#c-iModelBtn").addClass("has-value has-anim"); }
        // Update AC.V directly from result — do NOT rely on accadminSyncValues timing
        AC.V.px    = result.v.px;
        AC.V.py    = result.v.py;
        AC.V.pz    = result.v.pz;
        AC.V.pitch = result.v.pitch;
        AC.V.roll  = result.v.roll;
        AC.V.yaw   = result.v.yaw;
        ["px","py","pz","pitch","roll","yaw"].forEach(function(a) {
          const el = document.getElementById("c-v-" + a);
          if (el) el.value = parseFloat(AC.V[a].toFixed(4));
        });
        const resolved = {
          boneName: AC.bone, boneId: AC.boneId, fixedRot: AC.fixedRot,
          px: result.v.px, py: result.v.py, pz: result.v.pz,
          pitch: result.v.pitch, roll: result.v.roll, yaw: result.v.yaw,
          step: calibData.step
        };
        $.post(`https://${GetParentResourceName()}/accadminEnterCalib`, JSON.stringify(resolved));
        if (AC.animKey) {
          setTimeout(() => $.post(`https://${GetParentResourceName()}/accadminPreviewAnim`, JSON.stringify({ key: AC.animKey })), 300);
        }
      }
    }
  );
}
  function t(key) {
    return S.locales?.[S.locale]?.[key] || key;
  }
  function normalize(v) {
    return String(v || "")
      .trim()
      .toLowerCase();
  }
  function normalizeSide(side) {
    const k = normalize(side);
    return "left" === k || "l" === k ? "left" : "right";
  }
  function normalizeCategoryKey(category) {
    const key = normalize(category);
    return "belt" === key || "waist" === key ? "waist" : key;
  }
  function getPreviewCategoryConfig(category) {
    const map = S.previewConfig?.Categories || S.previewConfig?.categories || {};
    const key = normalizeCategoryKey(category);
    return map[key] || null;
  }
  function categorySupportsSideSwitch(category) {
    const cfg = getPreviewCategoryConfig(category);
    const bones = Array.isArray(cfg?.Bones) ? cfg.Bones : Array.isArray(cfg?.bones) ? cfg.bones : [];
    return bones.length > 1;
  }
  function setPreviewSideUI(side, canSwitch) {
    const resolved = normalizeSide(side);
    S.currentSide = resolved;
    S.canSwitchSide = !!canSwitch;
    const $switch = $("#previewSideSwitch");
    if (!$switch.length) return;
    $switch.toggleClass("is-hidden", !S.canSwitchSide);
    $switch.find(".radial-side-node").removeClass("active");
    $switch.find(`.radial-side-node[data-side="${resolved}"]`).addClass("active");
  }
  function syncPreviewCategory(category) {
    if (!category) return;
    menuAction("previewSelectCategory", {
      category: category,
    });
    const canSwitch = categorySupportsSideSwitch(category);
    const fallbackSide = "left" === S.currentSide ? "left" : "right";
    setPreviewSideUI(canSwitch ? fallbackSide : "right", canSwitch);
  }
  function getResolvedGender() {
    const selected = normalize(S.selectedGender);
    if ("male" === selected || "female" === selected) return selected;
    const detected = normalize(S.playerGender);
    return "male" === detected || "female" === detected ? detected : "male";
  }
  function getDefaultSelectedGender() {
    const keys = Object.keys(S.genders || {});
    if (!keys.length) return null;
    if (S.playerGender) {
      const matched = keys.find((k) => normalize(k) === normalize(S.playerGender));
      if (matched) return matched;
    }
    return keys[0] || null;
  }
  function getGenderLabel(key) {
    const lk = `gender_${normalize(key)}`,
      localized = t(lk);
    return localized !== lk ? localized : S.genders?.[key] || key || "";
  }
  function getCategoryLabel(category) {
    if (!category) return "";
    const lk = `category_${"waist" === normalizeCategoryKey(category) ? "belt" : normalize(category)}`,
      localized = t(lk);
    return localized !== lk ? localized : category;
  }
  function getCategoryToken(category) {
    const label = getCategoryLabel(category);
    if (!label) return "?";
    const compact = label.replace(/\s+/g, "").trim();
    return compact.length <= 2 ? compact : compact.slice(0, 2);
  }
  function getRadialCategoryIconKey(category) {
    return (
      {
        head: "head",
        neck: "neck",
        torso: "torso",
        waist: "belt",
        belt: "belt",
        hand: "hand",
        arm: "arm",
        leg: "leg",
      }[normalize(category)] || null
    );
  }
  function getItemLabel(itemName) {
    const item = S.items[itemName] || {};
    return item.Label || item.label || itemName;
  }
  function getImage(itemName, itemData) {
    const fileName = itemData?.Image || `${itemName}.png`;
    if (S.itemImageBaseUrl) {
      return S.itemImageBaseUrl + fileName;
    }
    return `./assets/inventoryitemimages/${fileName}`;
  }
  // Always returns the local fallback path regardless of framework.
  // Used in onerror attributes so images degrade gracefully when the
  // inventory resource image is unavailable.
  function getLocalImage(itemName, itemData) {
    const fileName = itemData?.Image || `${itemName}.png`;
    return `./assets/inventoryitemimages/${fileName}`;
  }
  // Son fallback: resim bulunamazsa iconify ikonu göster
  // window'a atanması zorunlu — onerror HTML attribute global scope'tan çağırır
  window.accImgFallback = function accImgFallback(img) {
    img.style.display = "none";
    if (img.parentNode && !img.parentNode.querySelector("iconify-icon.acc-img-fb")) {
      var icon = document.createElement("iconify-icon");
      icon.setAttribute("icon", "game-icons:gems");
      icon.className = "acc-img-fb";
      icon.style.cssText = "font-size:18px;color:rgba(240,233,210,0.38);pointer-events:none;";
      img.parentNode.appendChild(icon);
    }
  }
  function getAvailableItemsBySelection(category) {
    const out = [];
    return (
      $.each(S.items || {}, (itemName, item) => {
        if (!item || !category || item.Category !== category) return;
        const gender = normalize(item.Gender || "all");
        (S.selectedGender && "all" !== gender && gender !== S.selectedGender) ||
          out.push({
            itemName: itemName,
            item: item,
          });
      }),
      out
    );
  }
  function countAttachedByCategory(category) {
    const wanted = normalizeCategoryKey(category);
    let count = 0;
    return (
      Object.keys(S.attached || {}).forEach((itemName) => {
        if (!S.attached[itemName]) return;
        const item = S.items[itemName];
        item && normalizeCategoryKey(item.Category) === wanted && (count += 1);
      }),
      count
    );
  }
  function getFirstCategoryWithAttach() {
    let found = null;
    return (
      $(".radial-node:visible").each(function () {
        const category = $(this).data("category");
        countAttachedByCategory(category) > 0 && !found && (found = category);
      }),
      found
    );
  }
  function clearTimers(timers) {
    return Array.isArray(timers) && timers.length ? (timers.forEach((id) => clearTimeout(id)), []) : [];
  }
  function clearAllRevealTimers() {
    ((S.attachedRevealTimers = clearTimers(S.attachedRevealTimers)), (S.accRevealTimers = clearTimers(S.accRevealTimers)));
  }
  function setPlayerGender(gender) {
    const normalized = normalize(gender);
    ("male" !== normalized && "female" !== normalized) || ((S.playerGender = normalized), renderAccGenderIndicator(), setAccGenderTitleWithCurrent());
  }
  function setAccGenderTitleWithCurrent() {
    const gender = getResolvedGender();
    const genderLabel = getGenderLabel(gender);
    $("#accGenderTitle").text(genderLabel);
  }
  function setAttachedMenuSubtitle(text) {
    if (S._denyMsgActive) return;
    $("#attachedMenuDesc").text(text || t("acc_body_parts_default_title"));
  }
  function syncAttachedSubtitleWithSelection() {
    S.selectedCategory ? setAttachedMenuSubtitle(getCategoryLabel(S.selectedCategory)) : setAttachedMenuSubtitle();
  }
  function setAccDefaultExplanationText() {
    $("#accExplanationText").text(t("acc_explanations_text"));
  }
  function setAccBodyPartsTitle(text) {
    $("#accBodyPartsTitle").text(
      text ||
        (function () {
          const primary = t("acc_body_parts_default_title");
          if ("acc_body_parts_default_title" !== primary) return primary;
          const typo = t("acc_body_parts_defult_title");
          return "acc_body_parts_defult_title" !== typo ? typo : t("acc_body_parts_title");
        })(),
    );
  }
  function getObjectsInfoDefaultText() {
    return S.selectedGender ? (S.selectedCategory ? t("menu_description_available") : t("select_body_part")) : t("choose_gender");
  }
  function setObjectsInfoText(text) {
    $("#objectsInfoText").text(text || getObjectsInfoDefaultText());
  }
  function updateObjectsReturnButton() {
    const show = UI.$menu && UI.$menu.is(":visible") && "main" !== S.page;
    $("#objectsReturnButton").toggle(!!show);
  }
  function renderAccGenderIndicator() {
    const $img = $("#accGenderImage");
    if (!$img.length) return;
    const gender = getResolvedGender(),
      label = getGenderLabel(gender);
    $img.attr("src", `./assets/img/${gender}-black.png`).attr("alt", label).attr("title", label).css("display", "block");
  }
  const ACC_CATEGORY_ORDER = ["Head","Neck","Torso","Arm","Hand","Belt","Foot","Leg","Waist"];
  function renderAccPreviewBodyPartNodes() {
    const $row = $("#accBodypartRow");
    if (!$row.length) return;
    $("#accItemBox").find(".acc-custom-scrollbar").remove();
    $("#accItemBox").hide();
    $(".acc-bodypart-sep").show();
    if (!Array.isArray(S.categories) || !S.categories.length)
      return void $row.html(`<div class="acc-preview-empty">${t("no_categories_found")}</div>`);
    S.selectedCategory = null;
    const sorted = [...S.categories].sort((a, b) => {
      const ai = ACC_CATEGORY_ORDER.findIndex(o => o.toLowerCase() === a.toLowerCase());
      const bi = ACC_CATEGORY_ORDER.findIndex(o => o.toLowerCase() === b.toLowerCase());
      return (ai === -1 ? 999 : ai) - (bi === -1 ? 999 : bi);
    });
    const html = sorted
      .map((category) => {
        const label = getCategoryLabel(category);
        return `<button class="acc-preview-bodypart-node" data-category="${category}" title="${label}" aria-label="${label}"><span class="acc-preview-fallback">${String(label || "").slice(0, 2).toUpperCase()}</span></button>`;
      })
      .join("");
    $row.html(html);
    $row.find(".acc-preview-bodypart-node").each(function () {
      const iconKey = getRadialCategoryIconKey($(this).data("category"));
      iconKey && $(this).addClass("has-category-icon").css("--acc-icon-white", `url('./assets/img/${iconKey}-white.png')`).css("--acc-icon-black", `url('./assets/img/${iconKey}-black.png')`);
    });
  }
  function renderAccPreviewItemNodes(category) {
    const $preview = $("#accPreview");
    if (!$preview.length) return;
    const $box = $("#accItemBox");
    $box.find(".acc-custom-scrollbar").remove();
    S.selectedGender || (S.selectedGender = getDefaultSelectedGender() || getResolvedGender());
    const items = getAvailableItemsBySelection(category);
    if (!items.length) {
      $("#accItemListHeader").hide();
      $preview.html(`<div class="acc-preview-empty">${t("nothing_available_category")}</div>`);
      $box.show();
      $(".acc-bodypart-sep").hide();
      return;
    }
    const attachedCount = items.filter(({ itemName }) => S.attached && S.attached[itemName]).length;
    $("#accItemListLabel").text(t("acc_item_list_label") || "ITEM LIST");
    $("#accItemListCount").text(`${attachedCount} / ${items.length}`);
    $("#accItemListHeader").show();
    const html = items
      .map(({ itemName: itemName, item: item }) => {
        const label = item.Label || item.label || itemName,
          image = getImage(itemName, item);
        return `<button class="acc-preview-item-node${S.selectedItem === itemName ? " active" : ""}" data-name="${itemName}" title="${label}" aria-label="${label}"><img src="${image}" alt="${label}" onerror="this.onerror=function(){accImgFallback(this)};this.src='${getLocalImage(itemName, item)}'"><span>${label.slice(0, 2)}</span></button>`;
      })
      .join("");
    $preview.html(`<div class="acc-items-frame"><div class="acc-items-inner">${html}</div></div>`);
    $box.show();
    $(".acc-bodypart-sep").hide();
    const $frame = $preview.find(".acc-items-frame");
    const $sb = $('<div class="acc-custom-scrollbar"><div class="acc-custom-thumb"></div></div>');
    $frame.append($sb);
    function syncSb() {
      const el = $preview.find(".acc-items-inner")[0];
      if (!el) { $sb.hide(); return; }
      const trackH = el.clientHeight;
      $sb.css({ height: trackH + "px" });
      if (el.scrollHeight <= el.clientHeight) { $sb.hide(); return; }
      $sb.show();
      const thumbH = Math.max(20, trackH * (trackH / el.scrollHeight));
      const maxScroll = el.scrollHeight - el.clientHeight;
      const thumbTop = maxScroll > 0 ? (el.scrollTop / maxScroll) * (trackH - thumbH) : 0;
      $sb.find(".acc-custom-thumb").css({ height: thumbH + "px", top: thumbTop + "px" });
    }
    let _dragY = 0, _dragScroll = 0;
    $sb.on("mousedown", ".acc-custom-thumb", function (e) {
      const el = $preview.find(".acc-items-inner")[0];
      if (!el) return;
      _dragY = e.clientY;
      _dragScroll = el.scrollTop;
      $(this).addClass("dragging");
      e.preventDefault();
      $(document).on("mousemove.accSbDrag", function (ev) {
        const trackH = el.clientHeight;
        const thumbH = Math.max(20, trackH * (trackH / el.scrollHeight));
        const maxScroll = el.scrollHeight - el.clientHeight;
        el.scrollTop = _dragScroll + (ev.clientY - _dragY) * (maxScroll / (trackH - thumbH));
        syncSb();
      }).on("mouseup.accSbDrag", function () {
        $sb.find(".acc-custom-thumb").removeClass("dragging");
        $(document).off("mousemove.accSbDrag mouseup.accSbDrag");
      });
    });
    $sb.on("click", function (e) {
      if ($(e.target).hasClass("acc-custom-thumb")) return;
      const el = $preview.find(".acc-items-inner")[0];
      if (!el) return;
      const trackTop = $sb[0].getBoundingClientRect().top;
      const clickRatio = (e.clientY - trackTop) / el.clientHeight;
      el.scrollTop = clickRatio * (el.scrollHeight - el.clientHeight);
      syncSb();
    });
    $preview.find(".acc-items-inner").on("scroll.accSb", syncSb);
    setTimeout(syncSb, 0);
  }
  function renderObjectsAvailablePanel() {
    const genderKeys = Object.keys(S.genders || {});
    S.selectedGender || (S.selectedGender = getDefaultSelectedGender());
    const selectedItemsForCategory = S.selectedCategory ? getAvailableItemsBySelection(S.selectedCategory) : [],
      genderHtml = genderKeys.length
        ? (() => {
            const label = getGenderLabel(S.selectedGender || genderKeys[0]);
            return `<div class="objects-gender-indicator" title="${label}" aria-label="${label}"><img src="${"female" === normalize(S.selectedGender || S.playerGender || "") ? "./assets/img/female-white.png" : "./assets/img/male-white.png"}" alt="${label}" onerror="this.style.display='none'"></div>`;
          })()
        : `<div class="box objects-empty-line">${t("nothing_attached_main")}</div>`,
      bodyPartsHtml = S.categories.length
        ? S.categories
            .map((cat) => {
              const label = getCategoryLabel(cat),
                token = getCategoryToken(cat);
              return `<button class="objects-bodypart-node${S.selectedCategory === cat ? " active" : ""}${S.selectedGender ? "" : " disabled"}" data-category="${cat}" title="${label}">${token}</button>`;
            })
            .join("")
        : `<div class="box objects-empty-line">${t("no_categories_found")}</div>`,
      itemsHtml =
        S.selectedGender && S.selectedCategory
          ? selectedItemsForCategory.length
            ? selectedItemsForCategory
                .map(({ itemName: itemName, item: item }) => {
                  const label = item.Label || item.label || itemName,
                    image = getImage(itemName, item);
                  return `<button class="objects-item-orb${S.selectedItem === itemName ? " active" : ""}" data-name="${itemName}" title="${label}"><img src="${image}" alt="${label}" onerror="this.onerror=function(){accImgFallback(this)};this.src='${getLocalImage(itemName, item)}'"><span>${label.slice(0, 2)}</span></button>`;
                })
                .join("")
            : `<div class="objects-grid-hint">${t("nothing_available_category")}</div>`
          : `<div class="objects-grid-hint">${getObjectsInfoDefaultText()}</div>`,
      html = `\n            <div class="objects-divider"></div>\n            <div class="objects-gender-row">${genderHtml}</div>\n            <div class="objects-divider"></div>\n            <div class="objects-subtitle">${t("select_body_part")}</div>\n            <div class="objects-bodyparts-row">${bodyPartsHtml}</div>\n            <div class="objects-divider"></div>\n            <div class="objects-item-grid">${itemsHtml}</div>\n            <div class="objects-divider"></div>\n            <div class="objects-stats-title">${t("menu_description_available")}</div>\n            <div class="objects-divider"></div>\n            <div class="objects-stats-text" id="objectsInfoText">${getObjectsInfoDefaultText()}</div>\n        `;
    ($("#boxes").html(html), setObjectsInfoText(), $(".menu .remove, .menu .remove-all").hide(), $(".menu .attach").toggle(!!S.selectedItem));
  }
  function renderRadialNodes() {
    $(".radial-node").each(function () {
      const $node = $(this),
        category = $node.data("category"),
        existsInConfig = (function (category) {
          const wanted = normalizeCategoryKey(category);
          return (S.categories || []).some((cat) => normalizeCategoryKey(cat) === wanted);
        })(category),
        hasItems = countAttachedByCategory(category) > 0,
        label = getCategoryLabel(category),
        iconKey = getRadialCategoryIconKey(category);
      ($node
        .toggle(existsInConfig)
        .toggleClass("active", normalizeCategoryKey(S.selectedCategory) === normalizeCategoryKey(category))
        .toggleClass("has-items", hasItems)
        .attr("title", label)
        .text(getCategoryToken(category)),
        iconKey
          ? $node
              .addClass("has-category-icon")
              .css("--radial-icon-white", `url('./assets/img/${iconKey}-white.png')`)
              .css("--radial-icon-black", `url('./assets/img/${iconKey}-black.png')`)
              .css("--radial-icon", "var(--radial-icon-white)")
          : $node.removeClass("has-category-icon").css("--radial-icon-white", "none").css("--radial-icon-black", "none").css("--radial-icon", "none"));
    });
  }
  function renderAttachedOrbit() {
    if (($(".radial-node-orbit").empty().hide(), $("#attachedOrbit").empty(), !S.selectedCategory)) return;
    const items = (function (category) {
        const wanted = normalizeCategoryKey(category),
          out = [];
        return (
          Object.keys(S.attached || {}).forEach((itemName) => {
            if (!S.attached[itemName]) return;
            const itemData = S.items[itemName];
            itemData &&
              normalizeCategoryKey(itemData.Category) === wanted &&
              out.push({
                itemName: itemName,
                itemData: itemData,
              });
          }),
          out
        );
      })(S.selectedCategory),
      $orbit = (function ($node) {
        if (!$node?.length) return $();
        const category = $node.data("category"),
          $menu = $("#radialMenu");
        let $orbit = $menu.find(`.radial-node-orbit[data-category="${category}"]`);
        $orbit.length || (($orbit = $(`<div class="radial-node-orbit" data-category="${category}"></div>`)), $menu.append($orbit));
        const menuOffset = $menu.offset(),
          nodeOffset = $node.offset(),
          centerX = nodeOffset.left - menuOffset.left + $node.outerWidth() / 2,
          centerY = nodeOffset.top - menuOffset.top + $node.outerHeight() / 2;
        return (
          $orbit.css({
            left: `${centerX}px`,
            top: `${centerY}px`,
          }),
          $orbit
        );
      })($(`.radial-node[data-category="${S.selectedCategory}"]`));
    if (!$orbit.length) return;
    const hasItems = items.length > 0,
      renderCount = hasItems ? items.length : 1,
      points = (function (itemCount, radius) {
        if (!itemCount || itemCount < 1) return [];
        const safeRadius = Number.isFinite(radius) && radius > 0 ? radius : S.attachedFanRadiusPx,
          points = [],
          slotAnglesDeg = [-90, -35, 10, 55, 125, 180, -145];
        if (itemCount <= slotAnglesDeg.length) {
          for (let i = 0; i < itemCount; i += 1) {
            const angle = (slotAnglesDeg[i] * Math.PI) / 180;
            points.push({
              x: Math.cos(angle) * safeRadius,
              y: Math.sin(angle) * safeRadius,
            });
          }
          return points;
        }
        const startAngle = -0.5 * Math.PI;
        for (let i = 0; i < itemCount; i += 1) {
          const angle = startAngle + (2 * Math.PI * i) / itemCount;
          points.push({
            x: Math.cos(angle) * safeRadius,
            y: Math.sin(angle) * safeRadius,
          });
        }
        return points;
      })(renderCount, S.attachedFanRadiusPx);
    let $chipsToAnimate = $();
    for (let index = 0; index < renderCount; index += 1) {
      const point = points[index];
      if (!point) continue;
      const chipHtml = hasItems
          ? (() => {
              const entry = items[index],
                label = getItemLabel(entry.itemName),
                image = getImage(entry.itemName, entry.itemData);
              return `<button class="attached-item-chip" data-name="${entry.itemName}" title="${label}" aria-label="${label}"><img src="${image}" alt="${label}" onerror="this.onerror=function(){accImgFallback(this)};this.src='${getLocalImage(entry.itemName, entry.itemData)}'"><span>${label.slice(0, 2)}</span></button>`;

            })()
          : (() => {
              const emptyLabel = t("nothing_attached_category");
              return `<button class="attached-item-chip is-empty" title="${emptyLabel}" aria-label="${emptyLabel}"><svg xmlns="http://www.w3.org/2000/svg" width="1.4em" height="1.4em" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 14l-4-4 4-4"/><path d="M5 10h11a4 4 0 1 1 0 8h-1"/></svg></button>`;
            })(),
        $chip = $(chipHtml).css({
          left: `${point.x}px`,
          top: `${point.y}px`,
          "--chip-offset-x": `${point.x}px`,
          "--chip-offset-y": `${point.y}px`,
          "--chip-delay": index * S.chipCascadeMs + "ms",
          "--chip-speed": `${S.radialSpeedMs}ms`,
          "--detach-hold-duration": `${S.detachHoldMs}ms`,
          "--chip-animation-name": S.radialAnimationEffect,
        });
      ($orbit.append($chip), ($chipsToAnimate = $chipsToAnimate.add($chip)));
    }
    var $chips;
    ($orbit.show(),
      ($chips = $chipsToAnimate),
      $chips?.length &&
        setTimeout(() => {
          setTimeout(() => {
            ($chips.removeClass("is-open is-settled").addClass("is-open"),
              $chips.off("animationend.attachedChip").one("animationend.attachedChip", function () {
                $(this).removeClass("is-open").addClass("is-settled");
              }));
          }, 0);
        }, 0));
  }
  function startAttachedMenuReveal() {
    ((S.attachedRevealTimers = clearTimers(S.attachedRevealTimers)),
      (S.attachedRevealTimers = (function (stepMs, durationMs) {
        const timers = [];
        return (
          [
            "#attachedMenuTitle:visible",
            "#attachedMenuDesc:visible",
            "#rotateCharacterButton:visible, #toggleDressButton:visible, #openObjectsButton:visible",
            "#nodeHead, #nodeArm",
            "#nodeNeck, #nodeHand",
            "#nodeTorso, #nodeLeg",
            "#nodeWaist",
            ".attached-item-chip:visible",
          ].forEach((selector, index) => {
            const $group = $(selector);
            if (!$group.length) return;
            $group.stop(!0, !0).hide();
            const timerId = setTimeout(() => $group.stop(!0, !0).fadeIn(durationMs), index * stepMs);
            timers.push(timerId);
          }),
          timers
        );
      })(S.revealStepMs, S.revealDurationMs)));
  }
  function startAccMenuReveal() {
    ((S.accRevealTimers = clearTimers(S.accRevealTimers)),
      $(
        [
          "#accMainTitle:visible, #accGenderTitle:visible, #accGenderIndicator:visible",
          "#accBodyPartsTitle:visible",
          "#accBodypartRow .acc-preview-bodypart-node:visible, #accPreview .acc-preview-item-node:visible, #accPreview .acc-preview-empty:visible",
          "#accAttachButton:visible, #accRemoveButton:visible",
          "#accExplanationTitle:visible, #accExplanationText:visible",
        ].join(", "),
      )
        .stop(!0, !0)
        .hide()
        .fadeIn(160));
  }
  function refreshAttachedRadialState(preferFirstAttached, keepEmptySelection) {
    const hasSelection = !!S.selectedCategory,
      $selected = hasSelection ? $(`.radial-node[data-category="${S.selectedCategory}"]`) : $(),
      selectedHasItems = hasSelection && countAttachedByCategory(S.selectedCategory) > 0;
    (($selected.length && (selectedHasItems || keepEmptySelection)) || (S.selectedCategory = (preferFirstAttached && getFirstCategoryWithAttach()) || null), renderRadialNodes(), renderAttachedOrbit(), syncAttachedSubtitleWithSelection());
  }
  function resetAttachedNodeSelectionState() {
    ((S.selectedCategory = null), refreshAttachedRadialState(!1));
  }
  function showAttachedMenuStaticNow() {
    ((S.attachedRevealTimers = clearTimers(S.attachedRevealTimers)), $("#attachedMenuTitle, #attachedMenuDesc, .radial-node, #rotateCharacterButton, #toggleDressButton, #openObjectsButton").stop(!0, !0).show());
  }
  function closeNuiMenu(menuType) {
    (post("closeMenu", {
      menuType: menuType,
    }),
      (S.activeMenu = null));
  }
  function stopRotateHolding() {
    S.isRotateHolding && (menuAction("rotateCharacterStop"), (S.isRotateHolding = !1));
  }
  function clearAttachedChipHoldVisual($chip) {
    if (!$chip || !$chip.length) return;
    const cancelMs = Math.min(Math.round((S.detachHoldMs || 650) * 0.2), 200);
    $chip.removeClass("is-detach-holding").addClass("is-detach-cancel");
    setTimeout(function () { $chip.removeClass("is-detach-cancel"); }, cancelMs + 50);
  }
  function clearAttachedChipHoldState(clearVisual) {
    if (!S.attachedChipHold) return;
    const hold = S.attachedChipHold;
    hold.timeoutId && clearTimeout(hold.timeoutId);
    clearVisual && clearAttachedChipHoldVisual(hold.$chip);
    S.attachedChipHold = null;
  }
  function consumeAttachedChipClickSuppression() {
    if (!S.suppressAttachedChipClick) return !1;
    return (S.suppressAttachedChipClick = !1), !0;
  }
  function beginAttachedChipHold($chip) {
    const itemName = $chip && $chip.data("name");
    if (!$chip || !$chip.length || !itemName || $chip.hasClass("is-empty")) return;
    clearAttachedChipHoldState(!0);
    const hold = {
      $chip: $chip,
      itemName: itemName,
      startedAt: performance.now(),
      holdMs: S.detachHoldMs,
      detached: !1,
      timeoutId: 0,
    };
    $chip.addClass("is-detach-holding");
    S.attachedChipHold = hold;
    hold.timeoutId = setTimeout(() => {
      if (!S.attachedChipHold || S.attachedChipHold !== hold) return;
      hold.detached = !0;
      S.suppressAttachedChipClick = !0;
      hold.$chip.addClass("is-detach-done");
      menuAction("remove", { item: hold.itemName });
      clearAttachedChipHoldState(false);
    }, hold.holdMs);
  }
  function completeAttachedChipHold(mode) {
    if (!S.attachedChipHold) return;
    const hold = S.attachedChipHold;
    if ("release" === mode && !hold.detached) {
      const elapsed = performance.now() - hold.startedAt;
      if (elapsed < hold.holdMs) {
        (S.suppressAttachedChipClick = !0,
          menuAction("replayAttachAnimation", {
            item: hold.itemName,
          }));
      }
    }
    clearAttachedChipHoldState(!0);
  }
  function toggleSingleSelectedItem(itemName) {
    itemName && (S.selectedItem = S.selectedItem === itemName ? null : itemName);
  }
  function clearSelectedItems() {
    ((S.selectedItems = []), (S.selectedItem = null), $(".menu .item-box").removeClass("active"), $(".menu .box-tick").remove());
  }
  function goMainMenu() {
    (clearSelectedItems(),
      (S.page = "main"),
      (S.menuMode = null),
      (S.selectedItem = null),
      (S.selectedCategory = null),
      (S.selectedGender = null),
      $("#menuTitle").text(t("menu_title")),
      $("#menuDesc").text(t("menu_description_main")),
      updateLocaleUI(),
      $(".menu .remove-all").hide(),
      $("#boxes").html(`<div class="box mode-box" data-mode="attached">${t("main_attached")}</div><div class="box mode-box" data-mode="available">${t("main_available")}</div>`),
      $(".menu .attach, .menu .remove").hide(),
      $(".header-frame, .boxes, .main-buttons").css({
        opacity: "1",
        "pointer-events": "auto",
      }),
      updateObjectsReturnButton());
  }
  function goGenderMenu() {
    if (
      ((S.page = "gender"),
      (S.selectedItem = null),
      (S.selectedCategory = null),
      (S.selectedGender = "available" === S.menuMode ? getDefaultSelectedGender() : null),
      "attached" !== S.menuMode && clearSelectedItems(),
      $(".menu .remove-all").hide(),
      $("#menuTitle").text(t("choose_gender")),
      $("#menuDesc").text(t("select_body_part")),
      "available" === S.menuMode)
    )
      return (renderObjectsAvailablePanel(), void updateObjectsReturnButton());
    const keys = Object.keys(S.genders || {}),
      html = keys.length ? keys.map((key) => `<div class="box gender-box" data-gender="${key}">${getGenderLabel(key)}</div>`).join("") : `<div class="box">${t("nothing_attached_main")}</div>`;
    ($("#boxes").html(html), $(".menu .attach, .menu .remove, .menu .remove-all").hide(), updateObjectsReturnButton());
  }
  function goCategoriesMenu() {
    if (((S.page = "categories"), (S.selectedCategory = null), $("#menuTitle").text(t("select_body_part")), $("#menuDesc").text(t("menu_description_available")), "available" === S.menuMode))
      return (renderObjectsAvailablePanel(), void updateObjectsReturnButton());
    const html = S.categories.length ? S.categories.map((cat) => `<div class="box category-box" data-category="${cat}">${getCategoryLabel(cat)}</div>`).join("") : `<div class="box">${t("no_categories_found")}</div>`;
    ($("#boxes").html(html), $(".menu .attach, .menu .remove, .menu .remove-all").hide(), updateObjectsReturnButton());
  }
  function goItemsMenu(category) {
    if (((S.page = "items"), (S.selectedCategory = category), (S.selectedItem = null), "available" === S.menuMode))
      return ($("#menuTitle").text(t("select_body_part")), $("#menuDesc").text(t("menu_description_available")), renderObjectsAvailablePanel(), void updateObjectsReturnButton());
    const categoryLabel = getCategoryLabel(category);
    "attached" === S.menuMode
      ? ($("#menuTitle").text(`${categoryLabel} - ${t("main_attached")}`), $("#menuDesc").text(t("menu_description_attached")))
      : ($("#menuTitle").text(`${categoryLabel} - ${t("main_available")}`), $("#menuDesc").text(t("menu_description_available")));
    let found = !1,
      html = "";
    ("attached" === S.menuMode
      ? ($.each(S.attached || {}, (itemName) => {
          const item = S.items[itemName];
          if (!item || item.Category !== category) return !0;
          const gender = normalize(item.Gender || "all");
          if (S.selectedGender && "all" !== gender && gender !== S.selectedGender) return !0;
          found = !0;
          const label = getItemLabel(itemName),
            active = S.selectedItems.includes(itemName);
          html += `<div class="box item-box${active ? " active" : ""}" data-name="${itemName}">${label}${active ? '<span class="box-tick">✔</span>' : ""}</div>`;
        }),
        found || (html = `<div class="box">${t("nothing_attached_category")}</div>`),
        $(".menu .attach").hide(),
        $(".menu .remove").toggle(S.selectedItems.length > 0),
        $(".menu .remove-all").toggle(Object.keys(S.attached || {}).length > 0))
      : ($.each(S.items, (itemName, item) => {
          if (!item || item.Category !== category) return;
          const gender = normalize(item.Gender || "all");
          if (S.selectedGender && "all" !== gender && gender !== S.selectedGender) return;
          found = !0;
          const label = item.Label || item.label || itemName;
          html += `<div class="box item-box" data-name="${itemName}">${label}</div>`;
        }),
        found || (html = `<div class="box">${t("nothing_available_category")}</div>`),
        $(".menu .attach, .menu .remove").hide()),
      $("#boxes").html(html),
      updateObjectsReturnButton());
  }
  function updateLocaleUI() {
    ($("#menuTitle").text(t("menu_title")),
      $("#accMainTitle").text(t("acc_main_title")),
      setAccGenderTitleWithCurrent(),
      setAccBodyPartsTitle(),
      renderAccGenderIndicator(),
      renderAccPreviewBodyPartNodes(),
      $("#accGenderSubtitle").text(t("acc_gender_subtitle")),
      $("#accLblSelected").text(t("acc_lbl_selected")),
      $("#accLblCategory").text(t("acc_lbl_category")),
      $("#accAttachButton").text(t("acc_attach_button")),
      $("#accRemoveButton").text(t("acc_remove_button")),
      $("#accExplanationTitle").text(t("acc_explanations_title")),
      setAccDefaultExplanationText(),
      $(".attach-text").text(t("attach")),
      $(".menu .remove-text").text(t("remove")),
      $(".menu .remove-all-text").text(t("remove_all")),
      $("#attachedMenuTitle").text(
        (function () {
          const shortTitle = t("menu_title_short");
          return shortTitle && "menu_title_short" !== shortTitle ? shortTitle : "[menu_title_short]";
        })(),
      ),
      setAttachedMenuSubtitle(),
      $("#rotateCharacterButton").attr("title", "rotate_character" !== t("rotate_character") ? t("rotate_character") : "Rotate Character"),
      $("#toggleDressButton").attr("title", "toggle_dress" !== t("toggle_dress") ? t("toggle_dress") : "Dress / Undress"),
      $("#openObjectsButton").attr("title", "open_accessory_menu" !== t("open_accessory_menu") ? t("open_accessory_menu") : "Open Accessory Menu"),
      $("#openAccadminButton").attr("title", "accadmin_open" !== t("accadmin_open") ? t("accadmin_open") : "Admin Panel"));
    syncAdminButton();
  }
  function syncAdminButton() {
    $("#openAccadminButton").toggle(S.isAdmin === true);
  }
  function updateAccadminLocale() {
    // Page titles
    $("#c-p1-title").text(t("accadmin_title_setup")    || "Settings");
    $("#c-p2-title").text(t("accadmin_title_bone")     || "Bone Selection");
    $("#c-p3-title").text(t("accadmin_title_calib")    || "Calibration");
    $("#c-p4-title").text(t("accadmin_title_output")   || "Output");
    $("#c-p5-title").text(t("accadmin_title_item_reg") || "Item Registration");
    // Step labels
    $(".ard-step-lbl[data-sl='setup']").text(t("accadmin_step_setup")   || "Setup");
    $(".ard-step-lbl[data-sl='bone']").text(t("accadmin_step_bone")     || "Bone");
    $(".ard-step-lbl[data-sl='calib']").text(t("accadmin_step_calib")   || "Calib.");
    $(".ard-step-lbl[data-sl='output']").text(t("accadmin_step_output") || "Output");
    // P1 field labels
    $("#c-lbl-key").text(t("accadmin_field_key")         || "Item Key");
    $("#c-lbl-label").text(t("accadmin_field_label")     || "Label");
    $("#c-lbl-model").text(t("accadmin_field_model")     || "Model Name");
    $("#c-lbl-gender").text(t("accadmin_field_gender")   || "Gender Restriction");
    $("#c-lbl-calgender").text(t("accadmin_field_calgender") || "Calibration Character");
    $("#c-lbl-category").text(t("accadmin_field_category") || "Category");
    $("#c-lbl-anim").text(t("accadmin_field_anim")       || "Animation (optional)");
    // P1 group labels
    $("#c-p1-grp-info").text(t("accadmin_group_item_info") || "Item Info");
    $("#c-p1-grp-class").text(t("accadmin_group_class")    || "Classification");
    $("#c-p1-grp-opts").text(t("accadmin_group_options")   || "Options");
    $("#c-lbl-fixedrot").text(t("accadmin_fixedrot")       || "fixedRot");
    // P1 nav
    $("#c-btnGoToBone-lbl").text(t("accadmin_btn_bone") || "Bone");
    // P2 nav
    $("#c-btnBackSetup-lbl").text(t("accadmin_btn_back_setup") || "Setup");
    $("#c-btnGoToAccadmin-lbl").text(t("accadmin_btn_select_calib") || "Select");
    $("#c-selBoneTag").text(t("accadmin_bone_no_sel")          || "No bone selected yet");
    $(".ard-bback-text").text(t("accadmin_bone_back_regions") || "Regions");
    $("#c-boneHoverLabel").text(t("accadmin_bone_regions")     || "Body Regions");
    $("#c-bSearch").attr("placeholder", t("accadmin_bone_search") || "Search bones...");
    // P3 labels and nav
    $("#c-axis-lbl-pos").text(t("accadmin_lbl_position") || "Position");
    $("#c-rot-lbl-static").text(t("accadmin_lbl_rotation")  || "Rotation");
    $("#c-kbhint-title").text(t("accadmin_lbl_kbguide")    || "Keyboard Guide");
    $("#c-kb-cat-camera").text(t("accadmin_kb_camera")       || "Camera");
    $("#c-kb-cat-position").text(t("accadmin_kb_position") || "Position");
    $("#c-kb-cat-rotation").text(t("accadmin_kb_rotation") || "Rotation");
    $("#c-kb-cat-axis").text(t("accadmin_kb_axis")         || "Axis");
    $("#c-anim-ctrl-hdr").text(t("accadmin_lbl_animctrl")  || "Animation Control");
    $("#c-btnBackBone-lbl").text(t("accadmin_btn_back_bone")  || "Bone");
    $("#c-btnReset").text(t("accadmin_btn_reset")         || "Reset");
    $("#c-btnGenerate-lbl").text(t("accadmin_btn_generate")   || "Apply");
    $("#c-iKey").attr("placeholder",   t("accadmin_ph_key")   || "— Enter Key —");
    $("#c-iLabel").attr("placeholder", t("accadmin_ph_label") || "— Enter Label —");
    if (AC && AC.attachDelay === null) {
      $("#c-btn-use-delay-lbl").text(t("accadmin_add_delay") || "Add Delay");
    }
    if (AC && AC.animCut === null) {
      $("#c-btn-use-cut-lbl").text(t("accadmin_add_cut") || "Cut Here");
    }
    acSetAnimPlayBtn(AC ? AC.animState : "stopped");
    // P4 output
    $("#c-p4-output-title").text(t("accadmin_output_title") || "Config Output");
    $("#c-btnBackAccadmin-lbl").text(t("accadmin_btn_back_calib") || "Calib.");
    $("#c-btnCopy-lbl").text(t("accadmin_btn_copy")           || "Copy");
    $("#c-btnNew-lbl").text(t("accadmin_btn_new_item")     || "New Item");
    $("#c-btnItemReg-lbl").text(t("accadmin_btn_item_reg") || "Item Registration");
    // P4 card row labels
    $("#c-p4-lbl-label").text(t("accadmin_row_label")    || "Label");
    $("#c-p4-lbl-model").text(t("accadmin_row_model")    || "Model");
    $("#c-p4-lbl-cat").text(t("accadmin_row_category")   || "Category");
    $("#c-p4-lbl-gender").text(t("accadmin_row_gender")  || "Gender");
    $("#c-p4-lbl-bone").text(t("accadmin_row_bone")      || "Bone");
    $("#c-p4-lbl-anim").text(t("accadmin_row_anim")      || "Animation");
    // P5 item registration
    $("#c-p5-grp-id").text(t("accadmin_p5_grp_id")       || "Identifiers");
    $("#c-p5-grp-props").text(t("accadmin_p5_grp_props") || "Properties");
    $("#c-p5-lbl-label").text(t("accadmin_row_label")    || "Label");
    $("#c-p5-lbl-cat").text(t("accadmin_row_category")   || "Category");
    $("#c-p5-lbl-gender").text(t("accadmin_row_gender")  || "Gender");
    $("#c-p5-code-title").text(t("accadmin_p5_code_title") || "Item Code");
    $("#c-lbl-p5-name").text(t("accadmin_p5_lbl_name")     || "Item Name (key)");
    $("#c-lbl-p5-label").text(t("accadmin_p5_lbl_label")   || "Item Label");
    $("#c-p5-key").attr("placeholder",   t("accadmin_ph_key")   || "— Enter Key —");
    $("#c-p5-label").attr("placeholder", t("accadmin_ph_label") || "— Enter Label —");
    $("#c-lbl-p5-weight").text(t("accadmin_p5_lbl_weight") || "Weight");
    $("#c-lbl-p5-limit").text(t("accadmin_p5_lbl_limit")   || "Limit");
    $("#c-lbl-p5-desc").text(t("accadmin_p5_lbl_desc")     || "Description");
    $("#c-p5-btnBack-lbl").text(t("accadmin_btn_back")         || "Back");
    $("#c-p5-btnCopy-lbl").text(t("accadmin_btn_copy")         || "Copy");
    $("#c-btnImport-lbl").text(t("accadmin_btn_import") || "Import");
    // Region button labels
    $(".ard-region-btn[data-region='head'] .ard-region-lbl").text(t("accadmin_region_head") || "Head");
    $(".ard-region-btn[data-region='neck'] .ard-region-lbl").text(t("accadmin_region_neck") || "Neck");
    $(".ard-region-btn[data-region='torso'] .ard-region-lbl").text(t("accadmin_region_torso") || "Torso");
    $(".ard-region-btn[data-region='waist'] .ard-region-lbl").text(t("accadmin_region_waist") || "Waist & Hip");
    $(".ard-region-btn[data-region='arm_right'] .ard-region-lbl").text(t("accadmin_region_arm_right") || "Right Arm");
    $(".ard-region-btn[data-region='arm_left'] .ard-region-lbl").text(t("accadmin_region_arm_left") || "Left Arm");
    $(".ard-region-btn[data-region='fingers_right'] .ard-region-lbl").text(t("accadmin_region_fingers_right") || "Right Fingers");
    $(".ard-region-btn[data-region='fingers_left'] .ard-region-lbl").text(t("accadmin_region_fingers_left") || "Left Fingers");
    // Import overlay
    $("#c-imp-title").text(t("accadmin_imp_title") || "Import");
    $("#imp-search").attr("placeholder", t("accadmin_imp_search_ph") || "Search by label or key...");
    $("#imp-nav-hint").text(t("accadmin_imp_nav_hint") || "â†‘ â†“ to navigate Â· Enter to select");
    $("#c-imp-saved-lbl").text(t("accadmin_imp_saved_lbl") || "Saved");
    $("#c-import-cancel-lbl").text(t("accadmin_imp_cancel") || "Cancel");
    $("#c-import-delete-lbl").text(t("accadmin_btn_delete") || "Delete");
    $("#c-import-load-lbl").text(t("accadmin_imp_load") || "Load");
    // Side picker
    $("#c-side-picker-close-lbl").text(t("accadmin_btn_close") || "Close");
    $("#c-side-anim-none").text(t("accadmin_anim_none") || "— No Animation —");
    // Save draft button
    $("#c-btnSaveDraft-lbl").text(t("accadmin_btn_save") || "Save");
    // Gender csel options + display value
    $("#c-opt-gender-all").text(t("accadmin_gender_all") || "All");
    $("#c-opt-gender-male").text(t("accadmin_gender_male") || "Male");
    $("#c-opt-gender-female").text(t("accadmin_gender_female") || "Female");
    {
      const _gv = $("#c-iGender").attr("data-csel-val") || "all";
      const _gLbl = _gv === "male" ? (t("accadmin_gender_male") || "Male")
                  : _gv === "female" ? (t("accadmin_gender_female") || "Female")
                  : (t("accadmin_gender_all") || "All");
      $("#c-iGender .ard-csel-val").text(_gLbl);
    }
    // CalGender csel options + display value
    $("#c-opt-calgender-male").text(t("accadmin_gender_cal_male") || "Male character");
    $("#c-opt-calgender-female").text(t("accadmin_gender_cal_female") || "Female character");
    {
      const _cg = $("#c-iAccadminGender").attr("data-csel-val") || "Male";
      const _cgLbl = _cg === "Male" ? (t("accadmin_gender_cal_male") || "Male character")
                                    : (t("accadmin_gender_cal_female") || "Female character");
      $("#c-iAccadminGender .ard-csel-val").text(_cgLbl);
    }
    // Category csel options + display value
    $("#c-iCategory .ard-csel-opt").each(function () {
      $(this).text(getCategoryLabel($(this).data("val")));
    });
    $("#c-iCategory .ard-csel-val").text(getCategoryLabel($("#c-iCategory").attr("data-csel-val") || "Hand"));
    // Keyboard guide descriptions
    $("#c-kb-desc-wasd").text(t("accadmin_kb_desc_wasd") || "Forward · Back · Left · Right");
    $("#c-kb-desc-space-shift").text(t("accadmin_kb_desc_space_shift") || "Up · Down");
    $("#c-kb-desc-arrows").text(t("accadmin_kb_desc_arrows") || "Forward · Back · Left · Right");
    $("#c-kb-desc-qz").text(t("accadmin_kb_desc_qz") || "Up · Down");
    $("#c-kb-desc-cv").text(t("accadmin_kb_desc_cv") || "Cycle Pitch · Roll · Yaw");
    $("#c-kb-desc-axis").text(t("accadmin_kb_desc_axis") || "Toggle active axis");
    // P5 framework buttons
    $("#c-p5-lbl-vorp").text(t("accadmin_p5_btn_vorp") || "VORP SQL");
    $("#c-p5-lbl-rsg").text(t("accadmin_p5_btn_rsg") || "RSG Lua");
  }
  function handleObjectsReturnNavigation() {
    return "items" === S.page ? goCategoriesMenu() : "categories" === S.page ? goGenderMenu() : "gender" === S.page ? goMainMenu() : void 0;
  }
  function handleMessageOpen(data) {
    ((S.attached = data.attached || {}), setPlayerGender(data.gender), (S.selectedItems = []), (S.activeMenu = "standard"), UI.$menu.hide(), UI.$attachedMenu.hide(), UI.$accPanel.show(), startAccMenuReveal(), updateObjectsReturnButton());
  }
  function handleMessageOpenAttached(data) {
    if (((S.attached = data.attached || {}), setPlayerGender(data.gender), (S.activeMenu = "attached"), (S.selectedCategory = getFirstCategoryWithAttach()), !S.selectedCategory)) {
      const firstVisible = $(".radial-node:visible").first();
      S.selectedCategory = firstVisible.length ? firstVisible.data("category") : null;
    }
    const preview = data.preview || {};
    const canSwitch = void 0 === preview.canSwitchSide ? categorySupportsSideSwitch(S.selectedCategory) : !!preview.canSwitchSide;
    setPreviewSideUI(preview.side || S.currentSide || "right", canSwitch);
    S.selectedCategory && syncPreviewCategory(S.selectedCategory);
    if (data.isAdmin !== undefined) { S.isAdmin = data.isAdmin === true; }
    (updateLocaleUI(), refreshAttachedRadialState(!1), UI.$menu.hide(), UI.$accPanel.hide(), updateObjectsReturnButton(), UI.$attachedMenu.show(), startAttachedMenuReveal());
    post("getAdminStatus", {});
  }
  function handleMessageUpdateAttached(data) {
    const next = data.attached || {},
      prev = S.attached || {},
      prevKeys = Object.keys(prev),
      nextKeys = Object.keys(next),
      attachChanged = prevKeys.length !== nextKeys.length || nextKeys.some((k) => !prev[k]) || prevKeys.some((k) => !next[k]);
    S.attached = next;
    const attachedNames = new Set(nextKeys);
    S.selectedItems = S.selectedItems.filter((name) => attachedNames.has(name));
    if (!attachChanged) return;
    UI.$menu.is(":visible") && ("main" === S.page ? goMainMenu() : "items" === S.page && S.selectedCategory && goItemsMenu(S.selectedCategory));
    UI.$attachedMenu.is(":visible") && (S.selectedCategory && 0 === countAttachedByCategory(S.selectedCategory) && (S.selectedCategory = null), refreshAttachedRadialState(!1));
  }
  function handleMessageOpenAccadmin(data) {
    S.accadminAnimKeys = data.animKeys || [];
    S.accadminPedMale  = data.pedMale !== false;
    if (!S.accadminAnimKeys.length) {
      $.ajax({ url: "https://" + GetParentResourceName() + "/getAnimKeys", method: "POST", contentType: "application/json", data: JSON.stringify({}), dataType: "text" });
    }
    if (typeof AC !== "undefined") {
      AC.bone = null;
      AC.boneId = -1;
      AC.V = { px:0, py:0, pz:0, pitch:0, roll:0, yaw:0 };
      AC.fixedRot = true; AC.animKey = null; AC.animState = "stopped"; AC.attachDelay = null; AC.animCut = null; AC.imported = null;
    }
    if (typeof showAccPanel === "function") showAccPanel("c-p1");
    else { $(".ard-panel").removeClass("active"); $("#c-p1").addClass("active"); }
    if (typeof showRegionView === "function") showRegionView();
    if (typeof updateP2Summary === "function") updateP2Summary();
    if (typeof updateAccadminLocale === "function") updateAccadminLocale();
    {
      const _cg    = S.accadminPedMale ? "Male" : "Female";
      const _cgLbl = S.accadminPedMale
        ? (t("accadmin_gender_cal_male")    || "Male character")
        : (t("accadmin_gender_cal_female")  || "Female character");
      setCsel($("#c-iAccadminGender"), _cg, _cgLbl);
      $("#c-iAccadminGender").data("readonly", true).addClass("csel-readonly");
      if (typeof syncCalibVisual === "function") syncCalibVisual();
    }
    if (typeof clearAllRevealTimers === "function") clearAllRevealTimers();
    UI.$attachedMenu.hide();
    UI.$menu.hide();
    UI.$accPanel.hide();
    $("#accadminPanel").show();
  }
  /* ── csel: portal — lifted to <body> to escape filter+overflow clipping ── */
  function closeCselAll() {
    $(".ard-csel.open").each(function () {
      const $c = $(this), $m = $c.data("csel-menu");
      if ($m) { $m.css({ position: "", top: "", left: "", width: "", display: "" }).appendTo($c); $c.removeData("csel-menu"); }
      $c.removeClass("open");
    });
  }
  $(document).on("click", ".ard-csel", function (e) {
    if ($(e.target).closest(".ard-csel-menu").length) return;
    if ($(this).data("readonly")) return;
    const $csel = $(this), wasOpen = $csel.hasClass("open");
    closeCselAll();
    if (!wasOpen) {
      const rect = this.getBoundingClientRect();
      const $menu = $csel.find(".ard-csel-menu")
        .appendTo(document.body)
        .css({ position: "fixed", top: rect.bottom + "px", left: rect.left + "px", width: rect.width + "px", display: "block" })
        .data("csel", $csel);
      $csel.addClass("open").data("csel-menu", $menu);
    }
  });
  $(document).on("click", ".ard-csel-opt", function () {
    const $menu = $(this).closest(".ard-csel-menu");
    const $csel = $menu.data("csel");
    if (!$csel || !$csel.length) return;
    $menu.find(".ard-csel-opt").removeClass("sel");
    $(this).addClass("sel");
    $csel.find(".ard-csel-val").text($(this).text());
    $csel.attr("data-csel-val", $(this).data("val"));
    closeCselAll();
  });
  $(document).on("click", function (e) {
    if (!$(e.target).closest(".ard-csel, .ard-csel-menu").length) closeCselAll();
  });
  /* ── side picker ── */
  let accadminPickerType = null;
  function openSidePicker(type) {
    if (accadminPickerType === type && $("#accSidePicker").hasClass("open")) {
      closeSidePicker(); return;
    }
    accadminPickerType = type;
    $("#c-side-search").val("");
    if (type === "anim") {
      $("#c-side-picker-title").text(t("accadmin_picker_anim_title") || "Animations");
      $("#c-side-search").attr("placeholder", t("accadmin_anim_search") || "Search animations...");
      $("#c-pk-anim-ctrl-hdr").text(t("accadmin_picker_preview_title") || "Preview");
      $("#c-side-picker-apply-lbl").text(t("accadmin_picker_apply") || "Apply");
      $("#c-side-anim-none").show();
      if (!(S.accadminAnimKeys && S.accadminAnimKeys.length)) {
        $.ajax({ url: "https://" + GetParentResourceName() + "/getAnimKeys", method: "POST", contentType: "application/json", data: JSON.stringify({}), dataType: "text" });
      }
      buildPickerAnim("");
    } else {
      $("#c-side-picker-title").text(t("accadmin_picker_model_title") || "Models");
      $("#c-side-search").attr("placeholder", t("accadmin_model_search") || "Search models...");
      $("#c-side-anim-none").hide();
      buildPickerModel("");
    }
    $("#accSidePicker").addClass("open");
  }
  function closeSidePicker() {
    if (accadminPickerType === "anim" && AC.pickerPreviewKey) {
      post("accadminStopPreviewAnim", {});
      AC.pickerPreviewKey = null;
    }
    acPickerResetControls();
    $("#accSidePicker").removeClass("open");
    accadminPickerType = null;
  }
  function acPickerResetControls() {
    AC.pickerScrubDragging = false;
    acSetPickerPlayBtn("stopped");
    $("#c-pk-scrub-fill").css("width", "0%");
    $("#c-pk-scrub-cur").text("0.00");
    $("#c-pk-scrub-dur").text("0.00");
    $("#c-side-anim-ctrl").hide();
    $("#c-side-picker-apply").hide();
    $("#c-side-picker-sep").hide();
    $("#c-pk-anim-ctrl-label").text("");
  }
  function acSetPickerPlayBtn(state) {
    const $btn = $("#c-pk-btn-anim-play");
    if (state === "playing") {
      $btn.addClass("is-playing").html('<svg width="11" height="11" viewBox="0 0 10 10" fill="currentColor"><rect x="0" y="0" width="3" height="10"/><rect x="7" y="0" width="3" height="10"/></svg>');
    } else {
      $btn.removeClass("is-playing").html('<svg width="11" height="13" viewBox="0 0 8 10" fill="currentColor"><polygon points="0,0 8,5 0,10"/></svg>');
    }
  }
  function buildPickerAnim(filter) {
    const $list = $("#c-side-picker-list").empty();
    const q = filter.toLowerCase();
    const anims = (S.accadminAnimKeys || []).slice();
    const cur = $("#c-iAnimVal").text();
    const filtered = anims.filter(a => {
      if (!q) return true;
      const desc = animDesc(a.key).toLowerCase();
      return a.key.toLowerCase().includes(q) || a.cat.toLowerCase().includes(q) || desc.includes(q);
    });
    if (!filtered.length) {
      $list.html('<div style="padding:6px 8px;font-size:.76vh;color:rgba(240,235,215,.28);text-transform:uppercase;letter-spacing:1px;">' + (anims.length ? (t("accadmin_anim_no_match") || "No match") : (t("accadmin_anim_loading") || "No animations — loading...")) + "</div>");
      return;
    }
    let lastCat = null;
    filtered.forEach(a => {
      if (a.cat !== lastCat) {
        $list.append($('<div class="ard-pick-cat">').text(a.cat));
        lastCat = a.cat;
      }
      const desc = animDesc(a.key);
      const $d = $('<div class="ard-pick-item">').addClass(cur === a.key ? "sel" : "");
      $d.append($('<span class="ard-pick-key">').text(a.key));
      if (desc) $d.append($('<span class="ard-pick-desc">').text(desc));
      $d.on("click", function () {
        if (AC.pickerPreviewKey === a.key) {
          if (AC.animState === "playing") {
            post("accadminStopPreviewAnim", {});
          } else {
            post("accadminPreviewAnim", { key: a.key });
          }
          return;
        }
        $("#c-side-picker-list .ard-pick-item").removeClass("sel");
        $(this).addClass("sel");
        AC.pickerPreviewKey = a.key;
        post("accadminPreviewAnim", { key: a.key });
        $("#c-pk-anim-ctrl-label").text(a.key);
        $("#c-side-anim-ctrl").show();
        $("#c-side-picker-apply").css("display", "flex");
        $("#c-side-picker-sep").css("display", "block");
      });
      $list.append($d);
    });
  }
  let _modelDebounce = null;
  function buildPickerModel(filter) {
    clearTimeout(_modelDebounce);
    _modelDebounce = setTimeout(function () {
      const $list = $("#c-side-picker-list");
      const cur = $("#c-iModelVal").text();
      $.ajax({
        url: "https://" + GetParentResourceName() + "/searchObjects",
        method: "POST", contentType: "application/json",
        data: JSON.stringify({ query: filter }), dataType: "text",
      }).done(function (raw) {
        $list.empty();
        let models = [];
        try { models = JSON.parse(raw) || []; } catch (_) {}
        if (!models.length) {
          $list.html('<div style="padding:6px 8px;font-size:.76vh;color:rgba(240,235,215,.28);text-transform:uppercase;letter-spacing:1px;">' + (filter ? (t("accadmin_model_no_match") || "No match") : (t("accadmin_model_no_objects") || "No objects")) + "</div>");
          return;
        }
        models.forEach(m => {
          const $d = $('<div class="ard-pick-item">').addClass(cur === m ? "sel" : "").html('<span class="ard-pick-key">' + m + "</span>");
          $d.on("click", function () { $("#c-iModelVal").text(m); $("#c-iModel").val(m); $("#c-iModelBtn").addClass("has-value has-anim"); clearFieldError($("#c-iModelBtn")); closeSidePicker(); });
          $list.append($d);
        });
      });
    }, 200);
  }
  $(document).on("click", "#c-iModelBtn", function () { openSidePicker("model"); });
  $(document).on("click", "#c-iAnimBtn", function () { openSidePicker("anim"); });
  $(document).on("click", "#c-side-picker-close", function () { closeSidePicker(); });
  $(document).on("click", "#c-side-anim-none", function () { $("#c-iAnimVal").text(t("accadmin_anim_select") || "— Select Animation —"); $("#c-iAnim").val(""); if (typeof AC !== "undefined") AC.animKey = null; $("#c-iAnimBtn").removeClass("has-value has-anim"); closeSidePicker(); });
  $(document).on("input", "#c-side-search", function () {
    if (accadminPickerType === "anim") buildPickerAnim($(this).val());
    else buildPickerModel($(this).val());
  });

  /* ══════════════════════════════════════════════════════════════════════════
     ACCADMIN  P1 – P5
  ══════════════════════════════════════════════════════════════════════════ */
  const BONE_ID_MAP = {
    "skel_head":21030,"skel_pelvis":56200,
    "skel_l_hand":34606,"skel_r_hand":22798,
    "skel_l_forearm":53675,"skel_r_forearm":54187,
    "skel_l_upperarm":37873,"skel_r_upperarm":46065,
    "skel_l_calf":55120,"skel_r_calf":43312,
    "skel_l_thigh":65478,"skel_r_thigh":6884,
    "SKEL_Neck0":14283,"SKEL_Neck1":14284,"SKEL_Neck2":14285,
    "SKEL_Spine_Root":11569,"SKEL_Spine0":14410,"SKEL_Spine3":14413,
    "SKEL_Spine5":14415,"SKEL_Spine6":14416,
    "SKEL_L_Clavicle":30226,"SKEL_R_Clavicle":54802,
    "MH_L_Wrist":49600,"MH_R_Wrist":29881,
    "IK_L_Hand":36029,"IK_R_Hand":6286,
    "SKEL_R_Finger00":16827,"SKEL_R_Finger01":16828,"SKEL_R_Finger02":16829,
    "SKEL_R_Finger10":16747,"SKEL_R_Finger11":16748,"SKEL_R_Finger12":16749,"SKEL_R_Finger13":16750,
    "SKEL_R_Finger20":16731,"SKEL_R_Finger21":16732,"SKEL_R_Finger22":16733,"SKEL_R_Finger23":16734,
    "SKEL_R_Finger30":16779,"SKEL_R_Finger31":16780,"SKEL_R_Finger32":16781,"SKEL_R_Finger33":16782,
    "SKEL_R_Finger40":16763,"SKEL_R_Finger41":16764,"SKEL_R_Finger42":16765,"SKEL_R_Finger43":16766,
    "SKEL_L_Finger00":41403,"SKEL_L_Finger01":41404,"SKEL_L_Finger02":41405,
    "SKEL_L_Finger10":41323,"SKEL_L_Finger11":41324,"SKEL_L_Finger12":41325,"SKEL_L_Finger13":41326,
    "SKEL_L_Finger20":41307,"SKEL_L_Finger21":41308,"SKEL_L_Finger22":41309,"SKEL_L_Finger23":41310,
    "SKEL_L_Finger30":41355,"SKEL_L_Finger31":41356,"SKEL_L_Finger32":41357,"SKEL_L_Finger33":41358,
    "SKEL_L_Finger40":41339,"SKEL_L_Finger41":41340,"SKEL_L_Finger42":41341,"SKEL_L_Finger43":41342,
  };
  const BONES_BY_REGION = {
    head: ["skel_head"],
    neck: ["SKEL_Neck0","SKEL_Neck1","SKEL_Neck2"],
    torso: ["SKEL_Spine_Root","SKEL_Spine0","SKEL_Spine3","SKEL_Spine5","SKEL_Spine6",
            "SKEL_L_Clavicle","SKEL_R_Clavicle"],
    waist: ["skel_pelvis","skel_l_thigh","skel_r_thigh"],
    arm_right: ["skel_r_upperarm","skel_r_forearm","skel_r_hand","MH_R_Wrist","IK_R_Hand"],
    arm_left:  ["skel_l_upperarm","skel_l_forearm","skel_l_hand","MH_L_Wrist","IK_L_Hand"],
    fingers_right: [
      "SKEL_R_Finger00","SKEL_R_Finger01","SKEL_R_Finger02",
      "SKEL_R_Finger10","SKEL_R_Finger11","SKEL_R_Finger12","SKEL_R_Finger13",
      "SKEL_R_Finger20","SKEL_R_Finger21","SKEL_R_Finger22","SKEL_R_Finger23",
      "SKEL_R_Finger30","SKEL_R_Finger31","SKEL_R_Finger32","SKEL_R_Finger33",
      "SKEL_R_Finger40","SKEL_R_Finger41","SKEL_R_Finger42","SKEL_R_Finger43",
    ],
    fingers_left: [
      "SKEL_L_Finger00","SKEL_L_Finger01","SKEL_L_Finger02",
      "SKEL_L_Finger10","SKEL_L_Finger11","SKEL_L_Finger12","SKEL_L_Finger13",
      "SKEL_L_Finger20","SKEL_L_Finger21","SKEL_L_Finger22","SKEL_L_Finger23",
      "SKEL_L_Finger30","SKEL_L_Finger31","SKEL_L_Finger32","SKEL_L_Finger33",
      "SKEL_L_Finger40","SKEL_L_Finger41","SKEL_L_Finger42","SKEL_L_Finger43",
    ],
  };
  const REGION_LABEL = {
    head:"Head", neck:"Neck", torso:"Torso", waist:"Waist & Hip",
    arm_right:"Right Arm", arm_left:"Left Arm",
    fingers_right:"Right Fingers", fingers_left:"Left Fingers",
  };
  const AC = {
    bone: null,
    boneId: -1,
    V: { px:0, py:0, pz:0, pitch:0, roll:0, yaw:0 },
    fixedRot: true,
    animKey: null,
    step: 0.005,
    animState: "stopped",
    scrubDragging: false,
    pickerPreviewKey: null,
    pickerScrubDragging: false,
    p5fw: "vorp",
    attachDelay: null,
    animCut: null,
    imported: null,
  };
  function animDesc(key) {
    return S.locales?.[S.locale]?.["anim_desc_" + key] || "";
  }
  function boneFriendly(b) {
    return S.locales?.[S.locale]?.["bone_" + b.toLowerCase()] || "";
  }

  /* ── utilities ── */
  function showAccPanel(id) {
    $(".ard-panel").removeClass("active");
    $("#" + id).addClass("active");
  }
  function acFeedback($el, msg, ok) {
    if (!$el) return;
    clearTimeout($el.data("fbtimer"));
    $el.text(msg).css("color", ok ? "rgba(120,220,100,.9)" : "rgba(230,90,90,.9)").addClass("on");
    $el.data("fbtimer", setTimeout(() => $el.removeClass("on"), 2500));
  }
  function acCopyText(text, $fb) {
    if (!text) { acFeedback($fb, "Nothing to copy", false); return; }
    acCopyFallback(text, $fb);
  }
  function acCopyFallback(text, $fb) {
    const ta = document.createElement("textarea");
    ta.value = text; ta.style.cssText = "position:fixed;opacity:0;top:0;left:0;";
    document.body.appendChild(ta); ta.select();
    try { document.execCommand("copy"); acFeedback($fb, "Copied!", true); } catch(_) { acFeedback($fb, "Copy failed", false); }
    document.body.removeChild(ta);
  }

  /* ── validation helpers ── */
  function showPanelError(errId, msg) {
    const $e = $("#" + errId);
    $e.text(msg).show().removeClass("shake");
    void $e[0].offsetWidth;
    $e.addClass("shake");
  }
  function showFieldError($el, msg) {
    $el.addClass("field-error shake");
    setTimeout(() => $el.removeClass("shake"), 600);
    const errId = "ferr-" + ($el.attr("id") || "unk");
    let $err = $("#" + errId);
    if (!$err.length) {
      $err = $('<div class="field-error-msg">').attr("id", errId);
      $el.parent().append($err);
    }
    $err.text(msg).stop(true, true).show();
    clearTimeout($el.data("ferrTimer"));
    $el.data("ferrTimer", setTimeout(() => $err.fadeOut(300), 3000));
  }
  function clearFieldError($el) {
    $el.removeClass("field-error");
    const errId = "ferr-" + ($el.attr("id") || "unk");
    $("#" + errId).hide();
  }
  function validateP1() {
    let ok = true;
    if (!$("#c-iKey").val().trim()) {
      showFieldError($("#c-iKey"), t("accadmin_err_field_key") || "Item Key is required.");
      ok = false;
    }
    if (!$("#c-iModel").val().trim()) {
      showFieldError($("#c-iModelBtn"), t("accadmin_err_field_model") || "Model is required.");
      ok = false;
    }
    return ok;
  }
  function validateP2() {
    if (!AC.bone) {
      showPanelError("c-p2-error", t("accadmin_err_bone") || "Please select a bone first.");
      return false;
    }
    return true;
  }
  // Auto-clear field errors when user corrects the field
  $(document).on("input", "#c-iKey", function () {
    if ($(this).val().trim()) clearFieldError($(this));
  });

  /* ── STEP NAV ── */
  $(document).on("click", ".ard-step-node", function () {
    const $step = $(this);
    if ($step.hasClass("cur")) return;
    const step    = $step.parent().find(".ard-step-node").index($step) + 1;
    const $curNode = $(".ard-panel.active .ard-step-node.cur").first();
    const curStep = $curNode.length ? $curNode.parent().find(".ard-step-node").index($curNode) + 1 : 1;

    // Going to step 1 or 2 — always allowed (cleanup if leaving P3)
    if (step === 1 || step === 2) {
      if (curStep >= 3) { _spawnToken = null; stopKeyBridge(); post("accadminExitCalib", {}); }
      if (step === 1) { showAccPanel("c-p1"); showRegionView(); }
      else            { showAccPanel("c-p2"); showP2ForCurrentBone(); updateP2Summary(); }
      return;
    }

    // Going to step 3 or 4 — validate P1 fields first
    if (!validateP1()) {
      if (!$("#c-p1").hasClass("active")) {
        if (curStep >= 3) { stopKeyBridge(); post("accadminExitCalib", {}); }
        showAccPanel("c-p1"); showRegionView();
      }
      return;
    }
    // Then validate P2 (bone)
    if (!AC.bone) {
      if (curStep >= 3) { stopKeyBridge(); post("accadminExitCalib", {}); }
      if (!$("#c-p2").hasClass("active")) { showAccPanel("c-p2"); showRegionView(); updateP2Summary(); }
      validateP2();
      return;
    }

    // All valid — navigate
    if (step === 3) {
      enterP3();
    } else if (step === 4) {
      stopKeyBridge(); post("accadminExitCalib", {});
      generateOutput(); showAccPanel("c-p4");
      const ta = document.getElementById("c-oCode");
      if (ta) { ta.style.height = "auto"; ta.style.height = (ta.scrollHeight + 2) + "px"; }
    }
  });

  /* ── IMPORT ── */
  const IMP_CAT_SVG = {
    Head:  '<svg viewBox="0 0 14 14" stroke-width="1.5"><circle cx="7" cy="6" r="4"/><path d="M4 10 Q7 13 10 10"/></svg>',
    Neck:  '<svg viewBox="0 0 14 14" stroke-width="1.5"><rect x="4" y="3" width="6" height="8" rx="2"/></svg>',
    Torso: '<svg viewBox="0 0 14 14" stroke-width="1.5"><path d="M3 3 h8 l1 4 H2 z"/><rect x="4" y="7" width="6" height="5" rx="1"/></svg>',
    Belt:  '<svg viewBox="0 0 14 14" stroke-width="1.5"><rect x="1" y="5.5" width="12" height="3" rx="1"/><rect x="5.5" y="4.5" width="3" height="5" rx=".5"/></svg>',
    Arm:   '<svg viewBox="0 0 14 14" stroke-width="1.5"><path d="M5 2 Q3 7 5 12"/><path d="M9 2 Q11 7 9 12"/></svg>',
    Hand:  '<svg viewBox="0 0 14 14" stroke-width="1.5"><path d="M5 8 V4 M7 8 V3 M9 8 V4 M11 8 V5"/><path d="M3 8 Q3 12 7 12 Q11 12 11 8"/></svg>',
    Leg:   '<svg viewBox="0 0 14 14" stroke-width="1.5"><path d="M5 2 V8 Q5 12 3 13"/><path d="M9 2 V8 Q9 12 11 13"/></svg>',
  };
  const IMP_CAT_ORDER = ["Head","Neck","Torso","Belt","Arm","Hand","Leg"];

  const impState = {
    activeFilter : null,
    selectedKey  : null,
    navIndex     : -1,
    navFlat      : [],
    favs         : (() => { try { return JSON.parse(localStorage.getItem('fx_imp_favs') || '[]'); } catch(e) { return []; } })(),
    collapsed    : {},
    bound        : false,
    savedView    : false,
  };

  const draftState = {
    items       : [],
    reloadTimer : null,
  };

  function impEl(id) { return document.getElementById(id); }

  function impPassesFilter(key, d) {
    const f = impState.activeFilter;
    if (f === 'fav')    return impState.favs.includes(key);
    if (f === 'male')   return d.Gender === 'male';
    if (f === 'female') return d.Gender === 'female';
    if (f === 'all')    return d.Gender === 'all' || !d.Gender;
    return false;
  }

  function impPassesSearch(key, d, q) {
    const lq = q.toLowerCase();
    return (d.Label || '').toLowerCase().includes(lq) || key.toLowerCase().includes(lq);
  }

  function impRender() {
    if (impState.savedView) { impRenderDraftItems(); return; }
    const listEl  = impEl('imp-list');
    const navHint = impEl('imp-nav-hint');
    const searchEl = impEl('imp-search');
    const loadBtn = impEl('c-import-load');
    if (!listEl) return;

    const q = searchEl ? searchEl.value.trim() : '';

    if (!impState.activeFilter && !q) {
      listEl.innerHTML = '<div class="imp-empty">' + (t("accadmin_imp_empty_filter") || "Select a filter above to browse items") + '</div>';
      impState.navFlat = []; impState.navIndex = -1;
      if (loadBtn) loadBtn.disabled = true;
      if (navHint) navHint.classList.remove('vis');
      return;
    }

    const items = S.items || {};
    const matched = {};
    Object.entries(items).forEach(([k, d]) => {
      if (!d) return;
      if (q) { if (!impPassesSearch(k, d, q)) return; }
      else   { if (!impPassesFilter(k, d)) return; }
      matched[k] = d;
    });

    impState.navFlat = Object.keys(matched);
    listEl.innerHTML = '';

    if (impState.navFlat.length === 0) {
      listEl.innerHTML = '<div class="imp-empty">' + (t("accadmin_imp_empty_search") || "No items found") + '</div>';
      if (navHint) navHint.classList.remove('vis');
      return;
    }

    if (q) {
      if (navHint) navHint.classList.add('vis');
      impState.navFlat.forEach((k, i) => listEl.appendChild(impMakeRow(k, matched[k], i)));
    } else {
      if (navHint) navHint.classList.remove('vis');
      impState.navFlat = [];
      IMP_CAT_ORDER.forEach(cat => {
        const catItems = Object.entries(matched).filter(([, d]) => d.Category === cat);
        if (!catItems.length) return;
        const isCollapsed = !!impState.collapsed[cat];
        const hdr = document.createElement('div');
        hdr.className = 'imp-cat' + (isCollapsed ? ' collapsed' : '');
        hdr.innerHTML = `<span class="imp-cat-ico">${IMP_CAT_SVG[cat] || ''}</span>${cat}<span class="imp-cat-arrow">▼</span>`;
        hdr.addEventListener('click', () => {
          impState.collapsed[cat] = !impState.collapsed[cat];
          hdr.classList.toggle('collapsed');
          listEl.querySelectorAll(`.imp-cat-item[data-cat="${cat}"]`).forEach(el => el.classList.toggle('cat-hidden'));
        });
        listEl.appendChild(hdr);
        catItems.forEach(([k, d]) => {
          impState.navFlat.push(k);
          const row = impMakeRow(k, d, impState.navFlat.length - 1);
          row.classList.add('imp-cat-item');
          row.dataset.cat = cat;
          if (isCollapsed) row.classList.add('cat-hidden');
          listEl.appendChild(row);
        });
      });
    }
    impApplyNavFocus();
  }

  function impMakeRow(key, data, idx) {
    const isFav = impState.favs.includes(key);
    const isSel = impState.selectedKey === key;
    const row   = document.createElement('div');
    row.className = 'imp-item' + (isSel ? ' sel' : '');
    row.dataset.key = key;

    const star = document.createElement('button');
    star.className = 'imp-fav' + (isFav ? ' on' : '');
    star.textContent = '★';
    star.title = isFav ? 'Remove from favourites' : 'Add to favourites';
    star.addEventListener('click', e => { e.stopPropagation(); impToggleFav(key); });

    const label = document.createElement('span');
    label.className = 'imp-item-label';
    label.textContent = data.Label || key;

    const keySpan = document.createElement('span');
    keySpan.className = 'imp-item-key';
    keySpan.textContent = key;

    row.appendChild(star); row.appendChild(label); row.appendChild(keySpan);
    row.addEventListener('click', () => { impState.navIndex = idx; impSelectItem(key); });
    return row;
  }

  function impApplyNavFocus() {
    const listEl = impEl('imp-list');
    if (!listEl) return;
    listEl.querySelectorAll('.imp-item').forEach(el => el.classList.remove('kfocus'));
    if (impState.navIndex < 0 || impState.navIndex >= impState.navFlat.length) return;
    const el = listEl.querySelector(`.imp-item[data-key="${impState.navFlat[impState.navIndex]}"]`);
    if (el) { el.classList.add('kfocus'); el.scrollIntoView({ block: 'nearest' }); }
  }

  function impSelectItem(key) {
    impState.selectedKey = key;
    const loadBtn = impEl('c-import-load');
    if (loadBtn) loadBtn.disabled = false;
    impRender();
  }

  function impToggleFav(key) {
    const i = impState.favs.indexOf(key);
    if (i === -1) impState.favs.push(key); else impState.favs.splice(i, 1);
    try { localStorage.setItem('fx_imp_favs', JSON.stringify(impState.favs)); } catch(e) {}
    impRender();
  }

  /* ── Draft (Saved) view ── */

  function buildDraftLuaConfig(key, d) {
    var model = String(d.Model !== undefined ? d.Model : '');
    var modelOut = /^-?\d+$/.test(model) ? model : ('`' + model + '`');
    var delayLine = (d.AttachDelay !== undefined && d.AttachDelay !== null)
      ? '\n        AttachDelay = ' + Number(d.AttachDelay).toFixed(2) + ','
      : '';
    var cutLine = (d.AnimCut !== undefined && d.AnimCut !== null)
      ? '\n        AnimCut     = ' + Number(d.AnimCut).toFixed(2) + ','
      : '';
    var attach = d.Attach || {};
    var genders = [];
    if (attach.Male)   genders.push('Male');
    if (attach.Female) genders.push('Female');
    var attachLines = genders.map(function(g) {
      var e = attach[g];
      var parts = [];
      if (e.BoneID   !== undefined) parts.push('BoneID = ' + Math.floor(e.BoneID));
      if (e.BoneName !== undefined) parts.push('BoneName = "' + e.BoneName + '"');
      parts.push('PX = '    + Number(e.PX    || 0).toFixed(4));
      parts.push('PY = '    + Number(e.PY    || 0).toFixed(4));
      parts.push('PZ = '    + Number(e.PZ    || 0).toFixed(4));
      parts.push('Pitch = ' + Number(e.Pitch || 0).toFixed(4));
      parts.push('Roll = '  + Number(e.Roll  || 0).toFixed(4));
      parts.push('Yaw = '   + Number(e.Yaw   || 0).toFixed(4));
      parts.push('fixedRot = ' + (e.fixedRot ? 'true' : 'false'));
      if (e.Anim) parts.push('Anim = "' + e.Anim + '"');
      var pad = g === 'Male' ? 'Male  ' : 'Female';
      return '            ' + pad + ' = { ' + parts.join(', ') + ' },';
    }).join('\n');
    return '    ["' + key + '"] = {\n' +
      '        Label    = "' + (d.Label || key) + '",\n' +
      '        Gender   = "' + (d.Gender || 'all') + '",\n' +
      '        Category = "' + (d.Category || 'Hand') + '",\n' +
      '        Model    = ' + modelOut + ',' + delayLine + cutLine + '\n' +
      '        Attach   = {\n' + attachLines + '\n        }\n    },';
  }

  function impRenderDraftItems() {
    const listEl  = impEl('imp-list');
    const loadBtn = impEl('c-import-load');
    const delBtn  = impEl('c-import-delete');
    const delSep  = impEl('c-import-delete-sep');
    if (!listEl) return;
    listEl.innerHTML = '';
    if (loadBtn) loadBtn.disabled = true;
    if (delBtn)  { delBtn.disabled = true; delBtn.style.display = 'none'; }
    if (delSep)  delSep.style.display = 'none';
    if (!draftState.items.length) {
      listEl.innerHTML = '<div class="imp-empty">' + (t("accadmin_imp_empty_saved") || "No saved items") + '</div>';
      return;
    }
    draftState.items.forEach(function(d) {
      const key = d.key;
      const row = document.createElement('div');
      row.className = 'imp-item';
      row.innerHTML =
        '<span class="imp-item-label">' + (d.Label || key) + '</span>' +
        '<span class="imp-item-key">' + key + '</span>' +
        '<button class="imp-item-copy" title="Copy config"><iconify-icon icon="mdi:content-copy" width="13" height="13"></iconify-icon></button>';
      row.addEventListener('click', function() {
        listEl.querySelectorAll('.imp-item').forEach(function(r) { r.classList.remove('sel'); });
        row.classList.add('sel');
        impState.selectedKey = key;
        if (loadBtn) loadBtn.disabled = false;
        if (delBtn)  { delBtn.disabled = false; delBtn.style.display = ''; }
        if (delSep)  delSep.style.display = '';
      });
      row.querySelector('.imp-item-copy').addEventListener('click', function(e) {
        e.stopPropagation();
        const cfg = buildDraftLuaConfig(key, d);
        acCopyFallback(cfg, null);
        const btn = this;
        btn.classList.add('copied');
        setTimeout(function() { btn.classList.remove('copied'); }, 1200);
        const fb = impEl('imp-copy-feedback');
        if (fb) {
          fb.textContent = t('accadmin_saved_copied') || 'Kopyalandı';
          fb.classList.add('vis');
          clearTimeout(fb._hideTimer);
          fb._hideTimer = setTimeout(function() { fb.classList.remove('vis'); }, 1600);
        }
      });
      listEl.appendChild(row);
    });
  }

  function parseDraftToImport(key, d) {
    const maleRaw   = (d.Attach || {}).Male   || null;
    const femaleRaw = (d.Attach || {}).Female || null;
    function norm(a) {
      if (!a) return null;
      return {
        boneId: a.BoneID, boneName: a.BoneName,
        px: a.PX||0, py: a.PY||0, pz: a.PZ||0,
        pitch: a.Pitch||0, roll: a.Roll||0, yaw: a.Yaw||0,
        fixedRot: !!a.fixedRot, anim: a.Anim || null,
      };
    }
    const maleEntry   = norm(maleRaw);
    const femaleEntry = norm(femaleRaw);
    return {
      key,
      label:       d.Label       || key,
      model:       String(d.Model !== undefined ? d.Model : ''),
      gender:      d.Gender      || 'all',
      category:    d.Category    || 'Hand',
      anim:        (maleEntry || femaleEntry || {}).anim || null,
      attachDelay: d.AttachDelay !== undefined ? d.AttachDelay : null,
      animCut:     d.AnimCut     !== undefined ? d.AnimCut     : null,
      male:        maleEntry,
      female:      femaleEntry,
    };
  }

  function impReloadDraftItems() {
    const btn      = impEl('imp-reload-btn');
    const progWrap = impEl('imp-prog-wrap');
    const progBar  = impEl('imp-prog-bar');
    if (!btn || btn.classList.contains('loading')) return;
    btn.className = 'imp-reload-btn loading';
    if (progBar)  { progBar.className = 'imp-prog-bar'; progBar.style.width = '0%'; }
    if (progWrap) progWrap.classList.add('vis');
    requestAnimationFrame(function() { requestAnimationFrame(function() {
      if (progBar) progBar.style.width = '60%';
    }); });
    $.post('https://' + GetParentResourceName() + '/loadDraftItems', JSON.stringify({}));
  }

  function enterSavedView() {
    impState.savedView    = true;
    impState.selectedKey  = null;
    const loadBtn = impEl('c-import-load');
    const delBtn  = impEl('c-import-delete');
    const delSep  = impEl('c-import-delete-sep');
    if (loadBtn) loadBtn.disabled = true;
    if (delBtn)  { delBtn.disabled = true; delBtn.style.display = 'none'; }
    if (delSep)  delSep.style.display = 'none';
    document.querySelectorAll('#c-import-overlay .imp-tab:not(#imp-tab-saved)').forEach(function(t) {
      t.classList.remove('active');
    });
    impEl('imp-tab-saved') && impEl('imp-tab-saved').classList.add('active');
    const savedBar  = impEl('imp-saved-bar');
    const searchRow = document.querySelector('#c-import-overlay .imp-search-row');
    const navHint   = impEl('imp-nav-hint');
    if (savedBar)  savedBar.style.display = 'block';
    if (searchRow) searchRow.style.display = 'none';
    if (navHint)   navHint.classList.remove('vis');
    impReloadDraftItems();
  }

  function exitSavedView() {
    impState.savedView   = false;
    impState.selectedKey = null;
    const loadBtn = impEl('c-import-load');
    const delBtn  = impEl('c-import-delete');
    const delSep  = impEl('c-import-delete-sep');
    if (loadBtn) loadBtn.disabled = true;
    if (delBtn)  { delBtn.disabled = true; delBtn.style.display = 'none'; }
    if (delSep)  delSep.style.display = 'none';
    impEl('imp-tab-saved') && impEl('imp-tab-saved').classList.remove('active');
    const savedBar  = impEl('imp-saved-bar');
    const searchRow = document.querySelector('#c-import-overlay .imp-search-row');
    if (savedBar)  savedBar.style.display = 'none';
    if (searchRow) searchRow.style.display = '';
  }

  function openImportOverlay() {
    impState.activeFilter = null;
    impState.selectedKey  = null;
    impState.navIndex     = -1;
    impState.navFlat      = [];

    const searchEl  = impEl('imp-search');
    const loadBtn   = impEl('c-import-load');
    const navHint   = impEl('imp-nav-hint');

    // reset saved view state
    if (impState.savedView) exitSavedView();
    impState.activeFilter = null;
    impState.selectedKey  = null;
    impState.navIndex     = -1;
    impState.navFlat      = [];

    if (searchEl)  searchEl.value = '';
    if (loadBtn)   loadBtn.disabled = true;
    if (navHint)   navHint.classList.remove('vis');

    document.querySelectorAll('#c-import-overlay .imp-tab').forEach(t => t.classList.remove('active'));

    if (!impState.bound) {
      impState.bound = true;
      document.querySelectorAll('#c-import-overlay .imp-tab:not(#imp-tab-saved)').forEach(tab => {
        tab.addEventListener('click', () => {
          if (impState.savedView) exitSavedView();
          const f = tab.dataset.f;
          if (impState.activeFilter === f) {
            impState.activeFilter = null;
            document.querySelectorAll('#c-import-overlay .imp-tab').forEach(t => t.classList.remove('active'));
          } else {
            impState.activeFilter = f;
            document.querySelectorAll('#c-import-overlay .imp-tab').forEach(t => t.classList.remove('active'));
            tab.classList.add('active');
          }
          impState.navIndex = -1;
          impRender();
        });
      });
      const savedTab = impEl('imp-tab-saved');
      if (savedTab) savedTab.addEventListener('click', function() {
        if (impState.savedView) return;
        impState.activeFilter = null;
        enterSavedView();
      });
      const rBtn = impEl('imp-reload-btn');
      if (rBtn) rBtn.addEventListener('click', function() { impReloadDraftItems(); });
      const sEl = impEl('imp-search');
      if (sEl) {
        sEl.addEventListener('input', () => { impState.navIndex = -1; impRender(); });
        sEl.addEventListener('keydown', e => {
          if (!impState.navFlat.length) return;
          if (e.key === 'ArrowDown')      { e.preventDefault(); impState.navIndex = Math.min(impState.navIndex + 1, impState.navFlat.length - 1); impApplyNavFocus(); }
          else if (e.key === 'ArrowUp')   { e.preventDefault(); impState.navIndex = Math.max(impState.navIndex - 1, 0); impApplyNavFocus(); }
          else if (e.key === 'Enter' && impState.navIndex >= 0) { impSelectItem(impState.navFlat[impState.navIndex]); }
        });
      }
    }

    impRender();
    $("#c-import-overlay").show();
  }

  function applyImportData(parsed) {
    const calGender = $("#c-iAccadminGender").attr("data-csel-val") || "Male";
    const attach = calGender === "Female" ? parsed.female : parsed.male;
    const fallback = parsed.male || parsed.female;
    const bone = attach || fallback;

    if (parsed.key)   { $("#c-iKey").val(parsed.key); }
    if (parsed.label) { $("#c-iLabel").val(parsed.label); }

    if (parsed.model) {
      $("#c-iModel").val(parsed.model);
      $("#c-iModelVal").text(parsed.model);
      $("#c-iModelBtn").addClass("has-value has-anim");
      clearFieldError($("#c-iModelBtn"));
    }

    if (parsed.gender) {
      const gv = parsed.gender.toLowerCase();
      const gLabel = $("#c-iGender .ard-csel-opt[data-val='" + gv + "']").text() || parsed.gender;
      setCsel($("#c-iGender"), gv, gLabel);
    }

    if (parsed.category) {
      const catMap = { head:"Head", hand:"Hand", neck:"Neck", torso:"Torso", leg:"Leg", arm:"Arm", belt:"Belt", waist:"Belt" };
      const catVal = catMap[parsed.category.toLowerCase()] || parsed.category;
      const catLabel = $("#c-iCategory .ard-csel-opt[data-val='" + catVal + "']").text() || catVal;
      setCsel($("#c-iCategory"), catVal, catLabel);
    }

    if (bone) {
      if (bone.fixedRot !== undefined) {
        $("#c-iFixedRot").prop("checked", bone.fixedRot);
        AC.fixedRot = bone.fixedRot;
      }

      const animKey = parsed.anim || bone.anim || null;
      if (animKey) {
        $("#c-iAnim").val(animKey);
        $("#c-iAnimVal").text(animKey);
        $("#c-iAnimBtn").addClass("has-value has-anim");
        AC.animKey = animKey;
      } else {
        $("#c-iAnim").val("");
        $("#c-iAnimVal").text(t("accadmin_anim_select") || "— Select Animation —");
        $("#c-iAnimBtn").removeClass("has-value has-anim");
        AC.animKey = null;
      }

      if (bone.boneName) {
        AC.bone   = bone.boneName;
        AC.boneId = bone.boneId !== undefined ? bone.boneId : (BONE_ID_MAP[bone.boneName] !== undefined ? BONE_ID_MAP[bone.boneName] : -1);
      } else if (bone.boneId !== undefined) {
        const entry = Object.entries(BONE_ID_MAP).find(([, id]) => id === bone.boneId);
        if (entry) {
          AC.bone = entry[0];
        } else {
          // boneId not in BONE_ID_MAP — pass numeric string so Lua's GetPedBoneIndex fallback can still resolve it
          AC.bone = String(bone.boneId);
        }
        AC.boneId = bone.boneId;
      }

      AC.V.px    = bone.px    !== undefined ? bone.px    : AC.V.px;
      AC.V.py    = bone.py    !== undefined ? bone.py    : AC.V.py;
      AC.V.pz    = bone.pz    !== undefined ? bone.pz    : AC.V.pz;
      AC.V.pitch = bone.pitch !== undefined ? bone.pitch : AC.V.pitch;
      AC.V.roll  = bone.roll  !== undefined ? bone.roll  : AC.V.roll;
      AC.V.yaw   = bone.yaw   !== undefined ? bone.yaw   : AC.V.yaw;
    }

    AC.attachDelay = (parsed.attachDelay !== undefined && parsed.attachDelay !== null) ? parsed.attachDelay : null;
    if (AC.attachDelay !== null) {
      $("#c-btn-use-delay-lbl").text(t("accadmin_delay_added") || "Delay Added"); $("#c-btn-use-delay").addClass("captured");
    } else {
      $("#c-btn-use-delay-lbl").text(t("accadmin_add_delay") || "Add Delay"); $("#c-btn-use-delay").removeClass("captured");
    }
    AC.animCut = (parsed.animCut !== undefined && parsed.animCut !== null) ? parsed.animCut : null;
    if (AC.animCut !== null) {
      $("#c-btn-use-cut-lbl").text(t("accadmin_cut_added") || "Cut Added"); $("#c-btn-use-cut").addClass("captured");
    } else {
      $("#c-btn-use-cut-lbl").text(t("accadmin_add_cut") || "Cut Here"); $("#c-btn-use-cut").removeClass("captured");
    }

    AC.imported = {
      key:         parsed.key         || null,
      label:       parsed.label       || null,
      model:       parsed.model       || null,
      gender:      parsed.gender      || null,
      category:    parsed.category    || null,
      anim:        parsed.anim        || null,
      attachDelay: (parsed.attachDelay !== undefined && parsed.attachDelay !== null) ? parsed.attachDelay : null,
      animCut:     (parsed.animCut     !== undefined && parsed.animCut     !== null) ? parsed.animCut     : null,
      male:        parsed.male        || null,
      female:      parsed.female      || null,
    };

    if (typeof updateP2Summary === "function") updateP2Summary();
  }

  $(document).on("click", "#c-btnImport", function () {
    if ($("#c-import-overlay").is(":visible")) {
      $("#c-import-overlay").hide();
      return;
    }
    openImportOverlay();
  });

  $(document).on("click", "#c-import-cancel", function () {
    $("#c-import-overlay").hide();
  });

  $(document).on("click", "#c-import-load", function () {
    const key = impState.selectedKey;
    if (!key) return;
    const $btn = $(this);
    $btn.prop('disabled', true);

    // Draft (Saved) view — use direct spawn, no server key lookup
    if (impState.savedView) {
      const itemData = draftState.items.find(function(e) { return e.key === key; });
      if (!itemData) { $btn.prop('disabled', false); return; }
      const parsed = parseDraftToImport(key, itemData);
      applyImportData(parsed);
      AC.imported.key = null; // force spawnThenCalib path in enterP3
      $("#c-import-overlay").hide();
      return;
    }

    // Normal LUA item
    $.ajax({
      url: `https://${GetParentResourceName()}/getImportItemData`,
      method: 'POST', contentType: 'application/json', data: JSON.stringify({ key }), dataType: 'text'
    }).done(raw => {
      try {
        if (!raw || !raw.trim()) throw new Error('empty');
        const parsed = JSON.parse(raw);
        if (parsed.error) throw new Error(parsed.error);
        applyImportData(parsed);
        $("#c-import-overlay").hide();
      } catch(e) { $btn.prop('disabled', false); }
    }).fail(() => $btn.prop('disabled', false));
  });

  $(document).on("click", "#c-import-delete", function () {
    const key = impState.selectedKey;
    if (!key) return;
    draftState.items = draftState.items.filter(function(e) { return e.key !== key; });
    impState.selectedKey = null;
    impRenderDraftItems();
    $.post('https://' + GetParentResourceName() + '/deleteDraftItem', JSON.stringify({ key: key }));
  });

  /* ── P1 ── */
  $(document).on("click", "#c-btnGoToBone", function () {
    if (!validateP1()) return;
    $("#c-p1-error").hide();
    showAccPanel("c-p2");
    updateP2Summary();
  });

  /* ── P2 ── */
  function updateP2Summary() {
    $("#c-selBoneTag").text(AC.bone ? AC.bone : (t("accadmin_bone_no_sel") || "No bone selected yet"));
  }
  function showRegionView() {
    $("#c-bList").hide().removeData("region");
    $("#c-regionList").show();
    $("#c-bBackRegion").removeClass("vis");
    $("#c-bSearch").hide().val("");
    $("#c-boneHoverLabel").text(t("accadmin_bone_regions") || "Regions");
  }
  function showP2ForCurrentBone() {
    if (AC.bone) {
      const region = Object.keys(BONES_BY_REGION).find(r => BONES_BY_REGION[r].includes(AC.bone));
      if (region) { showBoneListForRegion(region); return; }
    }
    showRegionView();
  }
  function showBoneListForRegion(region) {
    $("#c-boneHoverLabel").text(REGION_LABEL[region] || region);
    $("#c-bBackRegion").addClass("vis");
    $("#c-bSearch").show().val("");
    $("#c-regionList").hide();
    renderBoneList(BONES_BY_REGION[region] || [], "");
    $("#c-bList").data("region", region).show();
  }
  function renderBoneList(bones, filter) {
    const $list = $("#c-bList").empty();
    const q = (filter || "").toLowerCase();
    const visible = q
      ? bones.filter(b => b.toLowerCase().includes(q) || boneFriendly(b).toLowerCase().includes(q))
      : bones;
    if (!visible.length) {
      $list.html('<div style="padding:8px 0;font-size:.76vh;color:rgba(240,235,215,.28);text-align:center;font-family:rdrlino,serif;text-transform:uppercase;letter-spacing:1px;">No match</div>');
      return;
    }
    visible.forEach(b => {
      const boneId = BONE_ID_MAP[b];
      const friendly = boneFriendly(b);
      const $item = $('<div class="ard-bitem">').toggleClass("sel", b === AC.bone);
      $item.append($('<span class="ard-blabel">').text(friendly || b));
      $item.append($('<span class="ard-bname">').text(b + (boneId !== undefined ? " · " + boneId : "")));
      $item.on("click", function () {
        AC.bone = b;
        AC.boneId = BONE_ID_MAP[b] !== undefined ? BONE_ID_MAP[b] : -1;
        $("#c-bList .ard-bitem").removeClass("sel");
        $(this).addClass("sel");
        updateP2Summary();
      });
      $list.append($item);
    });
  }
  $(document).on("click", ".ard-region-btn", function () { showBoneListForRegion($(this).data("region")); });
  $(document).on("click", "#c-bBackRegion", function () { showRegionView(); });
  $(document).on("input", "#c-bSearch", function () {
    const region = $("#c-bList").data("region") || "";
    renderBoneList(BONES_BY_REGION[region] || [], $(this).val());
  });
  $(document).on("mouseenter", "#c-bList .ard-bitem", function () {
    $("#c-boneHoverLabel").text($(this).find(".ard-blabel").text());
  });
  $(document).on("mouseleave", "#c-bList .ard-bitem", function () {
    const region = $("#c-bList").data("region") || "";
    $("#c-boneHoverLabel").text(REGION_LABEL[region] || "Bones");
  });
  $(document).on("click", "#c-btnBackSetup", function () { showAccPanel("c-p1"); showRegionView(); });
  $(document).on("click", "#c-btnGoToAccadmin", function () {
    if (!validateP2()) return;
    $("#c-p2-error").hide();
    enterP3();
  });

  /* ── P3 ── */
  function resolveAcBoneId() {
    if (AC.boneId !== undefined && AC.boneId >= 0) return AC.boneId;
    const mapped = BONE_ID_MAP[AC.bone];
    return mapped !== undefined ? mapped : -1;
  }
  function enterP3() {
    AC.fixedRot = $("#c-iFixedRot").is(":checked");
    AC.animKey  = $("#c-iAnim").val().trim() || null;
    const key   = $("#c-iKey").val().trim();
    const label = $("#c-iLabel").val().trim() || key;
    const model = $("#c-iModel").val().trim();

    $("#c-iSum").text(label || model);
    $("#c-accadminBoneTag").text("Bone: " + AC.bone);
    ["px","py","pz","pitch","roll","yaw"].forEach(a => $("#c-v-" + a).val(parseFloat(AC.V[a].toFixed(4))));
    $("#c-anim-ctrl-label").text(AC.animKey || "—");
    showAccPanel("c-p3");

    const calGender = $("#c-iAccadminGender").attr("data-csel-val") || "Male";
    const calibData = {
      boneName: AC.bone, boneId: resolveAcBoneId(), fixedRot: AC.fixedRot,
      px: AC.V.px, py: AC.V.py, pz: AC.V.pz,
      pitch: AC.V.pitch, roll: AC.V.roll, yaw: AC.V.yaw,
      step: AC.step
    };

    if (AC.imported && AC.imported.key) {
      spawnByKey(AC.imported.key, calGender, calibData);
    } else {
      const spawnData = {
        model, boneName: AC.bone, boneId: resolveAcBoneId(),
        px: AC.V.px, py: AC.V.py, pz: AC.V.pz,
        pitch: AC.V.pitch, roll: AC.V.roll, yaw: AC.V.yaw,
        fixedRot: AC.fixedRot, animKey: AC.animKey || null, attachDelay: AC.attachDelay
      };
      spawnThenCalib(spawnData, calibData);
    }
    startKeyBridge();
  }
  function sendP3Update() {
    post("accadminUpdate", {
      boneName: AC.bone,
      px: AC.V.px, py: AC.V.py, pz: AC.V.pz,
      pitch: AC.V.pitch, roll: AC.V.roll, yaw: AC.V.yaw,
      fixedRot: AC.fixedRot,
    });
  }
  let acBtnHoldTimer = null, acBtnHoldInterval = null;
  function acBtnClear() { clearTimeout(acBtnHoldTimer); clearInterval(acBtnHoldInterval); acBtnHoldTimer = acBtnHoldInterval = null; }
  function acBtnFire($el) {
    if (!$("#c-p3").hasClass("active")) return;
    const a = $el.data("a");
    const isRot = a === "pitch" || a === "roll" || a === "yaw";
    const step = isRot ? Math.max(AC.step, 0.5) : AC.step;
    const d = $el.hasClass("ard-aplus") ? step : -step;
    AC.V[a] = parseFloat((AC.V[a] + d).toFixed(6));
    $("#c-v-" + a).val(parseFloat(AC.V[a].toFixed(4)));
    post("accadminDelta", { field: a, delta: d });
  }
  $(document).on("mousedown", ".ard-aplus, .ard-aminus", function (e) {
    e.preventDefault();
    const $el = $(this);
    acBtnFire($el);
    acBtnHoldTimer = setTimeout(function () {
      acBtnHoldInterval = setInterval(function () { acBtnFire($el); }, 80);
    }, 500);
  });
  $(document).on("mouseup mouseleave", ".ard-aplus, .ard-aminus", acBtnClear);
  let acInputDebounce = null;
  $(document).on("input", ".ard-aval", function () {
    if (!$("#c-p3").hasClass("active")) return;
    const $el = $(this);
    clearTimeout(acInputDebounce);
    acInputDebounce = setTimeout(function () {
      const a = $el.data("a"), v = parseFloat($el.val());
      if (!isNaN(v)) { AC.V[a] = v; post("accadminSet", { field: a, value: v }); }
    }, 300);
  });
  $(document).on("change", ".ard-aval", function () {
    if (!$("#c-p3").hasClass("active")) return;
    clearTimeout(acInputDebounce);
    const a = $(this).data("a"), v = parseFloat($(this).val());
    if (!isNaN(v)) { AC.V[a] = v; post("accadminSet", { field: a, value: v }); }
  });
  $(document).on("keydown", ".ard-aval", function (e) {
    if (e.key !== "Enter") return;
    e.preventDefault();
    if (!$("#c-p3").hasClass("active")) return;
    clearTimeout(acInputDebounce);
    const a = $(this).data("a"), v = parseFloat($(this).val());
    if (!isNaN(v)) { AC.V[a] = v; post("accadminSet", { field: a, value: v }); $(this).blur(); }
  });
  $(document).on("click", "#c-btnReset", function () {
    AC.V = { px:0, py:0, pz:0, pitch:0, roll:0, yaw:0 };
    ["px","py","pz","pitch","roll","yaw"].forEach(a => $("#c-v-"+a).val("0"));
    sendP3Update();
  });
  $(document).on("click", "#c-btnBackBone", function () {
    _spawnToken = null;
    stopKeyBridge(); post("accadminExitCalib", {});
    showAccPanel("c-p2"); showP2ForCurrentBone(); updateP2Summary();
  });
  $(document).on("click", "#c-btnGenerate", function () {
    stopKeyBridge(); post("accadminExitCalib", {});
    generateOutput(); showAccPanel("c-p4");
    const ta = document.getElementById("c-oCode");
    if (ta) { ta.style.height = "auto"; ta.style.height = (ta.scrollHeight + 2) + "px"; }
  });

  /* ── keyboard bridge ── */
  let acKeyActive = false;
  const AC_KEYS = {
    Space:"up", ShiftLeft:"down", ShiftRight:"down",
    KeyW:"fwd", KeyS:"bwd", KeyA:"left", KeyD:"right",
    ArrowUp:"adj_fwd", ArrowDown:"adj_bwd", ArrowLeft:"adj_left", ArrowRight:"adj_right",
    KeyQ:"adj_up", KeyZ:"adj_down",
    KeyC:"rot_r", KeyV:"rot_l", KeyB:"rot_mode",
  };
  function isInputFocused() {
    const t = document.activeElement && document.activeElement.tagName;
    return t === "INPUT" || t === "TEXTAREA";
  }
  function startKeyBridge() { acKeyActive = true; }
  function stopKeyBridge() {
    acKeyActive = false;
    post("accadminKeyDown", { k: "__clear__" });
  }
  $(document).on("keydown.acbridge", function (e) {
    if (!acKeyActive || isInputFocused()) return;
    if (e.code === "Delete") {
      AC.V = { px:0,py:0,pz:0,pitch:0,roll:0,yaw:0 };
      ["px","py","pz","pitch","roll","yaw"].forEach(a => $("#c-v-"+a).val("0"));
      sendP3Update(); e.preventDefault(); return;
    }
    const k = AC_KEYS[e.code];
    if (!k) return;
    e.preventDefault();
    post("accadminKeyDown", { k });
  });
  $(document).on("keyup.acbridge", function (e) {
    if (!acKeyActive) return;
    const k = AC_KEYS[e.code];
    if (k) post("accadminKeyUp", { k });
  });
  // Sticky-key fix: clear all key state when mouse is used or window loses focus
  $(document).on("mousedown.acbridge", function () {
    if (acKeyActive) post("accadminKeyDown", { k: "__clear__" });
  });
  window.addEventListener("blur", function () {
    if (acKeyActive) post("accadminKeyDown", { k: "__clear__" });
  });

  /* ── P3 anim controls ── */
  $(document).on("click", "#c-btn-anim-play", function () {
    if (AC.animState === "playing" || AC.animState === "paused") post("accadminPausePreviewAnim", {});
    else post("accadminPreviewAnim", { key: AC.animKey });
  });
  $(document).on("click", "#c-btn-anim-stop", function () { post("accadminStopPreviewAnim", {}); });
  $(document).on("click", "#c-btn-frame-prev", function () { post("accadminFrameStep", { dir: -1 }); });
  $(document).on("click", "#c-btn-frame-next", function () { post("accadminFrameStep", { dir: 1 }); });

  /* ── Picker anim controls ── */
  $(document).on("click", "#c-pk-btn-anim-play", function () {
    if (AC.animState === "playing" || AC.animState === "paused") post("accadminPausePreviewAnim", {});
    else if (AC.pickerPreviewKey) post("accadminPreviewAnim", { key: AC.pickerPreviewKey });
  });
  $(document).on("click", "#c-pk-btn-anim-stop", function () { post("accadminStopPreviewAnim", {}); });
  $(document).on("click", "#c-pk-btn-frame-prev", function () { post("accadminFrameStep", { dir: -1 }); });
  $(document).on("click", "#c-pk-btn-frame-next", function () { post("accadminFrameStep", { dir: 1 }); });
  $(document).on("mousedown", "#c-pk-scrub-track", function (e) { AC.pickerScrubDragging = true; acPickerSeekScrubber(e); });
  $(document).on("mousemove.pkscrub", function (e) { if (AC.pickerScrubDragging) acPickerSeekScrubber(e); });
  $(document).on("mouseup.pkscrub", function () { AC.pickerScrubDragging = false; });
  function acPickerSeekScrubber(e) {
    const t = document.getElementById("c-pk-scrub-track"); if (!t) return;
    const r = t.getBoundingClientRect();
    const frac = Math.max(0, Math.min(1, (e.clientX - r.left) / r.width));
    $("#c-pk-scrub-fill").css("width", (frac * 100).toFixed(1) + "%");
    post("accadminSeekAnim", { frac });
  }
  $(document).on("click", "#c-side-picker-apply", function () {
    if (!AC.pickerPreviewKey) return;
    const key = AC.pickerPreviewKey;
    post("accadminStopPreviewAnim", {});
    AC.pickerPreviewKey = null;
    AC.animKey = key;
    $("#c-iAnimVal").text(key);
    $("#c-iAnim").val(key);
    $("#c-iAnimBtn").addClass("has-value has-anim");
    acPickerResetControls();
    $("#accSidePicker").removeClass("open");
    accadminPickerType = null;
  });

  function syncCalibVisual() {
    var val = $("#c-iAccadminGender").attr("data-csel-val") || "Male";
    var isMale = (val === "Male");
    $("#c-calib-ico").attr("src", isMale
      ? "./assets/img/male-white.png"
      : "./assets/img/female-white.png");
    $("#c-calib-val").text(isMale
      ? (t("accadmin_calib_male")   || "MALE")
      : (t("accadmin_calib_female") || "FEMALE"));
  }
  $(document).on("click", "#c-calib-arr-prev, #c-calib-arr-next", function () {
    var $csel = $("#c-iAccadminGender");
    var cur  = $csel.attr("data-csel-val") || "Male";
    var next = (cur === "Male") ? "Female" : "Male";
    var lbl  = (next === "Male")
      ? (t("accadmin_gender_cal_male")   || "Male character")
      : (t("accadmin_gender_cal_female") || "Female character");
    setCsel($csel, next, lbl);
    syncCalibVisual();
  });

  $(document).on("mousedown", "#c-scrub-track", function (e) { AC.scrubDragging = true; acSeekScrubber(e); });
  $(document).on("mousemove.scrub", function (e) { if (AC.scrubDragging) acSeekScrubber(e); });
  $(document).on("mouseup.scrub", function () { AC.scrubDragging = false; });
  function acSeekScrubber(e) {
    const t = document.getElementById("c-scrub-track"); if (!t) return;
    const r = t.getBoundingClientRect();
    const frac = Math.max(0, Math.min(1, (e.clientX - r.left) / r.width));
    $("#c-scrub-fill").css("width", (frac * 100).toFixed(1) + "%");
    post("accadminSeekAnim", { frac });
  }
  /* ── Scrubber: unified rAF-based state (eliminates jitter) ── */
  const _scrub = { cur: 0, dur: 0, syncedAt: 0, rafId: null, holdStart: 0 };
  function _scrubRafTick() {
    _scrub.rafId = null;
    if (AC.animState !== "playing") return;
    const now       = performance.now();
    const predicted = Math.min(_scrub.cur + (now - _scrub.syncedAt) / 1000, _scrub.dur);
    const atEnd     = _scrub.dur > 0 && predicted >= _scrub.dur - 0.05;
    if (atEnd) { if (!_scrub.holdStart) _scrub.holdStart = now; }
    else        { _scrub.holdStart = 0; }
    const showInf = atEnd && (now - _scrub.holdStart) > 500;
    _scrubWriteDOM(predicted, _scrub.dur, showInf);
    _scrub.rafId = requestAnimationFrame(_scrubRafTick);
  }
  function _scrubWriteDOM(cur, dur, holdInf) {
    if (dur <= 0) return;
    const pct  = (cur / dur * 100).toFixed(1) + "%";
    const cStr = cur.toFixed(2);
    const dStr = holdInf ? "∞" : dur.toFixed(2);
    if (!AC.scrubDragging) {
      document.getElementById("c-scrub-fill").style.width = pct;
      document.getElementById("c-scrub-cur").textContent  = cStr;
      const durEl = document.getElementById("c-scrub-dur");
      durEl.textContent = dStr;
      durEl.classList.toggle("ard-inf", !!holdInf);
    }
    if (!AC.pickerScrubDragging) {
      document.getElementById("c-pk-scrub-fill").style.width = pct;
      document.getElementById("c-pk-scrub-cur").textContent  = cStr;
      const pkDurEl = document.getElementById("c-pk-scrub-dur");
      pkDurEl.textContent = dStr;
      pkDurEl.classList.toggle("ard-inf", !!holdInf);
    }
  }
  function acUpdateScrubberUI(cur, dur) {
    _scrub.dur = dur;
    if (AC.animState === "playing" && dur > 0) {
      const now        = performance.now();
      const predicted  = _scrub.cur + (now - _scrub.syncedAt) / 1000;
      // Normalise against duration so the guard works for both short (0.03s) and long clips.
      // Cap predicted at dur before normalising: prevents the threshold going negative.
      const predCapped = Math.min(predicted, dur);
      const curNorm    = cur / dur;
      const predNorm   = predCapped / dur;
      const nearEnd    = predNorm >= 0.75;
      // After 200ms stuck at end, we are in a hold state â€” reject backward snaps even
      // if nearEnd is true (short animations always satisfy nearEnd).
      const inHold     = _scrub.holdStart > 0 && (now - _scrub.holdStart) > 200;
      if (curNorm < predNorm - 0.15 && (!nearEnd || inHold)) return;
      _scrub.cur      = cur;
      _scrub.syncedAt = now;
    } else {
      _scrub.cur      = cur;
      _scrub.syncedAt = performance.now();
      _scrubWriteDOM(cur, dur);
    }
  }
  function acSetAnimPlayBtn(state) {
    AC.animState = state;
    if (state === "playing") {
      if (!_scrub.rafId) {
        _scrub.syncedAt = performance.now();
        _scrub.rafId = requestAnimationFrame(_scrubRafTick);
      }
    } else {
      if (_scrub.rafId) { cancelAnimationFrame(_scrub.rafId); _scrub.rafId = null; }
      _scrub.holdStart = 0;
    }
    const $btn = $("#c-btn-anim-play");
    if (state === "playing") {
      $btn.addClass("is-playing").html('<svg width="11" height="11" viewBox="0 0 10 10" fill="currentColor"><rect x="0" y="0" width="3" height="10"/><rect x="7" y="0" width="3" height="10"/></svg>');
    } else {
      $btn.removeClass("is-playing").html('<svg width="11" height="13" viewBox="0 0 8 10" fill="currentColor"><polygon points="0,0 8,5 0,10"/></svg>');
    }
  }
  $(document).on("click", "#c-btn-use-delay", function () {
    if (AC.attachDelay !== null) {
      AC.attachDelay = null;
      $("#c-btn-use-delay-lbl").text(t("accadmin_add_delay") || "Add Delay"); $(this).removeClass("captured");
    } else {
      const cur = parseFloat($("#c-scrub-cur").text()) || 0;
      AC.attachDelay = cur;
      $("#c-btn-use-delay-lbl").text(t("accadmin_delay_added") || "Delay Added"); $(this).addClass("captured");
    }
  });
  $(document).on("click", "#c-btn-use-cut", function () {
    if (AC.animCut !== null) {
      AC.animCut = null;
      $("#c-btn-use-cut-lbl").text(t("accadmin_add_cut") || "Cut Here"); $(this).removeClass("captured");
    } else {
      const cur = parseFloat(document.getElementById("c-scrub-cur").textContent) || 0;
      AC.animCut = cur;
      $("#c-btn-use-cut-lbl").text(t("accadmin_cut_added") || "Cut Added"); $(this).addClass("captured");
    }
  });

  /* ── output generation ── */
  function generateOutput() {
    const key       = $("#c-iKey").val().trim();
    const label     = $("#c-iLabel").val().trim() || key;
    const model     = $("#c-iModel").val().trim();
    const calGender = $("#c-iAccadminGender").attr("data-csel-val") || "Male";
    const category  = $("#c-iCategory").attr("data-csel-val") || "Hand";
    const V         = AC.V;
    const boneId      = BONE_ID_MAP[AC.bone] ?? (AC.boneId >= 0 ? AC.boneId : undefined);
    const delayLine   = AC.attachDelay !== null ? `\n        AttachDelay = ${AC.attachDelay.toFixed(2)},` : "";
    const cutLine     = AC.animCut     !== null ? `\n        AnimCut     = ${AC.animCut.toFixed(2)},`     : "";
    const modelOutput = `\`${model}\``;
    const otherGender = calGender === "Male" ? "Female" : "Male";
    const padCur = calGender === "Male" ? "Male  " : "Female";
    const padOth = otherGender === "Male" ? "Male  " : "Female";

    function buildBlock(bone, bid, v, anim, fixedRot) {
      const bidPart  = bid !== undefined ? `BoneID = ${bid}, ` : "";
      const bonePart = (bone && !/^\d+$/.test(bone)) ? `BoneName = "${bone}", ` : "";
      const animPart = anim ? `, Anim = "${anim}"` : "";
      return `{ ${bidPart}${bonePart}PX = ${v.px.toFixed(4)}, PY = ${v.py.toFixed(4)}, PZ = ${v.pz.toFixed(4)}, Pitch = ${v.pitch.toFixed(4)}, Roll = ${v.roll.toFixed(4)}, Yaw = ${v.yaw.toFixed(4)}, fixedRot = ${fixedRot ? "true" : "false"}${animPart} }`;
    }

    function buildBlockFromImported(e) {
      if (!e) return null;
      const bid = e.boneId !== undefined ? e.boneId : undefined;
      const v   = { px: e.px||0, py: e.py||0, pz: e.pz||0, pitch: e.pitch||0, roll: e.roll||0, yaw: e.yaw||0 };
      return buildBlock(e.boneName || null, bid, v, e.anim || null, !!e.fixedRot);
    }

    const curBlock = buildBlock(AC.bone, boneId, V, AC.animKey, AC.fixedRot);
    let attachLines;
    let gender;

    gender = ($("#c-iGender").attr("data-csel-val") || (AC.imported && AC.imported.gender) || "all").toLowerCase();

    if (gender === "all") {
      if (AC.imported) {
        const otherEntry = calGender === "Male" ? AC.imported.female : AC.imported.male;
        const ob = buildBlockFromImported(otherEntry);
        if (ob) {
          attachLines = `            ${padCur} = ${curBlock},\n            ${padOth} = ${ob},`;
        } else {
          attachLines = `            ${padCur} = ${curBlock},\n            -- ${padOth} = ${curBlock},`;
        }
      } else {
        attachLines = `            ${padCur} = ${curBlock},\n            -- ${padOth} = ${curBlock},`;
      }
    } else {
      const blockLabel = gender === "female" ? "Female" : gender === "male" ? "Male" : calGender;
      attachLines = `            ${blockLabel} = ${curBlock},`;
    }

    const code =
`    ["${key}"] = {
        Label    = "${label}",
        Gender   = "${gender}",
        Category = "${category}",
        Model    = ${modelOutput},${delayLine}${cutLine}
        Attach   = {
${attachLines}
        }
    },`;
    $("#c-oCode").val(code);
    $("#c-p4-card-key").text(key || "—");
    $("#c-p4-card-label").text(label || "—");
    $("#c-p4-card-model").text(model || "—");
    $("#c-p4-card-cat").text(category || "—");
    $("#c-p4-card-gender").text(gender || "—");
    $("#c-p4-card-bone").text(AC.bone || "—");
    $("#c-p4-card-anim").text(AC.animKey || "—");
  }

  /* ── P4 ── */
  $(document).on("click", "#c-btnBackAccadmin", function () {
    showAccPanel("c-p3");
    startKeyBridge();
    const model = $("#c-iModel").val().trim();
    spawnThenCalib(
      { model, boneName: AC.bone, boneId: resolveAcBoneId(),
        px: AC.V.px, py: AC.V.py, pz: AC.V.pz,
        pitch: AC.V.pitch, roll: AC.V.roll, yaw: AC.V.yaw,
        fixedRot: AC.fixedRot,
        animKey: AC.animKey || null,
        attachDelay: null },
      { boneName: AC.bone, boneId: resolveAcBoneId(), fixedRot: AC.fixedRot,
        px: AC.V.px, py: AC.V.py, pz: AC.V.pz,
        pitch: AC.V.pitch, roll: AC.V.roll, yaw: AC.V.yaw,
        step: AC.step }
    );
  });
  $(document).on("click", "#c-btnCopy", function () { acCopyText($("#c-oCode").val(), $("#c-cfb")); });

  function buildDraftPayload() {
    const key      = $("#c-iKey").val().trim();
    const label    = $("#c-iLabel").val().trim() || key;
    const modelRaw = $("#c-iModel").val().trim();
    const calGender = $("#c-iAccadminGender").attr("data-csel-val") || "Male";
    const category  = $("#c-iCategory").attr("data-csel-val") || "Hand";
    if (!key) return null;
    const model  = /^-?\d+$/.test(modelRaw) ? parseInt(modelRaw, 10) : modelRaw;
    const boneId = BONE_ID_MAP[AC.bone] !== undefined ? BONE_ID_MAP[AC.bone] : (AC.boneId >= 0 ? AC.boneId : undefined);
    function makeEntry(v, bone, bid, fixedRot, anim) {
      const e = {};
      if (bid !== undefined) e.BoneID = bid;
      if (bone && !/^\d+$/.test(bone)) e.BoneName = bone;
      e.PX = v.px; e.PY = v.py; e.PZ = v.pz;
      e.Pitch = v.pitch; e.Roll = v.roll; e.Yaw = v.yaw;
      e.fixedRot = !!fixedRot;
      if (anim) e.Anim = anim;
      return e;
    }
    const curEntry = makeEntry(AC.V, AC.bone, boneId, AC.fixedRot, AC.animKey);
    const Attach   = {};
    let gender;
    gender = ($("#c-iGender").attr("data-csel-val") || (AC.imported && AC.imported.gender) || "all").toLowerCase();
    const attachKey = gender === "female" ? "Female" : gender === "male" ? "Male" : calGender;
    Attach[attachKey] = curEntry;
    if (gender === "all" && AC.imported) {
      const otherGender = calGender === "Male" ? "Female" : "Male";
      const otherEntry  = calGender === "Male" ? AC.imported.female : AC.imported.male;
      if (otherEntry) {
        const oBid = otherEntry.boneId !== undefined ? otherEntry.boneId : undefined;
        const oV   = { px: otherEntry.px||0, py: otherEntry.py||0, pz: otherEntry.pz||0,
                       pitch: otherEntry.pitch||0, roll: otherEntry.roll||0, yaw: otherEntry.yaw||0 };
        Attach[otherGender] = makeEntry(oV, otherEntry.boneName||null, oBid, !!otherEntry.fixedRot, otherEntry.anim||null);
      }
    }
    const itemData = { Label: label, Gender: gender, Category: category, Model: model, Attach };
    if (AC.attachDelay !== null && AC.attachDelay !== undefined) itemData.AttachDelay = AC.attachDelay;
    if (AC.animCut     !== null && AC.animCut     !== undefined) itemData.AnimCut     = AC.animCut;
    return { key, itemData };
  }

  $(document).on("click", "#c-btnSaveDraft", function () {
    const payload = buildDraftPayload();
    if (!payload) return;
    const btn = this;
    const lbl = document.getElementById("c-btnSaveDraft-lbl");
    btn.disabled = true;
    function restoreBtn() { btn.disabled = false; if (lbl) lbl.textContent = "Save"; }
    $.ajax({
      url: `https://${GetParentResourceName()}/saveDraftItem`,
      method: "POST", contentType: "application/json",
      data: JSON.stringify(payload), dataType: "text"
    }).done(function(raw) {
      let res = {};
      try { res = typeof raw === "string" ? JSON.parse(raw) : raw; } catch(e) {}
      if (res.success) {
        const _entry = Object.assign({}, payload.itemData, { key: payload.key });
        const _idx   = draftState.items.findIndex(function(e) { return e.key === payload.key; });
        if (_idx >= 0) draftState.items[_idx] = _entry; else draftState.items.push(_entry);
        if (lbl) lbl.textContent = t("accadmin_save_ok") || "Saved!";
      } else {
        if (lbl) lbl.textContent = res.error ? (t("accadmin_save_err") || "Error") + ": " + res.error : (t("accadmin_save_err") || "Error");
      }
      setTimeout(restoreBtn, 2000);
    }).fail(function() {
      if (lbl) lbl.textContent = t("accadmin_save_err") || "Error";
      setTimeout(restoreBtn, 2000);
    });
  });

  $(document).on("click", "#c-btnNew", function () { resetAccadmin(); showAccPanel("c-p1"); });
  $(document).on("click", "#c-btnItemReg", function () { buildP5(); showAccPanel("c-p5"); });

  /* ── P5 ── */
  function buildP5() {
    const key = $("#c-iKey").val().trim();
    const label = $("#c-iLabel").val().trim() || key;
    const cat = $("#c-iCategory").attr("data-csel-val") || "";
    const gender = $("#c-iGender").attr("data-csel-val") || "";
    $("#c-p5-key").val(key);
    $("#c-p5-label").val(label);
    $("#c-p5-card-key").text(key || "—");
    $("#c-p5-card-label").text(label || "—");
    $("#c-p5-card-cat").text(cat || "—");
    $("#c-p5-card-gender").text(gender || "—");
    refreshP5();
  }
  function refreshP5() {
    const key = $("#c-p5-key").val().trim();
    const label = $("#c-p5-label").val().trim() || key;
    const weight = parseFloat($("#c-p5-weight").val()) || 0;
    const limit = parseInt($("#c-p5-limit").val()) || 10;
    const desc = $("#c-p5-desc").val().trim() || "Accessory item";
    let code;
    if (AC.p5fw === "vorp") {
      code = "INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `groupId`, `rarityId`, `metadata`, `desc`, `weight`, `degradation`)\n"
           + `VALUES ('${key}', '${label}', ${limit}, 1, 'item_standard', 1, 1, 1, '{}', '${desc}', ${weight}, 0)\n`
           + "ON DUPLICATE KEY UPDATE\n"
           + "    `label` = VALUES(`label`), `limit` = VALUES(`limit`), `can_remove` = VALUES(`can_remove`),\n"
           + "    `type` = VALUES(`type`), `usable` = VALUES(`usable`), `groupId` = VALUES(`groupId`),\n"
           + "    `rarityId` = VALUES(`rarityId`), `metadata` = VALUES(`metadata`), `desc` = VALUES(`desc`),\n"
           + "    `weight` = VALUES(`weight`), `degradation` = VALUES(`degradation`);";
    } else {
      code = `['${key}'] = {\n    name = '${key}',\n    label = '${label}',\n    weight = ${weight},\n    type = 'item',\n    image = '${key}.png',\n    unique = false,\n    useable = true,\n    shouldClose = true,\n    combinable = nil,\n    description = '${desc}'\n}`;
    }
    $("#c-p5-code").val(code);
    const ta = document.getElementById("c-p5-code");
    if (ta) { ta.style.height = "auto"; ta.style.height = (ta.scrollHeight + 2) + "px"; }
  }
  $(document).on("click", "#c-p5-btn-vorp, #c-p5-btn-rsg", function () {
    AC.p5fw = $(this).data("fw");
    $(".ard-p5-fw-btn").removeClass("active");
    $(this).addClass("active");
    refreshP5();
  });
  $(document).on("input", "#c-p5-key, #c-p5-label, #c-p5-weight, #c-p5-limit, #c-p5-desc", refreshP5);
  $(document).on("click", "#c-p5-btnCopy", function () { acCopyText($("#c-p5-code").val(), $("#c-p5-cfb")); });
  $(document).on("click", "#c-p5-btnBack", function () { showAccPanel("c-p4"); });

  /* ── reset ── */
  function setCsel($el, val, label) {
    $el.attr("data-csel-val", val).find(".ard-csel-val").text(label);
    $el.find(".ard-csel-opt").removeClass("sel");
    $el.find(`.ard-csel-opt[data-val="${val}"]`).addClass("sel");
  }
  function resetAccadmin() {
    AC.bone = null;
    AC.boneId = -1;
    AC.V = { px:0, py:0, pz:0, pitch:0, roll:0, yaw:0 };
    AC.fixedRot = true; AC.animKey = null; AC.animState = "stopped"; AC.attachDelay = null; AC.animCut = null; AC.imported = null;
    stopKeyBridge();
    post("accadminRemove", {}); post("accadminExitCalib", {});
    $("#c-iKey").val("");
    clearFieldError($("#c-iKey")); clearFieldError($("#c-iModelBtn"));
    $("#c-iLabel").val("");
    $("#c-iModelVal").text(t("accadmin_model_select") || "— Select Model —"); $("#c-iModel").val("");
    $("#c-iModelBtn").removeClass("has-value has-anim");
    $("#c-iAnimVal").text(t("accadmin_anim_select") || "— Select Animation —"); $("#c-iAnim").val("");
    $("#c-iAnimBtn").removeClass("has-value has-anim");
    $("#c-iFixedRot").prop("checked", true);
    setCsel($("#c-iGender"), "all", t("accadmin_gender_all") || "All");
    {
      const _cg    = (S.accadminPedMale !== false) ? "Male" : "Female";
      const _cgLbl = (S.accadminPedMale !== false)
        ? (t("accadmin_gender_cal_male")   || "Male character")
        : (t("accadmin_gender_cal_female") || "Female character");
      setCsel($("#c-iAccadminGender"), _cg, _cgLbl);
      $("#c-iAccadminGender").data("readonly", true).addClass("csel-readonly");
      if (typeof syncCalibVisual === "function") syncCalibVisual();
    }
    setCsel($("#c-iCategory"), "Hand", getCategoryLabel("Hand"));
    ["px","py","pz","pitch","roll","yaw"].forEach(a => $("#c-v-"+a).val("0"));
    $("#c-btn-use-delay-lbl").text(t("accadmin_add_delay") || "Add Delay"); $("#c-btn-use-delay").removeClass("captured");
    showRegionView(); updateP2Summary();
  }

  /* ── inbound NUI message handlers ── */
  function handleAccadminPreviewState(data) {
    acSetAnimPlayBtn(data.state);
    acSetPickerPlayBtn(data.state);
    if (data.state === "stopped") {
      $("#c-scrub-fill").css("width", "0%");
      $("#c-scrub-cur").text("0.00");
      $("#c-pk-scrub-fill").css("width", "0%");
      $("#c-pk-scrub-cur").text("0.00");
    }
  }
  function handleAccadminScrubberUpdate(data) {
    acUpdateScrubberUI(data.cur || 0, data.dur || 0);
  }
  function handleAccadminSetRotateMode(data) {
    const labels = [
      t("accadmin_rot_pitch") || "Pitch ↕",
      t("accadmin_rot_roll")  || "Roll ↔",
      t("accadmin_rot_yaw")   || "Yaw ↻"
    ];
    const shortLabels = ["Pitch", "Roll", "Yaw"];
    $("#c-rot-mode").text(labels[data.mode || 0] || "");
    $("#c-kb-axis-desc").text(shortLabels[data.mode || 0] || "Pitch");
  }
  function handleAccadminSyncValues(data) {
    if (!data.v) return;
    const v = data.v;
    ["px","py","pz","pitch","roll","yaw"].forEach(a => {
      if (v[a] !== undefined) {
        AC.V[a] = parseFloat(v[a]) || 0;
        const el = document.getElementById("c-v-" + a);
        if (el && document.activeElement !== el) el.value = parseFloat(AC.V[a].toFixed(4));
      }
    });
  }
  /* ══════════════════════════════════════════════════════════════════════════
     END ACCADMIN
  ══════════════════════════════════════════════════════════════════════════ */

  function handleMessageClose() {
    ([UI.$menu, UI.$attachedMenu, UI.$accPanel].forEach(($el) => {
      $el.fadeOut(200, () => $el.hide());
    }),
      $("#accadminPanel").hide(),
      $("#c-import-overlay").hide(),
      $(".ard-panel").removeClass("active"),
      $("#accSidePicker").removeClass("open"),
      closeCselAll(),
      typeof stopKeyBridge === "function" && stopKeyBridge(),
      clearAllRevealTimers(),
      $(".menu").css({
        position: "",
        left: "",
        top: "",
        transform: "",
        margin: "",
      }),
      (S.selectedItems = []),
        setPreviewSideUI("right", !1),
      (S.activeMenu = null),
      updateObjectsReturnButton());
  }

  (function () {
    ["./assets/img/circle-white.png", "./assets/img/circle-red.png"].forEach(function (src) {
      const img = new Image();
      img.src = src;
    });
  })();

  $(document).ready(function () {
    ((UI.$menu = $("#menu")),
      (UI.$attachedMenu = $("#attachedMenu")),
      (UI.$accPanel = $("#accSettingsPanel")),
      (function () {
        const dfd = $.Deferred();
        return (
          $.ajax({
            url: `https://${GetParentResourceName()}/getConfig`,
            method: "POST",
            contentType: "application/json",
            data: JSON.stringify({}),
            dataType: "text",
          })
            .done((raw) => {
              try {
                if (!raw || !raw.trim()) throw new Error("Empty getConfig response");
                const data = JSON.parse(raw);
                ((function (data) {
                  ((S.items = data.items || {}),
                    (S.locale = data.locale || S.locale),
                    (S.locales = data.locales || S.locales),
                    (S.isAdmin = data.isAdmin === true),
                    (S.accadminDenyMs = typeof data.accadminDenyMs === "number" ? Math.max(500, data.accadminDenyMs) : 2000),
                    (S.openKey = data.openKey || "F4"),
                    (S.menuToggle = data.menuToggle !== false),
                    (S.previewConfig = data.previewConfig || {}),
                    (S.itemImageBaseUrl = typeof data.itemImageBaseUrl === "string" && data.itemImageBaseUrl.length ? data.itemImageBaseUrl : null),
                    (S.categories = Array.isArray(data.categories) ? data.categories : "object" == typeof data.categories ? Object.values(data.categories) : []),
                    (S.genders = data.genders && "object" == typeof data.genders ? data.genders : {}));
                  const a = data.uiAnimation || {};
                  var raw;
                  ((S.revealStepMs = Math.max(0, Number(a.RevealStepMs) || 250)),
                    (S.revealDurationMs = Math.max(0, Number(a.RevealDurationMs) || 200)),
                    (S.radialSpeedMs = Math.max(120, Number(a.RadialSpeedMs || a.SpeedMs) || 600)),
                    (S.radialAnimationEffect =
                      ((raw = String(a.RadialEffect || "radialOpen")),
                      {
                        radialopen: "attachedChipRadialOpen",
                        fadein: "attachedChipFadeIn",
                        slidezoom: "attachedChipSlideZoom",
                        rotateflip: "attachedChipRotateFlip",
                      }[
                        String(raw || "radialOpen")
                          .toLowerCase()
                          .replace(/\s+/g, "")
                      ] || "attachedChipRadialOpen")),
                    (S.chipCascadeMs = Math.max(0, Number(a.RadialStaggerMs || a.StaggerMs || a.ChipCascadeMs) || 100)),
                    (S.detachHoldMs = Math.max(250, Number(a.HoldDetachMs || a.DetachHoldMs) || 4e3)),
                    (S.attachedFanRadiusPx = Math.max(1, Number(a.RadialDistancePx || a.DistancePx || a.FanRadiusPx) || 72)));
                })(data),
                  dfd.resolve(data));
              } catch (err) {
                dfd.resolve({
                  items: {},
                  categories: [],
                });
              }
            })
            .fail((xhr, status, error) => {
              dfd.resolve({
                items: {},
                categories: [],
              });
            }),
          dfd.promise()
        );
      })().done(() => {
        ($(".menu .attach, .menu .remove").css("display", "none"), updateLocaleUI(), renderRadialNodes(), renderAttachedOrbit());
      }),
      $(document)
        .on("click", "#objects, .mode-box, .gender-box, .objects-bodypart-node, .category-box", function () {
          const $el = $(this);
          return $el.is("#objects")
            ? goGenderMenu()
            : $el.hasClass("mode-box")
              ? ((S.menuMode = $el.data("mode")), goGenderMenu())
              : $el.hasClass("gender-box")
                ? ((S.selectedGender = $el.data("gender")), renderAccGenderIndicator(), goCategoriesMenu())
                : void (($el.hasClass("objects-bodypart-node") && $el.hasClass("disabled")) || goItemsMenu($el.data("category")));
        })
        .on("click", ".objects-item-orb", function () {
          (toggleSingleSelectedItem($(this).data("name")), renderObjectsAvailablePanel());
        })
        .on("mouseenter", ".objects-bodypart-node, .objects-item-orb", function () {
          const $el = $(this);
          return $el.hasClass("objects-bodypart-node")
            ? $el.hasClass("disabled")
              ? setObjectsInfoText(t("choose_gender"))
              : setObjectsInfoText(`${getCategoryLabel($el.data("category"))} - ${t("menu_description_available")}`)
            : void setObjectsInfoText(getItemLabel($el.data("name")));
        })
        .on("mouseleave", ".objects-bodypart-node, .objects-item-orb", () => setObjectsInfoText())
        .on("mouseenter", ".objects-item-orb img, .menu .item-box", function () {
          const itemName = $(this).data("name") || $(this).closest("[data-name]").data("name");
          itemName && setObjectsInfoText(getItemLabel(itemName));
        })
        .on("mouseleave", ".objects-item-orb img, .menu .item-box", () => setObjectsInfoText())
        .on("wheel", ".acc-items-inner", function (e) {
          const el = this;
          if (!el || el.scrollHeight <= el.clientHeight) return;
          e.stopPropagation();
        })
        .on("wheel", ".acc-settings-panel", function (e) {
          e.stopPropagation();
        })
        .on("mouseenter", ".acc-settings-panel [data-help-key]", function () {
          !(function (helpKey) {
            if (!helpKey) return void setAccDefaultExplanationText();
            const lk = `acc_help_${helpKey}_text`,
              localized = t(lk);
            localized !== lk ? $("#accExplanationText").text(localized) : setAccDefaultExplanationText();
          })($(this).attr("data-help-key"));
        })
        .on("mouseleave", ".acc-settings-panel [data-help-key]", () => setAccDefaultExplanationText())
        .on("mouseenter", ".acc-preview-bodypart-node", function () {
          setAccBodyPartsTitle(
            (function (category) {
              const lk = `acc_body_parts_${normalize(category)}`,
                localized = t(lk);
              return localized !== lk ? localized : getCategoryLabel(category);
            })($(this).data("category")),
          );
        })
        .on("mouseenter", ".acc-preview-item-node, .acc-preview-item-node img", function () {
          const itemName = $(this).data("name") || $(this).closest(".acc-preview-item-node").data("name");
          itemName && $("#accExplanationText").text(getItemLabel(itemName));
        })
        .on("mouseleave", ".acc-preview-item-node, .acc-preview-item-node img", () => setAccDefaultExplanationText())
        .on("mouseleave", ".acc-preview-bodypart-node", () => {
          S.selectedCategory || setAccBodyPartsTitle();
        })
        .on("click", ".acc-preview-bodypart-node, .acc-preview-item-node, #accBodyPartsTitle", function () {
          const $el = $(this);
          if ($el.is("#accBodyPartsTitle")) return ((S.selectedItem = null), setAccBodyPartsTitle(), renderAccPreviewBodyPartNodes());
          if ($el.hasClass("acc-preview-bodypart-node")) {
            const category = $el.data("category");
            if (S.selectedCategory === category) {
              S.selectedCategory = null;
              S.selectedItem = null;
              $(".acc-preview-bodypart-node").removeClass("active");
              setAccBodyPartsTitle();
              $("#accItemBox").hide();
              $("#accInfoRow").hide();
              $(".acc-bodypart-sep").show();
              return;
            }
            $(".acc-preview-bodypart-node").removeClass("active");
            $el.addClass("active");
            return ((S.selectedCategory = category), (S.selectedItem = null), setAccBodyPartsTitle(getCategoryLabel(category)), renderAccPreviewItemNodes(category), syncPreviewCategory(category));
          }
          const itemName = $el.data("name");
          toggleSingleSelectedItem(itemName);
          $(".acc-preview-item-node").removeClass("active");
          if (S.selectedItem && itemName === S.selectedItem) {
            $el.addClass("active");
            $("#accValSelected").text(getItemLabel(itemName));
            $("#accValCategory").text(getCategoryLabel(S.selectedCategory));
            $("#accInfoRow").show();
          } else {
            $("#accInfoRow").hide();
          }
        })
        .on("click", "#accAttachButton, #accRemoveButton", function () {
          S.selectedItem &&
            menuAction($(this).is("#accAttachButton") ? "attach" : "remove", {
              item: S.selectedItem,
            });
        })
        .on("click", ".menu .item-box", function () {
          const $box = $(this);
          !(function ($box, itemName) {
            if ("attached" === S.menuMode) {
              const idx = S.selectedItems.indexOf(itemName);
              return (
                idx >= 0
                  ? (S.selectedItems.splice(idx, 1), $box.removeClass("active").find(".box-tick").remove())
                  : (S.selectedItems.push(itemName), $box.addClass("active"), $box.find(".box-tick").length || $box.append('<span class="box-tick">✔</span>')),
                $(".menu .remove").toggle(S.selectedItems.length > 0),
                void $(".menu .remove-all").toggle(Object.keys(S.attached || {}).length > 0)
              );
            }
            const alreadyActive = $box.hasClass("active");
            if (($(".menu .item-box").removeClass("active"), $(".menu .box-tick").remove(), alreadyActive && S.selectedItem === itemName)) return ((S.selectedItem = null), void $(".menu .attach, .menu .remove").hide());
            ((S.selectedItem = itemName), $box.addClass("active").append('<span class="box-tick">✔</span>'), $(".menu .attach, .menu .remove").stop().fadeIn(200).css("display", "inline-block"));
          })($box, $box.data("name"));
        })
        .on("click", ".radial-node", function () {
          showAttachedMenuStaticNow();
          const clicked = $(this).data("category"),
            same = normalizeCategoryKey(S.selectedCategory) === normalizeCategoryKey(clicked),
            hasVisible = $("#radialMenu").find(`.radial-node-orbit[data-category="${clicked}"]`).find(".attached-item-chip").length > 0;
          ((S.selectedCategory = same && hasVisible ? null : clicked), refreshAttachedRadialState(!1, !0), S.selectedCategory && syncPreviewCategory(S.selectedCategory));
        })
        .on("click", ".radial-side-node", function () {
          if (!S.canSwitchSide) return;
          const side = normalizeSide($(this).data("side"));
          setPreviewSideUI(side, !0);
          menuAction("previewSwitchSide", {
            side: side,
          });
        })
        .on("mouseenter", ".radial-node", function () {
          setAttachedMenuSubtitle(getCategoryLabel($(this).data("category")));
        })
        .on("mouseleave", ".radial-node, .attached-item-chip", syncAttachedSubtitleWithSelection)
        .on("mouseenter", "#rotateCharacterButton, #toggleDressButton, #openObjectsButton, #openAccadminButton", function () {
          S._hoveredActionBtn = $(this);
          setAttachedMenuSubtitle($(this).attr("title"));
        })
        .on("mouseleave", "#rotateCharacterButton, #toggleDressButton, #openObjectsButton, #openAccadminButton", () => {
          S._hoveredActionBtn = null;
          setAttachedMenuSubtitle();
        })
        .on("mouseenter", ".attached-item-chip", function () {
          const $chip = $(this);
          if ($chip.hasClass("is-empty")) {
            const returnLabel = "return_action" !== t("return_action") ? t("return_action") : "Return";
            return S.selectedCategory ? setAttachedMenuSubtitle(`${getCategoryLabel(S.selectedCategory)} | ${t("nothing_attached_category")} | ${returnLabel}`) : setAttachedMenuSubtitle(`${t("nothing_attached_category")} | ${returnLabel}`);
          }
          const itemName = $chip.data("name");
          if (!itemName) return;
          const itemLabel = getItemLabel(itemName),
            detach = "detach_action" !== t("detach_action") ? t("detach_action") : t("remove");
          if (S.selectedCategory) return setAttachedMenuSubtitle(`${getCategoryLabel(S.selectedCategory)} | ${itemLabel} | ${detach}`);
          setAttachedMenuSubtitle(`${itemLabel} | ${detach}`);
        })
        .on("click", ".attached-item-chip", function () {
          const $chip = $(this);
          if ($chip.hasClass("is-empty")) return ((S.selectedCategory = null), refreshAttachedRadialState(!1));
          consumeAttachedChipClickSuppression() ||
            menuAction("replayAttachAnimation", {
              item: $chip.data("name"),
            });
        })
        .on("mousedown touchstart", ".attached-item-chip", function (e) {
          const $chip = $(this);
          if ($chip.hasClass("is-empty")) return;
          if ("mousedown" === e.type && 1 !== e.which) return;
          // Avoid passive-listener warnings on delegated touchstart handlers.
          "mousedown" === e.type && e.preventDefault();
          beginAttachedChipHold($chip);
        })
        .on("mouseup touchend touchcancel", ".attached-item-chip", function () {
          completeAttachedChipHold("release");
        })
        .on("mouseleave", ".attached-item-chip", function () {
          completeAttachedChipHold("cancel");
        })
        .on("mousedown touchstart", "#rotateCharacterButton", function (e) {
          ("mousedown" === e.type && 1 !== e.which) || S.isRotateHolding || ((S.isRotateHolding = !0), menuAction("rotateCharacterStart"));
        })
        .on("mouseup mouseleave touchend touchcancel", "#rotateCharacterButton", stopRotateHolding)
        .on("click", "#rotateCharacterButton, #toggleDressButton", function () {
          menuAction($(this).is("#rotateCharacterButton") ? "rotateCharacter" : "toggleDress");
        })
        .on("click", "#openObjectsButton", () => {
          if (UI.$accPanel.is(":visible"))
            return ((S.accRevealTimers = clearTimers(S.accRevealTimers)), UI.$accPanel.hide(), resetAttachedNodeSelectionState(), UI.$attachedMenu.show(), startAttachedMenuReveal(), void updateObjectsReturnButton());
          (resetAttachedNodeSelectionState(), (S.attachedRevealTimers = clearTimers(S.attachedRevealTimers)), UI.$attachedMenu.hide(), UI.$menu.hide(), UI.$accPanel.show(), startAccMenuReveal(), updateObjectsReturnButton());
        })
        .on("click", "#openAccadminButton", () => {
          post("openAccadmin", {});
        })
        .on("click", "#objectsReturnButton", handleObjectsReturnNavigation)
        .on("click", ".menu .attach, .menu .remove, .menu .remove-all", function () {
          const $btn = $(this);
          if ($btn.is(".remove-all")) return menuAction("removeAll");
          if ($btn.is(".attach")) {
            if (!S.selectedItem) return;
            return "available" === S.menuMode && S.selectedCategory && S.attached[S.selectedItem]
              ? menuAction("alreadyAttached", {
                  item: S.selectedItem,
                })
              : menuAction("attach", {
                  item: S.selectedItem,
                });
          }
          if ("attached" === S.menuMode && S.selectedItems.length > 0)
            return menuAction("removeMultiple", {
              items: S.selectedItems,
            });
          S.selectedItem &&
            (menuAction("remove", {
              item: S.selectedItem,
            }),
            UI.$menu.hide());
        })
        .on("mousedown", ".menu", function (e) {
          if (1 !== e.which || $(e.target).closest(".box, .boxclose, .attach, .remove").length) return;
          const $el = $(this),
            off = $el.offset();
          off &&
            ((S.dragOffset.x = e.pageX - off.left),
            (S.dragOffset.y = e.pageY - off.top),
            (S.isDragging = !0),
            $el.css({
              position: "fixed",
              margin: "0",
              transform: "none",
              left: `${off.left}px`,
              top: `${off.top}px`,
            }));
        })
        .on("mousemove", (e) => {
          if (!S.isDragging) return;
          let x = e.pageX - S.dragOffset.x,
            y = e.pageY - S.dragOffset.y;
          const maxX = $(window).width() - $(".menu").outerWidth(),
            maxY = $(window).height() - $(".menu").outerHeight();
          ((x = Math.max(0, Math.min(x, maxX))),
            (y = Math.max(0, Math.min(y, maxY))),
            $(".menu").css({
              left: `${x}px`,
              top: `${y}px`,
            }));
        })
        .on("mouseup", () => {
          S.isDragging = !1;
        })
        .on("keydown", (e) => {
          if (S.menuToggle && S.openKey && (e.keyCode === S.openKey || e.key === S.openKey) && "attached" === S.activeMenu) {
            if ($("#accadminPanel").is(":visible")) {
              post("closeAccadmin", {});
              handleMessageClose();
              return;
            }
            clearAllRevealTimers();
            UI.$attachedMenu.fadeOut(200, () => UI.$attachedMenu.hide());
            UI.$accPanel.fadeOut(200, () => UI.$accPanel.hide());
            closeNuiMenu("attached");
            return;
          }
          if ("Escape" === e.key)
            return $("#accadminPanel").is(":visible")
              ? ($("#c-import-overlay").is(":visible")
                  ? ($("#c-import-overlay").hide(), !0)
                  : $("#accSidePicker").hasClass("open")
                  ? (closeSidePicker(), !0)
                  : (stopKeyBridge(), post("accadminExitCalib", {}), post("closeAccadmin", { reopenAttached: "attached" === S.activeMenu }), $("#accadminPanel").hide(), $(".ard-panel").removeClass("active"), closeCselAll(), "attached" !== S.activeMenu && closeNuiMenu("standard"), !0))
              : UI.$accPanel.is(":visible")
              ? (function () {
                  return $("#accItemBox").is(":visible")
                    ? ((S.selectedItem = null), (S.selectedCategory = null), setAccBodyPartsTitle(), renderAccPreviewBodyPartNodes(), !0)
                    : (UI.$accPanel.hide(), "attached" === S.activeMenu ? (resetAttachedNodeSelectionState(), UI.$attachedMenu.show(), startAttachedMenuReveal()) : closeNuiMenu("standard"), !0);
                })()
              : UI.$menu.is(":visible")
                ? ("items" === S.page
                    ? goCategoriesMenu()
                    : "categories" === S.page
                      ? goGenderMenu()
                      : "gender" === S.page
                        ? UI.$attachedMenu.is(":visible")
                          ? UI.$menu.hide()
                          : goMainMenu()
                        : (UI.$menu.hide(), updateObjectsReturnButton(), UI.$attachedMenu.is(":visible") || closeNuiMenu("standard")),
                  !0)
                : UI.$attachedMenu.is(":visible")
                  ? (S.selectedCategory ? (showAttachedMenuStaticNow(), resetAttachedNodeSelectionState()) : (clearAllRevealTimers(), UI.$attachedMenu.hide(), closeNuiMenu("attached")), !0)
                  : void 0;
        }),
      $(window)
        .on("blur", function () {
          stopRotateHolding();
          clearAttachedChipHoldState(!0);
        })
        .on("message", (event) => {
          const data = event.originalEvent.data || {},
            handler = {
              open: handleMessageOpen,
              openAttached: handleMessageOpenAttached,
              updateAttached: handleMessageUpdateAttached,
              close: handleMessageClose,
              openAccadmin: handleMessageOpenAccadmin,
              accadminPreviewState: function(d) { typeof handleAccadminPreviewState === "function" && handleAccadminPreviewState(d); },
              accadminScrubberUpdate: function(d) { typeof handleAccadminScrubberUpdate === "function" && handleAccadminScrubberUpdate(d); },
              accadminSetRotateMode: function(d) { typeof handleAccadminSetRotateMode === "function" && handleAccadminSetRotateMode(d); },
              accadminSyncValues: function(d) { typeof handleAccadminSyncValues === "function" && handleAccadminSyncValues(d); },
              accadminAnimKeys: function(d) {
                S.accadminAnimKeys = d.animKeys || [];
                if (accadminPickerType === "anim" && $("#accSidePicker").hasClass("open")) {
                  buildPickerAnim($("#c-side-search").val() || "");
                }
              },
              draftItemsLoaded: function(d) {
                draftState.items = Array.isArray(d.items) ? d.items : [];
                if (impState.savedView) impRenderDraftItems();
                const btn = impEl('imp-reload-btn');
                if (btn) {
                  btn.className = 'imp-reload-btn r-success';
                  setTimeout(function() { btn.className = 'imp-reload-btn'; }, 1000);
                }
                const progWrap = impEl('imp-prog-wrap');
                const progBar  = impEl('imp-prog-bar');
                if (progBar)  { progBar.classList.add('p-done'); progBar.style.width = '100%'; }
                if (progWrap) {
                  setTimeout(function() {
                    progWrap.classList.remove('vis');
                    setTimeout(function() { if (progBar) { progBar.style.width = '0%'; progBar.className = 'imp-prog-bar'; } }, 220);
                  }, 1000);
                }
              },
              accadminReticlePos: function() {},
              setAdminStatus: function(d) {
                S.isAdmin = d.isAdmin === true;
                syncAdminButton();
              },
              accadminDenied: function() {
                const $b = $("#openAccadminButton");
                $b.addClass("deny-shake").one("animationend webkitAnimationEnd", () => $b.removeClass("deny-shake"));
                const msg = t("accadmin_no_permission") || "Bu paneli açmak için yetkiniz yok.";
                clearTimeout(S._denyMsgTimer);
                S._denyMsgActive = true;
                const $desc = $("#attachedMenuDesc");
                $desc.addClass("deny-text").text(msg);
                S._denyMsgTimer = setTimeout(() => {
                  S._denyMsgActive = false;
                  $desc.removeClass("deny-text");
                  if (S._hoveredActionBtn && S._hoveredActionBtn.length) {
                    setAttachedMenuSubtitle(S._hoveredActionBtn.attr("title"));
                  } else {
                    syncAttachedSubtitleWithSelection();
                  }
                }, S.accadminDenyMs || 2000);
              },
            }[data.action];
          handler && handler(data);
        }));
  });
})();


// fx-accessories | Shop System — Fixitfy Development

;(function () {
    var storeItems = [], currentItems = [], cart = {}, storeIndex = null;
    var activeCategory = 'all', activeTier = null, locale = {}, playerBalance = {cash:0, gold:0};
    var favorites = JSON.parse(localStorage.getItem('fxshop_favs') || '{}');
    var selectedItemName = null;
    var shopIsOpen = false;
    var lowStockPct = 30;
    var keyGuide = document.getElementById('shop-key-guide');
    function updateKeyGuide() {
        if (!keyGuide) return;
        keyGuide.style.display = (shopIsOpen && selectedItemName) ? 'flex' : 'none';
    }

    var BODY_CATS = ['Head','Neck','Arm','Hand','Torso','Belt','Leg'];
    var CAT_IMGS = {
        all:'./assets/img/circle-white.png', Head:'./assets/img/head-white.png',
        Neck:'./assets/img/neck-white.png',  Arm:'./assets/img/arm-white.png',
        Hand:'./assets/img/hand-white.png',  Torso:'./assets/img/torso-white.png',
        Belt:'./assets/img/belt-white.png',  Leg:'./assets/img/leg-white.png',
    };

    var panel     = document.getElementById('shop-panel');
    var titleEl   = document.getElementById('shop-title');
    var searchEl  = document.getElementById('shop-search');
    var catBar    = document.getElementById('shop-cat-bar');
    var itemList  = document.getElementById('shop-item-list');
    var cartNodes = document.getElementById('shop-cart-nodes');
    var cartEmpty = document.getElementById('shop-cart-empty');
    var cashEl    = document.getElementById('shop-cash-val');
    var goldEl    = document.getElementById('shop-gold-val');
    var cashBalEl = document.getElementById('shop-cash-balance');
    var goldBalEl = document.getElementById('shop-gold-balance');
    var cashLbl   = document.getElementById('shop-cash-label');
    var goldLbl   = document.getElementById('shop-gold-label');
    var cartLbl   = document.getElementById('shop-cart-label-text');
    var buyBtn    = document.getElementById('shop-buy-btn');
    var cancelBtn = document.getElementById('shop-cancel-btn');

    function fmt(n) { return parseFloat(n||0).toFixed(2); }
    function L(key) { return locale['shop_'+key] || key; }
    function itemImg(name) { return './assets/inventoryitemimages/'+name+'.png'; }
    function cashIcon() { return './assets/img/cash.png'; }
    function goldIcon() { return './assets/img/itemtype_gold2.png'; }

    function getCartTotals() {
        var cash=0, gold=0;
        Object.values(cart).forEach(function(e){ var t=(e.cfg.price||0)*e.qty; if(e.cfg.moneytype==='gold') gold+=t; else cash+=t; });
        return {cash:cash, gold:gold};
    }

    function getActiveFavCount() {
        var activeNames = {};
        storeItems.forEach(function(i) { activeNames[i.itemName] = true; });
        return Object.keys(favorites).filter(function(k) { return activeNames[k]; }).length;
    }

    function updateFavBadge() {
        var b = document.getElementById('fav-badge');
        if (b) b.style.display = getActiveFavCount() > 0 ? 'block' : 'none';
    }

    function buildCategoryBar(items) {
        if (!catBar) return;
        catBar.innerHTML = '';
        catBar.style.display = '';
        var hasEvent = items.some(function(i){ return i.isSeasonItem; });
        var cats = ['fav', 'all'].concat(BODY_CATS);
        if (hasEvent) cats.push('event');
        cats.forEach(function(cat) {
            var btn = document.createElement('div');
            btn.className = 'shop-cat-btn'+(cat===activeCategory?' active':'');
            if (cat === 'event') btn.className += ' shop-cat-event';
            btn.dataset.cat = cat;
            if (cat === 'fav') {
                var badge=document.createElement('div'); badge.className='fav-badge'; badge.id='fav-badge';
                badge.style.display=getActiveFavCount()>0?'block':'none';
                btn.appendChild(badge);
            } else if (cat === 'all') {
                var icon=document.createElement('iconify-icon');
                icon.setAttribute('icon','mdi:apps');
                btn.appendChild(icon);
            } else if (cat === 'event') {
                var evIcon=document.createElement('iconify-icon');
                evIcon.setAttribute('icon','oui:calendar');
                btn.appendChild(evIcon);
            } else {
                var img=document.createElement('img');
                img.src=CAT_IMGS[cat]||CAT_IMGS['Head']; img.alt=cat;
                btn.appendChild(img);
            }
            btn.addEventListener('click', function(){
                if (activeCategory === cat && cat !== 'all') {
                    activeCategory = 'all';
                    document.querySelectorAll('.shop-cat-btn').forEach(function(b){ b.classList.remove('active'); });
                    var allBtn = catBar.querySelector('[data-cat="all"]');
                    if (allBtn) allBtn.classList.add('active');
                } else {
                    activeCategory = cat;
                    document.querySelectorAll('.shop-cat-btn').forEach(function(b){ b.classList.remove('active'); });
                    btn.classList.add('active');
                }
                applyFilter();
            });
            catBar.appendChild(btn);
        });
    }

    function applyFilter() {
        var q = searchEl ? searchEl.value.toLowerCase().trim() : '';
        currentItems = storeItems.filter(function(item){
            var mc = activeCategory==='all'
                  || (activeCategory==='fav' && favorites[item.itemName])
                  || (activeCategory==='event' && item.isSeasonItem)
                  || item.category===activeCategory;
            var ms = !q||(item.itemLabel||'').toLowerCase().includes(q)||(item.itemName||'').toLowerCase().includes(q);
            var mt = !activeTier || (item.tier||'common').toLowerCase() === activeTier;
            return mc&&ms&&mt;
        });
        renderItems();
        updateKeyGuide();
    }

    var CAT_DIVIDER_IMGS = {
        Head: './assets/img/head-white.png', Neck: './assets/img/neck-white.png',
        Arm:  './assets/img/arm-white.png',  Hand: './assets/img/hand-white.png',
        Torso:'./assets/img/torso-white.png',Belt: './assets/img/belt-white.png',
        Leg:  './assets/img/leg-white.png'
    };

    function buildItemRow(item) {
        var qty = cart[item.itemName] ? cart[item.itemName].qty : 0;
        var inCart = qty > 0;
        var isSelected = selectedItemName === item.itemName;

        var row = document.createElement('div');
        row.className = 'shop-item-row' + (inCart ? ' in-cart' : '') + (isSelected ? ' selected' : '');
        row.addEventListener('click', function() {
            selectedItemName = selectedItemName === item.itemName ? null : item.itemName;
            renderItems();
            updateKeyGuide();
            if (selectedItemName) {
                fetch('https://fx-accessories/shopPreview', {
                    method: 'POST',
                    headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({itemName: selectedItemName, storeIndex: storeIndex})
                });
            } else {
                fetch('https://fx-accessories/shopPreviewClear', {method: 'POST'});
            }
        });

        var tierSlot = document.createElement('span');
        tierSlot.className = 'shop-item-tier-slot';
        if (item.tier) {
            var tierIconMap = { common: 'mdi:hexagon-outline', rare: 'mdi:star-four-points', legendary: 'mdi:fire', exclusive: 'mdi:crown' };
            var tierIco = document.createElement('iconify-icon');
            tierIco.className = 'shop-item-tier-icon tier-' + item.tier.toLowerCase();
            tierIco.setAttribute('icon', tierIconMap[item.tier.toLowerCase()] || 'mdi:circle-small');
            tierSlot.appendChild(tierIco);
        }
        row.appendChild(tierSlot);

        var favBtn = document.createElement('div');
        favBtn.className = 'shop-fav-btn' + (favorites[item.itemName] ? ' active' : '');
        favBtn.innerHTML = '&#9733;';
        favBtn.addEventListener('click', function(e) { e.stopPropagation(); toggleFavorite(item.itemName, favBtn); });
        row.appendChild(favBtn);

        var img = document.createElement('img');
        img.className = 'shop-item-img';
        img.src = itemImg(item.itemName);
        img.onerror = function() { img.src = './assets/img/circle-black.png'; };
        row.appendChild(img);

        var labelWrap = document.createElement('div');
        labelWrap.className = 'shop-item-label-wrap';
        var label = document.createElement('div');
        label.className = 'shop-item-label';
        label.textContent = item.itemLabel || item.itemName;
        label.title = item.itemLabel || item.itemName;
        labelWrap.appendChild(label);
        if (item.stock !== undefined) {
            var sClass = item.stock === 0 ? 'stock-out' : item.stock === 1 ? 'stock-ultra' : item.stock <= lowStockPct ? 'stock-low' : 'stock-ok';
            var stockEl = document.createElement('div');
            stockEl.className = 'shop-item-stock ' + sClass;
            if (item.isSeasonItem) {
                stockEl.setAttribute('data-se-stock', item.itemName);
            } else {
                stockEl.setAttribute('data-nm-stock', item.itemName);
            }
            stockEl.textContent = item.stock === 0 ? L('stock_out') : item.stock === 1 ? L('stock_last') : L('stock_low').replace('{count}', item.stock);
            labelWrap.appendChild(stockEl);
        }
        row.appendChild(labelWrap);

        var badgeWrap = document.createElement('div');
        badgeWrap.className = 'shop-item-badge-wrap';
        if (item.isSeasonItem) {
            var evTag = document.createElement('iconify-icon');
            evTag.setAttribute('icon', 'oui:calendar');
            evTag.className = 'shop-item-event-tag';
            badgeWrap.appendChild(evTag);
        }
        row.appendChild(badgeWrap);

        var gender = (item.gender || 'all').toLowerCase();
        var tag = document.createElement('div');
        tag.className = 'shop-item-tag tag-' + gender;
        var genderIco = document.createElement('iconify-icon');
        if (gender === 'all') {
            genderIco.setAttribute('icon', 'famicons:male-female-sharp');
        } else if (gender === 'male') {
            genderIco.setAttribute('icon', 'tabler:gender-male');
        } else {
            genderIco.setAttribute('icon', 'tabler:gender-female');
        }
        genderIco.className = 'shop-gender-icon';
        tag.appendChild(genderIco);
        row.appendChild(tag);

        var qtyWrap = document.createElement('div');
        qtyWrap.className = 'shop-qty-wrap';
        var minusBtn = document.createElement('button');
        minusBtn.className = 'shop-qty-btn'; minusBtn.textContent = '−';
        minusBtn.addEventListener('click', function(e) { e.stopPropagation(); removeFromCart(item.itemName, 1); });
        var qtyVal = document.createElement('div');
        qtyVal.className = 'shop-qty-val'; qtyVal.textContent = qty;
        var plusBtn = document.createElement('button');
        plusBtn.className = 'shop-qty-btn'; plusBtn.textContent = '+';
        plusBtn.addEventListener('click', function(e) { e.stopPropagation(); addToCart(item); });
        qtyWrap.appendChild(minusBtn); qtyWrap.appendChild(qtyVal); qtyWrap.appendChild(plusBtn);
        row.appendChild(qtyWrap);

        var colorClass = item.moneytype === 'gold' ? 'price-gold' : 'price-cash';
        var priceWrap = document.createElement('div');
        if (item.originalPrice) {
            priceWrap.className = 'shop-item-price has-discount';
            var origRow = document.createElement('span');
            origRow.className = 'shop-price-original';
            origRow.textContent = fmt(item.originalPrice);
            priceWrap.appendChild(origRow);
            var newPriceRow = document.createElement('div');
            newPriceRow.className = 'shop-price-discounted-row';
            var pi2 = document.createElement('img'); pi2.className = 'shop-price-icon';
            pi2.src = item.moneytype === 'gold' ? goldIcon() : cashIcon();
            var pv2 = document.createElement('span');
            pv2.className = 'shop-price-val ' + colorClass;
            pv2.textContent = fmt(item.price);
            newPriceRow.appendChild(pi2); newPriceRow.appendChild(pv2);
            priceWrap.appendChild(newPriceRow);
        } else {
            priceWrap.className = 'shop-item-price';
            var pi = document.createElement('img'); pi.className = 'shop-price-icon';
            pi.src = item.moneytype === 'gold' ? goldIcon() : cashIcon();
            var pv = document.createElement('span');
            pv.className = 'shop-price-val ' + colorClass;
            pv.textContent = fmt(item.price);
            priceWrap.appendChild(pi); priceWrap.appendChild(pv);
        }
        row.appendChild(priceWrap);

        return row;
    }

    function buildCatDivider(cat, catLabel, isFirst) {
        var div = document.createElement('div');
        div.className = 'shop-cat-divider' + (isFirst ? ' first' : '');
        var icon = document.createElement('img');
        icon.src = CAT_DIVIDER_IMGS[cat] || './assets/img/circle-white.png';
        icon.alt = cat;
        var lbl = document.createElement('span');
        lbl.className = 'shop-cat-divider-lbl';
        lbl.textContent = catLabel;
        div.appendChild(icon);
        div.appendChild(lbl);
        return div;
    }

    function renderItems() {
        if (!itemList) return;
        var tierLegend = document.getElementById('shop-tier-legend');
        var tierSep    = document.getElementById('shop-tier-sep');
        if (tierLegend) {
            var hasTiers = storeItems.some(function(i) { return i.tier; });
            var show = hasTiers ? 'flex' : 'none';
            tierLegend.style.display = show;
            if (tierSep) tierSep.style.display = hasTiers ? '' : 'none';
        }
        var discStrip = document.getElementById('shop-discount-strip');
        var discSep   = document.getElementById('shop-disc-sep');
        if (discStrip) {
            var discItem = storeItems.find(function(i) { return i.discountPct; });
            if (discItem) {
                var pctEl = document.getElementById('shop-disc-strip-pct');
                if (pctEl) pctEl.textContent = '-' + discItem.discountPct + '%';
                var lblEl = document.getElementById('shop-disc-strip-lbl');
                if (lblEl) lblEl.textContent = L('discount');
                discStrip.style.display = 'flex';
                if (discSep) discSep.style.display = '';
            } else {
                discStrip.style.display = 'none';
                if (discSep) discSep.style.display = 'none';
            }
        }
        var frag = document.createDocumentFragment();

        if (!currentItems.length) {
            var el = document.createElement('div');
            el.className = 'shop-empty-msg';
            var ico = document.createElement('iconify-icon');
            var isFavEmpty = activeCategory === 'fav';
            ico.setAttribute('icon', isFavEmpty ? 'mdi:star-off-outline' : 'mdi:cart-off');
            el.appendChild(ico);
            var txt = document.createElement('span');
            txt.textContent = isFavEmpty ? L('no_fav_items') : L('no_items');
            el.appendChild(txt);
            frag.appendChild(el);
            itemList.textContent = '';
            itemList.appendChild(frag);
            return;
        }

        var useDividers = activeCategory === 'all' || activeCategory === 'fav';

        if (useDividers) {
            var grouped = {};
            BODY_CATS.forEach(function(c) { grouped[c] = []; });
            grouped['_other'] = [];
            currentItems.forEach(function(item) {
                var c = item.category;
                if (grouped[c] !== undefined) grouped[c].push(item);
                else grouped['_other'].push(item);
            });

            var isFirst = true;
            BODY_CATS.concat(['_other']).forEach(function(cat) {
                var items = grouped[cat];
                if (!items || !items.length) return;
                var catLabel = cat === '_other' ? L('cat_other') : (locale['category_' + cat.toLowerCase()] || cat);
                frag.appendChild(buildCatDivider(cat, catLabel, isFirst));
                isFirst = false;
                items.forEach(function(item) { frag.appendChild(buildItemRow(item)); });
            });
        } else {
            currentItems.forEach(function(item) { frag.appendChild(buildItemRow(item)); });
        }

        itemList.textContent = '';
        itemList.appendChild(frag);
    }

    function addToCart(item) {
        var n = item.itemName;
        if (item.stock !== undefined && item.stock <= 0) return;
        var cartQty = cart[n] ? cart[n].qty : 0;
        if (item.stock !== undefined && cartQty >= item.stock) return;
        if (cart[n]) cart[n].qty += 1; else cart[n] = {cfg: item, qty: 1};
        renderCart();
        renderItems();
    }

    function removeFromCart(name, amount) {
        if (!cart[name]) return;
        cart[name].qty -= (amount || 1);
        if (cart[name].qty <= 0) delete cart[name];
        renderCart();
        renderItems();
    }

    function renderCart() {
        if (!cartNodes) return;
        cartNodes.innerHTML = '';
        if (cartEmpty) cartNodes.appendChild(cartEmpty);
        var entries = Object.entries(cart);
        if (cartEmpty) cartEmpty.style.display = entries.length ? 'none' : 'block';
        entries.forEach(function(pair) {
            var name = pair[0], entry = pair[1];
            var node = document.createElement('div');
            node.className = 'shop-cart-node';
            node.title = (entry.cfg.itemLabel || name) + ' x' + entry.qty;
            var nodeImg = document.createElement('img'); nodeImg.className = 'cart-node-img';
            nodeImg.src = itemImg(name); nodeImg.onerror = function() { nodeImg.style.opacity = '0'; };
            var cancelIco = document.createElement('img'); cancelIco.className = 'cart-cancel-ico';
            cancelIco.src = './assets/img/cancel.png';
            var badge = document.createElement('div'); badge.className = 'cart-qty-badge'; badge.textContent = entry.qty;
            node.appendChild(nodeImg); node.appendChild(cancelIco); node.appendChild(badge);
            node.addEventListener('click', function() { removeFromCart(name, 1); });
            cartNodes.appendChild(node);
        });
        if (buyBtn) buyBtn.disabled = entries.length === 0;
        var totals = getCartTotals();
        if (cashEl) cashEl.textContent = fmt(totals.cash);
        if (goldEl) goldEl.textContent = fmt(totals.gold);
        var totalRow = document.getElementById('shop-total-row');
        if (totalRow) totalRow.style.display = (hideBalanceWhenCartEmpty && entries.length === 0) ? 'none' : '';
    }

    function toggleFavorite(name,btn){
        if(favorites[name]){delete favorites[name]; btn.classList.remove('active');}
        else{favorites[name]=true; btn.classList.add('active');}
        localStorage.setItem('fxshop_favs',JSON.stringify(favorites));
        updateFavBadge();
    }

    var hideBalanceWhenCartEmpty = false;

    function openShop(data){
        shopIsOpen = true; selectedItemName = null; updateKeyGuide();
        storeItems=data.items||[]; storeIndex=data.storeIndex; locale=data.locale||{}; activeCategory='all'; activeTier=null; cart={}; lowStockPct=data.lowStockPct||30;
        hideBalanceWhenCartEmpty = data.hideBalanceWhenCartEmpty || false;
        playerBalance={cash:data.cash||0, gold:data.gold||0};
        document.querySelectorAll('.stl-label[data-tier]').forEach(function(el) {
            el.textContent = L('tier_' + el.getAttribute('data-tier'));
        });
        document.querySelectorAll('.shop-tier-legend-item[data-tier]').forEach(function(el) {
            el.classList.remove('active');
            el.onclick = function() {
                var t = el.getAttribute('data-tier');
                if (activeTier === t) {
                    activeTier = null;
                    el.classList.remove('active');
                } else {
                    activeTier = t;
                    document.querySelectorAll('.shop-tier-legend-item').forEach(function(b){ b.classList.remove('active'); });
                    el.classList.add('active');
                }
                applyFilter();
            };
        });
        if(searchEl){searchEl.value=''; searchEl.placeholder=L('search_ph');}
        if(titleEl)   titleEl.textContent=data.storename||'Store';
        if(buyBtn)    buyBtn.textContent=L('btn_buy');
        if(cancelBtn) cancelBtn.textContent=L('btn_cancel');
        if(cashLbl)   cashLbl.textContent=L('cash_label');
        if(goldLbl)   goldLbl.textContent=L('gold_label');
        if(cartLbl)   cartLbl.textContent=L('cart_label');
        if(cashBalEl) cashBalEl.textContent=fmt(playerBalance.cash);
        if(goldBalEl) goldBalEl.textContent=fmt(playerBalance.gold);
        if(cartEmpty) cartEmpty.textContent=L('cart_empty');
        var yourCashLbl=document.getElementById('shop-your-cash-lbl'); if(yourCashLbl) yourCashLbl.textContent=L('your_cash_label');
        var yourGoldLbl=document.getElementById('shop-your-gold-lbl'); if(yourGoldLbl) yourGoldLbl.textContent=L('your_gold_label');
        var kgMap={'shop-kg-add-cart':'hint_add_cart','shop-kg-rotate':'hint_rotate','shop-kg-camera':'hint_camera','shop-kg-tilt':'hint_tilt','shop-kg-zoom':'hint_zoom','shop-kg-hide':'hint_hide_menu','shop-kg-reset':'hint_reset'};
        Object.keys(kgMap).forEach(function(id){var el=document.getElementById(id); if(el) el.textContent=L(kgMap[id]);});
        buildCategoryBar(storeItems); applyFilter(); renderCart();
        if(panel) panel.classList.add('active');
    }

    function closeShop(){
        if (panel) panel.classList.remove('active');
        cart = {}; selectedItemName = null; shopIsOpen = false;
        updateKeyGuide();
        renderCart(); renderItems();
        fetch('https://fx-accessories/shopPreviewClear', {method: 'POST'});
    }

    window.addEventListener('message',function(evt){
        var data=evt.data; if(!data||!data.action) return;
        if(data.action==='openShop')      openShop(data);
        if(data.action==='closeShop')     closeShop();
        if(data.action==='updateBalance'){
            playerBalance={cash:data.cash||0, gold:data.gold||0};
            if(cashBalEl) cashBalEl.textContent=fmt(playerBalance.cash);
            if(goldBalEl) goldBalEl.textContent=fmt(playerBalance.gold);
        }
        if(data.action==='nmStockUpdate'){
            var upd = data.stocks || {};
            Object.keys(upd).forEach(function(nm) {
                var newStock = upd[nm];
                storeItems.forEach(function(it) { if (it.itemName === nm) it.stock = newStock; });
                var el = document.querySelector('[data-nm-stock="' + nm + '"]');
                if (!el) return;
                el.className = 'shop-item-stock ' + (newStock === 0 ? 'stock-out' : newStock === 1 ? 'stock-ultra' : newStock <= lowStockPct ? 'stock-low' : 'stock-ok');
                el.textContent = newStock === 0 ? L('stock_out') : newStock === 1 ? L('stock_last') : L('stock_low').replace('{count}', newStock);
            });
        }
        if(data.action==='seStockUpdate'){
            var upd = data.stocks || {};
            Object.keys(upd).forEach(function(nm) {
                var newStock = upd[nm];
                storeItems.forEach(function(it) { if (it.itemName === nm) it.stock = newStock; });
                var el = document.querySelector('[data-se-stock="' + nm + '"]');
                if (!el) return;
                el.className = 'shop-item-stock ' + (newStock === 0 ? 'stock-out' : newStock === 1 ? 'stock-ultra' : newStock <= lowStockPct ? 'stock-low' : 'stock-ok');
                el.textContent = newStock === 0 ? L('stock_out') : newStock === 1 ? L('stock_last') : L('stock_low').replace('{count}', newStock);
            });
        }
    });

    function doClose(){ fetch('https://fx-accessories/closeShop',{method:'POST'}); }

    if(buyBtn) buyBtn.addEventListener('click',function(){
        var entries=Object.entries(cart);
        if(!entries.length) return;
        buyBtn.disabled=true;
        if(entries.length >= 3){
            // Cart mode: send all items in one request → server sends summary notify
            var cartItems=entries.map(function(pair){
                return {itemName:pair[0],count:pair[1].qty};
            });
            fetch('https://fx-accessories/shopBuyCart',{method:'POST',
                headers:{'Content-Type':'application/json'},
                body:JSON.stringify({storeIndex:storeIndex,cart:cartItems})})
                .then(function(){ doClose(); })
                .catch(function(){ buyBtn.disabled=false; });
        } else {
            // 1-2 items: keep individual notify behavior
            var promises=entries.map(function(pair){
                return fetch('https://fx-accessories/shopBuy',{method:'POST',
                    headers:{'Content-Type':'application/json'},
                    body:JSON.stringify({storeIndex:storeIndex,itemName:pair[0],count:pair[1].qty})});
            });
            Promise.all(promises)
                .then(function(){ doClose(); })
                .catch(function(){ buyBtn.disabled=false; });
        }
    });

    if(cancelBtn) cancelBtn.addEventListener('click',doClose);
    var scb=document.getElementById('shop-close-btn'); if(scb) scb.addEventListener('click',doClose);
    if(searchEl) searchEl.addEventListener('input',applyFilter);
    document.addEventListener('keydown',function(e){ if(e.key==='Escape'&&panel&&panel.classList.contains('active')) doClose(); });

    document.addEventListener('keyup', function(e) {
        if (!shopIsOpen) return;
        if (e.code === 'KeyC' || e.code === 'KeyV') {
            fetch('https://fx-accessories/shopPreviewRotateStop', {method: 'POST'});
        } else if (e.code === 'KeyQ' || e.code === 'KeyE') {
            fetch('https://fx-accessories/shopPreviewTiltStop', {method: 'POST'});
        }
    });

    document.addEventListener('keydown', function(e) {
        if (!shopIsOpen) return;
        if (e.repeat) return;
        var tag = document.activeElement && document.activeElement.tagName;
        if (tag === 'INPUT' || tag === 'TEXTAREA') return;

        if (e.code === 'Space') {
            e.preventDefault();
            if (selectedItemName) {
                var item = currentItems.find(function(i) { return i.itemName === selectedItemName; });
                if (item) addToCart(item);
            }
            return;
        }

        if (e.code === 'KeyH') {
            e.preventDefault();
            if (panel) panel.classList.toggle('active');
            return;
        }

        if (!selectedItemName) return;

        if (e.code === 'KeyX') {
            e.preventDefault();
            fetch('https://fx-accessories/shopPreviewReset', {method: 'POST'});
        } else if (e.code === 'KeyC') {
            e.preventDefault();
            fetch('https://fx-accessories/shopPreviewRotate', {
                method: 'POST', headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({dir: -1})
            });
        } else if (e.code === 'KeyV') {
            e.preventDefault();
            fetch('https://fx-accessories/shopPreviewRotate', {
                method: 'POST', headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({dir: 1})
            });
        } else if (e.code === 'KeyQ') {
            e.preventDefault();
            fetch('https://fx-accessories/shopPreviewTilt', {
                method: 'POST', headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({dir: -1})
            });
        } else if (e.code === 'KeyE') {
            e.preventDefault();
            fetch('https://fx-accessories/shopPreviewTilt', {
                method: 'POST', headers: {'Content-Type': 'application/json'},
                body: JSON.stringify({dir: 1})
            });
        }
    });

    // LMB orbit / RMB zoom via mouse drag (outside the shop panel)
    // Her buton kendi koordinatını ayrı takip eder — paylaşımlı lx/ly jitter'a yol açıyordu.
    var _mState = {
        lmb: false, rmb: false,
        lmbX: 0, lmbY: 0,
        rmbX: 0, rmbY: 0,
        lastOrbit: 0, lastZoom: 0
    };

    document.addEventListener('contextmenu', function(e) {
        if (shopIsOpen) e.preventDefault();
    });

    document.addEventListener('mousedown', function(e) {
        if (!shopIsOpen || !selectedItemName) return;
        if (panel && panel.contains(e.target)) return;
        if (e.button === 0) { _mState.lmb = true; _mState.lmbX = e.clientX; _mState.lmbY = e.clientY; }
        if (e.button === 2) { _mState.rmb = true; _mState.rmbX = e.clientX; _mState.rmbY = e.clientY; }
    });

    document.addEventListener('mouseup', function(e) {
        if (e.button === 0) _mState.lmb = false;
        if (e.button === 2) _mState.rmb = false;
    });

    document.addEventListener('mousemove', function(e) {
        if (!shopIsOpen || !selectedItemName) return;
        var now = Date.now();

        if (_mState.lmb) {
            var dx = e.clientX - _mState.lmbX;
            _mState.lmbX = e.clientX;
            _mState.lmbY = e.clientY;
            if (dx !== 0 && now - _mState.lastOrbit > 16) {
                _mState.lastOrbit = now;
                fetch('https://fx-accessories/shopPreviewOrbit', {
                    method: 'POST', headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({dx: dx})
                });
            }
        }

        if (_mState.rmb) {
            var dy = e.clientY - _mState.rmbY;
            _mState.rmbX = e.clientX;
            _mState.rmbY = e.clientY;
            if (dy !== 0 && now - _mState.lastZoom > 16) {
                _mState.lastZoom = now;
                fetch('https://fx-accessories/shopPreviewZoom', {
                    method: 'POST', headers: {'Content-Type': 'application/json'},
                    body: JSON.stringify({dy: dy})
                });
            }
        }
    });

})();

/* ─────────────────────────────────────────────────────────────────────────
   FX-ACCESSORIES — Built-in notify system (fxNotify)
   ───────────────────────────────────────────────────────────────────────── */
(function() {
    var container = document.getElementById('fx-notify-container');

    function showFxNotify(text, ntype, time, titles) {
        if (!container) return;

        var type     = ntype || 'info';
        var dur      = Math.max(3000, Math.min(15000, time || 5000));
        var fallback = { info: 'INFO', success: 'SUCCESS', error: 'ERROR', warning: 'WARNING' };
        var title    = (titles && titles[type]) || fallback[type] || type.toUpperCase();
        var id       = 'fn-' + Math.floor(Math.random() * 99999);

        var el = document.createElement('div');
        el.className = 'fx-notif fx-notif--' + type;
        el.id = id;
        el.innerHTML =
            '<img id="notify-img" src="./assets/img/' + type + '.png" alt="' + type + '">' +
            '<div class="fx-notif-bar" id="' + id + '-bar"></div>' +
            '<span class="fx-notif-title">' + title + '</span>' +
            '<span class="fx-notif-desc">'  + text  + '</span>';

        container.appendChild(el);

        if (type !== 'warning') {
            var audio = new Audio('./assets/sounds/' + type + '.mp3');
            audio.volume = 0.05;
            audio.play().catch(function() {});
        }

        // Trigger fade-in on next frame
        requestAnimationFrame(function() { el.classList.add('fx-notif-in'); });

        var bar       = document.getElementById(id + '-bar');
        var remaining = dur;
        var interval  = setInterval(function() {
            remaining -= 10;
            var pct = (remaining / dur) * 100;
            if (bar) {
                bar.style.background =
                    'radial-gradient(closest-side, rgba(0,0,0,0) 79%, transparent 80% 100%), ' +
                    'conic-gradient(rgb(255,255,255) ' + pct + '%, rgb(0,0,0) 0)';
            }
            if (remaining <= 0) {
                clearInterval(interval);
                el.classList.remove('fx-notif-in');
                setTimeout(function() {
                    if (el.parentNode) el.parentNode.removeChild(el);
                }, 350);
            }
        }, 10);
    }

    // Kayıtlı pozisyonu uygula
    (function() {
        var saved = localStorage.getItem('fxNotifyPos');
        if (!saved || !container) return;
        try {
            var pos = JSON.parse(saved);
            container.style.top    = pos.top    || '';
            container.style.left   = pos.left   || '';
            container.style.right  = pos.right  !== undefined ? pos.right  : '';
            container.style.bottom = pos.bottom !== undefined ? pos.bottom : '';
        } catch(e) {}
    })();

    // Edit modu
    var editActive = false;
    var editSampleInterval = null;

    function enterEditMode(d) {
        if (!container || editActive) return;
        editActive = true;

        var notifySample   = (d && d.notify_sample)   || (d && d.sample) || 'Drag to reposition the notification';
        var progressSample = (d && d.progress_sample) || 'Progress Bar';
        var hintText       = (d && d.hint)            || 'Drag & drop -- ESC to exit';

        var types = ['info', 'success', 'error', 'warning'];
        var ti = 0;
        showFxNotify(notifySample, types[ti], 999999, null);
        editSampleInterval = setInterval(function() {
            ti = (ti + 1) % types.length;
            container.innerHTML = '';
            showFxNotify(notifySample, types[ti], 999999, null);
        }, 2000);

        var hint = document.createElement('div');
        hint.id = 'fx-editpos-hint';
        hint.innerHTML = hintText.replace(/\b(ESC|ENTER|F\d{1,2}|CTRL|ALT|SHIFT|TAB)\b/gi, '<span style="color:#c9a86c;font-weight:600;">$1</span>');
        document.body.appendChild(hint);

        container.classList.add('fx-notif-dragging');

        var isDraggingN = false, oxN = 0, oyN = 0;

        function onDownN(e) {
            isDraggingN = true;
            var r = container.getBoundingClientRect();
            oxN = e.clientX - r.left;
            oyN = e.clientY - r.top;
            container.style.cursor = 'grabbing';
            e.preventDefault();
        }
        function onMoveN(e) {
            if (!isDraggingN) return;
            var x = Math.max(0, Math.min(e.clientX - oxN, window.innerWidth  - container.offsetWidth));
            var y = Math.max(0, Math.min(e.clientY - oyN, window.innerHeight - container.offsetHeight));
            container.style.left   = (x / window.innerWidth  * 100).toFixed(2) + '%';
            container.style.top    = (y / window.innerHeight * 100).toFixed(2) + '%';
            container.style.right  = 'auto';
            container.style.bottom = 'auto';
        }
        function onUpN() {
            if (!isDraggingN) return;
            isDraggingN = false;
            container.style.cursor = 'grab';
            localStorage.setItem('fxNotifyPos', JSON.stringify({
                top: container.style.top, left: container.style.left,
                right: 'auto', bottom: 'auto'
            }));
        }

        // Also make the progress bar container draggable
        var progressContainer = document.getElementById('fx-progress-container');
        if (progressContainer) {
            var wasHidden = progressContainer.style.display === 'none' || !progressContainer.style.display;
            progressContainer.style.display = 'flex';
            progressContainer.classList.add('fx-progress-dragging');
            var progressImgEl  = document.getElementById('fx-progressbar-img');
            var progressTextEl = document.getElementById('fx-progressbar-text');
            var progressFillEl = document.getElementById('fx-progress-fill');
            if (progressImgEl) progressImgEl.src = './assets/img/dropicon.png';
            if (progressTextEl) progressTextEl.textContent = progressSample;
            if (progressFillEl) { progressFillEl.style.transition = 'none'; progressFillEl.style.width = '60%'; }

            var isDraggingP = false, oxP = 0, oyP = 0;
            function onDownP(e) {
                isDraggingP = true;
                var r = progressContainer.getBoundingClientRect();
                oxP = e.clientX - r.left;
                oyP = e.clientY - r.top;
                progressContainer.style.cursor = 'grabbing';
                e.preventDefault();
            }
            function onMoveP(e) {
                if (!isDraggingP) return;
                var x = Math.max(0, Math.min(e.clientX - oxP, window.innerWidth  - progressContainer.offsetWidth));
                var y = Math.max(0, Math.min(e.clientY - oyP, window.innerHeight - progressContainer.offsetHeight));
                progressContainer.style.left   = (x / window.innerWidth  * 100).toFixed(2) + '%';
                progressContainer.style.top    = (y / window.innerHeight * 100).toFixed(2) + '%';
                progressContainer.style.right  = 'auto';
                progressContainer.style.bottom = 'auto';
            }
            function onUpP() {
                if (!isDraggingP) return;
                isDraggingP = false;
                progressContainer.style.cursor = 'grab';
                localStorage.setItem('fxProgressPos', JSON.stringify({
                    top: progressContainer.style.top, left: progressContainer.style.left,
                    right: 'auto', bottom: 'auto'
                }));
            }

            progressContainer.addEventListener('mousedown', onDownP);
            document.addEventListener('mousemove', onMoveP);
            document.addEventListener('mouseup',   onUpP);

            progressContainer._editCleanup = function() {
                progressContainer.removeEventListener('mousedown', onDownP);
                document.removeEventListener('mousemove',  onMoveP);
                document.removeEventListener('mouseup',    onUpP);
                progressContainer.classList.remove('fx-progress-dragging');
                progressContainer.style.cursor = '';
                if (wasHidden) progressContainer.style.display = 'none';
            };
        }

        function onKey(e) {
            if (e.key === 'Escape') exitEditMode();
        }

        container.addEventListener('mousedown', onDownN);
        document.addEventListener('mousemove',  onMoveN);
        document.addEventListener('mouseup',    onUpN);
        document.addEventListener('keydown',    onKey);

        container._editCleanup = function() {
            container.removeEventListener('mousedown', onDownN);
            document.removeEventListener('mousemove',  onMoveN);
            document.removeEventListener('mouseup',    onUpN);
            document.removeEventListener('keydown',    onKey);
            var pc = document.getElementById('fx-progress-container');
            if (pc && pc._editCleanup) { pc._editCleanup(); delete pc._editCleanup; }
        };
    }

    function exitEditMode() {
        if (!editActive) return;
        editActive = false;
        if (editSampleInterval) { clearInterval(editSampleInterval); editSampleInterval = null; }
        if (container._editCleanup) { container._editCleanup(); delete container._editCleanup; }
        container.classList.remove('fx-notif-dragging');
        container.style.cursor = '';
        container.innerHTML = '';
        var hint = document.getElementById('fx-editpos-hint');
        if (hint && hint.parentNode) hint.parentNode.removeChild(hint);
        fetch('https://' + GetParentResourceName() + '/acceditposClose', {
            method: 'POST', body: JSON.stringify({})
        });
    }

    window.addEventListener('message', function(evt) {
        var d = evt.data;
        if (d && d.action === 'fxNotify')   showFxNotify(d.text, d.ntype, d.time, d.titles);
        if (d && d.action === 'acceditpos') enterEditMode(d);
    });
})();

/* ─────────────────────────────────────────────────────────────────────────
   FX-ACCESSORIES — Progress bar (fxProgressBar)
   ───────────────────────────────────────────────────────────────────────── */
(function() {
    var container = document.getElementById('fx-progress-container');
    var imgEl     = document.getElementById('fx-progressbar-img');
    var textEl    = document.getElementById('fx-progressbar-text');
    var fillEl    = document.getElementById('fx-progress-fill');
    var timer     = null;

    (function() {
        var saved = localStorage.getItem('fxProgressPos');
        if (!saved || !container) return;
        try {
            var pos = JSON.parse(saved);
            container.style.top    = pos.top    || '';
            container.style.left   = pos.left   || '';
            container.style.right  = pos.right  !== undefined ? pos.right  : '';
            container.style.bottom = pos.bottom !== undefined ? pos.bottom : '';
        } catch(e) {}
    })();

    function showProgress(item, text, duration) {
        if (!container) return;
        // Only show during item use — not while acc menu is open
        var accPanel = document.getElementById('accSettingsPanel');
        if (accPanel && accPanel.style.display !== 'none') return;
        if (timer) { clearTimeout(timer); timer = null; }
        if (imgEl) {
            imgEl.onerror = function() { this.onerror = null; this.src = './assets/img/dropicon.png'; };
            imgEl.src = item
                ? './assets/inventoryitemimages/' + item + '.png'
                : './assets/img/dropicon.png';
        }
        if (textEl) textEl.textContent = text || '';
        if (fillEl) { fillEl.style.transition = 'none'; fillEl.style.width = '100%'; }
        container.style.display = 'flex';
        requestAnimationFrame(function() {
            requestAnimationFrame(function() {
                if (fillEl) {
                    fillEl.style.transition = 'width ' + duration + 'ms linear';
                    fillEl.style.width = '0%';
                }
            });
        });
        timer = setTimeout(function() {
            container.style.display = 'none';
            timer = null;
        }, duration);
    }

    window.addEventListener('message', function(evt) {
        var d = evt.data;
        if (d && d.action === 'fxProgressBar') showProgress(d.item, d.text, d.duration);
    });
})();

/* ─────────────────────────────────────────────────────────────────────────
   FX-ACCESSORIES — Duyuru katmanı (fxAnnounce)
   ───────────────────────────────────────────────────────────────────────── */
(function() {
    var annEl       = document.getElementById('fx-announce');
    var annIcon     = document.getElementById('fx-ann-icon-el');
    var annLabel    = document.getElementById('fx-ann-label');
    var annBadge    = document.getElementById('fx-ann-badge');
    var annDiscIcon = document.getElementById('fx-ann-discount-icon-el');
    var annDiscount = document.getElementById('fx-ann-discount');
    var annDesc     = document.getElementById('fx-ann-desc');
    var annDatesRow = document.getElementById('fx-ann-dates-row');
    var annDateIcon = document.getElementById('fx-ann-date-icon-el');
    var annDates    = document.getElementById('fx-ann-dates');
    var annBar      = document.getElementById('fx-ann-bar');
    var annTimer    = null;

    function showAnnounce(d) {
        if (!annEl) return;
        if (annTimer) { clearTimeout(annTimer); annTimer = null; }
        if (annIcon)  annIcon.setAttribute('icon', d.icon || 'mdi:bullhorn');
        if (annLabel) annLabel.textContent = d.label || '';
        if (annBadge) {
            if (d.discountPct) {
                annBadge.style.display = '';
                if (annDiscIcon) annDiscIcon.setAttribute('icon', d.discountIcon || 'mdi:tag-outline');
                if (annDiscount) annDiscount.textContent = '-' + d.discountPct + '%';
            } else {
                annBadge.style.display = 'none';
            }
        }
        if (annDesc) annDesc.textContent = d.desc || '';
        if (annDatesRow) {
            if (d.dateRange) {
                annDatesRow.style.display = '';
                if (annDateIcon) annDateIcon.setAttribute('icon', d.dateIcon || 'oui:calendar');
                if (annDates)    annDates.textContent = d.dateRange;
            } else {
                annDatesRow.style.display = 'none';
            }
        }
        if (annBar) { annBar.style.transition = 'none'; annBar.style.width = '100%'; }
        annEl.style.display = 'block';
        annEl.classList.remove('fx-ann-out');
        annEl.classList.add('fx-ann-in');
        var dur = Math.max(4000, Math.min(12000, (d.duration || 7) * 1000));
        requestAnimationFrame(function() {
            requestAnimationFrame(function() {
                if (annBar) {
                    annBar.style.transition = 'width ' + dur + 'ms linear';
                    annBar.style.width = '0%';
                }
            });
        });
        annTimer = setTimeout(function() {
            annEl.classList.remove('fx-ann-in');
            annEl.classList.add('fx-ann-out');
            setTimeout(function() {
                annEl.style.display = 'none';
                annEl.classList.remove('fx-ann-out');
            }, 400);
        }, dur);
    }

    window.addEventListener('message', function(evt) {
        if (evt.data && evt.data.action === 'fxAnnounce') showAnnounce(evt.data);
    });
})();
