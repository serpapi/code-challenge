(function(){'use strict';var n;function aa(a){var b=0;return function(){return b<a.length?{done:!1,value:a[b++]}:{done:!0}}}
var p=typeof Object.defineProperties=="function"?Object.defineProperty:function(a,b,c){if(a==Array.prototype||a==Object.prototype)return a;a[b]=c.value;return a};
function da(a){a=["object"==typeof globalThis&&globalThis,a,"object"==typeof window&&window,"object"==typeof self&&self,"object"==typeof global&&global];for(var b=0;b<a.length;++b){var c=a[b];if(c&&c.Math==Math)return c}throw Error("Cannot find global object");}
var q=da(this);function r(a,b){if(b)a:{var c=q;a=a.split(".");for(var d=0;d<a.length-1;d++){var f=a[d];if(!(f in c))break a;c=c[f]}a=a[a.length-1];d=c[a];b=b(d);b!=d&&b!=null&&p(c,a,{configurable:!0,writable:!0,value:b})}}
r("Symbol",function(a){function b(e){if(this instanceof b)throw new TypeError("Symbol is not a constructor");return new c(d+(e||"")+"_"+f++,e)}
function c(e,h){this.g=e;p(this,"description",{configurable:!0,writable:!0,value:h})}
if(a)return a;c.prototype.toString=function(){return this.g};
var d="jscomp_symbol_"+(Math.random()*1E9>>>0)+"_",f=0;return b});
r("Symbol.iterator",function(a){if(a)return a;a=Symbol("Symbol.iterator");for(var b="Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array".split(" "),c=0;c<b.length;c++){var d=q[b[c]];typeof d==="function"&&typeof d.prototype[a]!="function"&&p(d.prototype,a,{configurable:!0,writable:!0,value:function(){return ea(aa(this))}})}return a});
function ea(a){a={next:a};a[Symbol.iterator]=function(){return this};
return a}
var fa=typeof Object.create=="function"?Object.create:function(a){function b(){}
b.prototype=a;return new b},t;
if(typeof Object.setPrototypeOf=="function")t=Object.setPrototypeOf;else{var v;a:{var ha={a:!0},ia={};try{ia.__proto__=ha;v=ia.a;break a}catch(a){}v=!1}t=v?function(a,b){a.__proto__=b;if(a.__proto__!==b)throw new TypeError(a+" is not extensible");return a}:null}var ja=t;
function x(a){var b=typeof Symbol!="undefined"&&Symbol.iterator&&a[Symbol.iterator];if(b)return b.call(a);if(typeof a.length=="number")return{next:aa(a)};throw Error(String(a)+" is not an iterable or ArrayLike");}
function y(){this.j=!1;this.h=null;this.m=void 0;this.g=1;this.A=this.l=0;this.i=null}
function z(a){if(a.j)throw new TypeError("Generator is already running");a.j=!0}
y.prototype.s=function(a){this.m=a};
function B(a,b){a.i={O:b,P:!0};a.g=a.l||a.A}
y.prototype.return=function(a){this.i={return:a};this.g=this.A};
function C(a,b,c){a.g=c;return{value:b}}
function ka(a){this.g=new y;this.h=a}
function la(a,b){z(a.g);var c=a.g.h;if(c)return D(a,"return"in c?c["return"]:function(d){return{value:d,done:!0}},b,a.g.return);
a.g.return(b);return E(a)}
function D(a,b,c,d){try{var f=b.call(a.g.h,c);if(!(f instanceof Object))throw new TypeError("Iterator result "+f+" is not an object");if(!f.done)return a.g.j=!1,f;var e=f.value}catch(h){return a.g.h=null,B(a.g,h),E(a)}a.g.h=null;d.call(a.g,e);return E(a)}
function E(a){for(;a.g.g;)try{var b=a.h(a.g);if(b)return a.g.j=!1,{value:b.value,done:!1}}catch(c){a.g.m=void 0,B(a.g,c)}a.g.j=!1;if(a.g.i){b=a.g.i;a.g.i=null;if(b.P)throw b.O;return{value:b.return,done:!0}}return{value:void 0,done:!0}}
function ma(a){this.next=function(b){z(a.g);a.g.h?b=D(a,a.g.h.next,b,a.g.s):(a.g.s(b),b=E(a));return b};
this.throw=function(b){z(a.g);a.g.h?b=D(a,a.g.h["throw"],b,a.g.s):(B(a.g,b),b=E(a));return b};
this.return=function(b){return la(a,b)};
this[Symbol.iterator]=function(){return this}}
function na(a){function b(d){return a.next(d)}
function c(d){return a.throw(d)}
return new Promise(function(d,f){function e(h){h.done?d(h.value):Promise.resolve(h.value).then(b,c).then(e,f)}
e(a.next())})}
function oa(a){return na(new ma(new ka(a)))}
r("Promise",function(a){function b(h){this.h=0;this.i=void 0;this.g=[];this.s=!1;var g=this.j();try{h(g.resolve,g.reject)}catch(k){g.reject(k)}}
function c(){this.g=null}
function d(h){return h instanceof b?h:new b(function(g){g(h)})}
if(a)return a;c.prototype.h=function(h){if(this.g==null){this.g=[];var g=this;this.i(function(){g.l()})}this.g.push(h)};
var f=q.setTimeout;c.prototype.i=function(h){f(h,0)};
c.prototype.l=function(){for(;this.g&&this.g.length;){var h=this.g;this.g=[];for(var g=0;g<h.length;++g){var k=h[g];h[g]=null;try{k()}catch(l){this.j(l)}}}this.g=null};
c.prototype.j=function(h){this.i(function(){throw h;})};
b.prototype.j=function(){function h(l){return function(m){k||(k=!0,l.call(g,m))}}
var g=this,k=!1;return{resolve:h(this.J),reject:h(this.l)}};
b.prototype.J=function(h){if(h===this)this.l(new TypeError("A Promise cannot resolve to itself"));else if(h instanceof b)this.L(h);else{a:switch(typeof h){case "object":var g=h!=null;break a;case "function":g=!0;break a;default:g=!1}g?this.I(h):this.m(h)}};
b.prototype.I=function(h){var g=void 0;try{g=h.then}catch(k){this.l(k);return}typeof g=="function"?this.M(g,h):this.m(h)};
b.prototype.l=function(h){this.A(2,h)};
b.prototype.m=function(h){this.A(1,h)};
b.prototype.A=function(h,g){if(this.h!=0)throw Error("Cannot settle("+h+", "+g+"): Promise already settled in state"+this.h);this.h=h;this.i=g;this.h===2&&this.K();this.S()};
b.prototype.K=function(){var h=this;f(function(){if(h.T()){var g=q.console;typeof g!=="undefined"&&g.error(h.i)}},1)};
b.prototype.T=function(){if(this.s)return!1;var h=q.CustomEvent,g=q.Event,k=q.dispatchEvent;if(typeof k==="undefined")return!0;typeof h==="function"?h=new h("unhandledrejection",{cancelable:!0}):typeof g==="function"?h=new g("unhandledrejection",{cancelable:!0}):(h=q.document.createEvent("CustomEvent"),h.initCustomEvent("unhandledrejection",!1,!0,h));h.promise=this;h.reason=this.i;return k(h)};
b.prototype.S=function(){if(this.g!=null){for(var h=0;h<this.g.length;++h)e.h(this.g[h]);this.g=null}};
var e=new c;b.prototype.L=function(h){var g=this.j();h.B(g.resolve,g.reject)};
b.prototype.M=function(h,g){var k=this.j();try{h.call(g,k.resolve,k.reject)}catch(l){k.reject(l)}};
b.prototype.then=function(h,g){function k(w,A){return typeof w=="function"?function(ba){try{l(w(ba))}catch(ca){m(ca)}}:A}
var l,m,u=new b(function(w,A){l=w;m=A});
this.B(k(h,l),k(g,m));return u};
b.prototype.catch=function(h){return this.then(void 0,h)};
b.prototype.B=function(h,g){function k(){switch(l.h){case 1:h(l.i);break;case 2:g(l.i);break;default:throw Error("Unexpected state: "+l.h);}}
var l=this;this.g==null?e.h(k):this.g.push(k);this.s=!0};
b.resolve=d;b.reject=function(h){return new b(function(g,k){k(h)})};
b.race=function(h){return new b(function(g,k){for(var l=x(h),m=l.next();!m.done;m=l.next())d(m.value).B(g,k)})};
b.all=function(h){var g=x(h),k=g.next();return k.done?d([]):new b(function(l,m){function u(ba){return function(ca){w[ba]=ca;A--;A==0&&l(w)}}
var w=[],A=0;do w.push(void 0),A++,d(k.value).B(u(w.length-1),m),k=g.next();while(!k.done)})};
return b});
function F(a,b){return Object.prototype.hasOwnProperty.call(a,b)}
var pa=typeof Object.assign=="function"?Object.assign:function(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(d)for(var f in d)F(d,f)&&(a[f]=d[f])}return a};
r("Object.assign",function(a){return a||pa});
r("Symbol.dispose",function(a){return a?a:Symbol("Symbol.dispose")});
r("WeakMap",function(a){function b(k){this.g=(g+=Math.random()+1).toString();if(k){k=x(k);for(var l;!(l=k.next()).done;)l=l.value,this.set(l[0],l[1])}}
function c(){}
function d(k){var l=typeof k;return l==="object"&&k!==null||l==="function"}
function f(k){if(!F(k,h)){var l=new c;p(k,h,{value:l})}}
function e(k){var l=Object[k];l&&(Object[k]=function(m){if(m instanceof c)return m;Object.isExtensible(m)&&f(m);return l(m)})}
if(function(){if(!a||!Object.seal)return!1;try{var k=Object.seal({}),l=Object.seal({}),m=new a([[k,2],[l,3]]);if(m.get(k)!=2||m.get(l)!=3)return!1;m.delete(k);m.set(l,4);return!m.has(k)&&m.get(l)==4}catch(u){return!1}}())return a;
var h="$jscomp_hidden_"+Math.random();e("freeze");e("preventExtensions");e("seal");var g=0;b.prototype.set=function(k,l){if(!d(k))throw Error("Invalid WeakMap key");f(k);if(!F(k,h))throw Error("WeakMap key fail: "+k);k[h][this.g]=l;return this};
b.prototype.get=function(k){return d(k)&&F(k,h)?k[h][this.g]:void 0};
b.prototype.has=function(k){return d(k)&&F(k,h)&&F(k[h],this.g)};
b.prototype.delete=function(k){return d(k)&&F(k,h)&&F(k[h],this.g)?delete k[h][this.g]:!1};
return b});
r("Map",function(a){function b(){var g={};return g.previous=g.next=g.head=g}
function c(g,k){var l=g[1];return ea(function(){if(l){for(;l.head!=g[1];)l=l.previous;for(;l.next!=l.head;)return l=l.next,{done:!1,value:k(l)};l=null}return{done:!0,value:void 0}})}
function d(g,k){var l=k&&typeof k;l=="object"||l=="function"?e.has(k)?l=e.get(k):(l=""+ ++h,e.set(k,l)):l="p_"+k;var m=g[0][l];if(m&&F(g[0],l))for(g=0;g<m.length;g++){var u=m[g];if(k!==k&&u.key!==u.key||k===u.key)return{id:l,list:m,index:g,o:u}}return{id:l,list:m,index:-1,o:void 0}}
function f(g){this[0]={};this[1]=b();this.size=0;if(g){g=x(g);for(var k;!(k=g.next()).done;)k=k.value,this.set(k[0],k[1])}}
if(function(){if(!a||typeof a!="function"||!a.prototype.entries||typeof Object.seal!="function")return!1;try{var g=Object.seal({x:4}),k=new a(x([[g,"s"]]));if(k.get(g)!="s"||k.size!=1||k.get({x:4})||k.set({x:4},"t")!=k||k.size!=2)return!1;var l=k.entries(),m=l.next();if(m.done||m.value[0]!=g||m.value[1]!="s")return!1;m=l.next();return m.done||m.value[0].x!=4||m.value[1]!="t"||!l.next().done?!1:!0}catch(u){return!1}}())return a;
var e=new WeakMap;f.prototype.set=function(g,k){g=g===0?0:g;var l=d(this,g);l.list||(l.list=this[0][l.id]=[]);l.o?l.o.value=k:(l.o={next:this[1],previous:this[1].previous,head:this[1],key:g,value:k},l.list.push(l.o),this[1].previous.next=l.o,this[1].previous=l.o,this.size++);return this};
f.prototype.delete=function(g){g=d(this,g);return g.o&&g.list?(g.list.splice(g.index,1),g.list.length||delete this[0][g.id],g.o.previous.next=g.o.next,g.o.next.previous=g.o.previous,g.o.head=null,this.size--,!0):!1};
f.prototype.clear=function(){this[0]={};this[1]=this[1].previous=b();this.size=0};
f.prototype.has=function(g){return!!d(this,g).o};
f.prototype.get=function(g){return(g=d(this,g).o)&&g.value};
f.prototype.entries=function(){return c(this,function(g){return[g.key,g.value]})};
f.prototype.keys=function(){return c(this,function(g){return g.key})};
f.prototype.values=function(){return c(this,function(g){return g.value})};
f.prototype.forEach=function(g,k){for(var l=this.entries(),m;!(m=l.next()).done;)m=m.value,g.call(k,m[1],m[0],this)};
f.prototype[Symbol.iterator]=f.prototype.entries;var h=0;return f});
r("Set",function(a){function b(c){this.g=new Map;if(c){c=x(c);for(var d;!(d=c.next()).done;)this.add(d.value)}this.size=this.g.size}
if(function(){if(!a||typeof a!="function"||!a.prototype.entries||typeof Object.seal!="function")return!1;try{var c=Object.seal({x:4}),d=new a(x([c]));if(!d.has(c)||d.size!=1||d.add(c)!=d||d.size!=1||d.add({x:4})!=d||d.size!=2)return!1;var f=d.entries(),e=f.next();if(e.done||e.value[0]!=c||e.value[1]!=c)return!1;e=f.next();return e.done||e.value[0]==c||e.value[0].x!=4||e.value[1]!=e.value[0]?!1:f.next().done}catch(h){return!1}}())return a;
b.prototype.add=function(c){c=c===0?0:c;this.g.set(c,c);this.size=this.g.size;return this};
b.prototype.delete=function(c){c=this.g.delete(c);this.size=this.g.size;return c};
b.prototype.clear=function(){this.g.clear();this.size=0};
b.prototype.has=function(c){return this.g.has(c)};
b.prototype.entries=function(){return this.g.entries()};
b.prototype.values=function(){return this.g.values()};
b.prototype.keys=b.prototype.values;b.prototype[Symbol.iterator]=b.prototype.values;b.prototype.forEach=function(c,d){var f=this;this.g.forEach(function(e){return c.call(d,e,e,f)})};
return b});
r("Array.prototype.find",function(a){return a?a:function(b,c){a:{var d=this;d instanceof String&&(d=String(d));for(var f=d.length,e=0;e<f;e++){var h=d[e];if(b.call(c,h,e,d)){b=h;break a}}b=void 0}return b}});
r("Object.is",function(a){return a?a:function(b,c){return b===c?b!==0||1/b===1/c:b!==b&&c!==c}});
r("Array.prototype.includes",function(a){return a?a:function(b,c){var d=this;d instanceof String&&(d=String(d));var f=d.length;c=c||0;for(c<0&&(c=Math.max(c+f,0));c<f;c++){var e=d[c];if(e===b||Object.is(e,b))return!0}return!1}});
r("String.prototype.includes",function(a){return a?a:function(b,c){if(this==null)throw new TypeError("The 'this' value for String.prototype.includes must not be null or undefined");if(b instanceof RegExp)throw new TypeError("First argument to String.prototype.includes must not be a regular expression");return(this+"").indexOf(b,c||0)!==-1}});
r("Array.from",function(a){return a?a:function(b,c,d){c=c!=null?c:function(g){return g};
var f=[],e=typeof Symbol!="undefined"&&Symbol.iterator&&b[Symbol.iterator];if(typeof e=="function"){b=e.call(b);for(var h=0;!(e=b.next()).done;)f.push(c.call(d,e.value,h++))}else for(e=b.length,h=0;h<e;h++)f.push(c.call(d,b[h],h));return f}});/*

 Copyright The Closure Library Authors.
 SPDX-License-Identifier: Apache-2.0
*/
var G=this||self;function H(a){var b=typeof a;return b=="object"&&a!=null||b=="function"}
function qa(a){return Object.prototype.hasOwnProperty.call(a,ra)&&a[ra]||(a[ra]=++sa)}
var ra="closure_uid_"+(Math.random()*1E9>>>0),sa=0;function I(a,b){a=a.split(".");for(var c=G,d;a.length&&(d=a.shift());)a.length||b===void 0?c[d]&&c[d]!==Object.prototype[d]?c=c[d]:c=c[d]={}:c[d]=b}
function ta(a,b){function c(){}
c.prototype=b.prototype;a.H=b.prototype;a.prototype=new c;a.prototype.constructor=a;a.Y=function(d,f,e){for(var h=Array(arguments.length-2),g=2;g<arguments.length;g++)h[g-2]=arguments[g];return b.prototype[f].apply(d,h)}}
;var ua=Array.prototype.indexOf?function(a,b){return Array.prototype.indexOf.call(a,b,void 0)}:function(a,b){if(typeof a==="string")return typeof b!=="string"||b.length!=1?-1:a.indexOf(b,0);
for(var c=0;c<a.length;c++)if(c in a&&a[c]===b)return c;return-1},va=Array.prototype.forEach?function(a,b,c){Array.prototype.forEach.call(a,b,c)}:function(a,b,c){for(var d=a.length,f=typeof a==="string"?a.split(""):a,e=0;e<d;e++)e in f&&b.call(c,f[e],e,a)};
function wa(a,b){b=ua(a,b);b>=0&&Array.prototype.splice.call(a,b,1)}
function xa(a){return Array.prototype.concat.apply([],arguments)}
function ya(a){var b=a.length;if(b>0){for(var c=Array(b),d=0;d<b;d++)c[d]=a[d];return c}return[]}
;function za(a,b){this.i=a;this.j=b;this.h=0;this.g=null}
za.prototype.get=function(){if(this.h>0){this.h--;var a=this.g;this.g=a.next;a.next=null}else a=this.i();return a};function Aa(a){G.setTimeout(function(){throw a;},0)}
;function Ba(){this.h=this.g=null}
Ba.prototype.add=function(a,b){var c=Ca.get();c.set(a,b);this.h?this.h.next=c:this.g=c;this.h=c};
Ba.prototype.remove=function(){var a=null;this.g&&(a=this.g,this.g=this.g.next,this.g||(this.h=null),a.next=null);return a};
var Ca=new za(function(){return new Da},function(a){return a.reset()});
function Da(){this.next=this.scope=this.g=null}
Da.prototype.set=function(a,b){this.g=a;this.scope=b;this.next=null};
Da.prototype.reset=function(){this.next=this.scope=this.g=null};var Ea,Fa=!1,Ga=new Ba;function Ha(a){Ea||Ia();Fa||(Ea(),Fa=!0);Ga.add(a,void 0)}
function Ia(){var a=Promise.resolve(void 0);Ea=function(){a.then(Ja)}}
function Ja(){for(var a;a=Ga.remove();){try{a.g.call(a.scope)}catch(c){Aa(c)}var b=Ca;b.j(a);b.h<100&&(b.h++,a.next=b.g,b.g=a)}Fa=!1}
;function J(){this.i=this.i;this.j=this.j}
J.prototype.i=!1;J.prototype.dispose=function(){this.i||(this.i=!0,this.C())};
J.prototype[Symbol.dispose]=function(){this.dispose()};
J.prototype.addOnDisposeCallback=function(a,b){this.i?b!==void 0?a.call(b):a():(this.j||(this.j=[]),b&&(a=a.bind(b)),this.j.push(a))};
J.prototype.C=function(){if(this.j)for(;this.j.length;)this.j.shift()()};function Ka(a){var b={},c;for(c in a)b[c]=a[c];return b}
;var La=/&/g,Ma=/</g,Na=/>/g,Oa=/"/g,Pa=/'/g,Qa=/\x00/g,Ra=/[\x00&<>"']/;/*

 Copyright Google LLC
 SPDX-License-Identifier: Apache-2.0
*/
function K(a){this.g=a}
K.prototype.toString=function(){return this.g};
var Sa=new K("about:invalid#zClosurez");function Ta(a){this.R=a}
function L(a){return new Ta(function(b){return b.substr(0,a.length+1).toLowerCase()===a+":"})}
var Ua=[L("data"),L("http"),L("https"),L("mailto"),L("ftp"),new Ta(function(a){return/^[^:]*([/?#]|$)/.test(a)})],Va=/^\s*(?!javascript:)(?:[\w+.-]+:|[^:/?#]*(?:[/?#]|$))/i;var Wa={X:0,V:1,W:2,0:"FORMATTED_HTML_CONTENT",1:"EMBEDDED_INTERNAL_CONTENT",2:"EMBEDDED_TRUSTED_EXTERNAL_CONTENT"};function M(a,b){b=Error.call(this,a+" cannot be used with intent "+Wa[b]);this.message=b.message;"stack"in b&&(this.stack=b.stack);this.type=a;this.name="TypeCannotBeUsedWithIframeIntentError"}
var N=Error;M.prototype=fa(N.prototype);M.prototype.constructor=M;if(ja)ja(M,N);else for(var O in N)if(O!="prototype")if(Object.defineProperties){var Xa=Object.getOwnPropertyDescriptor(N,O);Xa&&Object.defineProperty(M,O,Xa)}else M[O]=N[O];M.H=N.prototype;function Ya(a){Ra.test(a)&&(a.indexOf("&")!=-1&&(a=a.replace(La,"&amp;")),a.indexOf("<")!=-1&&(a=a.replace(Ma,"&lt;")),a.indexOf(">")!=-1&&(a=a.replace(Na,"&gt;")),a.indexOf('"')!=-1&&(a=a.replace(Oa,"&quot;")),a.indexOf("'")!=-1&&(a=a.replace(Pa,"&#39;")),a.indexOf("\x00")!=-1&&(a=a.replace(Qa,"&#0;")));return a}
;var Za,P;a:{for(var $a=["CLOSURE_FLAGS"],Q=G,ab=0;ab<$a.length;ab++)if(Q=Q[$a[ab]],Q==null){P=null;break a}P=Q}var bb=P&&P[610401301];Za=bb!=null?bb:!1;function R(){var a=G.navigator;return a&&(a=a.userAgent)?a:""}
var S,cb=G.navigator;S=cb?cb.userAgentData||null:null;function db(){return Za?!!S&&S.brands.length>0:!1}
function eb(a){var b={};a.forEach(function(c){b[c[0]]=c[1]});
return function(c){return b[c.find(function(d){return d in b})]||""}}
function fb(){for(var a=R(),b=RegExp("([A-Z][\\w ]+)/([^\\s]+)\\s*(?:\\((.*?)\\))?","g"),c=[],d;d=b.exec(a);)c.push([d[1],d[2],d[3]||void 0]);a=eb(c);if(db())a:{if(Za&&S)for(b=0;b<S.brands.length;b++)if((c=S.brands[b].brand)&&c.indexOf("Chromium")!=-1){b=!0;break a}b=!1}else b=(R().indexOf("Chrome")!=-1||R().indexOf("CriOS")!=-1)&&(db()||R().indexOf("Edge")==-1)||R().indexOf("Silk")!=-1;return b?a(["Chrome","CriOS","HeadlessChrome"]):""}
function gb(){if(db()){var a=S.brands.find(function(b){return b.brand==="Chromium"});
if(!a||!a.version)return NaN;a=a.version.split(".")}else{a=fb();if(a==="")return NaN;a=a.split(".")}return a.length===0?NaN:Number(a[0])}
;function hb(a,b){var c=b.parentNode;c&&c.replaceChild(a,b)}
;function T(a){J.call(this);this.s=1;this.l=[];this.m=0;this.g=[];this.h={};this.A=!!a}
ta(T,J);n=T.prototype;n.subscribe=function(a,b,c){var d=this.h[a];d||(d=this.h[a]=[]);var f=this.s;this.g[f]=a;this.g[f+1]=b;this.g[f+2]=c;this.s=f+3;d.push(f);return f};
function ib(a,b,c){var d=U;if(a=d.h[a]){var f=d.g;(a=a.find(function(e){return f[e+1]==b&&f[e+2]==c}))&&d.D(a)}}
n.D=function(a){var b=this.g[a];if(b){var c=this.h[b];this.m!=0?(this.l.push(a),this.g[a+1]=function(){}):(c&&wa(c,a),delete this.g[a],delete this.g[a+1],delete this.g[a+2])}return!!b};
n.G=function(a,b){var c=this.h[a];if(c){var d=Array(arguments.length-1),f=arguments.length,e;for(e=1;e<f;e++)d[e-1]=arguments[e];if(this.A)for(e=0;e<c.length;e++)f=c[e],jb(this.g[f+1],this.g[f+2],d);else{this.m++;try{for(e=0,f=c.length;e<f&&!this.i;e++){var h=c[e];this.g[h+1].apply(this.g[h+2],d)}}finally{if(this.m--,this.l.length>0&&this.m==0)for(;c=this.l.pop();)this.D(c)}}return e!=0}return!1};
function jb(a,b,c){Ha(function(){a.apply(b,c)})}
n.clear=function(a){if(a){var b=this.h[a];b&&(b.forEach(this.D,this),delete this.h[a])}else this.g.length=0,this.h={}};
n.C=function(){T.H.C.call(this);this.clear();this.l.length=0};var kb=RegExp("^(?:([^:/?#.]+):)?(?://(?:([^\\\\/?#]*)@)?([^\\\\/?#]*?)(?::([0-9]+))?(?=[\\\\/?#]|$))?([^?#]+)?(?:\\?([^#]*))?(?:#([\\s\\S]*))?$");function lb(a){var b=a.match(kb);a=b[1];var c=b[2],d=b[3];b=b[4];var f="";a&&(f+=a+":");d&&(f+="//",c&&(f+=c+"@"),f+=d,b&&(f+=":"+b));return f}
function mb(a,b,c){if(Array.isArray(b))for(var d=0;d<b.length;d++)mb(a,String(b[d]),c);else b!=null&&c.push(a+(b===""?"":"="+encodeURIComponent(String(b))))}
var nb=/#|$/;var ob=["https://www.google.com"];function pb(){var a=this;this.g=[];this.h=function(){Promise.all(a.g.map(function(b){document.requestStorageAccessFor(b)})).then(function(){window.removeEventListener("click",a.h)})}}
function qb(){return oa(function(a){var b=a.return;var c=gb()>=119;return b.call(a,c&&!!navigator.permissions&&!!navigator.permissions.query&&"requestStorageAccessFor"in document)})}
function rb(){var a=new pb,b=["https://www.youtube.com"];b=b===void 0?ob:b;oa(function(c){switch(c.g){case 1:return C(c,qb(),2);case 2:if(!c.m){c.g=3;break}return C(c,Promise.all(b.map(function(d){var f;return oa(function(e){if(e.g==1)return e.l=2,C(e,navigator.permissions.query({name:"top-level-storage-access",requestedOrigin:d}),4);e.g!=2?(f=e.m,f.state==="prompt"&&a.g.push(d),e.g=0,e.l=0):(e.l=0,e.i=null,e.g=0)})})),4);
case 4:a.g.length>0&&window.addEventListener("click",a.h);case 3:return c.return()}})}
;var V={},sb=[],U=new T,tb={};function ub(){for(var a=x(sb),b=a.next();!b.done;b=a.next())b=b.value,b()}
function vb(a,b){return a.tagName.toLowerCase().substring(0,3)==="yt:"?a.getAttribute(b):a.dataset?a.dataset[b]:a.getAttribute("data-"+b)}
function wb(a){U.G.apply(U,arguments)}
;function xb(a){return(a.search("cue")===0||a.search("load")===0)&&a!=="loadModule"}
function yb(a){return a.search("get")===0||a.search("is")===0}
;var W=window;
function X(a,b){this.v={};this.playerInfo={};this.videoTitle="";this.i=this.g=null;this.h=0;this.m=!1;this.l=[];this.j=null;this.A={};this.options=null;if(!a)throw Error("YouTube player element ID required.");this.id=qa(this);b=Object.assign({title:"video player",videoId:"",width:640,height:360},b||{});var c=document;if(a=typeof a==="string"?c.getElementById(a):a){W.yt_embedsEnableRsaforFromIframeApi&&rb();c=a.tagName.toLowerCase()==="iframe";b.host||(b.host=c?lb(a.src):"https://www.youtube.com");this.options=
b||{};b=[this.options,window.YTConfig||{}];for(var d=0;d<b.length;d++)b[d].host&&(b[d].host=b[d].host.toString().replace("http://","https://"));c||(W.yt_embedsEnableAutoplayAndVisibilitySignals?(b=document.createElement("iframe"),zb(this,b,a),this.i=a,hb(b,a),Ab(this,b,Bb(this,b)),a=b):(b=document.createElement("iframe"),zb(this,b,a),Ab(this,b,Bb(this)),this.i=a,hb(b,a),a=b));this.g=a;this.g.id||(this.g.id="widget"+qa(this.g));V[this.g.id]=this;if(window.postMessage){this.j=new T;Cb(this);a=Y(this,
"events");for(var f in a)a.hasOwnProperty(f)&&this.addEventListener(f,a[f]);for(var e in tb)tb.hasOwnProperty(e)&&Db(this,e)}}}
n=X.prototype;n.setSize=function(a,b){this.g.width=a.toString();this.g.height=b.toString();return this};
n.getIframe=function(){return this.g};
n.addEventListener=function(a,b){var c=b;typeof b==="string"&&(c=function(){window[b].apply(window,arguments)});
if(!c)return this;this.j.subscribe(a,c);Eb(this,a);return this};
function Db(a,b){b=b.split(".");if(b.length===2){var c=b[1];"player"===b[0]&&Eb(a,c)}}
n.destroy=function(){this.g&&this.g.id&&(V[this.g.id]=null);var a=this.j;a&&typeof a.dispose=="function"&&a.dispose();this.i?hb(this.i,this.g):(a=this.g)&&a.parentNode&&a.parentNode.removeChild(a);Z&&(Z[this.id]=null);this.options=null;this.g&&this.s&&this.g.removeEventListener("load",this.s);this.i=this.g=null};
function Fb(a,b,c){c=c||[];c=Array.prototype.slice.call(c);b={event:"command",func:b,args:c};a.m?a.sendMessage(b):a.l.push(b)}
function zb(a,b,c){c=c.attributes;for(var d=0,f=c.length;d<f;d++){var e=c[d].value;e!=null&&e!==""&&e!=="null"&&b.setAttribute(c[d].name,e)}b.setAttribute("frameBorder","0");b.setAttribute("allowfullscreen","");b.setAttribute("allow","accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share");b.setAttribute("referrerPolicy","strict-origin-when-cross-origin");b.setAttribute("title","YouTube "+Y(a,"title"));(c=Y(a,"width"))&&b.setAttribute("width",c.toString());
(a=Y(a,"height"))&&b.setAttribute("height",a.toString())}
function Ab(a,b,c){a=""+Y(a,"host")+Gb(a)+"?";var d=[],f;for(f in c)mb(f,c[f],d);c=a+d.join("&");if(W.yt_embedsEnableIframeSrcWithIntent){var e=e===void 0?Ua:e;a:if(e=e===void 0?Ua:e,c instanceof K)e=c;else{for(f=0;f<e.length;++f)if(a=e[f],a instanceof Ta&&a.R(c)){e=new K(c);break a}e=void 0}e=e||Sa;b.removeAttribute("srcdoc");c="allow-same-origin allow-scripts allow-forms allow-popups allow-popups-to-escape-sandbox allow-storage-access-by-user-activation".split(" ");b.setAttribute("sandbox","");
for(f=0;f<c.length;f++)b.sandbox.supports&&!b.sandbox.supports(c[f])||b.sandbox.add(c[f]);if(e instanceof K)if(e instanceof K)e=e.g;else throw Error("");else e=Va.test(e)?e:void 0;e!==void 0&&(b.src=e);b.sandbox.add("allow-presentation","allow-top-navigation")}else b.src=c}
n.F=function(){this.g&&this.g.contentWindow?this.sendMessage({event:"listening"}):clearInterval(this.h)};
function Cb(a){Hb(a,a.id,String(Y(a,"host")));a.h=setInterval(a.F.bind(a),250);a.g&&(a.s=function(){clearInterval(a.h);a.h=setInterval(a.F.bind(a),250)},a.g.addEventListener("load",a.s))}
function Ib(a){var b=a.getBoundingClientRect();a=Math.max(0,Math.min(b.bottom,window.innerHeight||document.documentElement.clientHeight)-Math.max(b.top,0))*Math.max(0,Math.min(b.right,window.innerWidth||document.documentElement.clientWidth)-Math.max(b.left,0));a=(b=b.height*b.width)?a/b:0;return document.visibilityState==="hidden"||a<.5?1:a<.75?2:a<.85?3:a<.95?4:a<1?5:6}
function Eb(a,b){a.A[b]||(a.A[b]=!0,Fb(a,"addEventListener",[b]))}
n.sendMessage=function(a){a.id=this.id;a.channel="widget";a=JSON.stringify(a);var b=lb(this.g.src||"").replace("http:","https:");if(this.g.contentWindow)try{this.g.contentWindow.postMessage(a,b)}catch(c){if(c.name&&c.name==="SyntaxError")c.message&&c.message.indexOf("target origin ''")>0||console&&console.warn&&console.warn(c);else throw c;}else console&&console.warn&&console.warn("The YouTube player is not attached to the DOM. API calls should be made after the onReady event. See more: https://developers.google.com/youtube/iframe_api_reference#Events")};
function Gb(a){if(W.yt_embedsEnableIframeApiVideoIdValidation){a=String(Y(a,"videoId"));if(a.includes("../"))throw Error("Invalid video id");return"/embed/"+a}return"/embed/"+String(Y(a,"videoId"))}
function Bb(a,b){var c=Y(a,"playerVars");c?c=Ka(c):c={};window!==window.top&&document.referrer&&(c.widget_referrer=document.referrer.substring(0,256));var d=Y(a,"embedConfig");if(d){if(H(d))try{d=JSON.stringify(d)}catch(f){console.error("Invalid embed config JSON",f)}c.embed_config=d}c.enablejsapi=window.postMessage?1:0;window.location.host&&(c.origin=window.location.protocol+"//"+window.location.host);c.widgetid=a.id;window.location.href&&va(["debugjs","debugcss"],function(f){var e=window.location.href;
var h=e.search(nb);b:{var g=0;for(var k=f.length;(g=e.indexOf(f,g))>=0&&g<h;){var l=e.charCodeAt(g-1);if(l==38||l==63)if(l=e.charCodeAt(g+k),!l||l==61||l==38||l==35)break b;g+=k+1}g=-1}if(g<0)e=null;else{k=e.indexOf("&",g);if(k<0||k>h)k=h;g+=f.length+1;e=decodeURIComponent(e.slice(g,k!==-1?k:0).replace(/\+/g," "))}e!==null&&(c[f]=e)});
W.yt_embedsEnableIframeApiSendFullEmbedUrl&&(window.location.href&&(c.forigin=window.location.href),a=window.location.ancestorOrigins,c.aoriginsup=a===void 0?0:1,a&&a.length>0&&(c.aorigins=Array.from(a).join(",")),window.document.referrer&&(c.gporigin=window.document.referrer));W.yt_embedsEnableAutoplayAndVisibilitySignals&&b&&(c.vf=Ib(b));return c}
function Jb(a,b){if(H(b)){for(var c in b)b.hasOwnProperty(c)&&(a.playerInfo[c]=b[c]);a.playerInfo.hasOwnProperty("videoData")&&(b=a.playerInfo.videoData,b.hasOwnProperty("title")&&b.title?(b=b.title,b!==a.videoTitle&&(a.videoTitle=b,a.g.setAttribute("title",b))):(a.videoTitle="",a.g.setAttribute("title","YouTube "+Y(a,"title"))))}}
function Kb(a,b){b=x(b);for(var c=b.next(),d={};!c.done;d={u:void 0},c=b.next())d.u=c.value,a[d.u]||(d.u==="getCurrentTime"?a[d.u]=function(){var f=this.playerInfo.currentTime;if(this.playerInfo.playerState===1){var e=(Date.now()/1E3-this.playerInfo.currentTimeLastUpdated_)*this.playerInfo.playbackRate;e>0&&(f+=Math.min(e,1))}return f}:xb(d.u)?a[d.u]=function(f){return function(){this.playerInfo={};
this.v={};Fb(this,f.u,arguments);return this}}(d):yb(d.u)?a[d.u]=function(f){return function(){var e=f.u,h=0;
e.search("get")===0?h=3:e.search("is")===0&&(h=2);return this.playerInfo[e.charAt(h).toLowerCase()+e.substring(h+1)]}}(d):a[d.u]=function(f){return function(){Fb(this,f.u,arguments);
return this}}(d))}
n.getVideoEmbedCode=function(){var a=""+Y(this,"host")+Gb(this),b=Number(Y(this,"width")),c=Number(Y(this,"height"));if(isNaN(b)||isNaN(c))throw Error("Invalid width or height property");b=Math.floor(b);c=Math.floor(c);var d=this.videoTitle;a=Ya(a);d=Ya(d!=null?d:"YouTube video player");return'<iframe width="'+b+'" height="'+c+'" src="'+a+'" title="'+(d+'" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>')};
n.getOptions=function(a){return this.v.namespaces?a?this.v[a]?this.v[a].options||[]:[]:this.v.namespaces||[]:[]};
n.getOption=function(a,b){if(this.v.namespaces&&a&&b&&this.v[a])return this.v[a][b]};
function Y(a,b){a=[a.options,window.YTConfig||{}];for(var c=0;c<a.length;c++){var d=a[c][b];if(d!==void 0)return d}return null}
var Z=null,Lb=null;function Mb(a){if(a.tagName.toLowerCase()!=="iframe"){var b=vb(a,"videoid");b&&(b={videoId:b,width:vb(a,"width"),height:vb(a,"height")},new X(a,b))}}
function Hb(a,b,c){Z||(Z={},Lb=new Set,Nb.addEventListener("message",function(d){a:if(Lb.has(d.origin)){try{var f=JSON.parse(d.data)}catch(g){break a}var e=Z[f.id];if(e&&d.origin===e.N)switch(d=e.U,d.m=!0,d.m&&(va(d.l,d.sendMessage,d),d.l.length=0),e=f.event,f=f.info,e){case "apiInfoDelivery":if(H(f))for(var h in f)f.hasOwnProperty(h)&&(d.v[h]=f[h]);break;case "infoDelivery":Jb(d,f);break;case "initialDelivery":H(f)&&(clearInterval(d.h),d.playerInfo={},d.v={},Kb(d,f.apiInterface),Jb(d,f));break;default:d.j.i||
(h={target:d,data:f},d.j.G(e,h),wb("player."+e,h))}}}));
Z[b]={U:a,N:c};Lb.add(c)}
var Nb=window;I("YT.PlayerState.UNSTARTED",-1);I("YT.PlayerState.ENDED",0);I("YT.PlayerState.PLAYING",1);I("YT.PlayerState.PAUSED",2);I("YT.PlayerState.BUFFERING",3);I("YT.PlayerState.CUED",5);I("YT.get",function(a){return V[a]});
I("YT.scan",ub);I("YT.subscribe",function(a,b,c){U.subscribe(a,b,c);tb[a]=!0;for(var d in V)V.hasOwnProperty(d)&&Db(V[d],a)});
I("YT.unsubscribe",function(a,b,c){ib(a,b,c)});
I("YT.Player",X);X.prototype.destroy=X.prototype.destroy;X.prototype.setSize=X.prototype.setSize;X.prototype.getIframe=X.prototype.getIframe;X.prototype.addEventListener=X.prototype.addEventListener;X.prototype.getVideoEmbedCode=X.prototype.getVideoEmbedCode;X.prototype.getOptions=X.prototype.getOptions;X.prototype.getOption=X.prototype.getOption;sb.push(function(a){var b=a;b||(b=document);a=ya(b.getElementsByTagName("yt:player"));b=ya((b||document).querySelectorAll(".yt-player"));va(xa(a,b),Mb)});
typeof YTConfig!=="undefined"&&YTConfig.parsetags&&YTConfig.parsetags!=="onload"||ub();var Ob=G.onYTReady;Ob&&Ob();var Pb=G.onYouTubeIframeAPIReady;Pb&&Pb();var Qb=G.onYouTubePlayerAPIReady;Qb&&Qb();}).call(this);
