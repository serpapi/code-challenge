(function(){/*

 Copyright The Closure Library Authors.
 SPDX-License-Identifier: Apache-2.0
*/
'use strict';var m;function aa(a){var b=0;return function(){return b<a.length?{done:!1,value:a[b++]}:{done:!0}}}
var ba="function"==typeof Object.defineProperties?Object.defineProperty:function(a,b,c){if(a==Array.prototype||a==Object.prototype)return a;a[b]=c.value;return a};
function da(a){a=["object"==typeof globalThis&&globalThis,a,"object"==typeof window&&window,"object"==typeof self&&self,"object"==typeof global&&global];for(var b=0;b<a.length;++b){var c=a[b];if(c&&c.Math==Math)return c}throw Error("Cannot find global object");}
var ea=da(this);function u(a,b){if(b)a:{var c=ea;a=a.split(".");for(var d=0;d<a.length-1;d++){var e=a[d];if(!(e in c))break a;c=c[e]}a=a[a.length-1];d=c[a];b=b(d);b!=d&&null!=b&&ba(c,a,{configurable:!0,writable:!0,value:b})}}
u("Symbol",function(a){function b(f){if(this instanceof b)throw new TypeError("Symbol is not a constructor");return new c(d+(f||"")+"_"+e++,f)}
function c(f,g){this.h=f;ba(this,"description",{configurable:!0,writable:!0,value:g})}
if(a)return a;c.prototype.toString=function(){return this.h};
var d="jscomp_symbol_"+(1E9*Math.random()>>>0)+"_",e=0;return b});
u("Symbol.iterator",function(a){if(a)return a;a=Symbol("Symbol.iterator");for(var b="Array Int8Array Uint8Array Uint8ClampedArray Int16Array Uint16Array Int32Array Uint32Array Float32Array Float64Array".split(" "),c=0;c<b.length;c++){var d=ea[b[c]];"function"===typeof d&&"function"!=typeof d.prototype[a]&&ba(d.prototype,a,{configurable:!0,writable:!0,value:function(){return fa(aa(this))}})}return a});
function fa(a){a={next:a};a[Symbol.iterator]=function(){return this};
return a}
function ia(a){return a.raw=a}
function v(a){var b="undefined"!=typeof Symbol&&Symbol.iterator&&a[Symbol.iterator];if(b)return b.call(a);if("number"==typeof a.length)return{next:aa(a)};throw Error(String(a)+" is not an iterable or ArrayLike");}
function ja(a){if(!(a instanceof Array)){a=v(a);for(var b,c=[];!(b=a.next()).done;)c.push(b.value);a=c}return a}
function ka(a,b){return Object.prototype.hasOwnProperty.call(a,b)}
var la="function"==typeof Object.assign?Object.assign:function(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(d)for(var e in d)ka(d,e)&&(a[e]=d[e])}return a};
u("Object.assign",function(a){return a||la});
var na="function"==typeof Object.create?Object.create:function(a){function b(){}
b.prototype=a;return new b},oa=function(){function a(){function c(){}
new c;Reflect.construct(c,[],function(){});
return new c instanceof c}
if("undefined"!=typeof Reflect&&Reflect.construct){if(a())return Reflect.construct;var b=Reflect.construct;return function(c,d,e){c=b(c,d);e&&Reflect.setPrototypeOf(c,e.prototype);return c}}return function(c,d,e){void 0===e&&(e=c);
e=na(e.prototype||Object.prototype);return Function.prototype.apply.call(c,e,d)||e}}(),pa;
if("function"==typeof Object.setPrototypeOf)pa=Object.setPrototypeOf;else{var qa;a:{var sa={a:!0},ta={};try{ta.__proto__=sa;qa=ta.a;break a}catch(a){}qa=!1}pa=qa?function(a,b){a.__proto__=b;if(a.__proto__!==b)throw new TypeError(a+" is not extensible");return a}:null}var ua=pa;
function w(a,b){a.prototype=na(b.prototype);a.prototype.constructor=a;if(ua)ua(a,b);else for(var c in b)if("prototype"!=c)if(Object.defineProperties){var d=Object.getOwnPropertyDescriptor(b,c);d&&Object.defineProperty(a,c,d)}else a[c]=b[c];a.va=b.prototype}
function va(){this.v=!1;this.m=null;this.i=void 0;this.h=1;this.s=this.l=0;this.Da=this.j=null}
function wa(a){if(a.v)throw new TypeError("Generator is already running");a.v=!0}
va.prototype.fa=function(a){this.i=a};
function xa(a,b){a.j={exception:b,qd:!0};a.h=a.l||a.s}
va.prototype.return=function(a){this.j={return:a};this.h=this.s};
va.prototype.yield=function(a,b){this.h=b;return{value:a}};
va.prototype.A=function(a){this.h=a};
function ya(a,b,c){a.l=b;void 0!=c&&(a.s=c)}
function za(a){a.l=0;var b=a.j.exception;a.j=null;return b}
function Aa(a){var b=a.Da.splice(0)[0];(b=a.j=a.j||b)?b.qd?a.h=a.l||a.s:void 0!=b.A&&a.s<b.A?(a.h=b.A,a.j=null):a.h=a.s:a.h=0}
function Ba(a){this.h=new va;this.i=a}
function Ca(a,b){wa(a.h);var c=a.h.m;if(c)return Da(a,"return"in c?c["return"]:function(d){return{value:d,done:!0}},b,a.h.return);
a.h.return(b);return Ea(a)}
function Da(a,b,c,d){try{var e=b.call(a.h.m,c);if(!(e instanceof Object))throw new TypeError("Iterator result "+e+" is not an object");if(!e.done)return a.h.v=!1,e;var f=e.value}catch(g){return a.h.m=null,xa(a.h,g),Ea(a)}a.h.m=null;d.call(a.h,f);return Ea(a)}
function Ea(a){for(;a.h.h;)try{var b=a.i(a.h);if(b)return a.h.v=!1,{value:b.value,done:!1}}catch(c){a.h.i=void 0,xa(a.h,c)}a.h.v=!1;if(a.h.j){b=a.h.j;a.h.j=null;if(b.qd)throw b.exception;return{value:b.return,done:!0}}return{value:void 0,done:!0}}
function Fa(a){this.next=function(b){wa(a.h);a.h.m?b=Da(a,a.h.m.next,b,a.h.fa):(a.h.fa(b),b=Ea(a));return b};
this.throw=function(b){wa(a.h);a.h.m?b=Da(a,a.h.m["throw"],b,a.h.fa):(xa(a.h,b),b=Ea(a));return b};
this.return=function(b){return Ca(a,b)};
this[Symbol.iterator]=function(){return this}}
function Ga(a){function b(d){return a.next(d)}
function c(d){return a.throw(d)}
return new Promise(function(d,e){function f(g){g.done?d(g.value):Promise.resolve(g.value).then(b,c).then(f,e)}
f(a.next())})}
function A(a){return Ga(new Fa(new Ba(a)))}
function B(){for(var a=Number(this),b=[],c=a;c<arguments.length;c++)b[c-a]=arguments[c];return b}
u("Reflect",function(a){return a?a:{}});
u("Reflect.construct",function(){return oa});
u("Reflect.setPrototypeOf",function(a){return a?a:ua?function(b,c){try{return ua(b,c),!0}catch(d){return!1}}:null});
u("Promise",function(a){function b(g){this.h=0;this.j=void 0;this.i=[];this.v=!1;var h=this.l();try{g(h.resolve,h.reject)}catch(k){h.reject(k)}}
function c(){this.h=null}
function d(g){return g instanceof b?g:new b(function(h){h(g)})}
if(a)return a;c.prototype.i=function(g){if(null==this.h){this.h=[];var h=this;this.j(function(){h.m()})}this.h.push(g)};
var e=ea.setTimeout;c.prototype.j=function(g){e(g,0)};
c.prototype.m=function(){for(;this.h&&this.h.length;){var g=this.h;this.h=[];for(var h=0;h<g.length;++h){var k=g[h];g[h]=null;try{k()}catch(l){this.l(l)}}}this.h=null};
c.prototype.l=function(g){this.j(function(){throw g;})};
b.prototype.l=function(){function g(l){return function(n){k||(k=!0,l.call(h,n))}}
var h=this,k=!1;return{resolve:g(this.W),reject:g(this.m)}};
b.prototype.W=function(g){if(g===this)this.m(new TypeError("A Promise cannot resolve to itself"));else if(g instanceof b)this.ba(g);else{a:switch(typeof g){case "object":var h=null!=g;break a;case "function":h=!0;break a;default:h=!1}h?this.V(g):this.s(g)}};
b.prototype.V=function(g){var h=void 0;try{h=g.then}catch(k){this.m(k);return}"function"==typeof h?this.ja(h,g):this.s(g)};
b.prototype.m=function(g){this.fa(2,g)};
b.prototype.s=function(g){this.fa(1,g)};
b.prototype.fa=function(g,h){if(0!=this.h)throw Error("Cannot settle("+g+", "+h+"): Promise already settled in state"+this.h);this.h=g;this.j=h;2===this.h&&this.Z();this.Da()};
b.prototype.Z=function(){var g=this;e(function(){if(g.P()){var h=ea.console;"undefined"!==typeof h&&h.error(g.j)}},1)};
b.prototype.P=function(){if(this.v)return!1;var g=ea.CustomEvent,h=ea.Event,k=ea.dispatchEvent;if("undefined"===typeof k)return!0;"function"===typeof g?g=new g("unhandledrejection",{cancelable:!0}):"function"===typeof h?g=new h("unhandledrejection",{cancelable:!0}):(g=ea.document.createEvent("CustomEvent"),g.initCustomEvent("unhandledrejection",!1,!0,g));g.promise=this;g.reason=this.j;return k(g)};
b.prototype.Da=function(){if(null!=this.i){for(var g=0;g<this.i.length;++g)f.i(this.i[g]);this.i=null}};
var f=new c;b.prototype.ba=function(g){var h=this.l();g.ac(h.resolve,h.reject)};
b.prototype.ja=function(g,h){var k=this.l();try{g.call(h,k.resolve,k.reject)}catch(l){k.reject(l)}};
b.prototype.then=function(g,h){function k(t,r){return"function"==typeof t?function(x){try{l(t(x))}catch(y){n(y)}}:r}
var l,n,p=new b(function(t,r){l=t;n=r});
this.ac(k(g,l),k(h,n));return p};
b.prototype.catch=function(g){return this.then(void 0,g)};
b.prototype.ac=function(g,h){function k(){switch(l.h){case 1:g(l.j);break;case 2:h(l.j);break;default:throw Error("Unexpected state: "+l.h);}}
var l=this;null==this.i?f.i(k):this.i.push(k);this.v=!0};
b.resolve=d;b.reject=function(g){return new b(function(h,k){k(g)})};
b.race=function(g){return new b(function(h,k){for(var l=v(g),n=l.next();!n.done;n=l.next())d(n.value).ac(h,k)})};
b.all=function(g){var h=v(g),k=h.next();return k.done?d([]):new b(function(l,n){function p(x){return function(y){t[x]=y;r--;0==r&&l(t)}}
var t=[],r=0;do t.push(void 0),r++,d(k.value).ac(p(t.length-1),n),k=h.next();while(!k.done)})};
return b});
u("WeakMap",function(a){function b(k){this.h=(h+=Math.random()+1).toString();if(k){k=v(k);for(var l;!(l=k.next()).done;)l=l.value,this.set(l[0],l[1])}}
function c(){}
function d(k){var l=typeof k;return"object"===l&&null!==k||"function"===l}
function e(k){if(!ka(k,g)){var l=new c;ba(k,g,{value:l})}}
function f(k){var l=Object[k];l&&(Object[k]=function(n){if(n instanceof c)return n;Object.isExtensible(n)&&e(n);return l(n)})}
if(function(){if(!a||!Object.seal)return!1;try{var k=Object.seal({}),l=Object.seal({}),n=new a([[k,2],[l,3]]);if(2!=n.get(k)||3!=n.get(l))return!1;n.delete(k);n.set(l,4);return!n.has(k)&&4==n.get(l)}catch(p){return!1}}())return a;
var g="$jscomp_hidden_"+Math.random();f("freeze");f("preventExtensions");f("seal");var h=0;b.prototype.set=function(k,l){if(!d(k))throw Error("Invalid WeakMap key");e(k);if(!ka(k,g))throw Error("WeakMap key fail: "+k);k[g][this.h]=l;return this};
b.prototype.get=function(k){return d(k)&&ka(k,g)?k[g][this.h]:void 0};
b.prototype.has=function(k){return d(k)&&ka(k,g)&&ka(k[g],this.h)};
b.prototype.delete=function(k){return d(k)&&ka(k,g)&&ka(k[g],this.h)?delete k[g][this.h]:!1};
return b});
u("Map",function(a){function b(){var h={};return h.previous=h.next=h.head=h}
function c(h,k){var l=h[1];return fa(function(){if(l){for(;l.head!=h[1];)l=l.previous;for(;l.next!=l.head;)return l=l.next,{done:!1,value:k(l)};l=null}return{done:!0,value:void 0}})}
function d(h,k){var l=k&&typeof k;"object"==l||"function"==l?f.has(k)?l=f.get(k):(l=""+ ++g,f.set(k,l)):l="p_"+k;var n=h[0][l];if(n&&ka(h[0],l))for(h=0;h<n.length;h++){var p=n[h];if(k!==k&&p.key!==p.key||k===p.key)return{id:l,list:n,index:h,entry:p}}return{id:l,list:n,index:-1,entry:void 0}}
function e(h){this[0]={};this[1]=b();this.size=0;if(h){h=v(h);for(var k;!(k=h.next()).done;)k=k.value,this.set(k[0],k[1])}}
if(function(){if(!a||"function"!=typeof a||!a.prototype.entries||"function"!=typeof Object.seal)return!1;try{var h=Object.seal({x:4}),k=new a(v([[h,"s"]]));if("s"!=k.get(h)||1!=k.size||k.get({x:4})||k.set({x:4},"t")!=k||2!=k.size)return!1;var l=k.entries(),n=l.next();if(n.done||n.value[0]!=h||"s"!=n.value[1])return!1;n=l.next();return n.done||4!=n.value[0].x||"t"!=n.value[1]||!l.next().done?!1:!0}catch(p){return!1}}())return a;
var f=new WeakMap;e.prototype.set=function(h,k){h=0===h?0:h;var l=d(this,h);l.list||(l.list=this[0][l.id]=[]);l.entry?l.entry.value=k:(l.entry={next:this[1],previous:this[1].previous,head:this[1],key:h,value:k},l.list.push(l.entry),this[1].previous.next=l.entry,this[1].previous=l.entry,this.size++);return this};
e.prototype.delete=function(h){h=d(this,h);return h.entry&&h.list?(h.list.splice(h.index,1),h.list.length||delete this[0][h.id],h.entry.previous.next=h.entry.next,h.entry.next.previous=h.entry.previous,h.entry.head=null,this.size--,!0):!1};
e.prototype.clear=function(){this[0]={};this[1]=this[1].previous=b();this.size=0};
e.prototype.has=function(h){return!!d(this,h).entry};
e.prototype.get=function(h){return(h=d(this,h).entry)&&h.value};
e.prototype.entries=function(){return c(this,function(h){return[h.key,h.value]})};
e.prototype.keys=function(){return c(this,function(h){return h.key})};
e.prototype.values=function(){return c(this,function(h){return h.value})};
e.prototype.forEach=function(h,k){for(var l=this.entries(),n;!(n=l.next()).done;)n=n.value,h.call(k,n[1],n[0],this)};
e.prototype[Symbol.iterator]=e.prototype.entries;var g=0;return e});
function Ia(a,b,c){if(null==a)throw new TypeError("The 'this' value for String.prototype."+c+" must not be null or undefined");if(b instanceof RegExp)throw new TypeError("First argument to String.prototype."+c+" must not be a regular expression");return a+""}
u("String.prototype.endsWith",function(a){return a?a:function(b,c){var d=Ia(this,b,"endsWith");b+="";void 0===c&&(c=d.length);c=Math.max(0,Math.min(c|0,d.length));for(var e=b.length;0<e&&0<c;)if(d[--c]!=b[--e])return!1;return 0>=e}});
u("Array.prototype.find",function(a){return a?a:function(b,c){a:{var d=this;d instanceof String&&(d=String(d));for(var e=d.length,f=0;f<e;f++){var g=d[f];if(b.call(c,g,f,d)){b=g;break a}}b=void 0}return b}});
u("String.prototype.startsWith",function(a){return a?a:function(b,c){var d=Ia(this,b,"startsWith");b+="";var e=d.length,f=b.length;c=Math.max(0,Math.min(c|0,d.length));for(var g=0;g<f&&c<e;)if(d[c++]!=b[g++])return!1;return g>=f}});
u("Number.isFinite",function(a){return a?a:function(b){return"number"!==typeof b?!1:!isNaN(b)&&Infinity!==b&&-Infinity!==b}});
function Ja(a,b){a instanceof String&&(a+="");var c=0,d=!1,e={next:function(){if(!d&&c<a.length){var f=c++;return{value:b(f,a[f]),done:!1}}d=!0;return{done:!0,value:void 0}}};
e[Symbol.iterator]=function(){return e};
return e}
u("Array.prototype.keys",function(a){return a?a:function(){return Ja(this,function(b){return b})}});
u("Set",function(a){function b(c){this.h=new Map;if(c){c=v(c);for(var d;!(d=c.next()).done;)this.add(d.value)}this.size=this.h.size}
if(function(){if(!a||"function"!=typeof a||!a.prototype.entries||"function"!=typeof Object.seal)return!1;try{var c=Object.seal({x:4}),d=new a(v([c]));if(!d.has(c)||1!=d.size||d.add(c)!=d||1!=d.size||d.add({x:4})!=d||2!=d.size)return!1;var e=d.entries(),f=e.next();if(f.done||f.value[0]!=c||f.value[1]!=c)return!1;f=e.next();return f.done||f.value[0]==c||4!=f.value[0].x||f.value[1]!=f.value[0]?!1:e.next().done}catch(g){return!1}}())return a;
b.prototype.add=function(c){c=0===c?0:c;this.h.set(c,c);this.size=this.h.size;return this};
b.prototype.delete=function(c){c=this.h.delete(c);this.size=this.h.size;return c};
b.prototype.clear=function(){this.h.clear();this.size=0};
b.prototype.has=function(c){return this.h.has(c)};
b.prototype.entries=function(){return this.h.entries()};
b.prototype.values=function(){return this.h.values()};
b.prototype.keys=b.prototype.values;b.prototype[Symbol.iterator]=b.prototype.values;b.prototype.forEach=function(c,d){var e=this;this.h.forEach(function(f){return c.call(d,f,f,e)})};
return b});
u("Array.prototype.values",function(a){return a?a:function(){return Ja(this,function(b,c){return c})}});
u("Object.values",function(a){return a?a:function(b){var c=[],d;for(d in b)ka(b,d)&&c.push(b[d]);return c}});
u("Object.is",function(a){return a?a:function(b,c){return b===c?0!==b||1/b===1/c:b!==b&&c!==c}});
u("Array.prototype.includes",function(a){return a?a:function(b,c){var d=this;d instanceof String&&(d=String(d));var e=d.length;c=c||0;for(0>c&&(c=Math.max(c+e,0));c<e;c++){var f=d[c];if(f===b||Object.is(f,b))return!0}return!1}});
u("String.prototype.includes",function(a){return a?a:function(b,c){return-1!==Ia(this,b,"includes").indexOf(b,c||0)}});
u("Number.MAX_SAFE_INTEGER",function(){return 9007199254740991});
u("Number.isNaN",function(a){return a?a:function(b){return"number"===typeof b&&isNaN(b)}});
u("Number.isInteger",function(a){return a?a:function(b){return Number.isFinite(b)?b===Math.floor(b):!1}});
u("Array.prototype.entries",function(a){return a?a:function(){return Ja(this,function(b,c){return[b,c]})}});
u("Array.from",function(a){return a?a:function(b,c,d){c=null!=c?c:function(h){return h};
var e=[],f="undefined"!=typeof Symbol&&Symbol.iterator&&b[Symbol.iterator];if("function"==typeof f){b=f.call(b);for(var g=0;!(f=b.next()).done;)e.push(c.call(d,f.value,g++))}else for(f=b.length,g=0;g<f;g++)e.push(c.call(d,b[g],g));return e}});
u("Object.setPrototypeOf",function(a){return a||ua});
u("Object.entries",function(a){return a?a:function(b){var c=[],d;for(d in b)ka(b,d)&&c.push([d,b[d]]);return c}});
u("globalThis",function(a){return a||ea});
var Ka=Ka||{},C=this||self;function D(a,b,c){a=a.split(".");c=c||C;a[0]in c||"undefined"==typeof c.execScript||c.execScript("var "+a[0]);for(var d;a.length&&(d=a.shift());)a.length||void 0===b?c[d]&&c[d]!==Object.prototype[d]?c=c[d]:c=c[d]={}:c[d]=b}
function E(a,b){a=a.split(".");b=b||C;for(var c=0;c<a.length;c++)if(b=b[a[c]],null==b)return null;return b}
function La(a){var b=typeof a;return"object"!=b?b:a?Array.isArray(a)?"array":b:"null"}
function Ma(a){var b=La(a);return"array"==b||"object"==b&&"number"==typeof a.length}
function Na(a){var b=typeof a;return"object"==b&&null!=a||"function"==b}
function Oa(a){return Object.prototype.hasOwnProperty.call(a,Pa)&&a[Pa]||(a[Pa]=++Qa)}
var Pa="closure_uid_"+(1E9*Math.random()>>>0),Qa=0;function Ra(a,b,c){return a.call.apply(a.bind,arguments)}
function Sa(a,b,c){if(!a)throw Error();if(2<arguments.length){var d=Array.prototype.slice.call(arguments,2);return function(){var e=Array.prototype.slice.call(arguments);Array.prototype.unshift.apply(e,d);return a.apply(b,e)}}return function(){return a.apply(b,arguments)}}
function Ta(a,b,c){Ta=Function.prototype.bind&&-1!=Function.prototype.bind.toString().indexOf("native code")?Ra:Sa;return Ta.apply(null,arguments)}
function Ua(a,b){var c=Array.prototype.slice.call(arguments,1);return function(){var d=c.slice();d.push.apply(d,arguments);return a.apply(this,d)}}
function Va(a,b){function c(){}
c.prototype=b.prototype;a.va=b.prototype;a.prototype=new c;a.prototype.constructor=a;a.base=function(d,e,f){for(var g=Array(arguments.length-2),h=2;h<arguments.length;h++)g[h-2]=arguments[h];return b.prototype[e].apply(d,g)}}
function Wa(a){return a}
;function Xa(a,b){if(Error.captureStackTrace)Error.captureStackTrace(this,Xa);else{var c=Error().stack;c&&(this.stack=c)}a&&(this.message=String(a));void 0!==b&&(this.cause=b)}
Va(Xa,Error);Xa.prototype.name="CustomError";function Ya(a){a=a.url;var b=/[?&]dsh=1(&|$)/.test(a);this.j=!b&&/[?&]ae=1(&|$)/.test(a);this.l=!b&&/[?&]ae=2(&|$)/.test(a);if((this.h=/[?&]adurl=([^&]*)/.exec(a))&&this.h[1]){try{var c=decodeURIComponent(this.h[1])}catch(d){c=null}this.i=c}}
;function Za(){}
function $a(a){var b=!1,c;return function(){b||(c=a(),b=!0);return c}}
;var ab=Array.prototype.indexOf?function(a,b){return Array.prototype.indexOf.call(a,b,void 0)}:function(a,b){if("string"===typeof a)return"string"!==typeof b||1!=b.length?-1:a.indexOf(b,0);
for(var c=0;c<a.length;c++)if(c in a&&a[c]===b)return c;return-1},bb=Array.prototype.forEach?function(a,b,c){Array.prototype.forEach.call(a,b,c)}:function(a,b,c){for(var d=a.length,e="string"===typeof a?a.split(""):a,f=0;f<d;f++)f in e&&b.call(c,e[f],f,a)},cb=Array.prototype.filter?function(a,b){return Array.prototype.filter.call(a,b,void 0)}:function(a,b){for(var c=a.length,d=[],e=0,f="string"===typeof a?a.split(""):a,g=0;g<c;g++)if(g in f){var h=f[g];
b.call(void 0,h,g,a)&&(d[e++]=h)}return d},db=Array.prototype.map?function(a,b){return Array.prototype.map.call(a,b,void 0)}:function(a,b){for(var c=a.length,d=Array(c),e="string"===typeof a?a.split(""):a,f=0;f<c;f++)f in e&&(d[f]=b.call(void 0,e[f],f,a));
return d},eb=Array.prototype.reduce?function(a,b,c){return Array.prototype.reduce.call(a,b,c)}:function(a,b,c){var d=c;
bb(a,function(e,f){d=b.call(void 0,d,e,f,a)});
return d};
function fb(a,b){a:{for(var c=a.length,d="string"===typeof a?a.split(""):a,e=0;e<c;e++)if(e in d&&b.call(void 0,d[e],e,a)){b=e;break a}b=-1}return 0>b?null:"string"===typeof a?a.charAt(b):a[b]}
function gb(a,b){b=ab(a,b);var c;(c=0<=b)&&Array.prototype.splice.call(a,b,1);return c}
function hb(a,b){for(var c=1;c<arguments.length;c++){var d=arguments[c];if(Ma(d)){var e=a.length||0,f=d.length||0;a.length=e+f;for(var g=0;g<f;g++)a[e+g]=d[g]}else a.push(d)}}
;function ib(a,b){for(var c in a)b.call(void 0,a[c],c,a)}
function jb(a){var b=kb,c;for(c in b)if(a.call(void 0,b[c],c,b))return c}
function lb(a){for(var b in a)return!1;return!0}
function mb(a,b){if(null!==a&&b in a)throw Error('The object already contains the key "'+b+'"');a[b]=!0}
function nb(a){return null!==a&&"privembed"in a?a.privembed:!1}
function ob(a,b){for(var c in a)if(!(c in b)||a[c]!==b[c])return!1;for(var d in b)if(!(d in a))return!1;return!0}
function pb(a){var b={},c;for(c in a)b[c]=a[c];return b}
function qb(a){if(!a||"object"!==typeof a)return a;if("function"===typeof a.clone)return a.clone();if("undefined"!==typeof Map&&a instanceof Map)return new Map(a);if("undefined"!==typeof Set&&a instanceof Set)return new Set(a);if(a instanceof Date)return new Date(a.getTime());var b=Array.isArray(a)?[]:"function"!==typeof ArrayBuffer||"function"!==typeof ArrayBuffer.isView||!ArrayBuffer.isView(a)||a instanceof DataView?{}:new a.constructor(a.length),c;for(c in a)b[c]=qb(a[c]);return b}
var rb="constructor hasOwnProperty isPrototypeOf propertyIsEnumerable toLocaleString toString valueOf".split(" ");function sb(a,b){for(var c,d,e=1;e<arguments.length;e++){d=arguments[e];for(c in d)a[c]=d[c];for(var f=0;f<rb.length;f++)c=rb[f],Object.prototype.hasOwnProperty.call(d,c)&&(a[c]=d[c])}}
;var tb;function ub(){if(void 0===tb){var a=null,b=C.trustedTypes;if(b&&b.createPolicy){try{a=b.createPolicy("goog#html",{createHTML:Wa,createScript:Wa,createScriptURL:Wa})}catch(c){C.console&&C.console.error(c.message)}tb=a}else tb=a}return tb}
;function vb(a,b){this.j=a===wb&&b||""}
vb.prototype.i=!0;vb.prototype.h=function(){return this.j};
function xb(a){return new vb(wb,a)}
var wb={};xb("");var yb={};function zb(a){this.j=a;this.i=!0}
zb.prototype.toString=function(){return this.j.toString()};
zb.prototype.h=function(){return this.j.toString()};function Ab(a){this.j=a}
Ab.prototype.toString=function(){return this.j+""};
Ab.prototype.i=!0;Ab.prototype.h=function(){return this.j.toString()};
function Bb(a){if(a instanceof Ab&&a.constructor===Ab)return a.j;La(a);return"type_error:TrustedResourceUrl"}
var Cb={};function Db(a){var b=ub();a=b?b.createScriptURL(a):a;return new Ab(a,Cb)}
;var Eb=String.prototype.trim?function(a){return a.trim()}:function(a){return/^[\s\xa0]*([\s\S]*?)[\s\xa0]*$/.exec(a)[1]};
function Fb(a,b){return-1!=a.toLowerCase().indexOf(b.toLowerCase())}
function Gb(a,b){return a<b?-1:a>b?1:0}
;function Hb(a){this.j=a}
Hb.prototype.toString=function(){return this.j.toString()};
Hb.prototype.i=!0;Hb.prototype.h=function(){return this.j.toString()};
function Ib(a){if(a instanceof Hb&&a.constructor===Hb)return a.j;La(a);return"type_error:SafeUrl"}
var Jb;try{new URL("s://g"),Jb=!0}catch(a){Jb=!1}var Kb=Jb;function Lb(a){if(a instanceof Hb)return a;a="object"==typeof a&&a.i?a.h():String(a);a:{var b=a;if(Kb){try{var c=new URL(b)}catch(d){b="https:";break a}b=c.protocol}else b:{c=document.createElement("a");try{c.href=b}catch(d){b=void 0;break b}b=c.protocol;b=":"===b||""===b?"https:":b}}"javascript:"!==b||(a="about:invalid#zClosurez");return new Hb(a,Mb)}
var Mb={},Nb=new Hb("about:invalid#zClosurez",Mb);var Ob,Pb=E("CLOSURE_FLAGS"),Qb=Pb&&Pb[610401301];Ob=null!=Qb?Qb:!1;function Rb(){var a=C.navigator;return a&&(a=a.userAgent)?a:""}
var Sb,Tb=C.navigator;Sb=Tb?Tb.userAgentData||null:null;function Ub(a){return Ob?Sb?Sb.brands.some(function(b){return(b=b.brand)&&-1!=b.indexOf(a)}):!1:!1}
function F(a){return-1!=Rb().indexOf(a)}
;function Vb(){return Ob?!!Sb&&0<Sb.brands.length:!1}
function Wb(){return Vb()?!1:F("Opera")}
function Xb(){return Vb()?!1:F("Trident")||F("MSIE")}
function Yb(){return Vb()?!1:F("Edge")}
function Zb(){return Vb()?Ub("Microsoft Edge"):F("Edg/")}
function $b(){return F("Firefox")||F("FxiOS")}
function ac(){return F("Safari")&&!(bc()||(Vb()?0:F("Coast"))||Wb()||Yb()||Zb()||(Vb()?Ub("Opera"):F("OPR"))||$b()||F("Silk")||F("Android"))}
function bc(){return Vb()?Ub("Chromium"):(F("Chrome")||F("CriOS"))&&!Yb()||F("Silk")}
function cc(){return F("Android")&&!(bc()||$b()||Wb()||F("Silk"))}
function dc(a){var b={};a.forEach(function(c){b[c[0]]=c[1]});
return function(c){return b[c.find(function(d){return d in b})]||""}}
function ec(a){var b=Rb();if("Internet Explorer"===a){if(Xb())if((a=/rv: *([\d\.]*)/.exec(b))&&a[1])b=a[1];else{a="";var c=/MSIE +([\d\.]+)/.exec(b);if(c&&c[1])if(b=/Trident\/(\d.\d)/.exec(b),"7.0"==c[1])if(b&&b[1])switch(b[1]){case "4.0":a="8.0";break;case "5.0":a="9.0";break;case "6.0":a="10.0";break;case "7.0":a="11.0"}else a="7.0";else a=c[1];b=a}else b="";return b}var d=RegExp("([A-Z][\\w ]+)/([^\\s]+)\\s*(?:\\((.*?)\\))?","g");c=[];for(var e;e=d.exec(b);)c.push([e[1],e[2],e[3]||void 0]);b=dc(c);
switch(a){case "Opera":if(Wb())return b(["Version","Opera"]);if(Vb()?Ub("Opera"):F("OPR"))return b(["OPR"]);break;case "Microsoft Edge":if(Yb())return b(["Edge"]);if(Zb())return b(["Edg"]);break;case "Chromium":if(bc())return b(["Chrome","CriOS","HeadlessChrome"])}return"Firefox"===a&&$b()||"Safari"===a&&ac()||"Android Browser"===a&&cc()||"Silk"===a&&F("Silk")?(b=c[2])&&b[1]||"":""}
function fc(a){if(Vb()&&"Silk"!==a){var b=Sb.brands.find(function(c){return c.brand===a});
if(!b||!b.version)return NaN;b=b.version.split(".")}else{b=ec(a);if(""===b)return NaN;b=b.split(".")}return 0===b.length?NaN:Number(b[0])}
;function hc(a){this.j=a;this.i=!0}
hc.prototype.h=function(){return this.j.toString()};
hc.prototype.toString=function(){return this.j.toString()};function ic(a,b){b=b instanceof Hb?b:Lb(b);a.href=Ib(b)}
function jc(a,b){a.rel="stylesheet";Fb("stylesheet","stylesheet")?(a.href=Bb(b).toString(),(b=kc('style[nonce],link[rel="stylesheet"][nonce]',a.ownerDocument&&a.ownerDocument.defaultView))&&a.setAttribute("nonce",b)):a.href=b instanceof Ab?Bb(b).toString():b instanceof Hb?Ib(b):Ib(Lb(b))}
function lc(){return kc("script[nonce]")}
var mc=/^[\w+/_-]+[=]{0,2}$/;function kc(a,b){b=(b||C).document;return b.querySelector?(a=b.querySelector(a))&&(a=a.nonce||a.getAttribute("nonce"))&&mc.test(a)?a:"":""}
;function nc(a){for(var b=0,c=0;c<a.length;++c)b=31*b+a.charCodeAt(c)>>>0;return b}
;var oc=RegExp("^(?:([^:/?#.]+):)?(?://(?:([^\\\\/?#]*)@)?([^\\\\/?#]*?)(?::([0-9]+))?(?=[\\\\/?#]|$))?([^?#]+)?(?:\\?([^#]*))?(?:#([\\s\\S]*))?$");function pc(a){return a?decodeURI(a):a}
function qc(a,b){return b.match(oc)[a]||null}
function rc(a){return pc(qc(3,a))}
function sc(a){var b=a.match(oc);a=b[5];var c=b[6];b=b[7];var d="";a&&(d+=a);c&&(d+="?"+c);b&&(d+="#"+b);return d}
function tc(a){var b=a.indexOf("#");return 0>b?a:a.slice(0,b)}
function uc(a,b){if(!b)return a;var c=a.indexOf("#");0>c&&(c=a.length);var d=a.indexOf("?");if(0>d||d>c){d=c;var e=""}else e=a.substring(d+1,c);a=[a.slice(0,d),e,a.slice(c)];c=a[1];a[1]=b?c?c+"&"+b:b:c;return a[0]+(a[1]?"?"+a[1]:"")+a[2]}
function vc(a,b,c){if(Array.isArray(b))for(var d=0;d<b.length;d++)vc(a,String(b[d]),c);else null!=b&&c.push(a+(""===b?"":"="+encodeURIComponent(String(b))))}
function wc(a,b){var c=[];for(b=b||0;b<a.length;b+=2)vc(a[b],a[b+1],c);return c.join("&")}
function xc(a){var b=[],c;for(c in a)vc(c,a[c],b);return b.join("&")}
function yc(a,b){var c=2==arguments.length?wc(arguments[1],0):wc(arguments,1);return uc(a,c)}
function zc(a,b){b=xc(b);return uc(a,b)}
function Ac(a,b,c){c=null!=c?"="+encodeURIComponent(String(c)):"";return uc(a,b+c)}
function Bc(a,b,c,d){for(var e=c.length;0<=(b=a.indexOf(c,b))&&b<d;){var f=a.charCodeAt(b-1);if(38==f||63==f)if(f=a.charCodeAt(b+e),!f||61==f||38==f||35==f)return b;b+=e+1}return-1}
var Cc=/#|$/,Dc=/[?&]($|#)/;function Ec(a,b){for(var c=a.search(Cc),d=0,e,f=[];0<=(e=Bc(a,d,b,c));)f.push(a.substring(d,e)),d=Math.min(a.indexOf("&",e)+1||c,c);f.push(a.slice(d));return f.join("").replace(Dc,"$1")}
;function Fc(a){this.ed=a}
;function Gc(a,b,c){this.i=a;this.l=b;this.h=c||[];this.sb=new Map}
m=Gc.prototype;m.Sd=function(a){var b=B.apply(1,arguments),c=this.Bc(b);c?c.push(new Fc(a)):this.Dd(a,b)};
m.Dd=function(a){var b=this.ld(B.apply(1,arguments));this.sb.set(b,[new Fc(a)])};
m.Bc=function(){var a=this.ld(B.apply(0,arguments));return this.sb.has(a)?this.sb.get(a):void 0};
m.ke=function(){var a=this.Bc(B.apply(0,arguments));return a&&a.length?a[0]:void 0};
m.clear=function(){this.sb.clear()};
m.ld=function(){var a=B.apply(0,arguments);return a?a.join(","):"key"};function Hc(a,b){Gc.call(this,a,3,b)}
w(Hc,Gc);Hc.prototype.j=function(a){var b=B.apply(1,arguments),c=0,d=this.ke(b);d&&(c=d.ed);this.Dd(c+a,b)};function Ic(a,b){Gc.call(this,a,2,b)}
w(Ic,Gc);Ic.prototype.record=function(a){this.Sd(a,B.apply(1,arguments))};function Jc(a){a&&"function"==typeof a.dispose&&a.dispose()}
;function Kc(a){for(var b=0,c=arguments.length;b<c;++b){var d=arguments[b];Ma(d)?Kc.apply(null,d):Jc(d)}}
;function G(){this.Da=this.Da;this.fa=this.fa}
G.prototype.Da=!1;G.prototype.h=function(){return this.Da};
G.prototype.dispose=function(){this.Da||(this.Da=!0,this.M())};
function Lc(a,b){Mc(a,Ua(Jc,b))}
function Mc(a,b){a.Da?b():(a.fa||(a.fa=[]),a.fa.push(b))}
G.prototype.M=function(){if(this.fa)for(;this.fa.length;)this.fa.shift()()};function Nc(a,b){this.type=a;this.h=this.target=b;this.defaultPrevented=this.j=!1}
Nc.prototype.stopPropagation=function(){this.j=!0};
Nc.prototype.preventDefault=function(){this.defaultPrevented=!0};function Oc(a){var b=E("window.location.href");null==a&&(a='Unknown Error of type "null/undefined"');if("string"===typeof a)return{message:a,name:"Unknown error",lineNumber:"Not available",fileName:b,stack:"Not available"};var c=!1;try{var d=a.lineNumber||a.line||"Not available"}catch(g){d="Not available",c=!0}try{var e=a.fileName||a.filename||a.sourceURL||C.$googDebugFname||b}catch(g){e="Not available",c=!0}b=Pc(a);if(!(!c&&a.lineNumber&&a.fileName&&a.stack&&a.message&&a.name)){c=a.message;if(null==
c){if(a.constructor&&a.constructor instanceof Function){if(a.constructor.name)c=a.constructor.name;else if(c=a.constructor,Qc[c])c=Qc[c];else{c=String(c);if(!Qc[c]){var f=/function\s+([^\(]+)/m.exec(c);Qc[c]=f?f[1]:"[Anonymous]"}c=Qc[c]}c='Unknown Error of type "'+c+'"'}else c="Unknown Error of unknown type";"function"===typeof a.toString&&Object.prototype.toString!==a.toString&&(c+=": "+a.toString())}return{message:c,name:a.name||"UnknownError",lineNumber:d,fileName:e,stack:b||"Not available"}}a.stack=
b;return{message:a.message,name:a.name,lineNumber:a.lineNumber,fileName:a.fileName,stack:a.stack}}
function Pc(a,b){b||(b={});b[Rc(a)]=!0;var c=a.stack||"";(a=a.cause)&&!b[Rc(a)]&&(c+="\nCaused by: ",a.stack&&0==a.stack.indexOf(a.toString())||(c+="string"===typeof a?a:a.message+"\n"),c+=Pc(a,b));return c}
function Rc(a){var b="";"function"===typeof a.toString&&(b=""+a);return b+a.stack}
var Qc={};var Sc=function(){if(!C.addEventListener||!Object.defineProperty)return!1;var a=!1,b=Object.defineProperty({},"passive",{get:function(){a=!0}});
try{var c=function(){};
C.addEventListener("test",c,b);C.removeEventListener("test",c,b)}catch(d){}return a}();function Tc(){return Ob?!!Sb&&!!Sb.platform:!1}
function Uc(){return Tc()?"Android"===Sb.platform:F("Android")}
function Vc(){return F("iPhone")&&!F("iPod")&&!F("iPad")}
function Wc(){return Vc()||F("iPad")||F("iPod")}
function Xc(){return Tc()?"macOS"===Sb.platform:F("Macintosh")}
function Yc(){return Tc()?"Windows"===Sb.platform:F("Windows")}
function Zc(){return Tc()?"Chrome OS"===Sb.platform:F("CrOS")}
function $c(){var a=Rb(),b="";Yc()?(b=/Windows (?:NT|Phone) ([0-9.]+)/,b=(a=b.exec(a))?a[1]:"0.0"):Wc()?(b=/(?:iPhone|iPod|iPad|CPU)\s+OS\s+(\S+)/,b=(a=b.exec(a))&&a[1].replace(/_/g,".")):Xc()?(b=/Mac OS X ([0-9_.]+)/,b=(a=b.exec(a))?a[1].replace(/_/g,"."):"10"):Fb(Rb(),"KaiOS")?(b=/(?:KaiOS)\/(\S+)/i,b=(a=b.exec(a))&&a[1]):Uc()?(b=/Android\s+([^\);]+)(\)|;)/,b=(a=b.exec(a))&&a[1]):Zc()&&(b=/(?:CrOS\s+(?:i686|x86_64)\s+([0-9.]+))/,b=(a=b.exec(a))&&a[1]);a=0;b=Eb(String(b||"")).split(".");for(var c=
Eb("12").split("."),d=Math.max(b.length,c.length),e=0;0==a&&e<d;e++){var f=b[e]||"",g=c[e]||"";do{f=/(\d*)(\D*)(.*)/.exec(f)||["","","",""];g=/(\d*)(\D*)(.*)/.exec(g)||["","","",""];if(0==f[0].length&&0==g[0].length)break;a=Gb(0==f[1].length?0:parseInt(f[1],10),0==g[1].length?0:parseInt(g[1],10))||Gb(0==f[2].length,0==g[2].length)||Gb(f[2],g[2]);f=f[3];g=g[3]}while(0==a)}}
;function ad(a){ad[" "](a);return a}
ad[" "]=function(){};var bd=Wb(),cd=Xb(),dd=F("Edge"),ed=F("Gecko")&&!(Fb(Rb(),"WebKit")&&!F("Edge"))&&!(F("Trident")||F("MSIE"))&&!F("Edge"),fd=Fb(Rb(),"WebKit")&&!F("Edge");fd&&F("Mobile");Xc();Yc();(Tc()?"Linux"===Sb.platform:F("Linux"))||Zc();var gd=C.navigator||null;gd&&(gd.appVersion||"").indexOf("X11");var hd=Uc();Vc();F("iPad");F("iPod");Wc();Fb(Rb(),"KaiOS");function id(){var a=C.document;return a?a.documentMode:void 0}
var jd;a:{var kd="",ld=function(){var a=Rb();if(ed)return/rv:([^\);]+)(\)|;)/.exec(a);if(dd)return/Edge\/([\d\.]+)/.exec(a);if(cd)return/\b(?:MSIE|rv)[: ]([^\);]+)(\)|;)/.exec(a);if(fd)return/WebKit\/(\S+)/.exec(a);if(bd)return/(?:Version)[ \/]?(\S+)/.exec(a)}();
ld&&(kd=ld?ld[1]:"");if(cd){var md=id();if(null!=md&&md>parseFloat(kd)){jd=String(md);break a}}jd=kd}var nd=jd,od;if(C.document&&cd){var pd=id();od=pd?pd:parseInt(nd,10)||void 0}else od=void 0;var qd=od;function rd(a,b){Nc.call(this,a?a.type:"");this.relatedTarget=this.h=this.target=null;this.button=this.screenY=this.screenX=this.clientY=this.clientX=0;this.key="";this.charCode=this.keyCode=0;this.metaKey=this.shiftKey=this.altKey=this.ctrlKey=!1;this.state=null;this.pointerId=0;this.pointerType="";this.i=null;a&&this.init(a,b)}
Va(rd,Nc);var sd={2:"touch",3:"pen",4:"mouse"};
rd.prototype.init=function(a,b){var c=this.type=a.type,d=a.changedTouches&&a.changedTouches.length?a.changedTouches[0]:null;this.target=a.target||a.srcElement;this.h=b;if(b=a.relatedTarget){if(ed){a:{try{ad(b.nodeName);var e=!0;break a}catch(f){}e=!1}e||(b=null)}}else"mouseover"==c?b=a.fromElement:"mouseout"==c&&(b=a.toElement);this.relatedTarget=b;d?(this.clientX=void 0!==d.clientX?d.clientX:d.pageX,this.clientY=void 0!==d.clientY?d.clientY:d.pageY,this.screenX=d.screenX||0,this.screenY=d.screenY||
0):(this.clientX=void 0!==a.clientX?a.clientX:a.pageX,this.clientY=void 0!==a.clientY?a.clientY:a.pageY,this.screenX=a.screenX||0,this.screenY=a.screenY||0);this.button=a.button;this.keyCode=a.keyCode||0;this.key=a.key||"";this.charCode=a.charCode||("keypress"==c?a.keyCode:0);this.ctrlKey=a.ctrlKey;this.altKey=a.altKey;this.shiftKey=a.shiftKey;this.metaKey=a.metaKey;this.pointerId=a.pointerId||0;this.pointerType="string"===typeof a.pointerType?a.pointerType:sd[a.pointerType]||"";this.state=a.state;
this.i=a;a.defaultPrevented&&rd.va.preventDefault.call(this)};
rd.prototype.stopPropagation=function(){rd.va.stopPropagation.call(this);this.i.stopPropagation?this.i.stopPropagation():this.i.cancelBubble=!0};
rd.prototype.preventDefault=function(){rd.va.preventDefault.call(this);var a=this.i;a.preventDefault?a.preventDefault():a.returnValue=!1};var td="closure_listenable_"+(1E6*Math.random()|0);var ud=0;function vd(a,b,c,d,e){this.listener=a;this.proxy=null;this.src=b;this.type=c;this.capture=!!d;this.fc=e;this.key=++ud;this.Rb=this.Zb=!1}
function wd(a){a.Rb=!0;a.listener=null;a.proxy=null;a.src=null;a.fc=null}
;function xd(a){this.src=a;this.listeners={};this.h=0}
xd.prototype.add=function(a,b,c,d,e){var f=a.toString();a=this.listeners[f];a||(a=this.listeners[f]=[],this.h++);var g=yd(a,b,d,e);-1<g?(b=a[g],c||(b.Zb=!1)):(b=new vd(b,this.src,f,!!d,e),b.Zb=c,a.push(b));return b};
xd.prototype.remove=function(a,b,c,d){a=a.toString();if(!(a in this.listeners))return!1;var e=this.listeners[a];b=yd(e,b,c,d);return-1<b?(wd(e[b]),Array.prototype.splice.call(e,b,1),0==e.length&&(delete this.listeners[a],this.h--),!0):!1};
function zd(a,b){var c=b.type;c in a.listeners&&gb(a.listeners[c],b)&&(wd(b),0==a.listeners[c].length&&(delete a.listeners[c],a.h--))}
function yd(a,b,c,d){for(var e=0;e<a.length;++e){var f=a[e];if(!f.Rb&&f.listener==b&&f.capture==!!c&&f.fc==d)return e}return-1}
;var Ad="closure_lm_"+(1E6*Math.random()|0),Bd={},Cd=0;function Dd(a,b,c,d,e){if(d&&d.once)Ed(a,b,c,d,e);else if(Array.isArray(b))for(var f=0;f<b.length;f++)Dd(a,b[f],c,d,e);else c=Fd(c),a&&a[td]?a.listen(b,c,Na(d)?!!d.capture:!!d,e):Gd(a,b,c,!1,d,e)}
function Gd(a,b,c,d,e,f){if(!b)throw Error("Invalid event type");var g=Na(e)?!!e.capture:!!e,h=Hd(a);h||(a[Ad]=h=new xd(a));c=h.add(b,c,d,g,f);if(!c.proxy){d=Id();c.proxy=d;d.src=a;d.listener=c;if(a.addEventListener)Sc||(e=g),void 0===e&&(e=!1),a.addEventListener(b.toString(),d,e);else if(a.attachEvent)a.attachEvent(Jd(b.toString()),d);else if(a.addListener&&a.removeListener)a.addListener(d);else throw Error("addEventListener and attachEvent are unavailable.");Cd++}}
function Id(){function a(c){return b.call(a.src,a.listener,c)}
var b=Kd;return a}
function Ed(a,b,c,d,e){if(Array.isArray(b))for(var f=0;f<b.length;f++)Ed(a,b[f],c,d,e);else c=Fd(c),a&&a[td]?a.l.add(String(b),c,!0,Na(d)?!!d.capture:!!d,e):Gd(a,b,c,!0,d,e)}
function Ld(a,b,c,d,e){if(Array.isArray(b))for(var f=0;f<b.length;f++)Ld(a,b[f],c,d,e);else(d=Na(d)?!!d.capture:!!d,c=Fd(c),a&&a[td])?a.l.remove(String(b),c,d,e):a&&(a=Hd(a))&&(b=a.listeners[b.toString()],a=-1,b&&(a=yd(b,c,d,e)),(c=-1<a?b[a]:null)&&Md(c))}
function Md(a){if("number"!==typeof a&&a&&!a.Rb){var b=a.src;if(b&&b[td])zd(b.l,a);else{var c=a.type,d=a.proxy;b.removeEventListener?b.removeEventListener(c,d,a.capture):b.detachEvent?b.detachEvent(Jd(c),d):b.addListener&&b.removeListener&&b.removeListener(d);Cd--;(c=Hd(b))?(zd(c,a),0==c.h&&(c.src=null,b[Ad]=null)):wd(a)}}}
function Jd(a){return a in Bd?Bd[a]:Bd[a]="on"+a}
function Kd(a,b){if(a.Rb)a=!0;else{b=new rd(b,this);var c=a.listener,d=a.fc||a.src;a.Zb&&Md(a);a=c.call(d,b)}return a}
function Hd(a){a=a[Ad];return a instanceof xd?a:null}
var Nd="__closure_events_fn_"+(1E9*Math.random()>>>0);function Fd(a){if("function"===typeof a)return a;a[Nd]||(a[Nd]=function(b){return a.handleEvent(b)});
return a[Nd]}
;function Od(){G.call(this);this.l=new xd(this);this.Kb=this;this.Qa=null}
Va(Od,G);Od.prototype[td]=!0;m=Od.prototype;m.addEventListener=function(a,b,c,d){Dd(this,a,b,c,d)};
m.removeEventListener=function(a,b,c,d){Ld(this,a,b,c,d)};
function Pd(a,b){var c=a.Qa;if(c){var d=[];for(var e=1;c;c=c.Qa)d.push(c),++e}a=a.Kb;c=b.type||b;"string"===typeof b?b=new Nc(b,a):b instanceof Nc?b.target=b.target||a:(e=b,b=new Nc(c,a),sb(b,e));e=!0;if(d)for(var f=d.length-1;!b.j&&0<=f;f--){var g=b.h=d[f];e=Qd(g,c,!0,b)&&e}b.j||(g=b.h=a,e=Qd(g,c,!0,b)&&e,b.j||(e=Qd(g,c,!1,b)&&e));if(d)for(f=0;!b.j&&f<d.length;f++)g=b.h=d[f],e=Qd(g,c,!1,b)&&e}
m.M=function(){Od.va.M.call(this);this.removeAllListeners();this.Qa=null};
m.listen=function(a,b,c,d){return this.l.add(String(a),b,!1,c,d)};
m.removeAllListeners=function(a){if(this.l){var b=this.l;a=a&&a.toString();var c=0,d;for(d in b.listeners)if(!a||d==a){for(var e=b.listeners[d],f=0;f<e.length;f++)++c,wd(e[f]);delete b.listeners[d];b.h--}b=c}else b=0;return b};
function Qd(a,b,c,d){b=a.l.listeners[String(b)];if(!b)return!0;b=b.concat();for(var e=!0,f=0;f<b.length;++f){var g=b[f];if(g&&!g.Rb&&g.capture==c){var h=g.listener,k=g.fc||g.src;g.Zb&&zd(a.l,g);e=!1!==h.call(k,d)&&e}}return e&&!d.defaultPrevented}
;function Rd(a,b){this.j=a;this.l=b;this.i=0;this.h=null}
Rd.prototype.get=function(){if(0<this.i){this.i--;var a=this.h;this.h=a.next;a.next=null}else a=this.j();return a};
function Sd(a,b){a.l(b);100>a.i&&(a.i++,b.next=a.h,a.h=b)}
;function Td(a,b){return a+Math.random()*(b-a)}
;function Ud(a,b){this.x=void 0!==a?a:0;this.y=void 0!==b?b:0}
m=Ud.prototype;m.clone=function(){return new Ud(this.x,this.y)};
m.equals=function(a){return a instanceof Ud&&(this==a?!0:this&&a?this.x==a.x&&this.y==a.y:!1)};
m.ceil=function(){this.x=Math.ceil(this.x);this.y=Math.ceil(this.y);return this};
m.floor=function(){this.x=Math.floor(this.x);this.y=Math.floor(this.y);return this};
m.round=function(){this.x=Math.round(this.x);this.y=Math.round(this.y);return this};
m.scale=function(a,b){this.x*=a;this.y*="number"===typeof b?b:a;return this};function Vd(a,b){this.width=a;this.height=b}
m=Vd.prototype;m.clone=function(){return new Vd(this.width,this.height)};
m.aspectRatio=function(){return this.width/this.height};
m.isEmpty=function(){return!(this.width*this.height)};
m.ceil=function(){this.width=Math.ceil(this.width);this.height=Math.ceil(this.height);return this};
m.floor=function(){this.width=Math.floor(this.width);this.height=Math.floor(this.height);return this};
m.round=function(){this.width=Math.round(this.width);this.height=Math.round(this.height);return this};
m.scale=function(a,b){this.width*=a;this.height*="number"===typeof b?b:a;return this};function Wd(a){var b=document;return"string"===typeof a?b.getElementById(a):a}
function Xd(a){var b=document;a=String(a);"application/xhtml+xml"===b.contentType&&(a=a.toLowerCase());return b.createElement(a)}
function Yd(a,b){for(var c=0;a;){if(b(a))return a;a=a.parentNode;c++}return null}
;var Zd;function $d(){var a=C.MessageChannel;"undefined"===typeof a&&"undefined"!==typeof window&&window.postMessage&&window.addEventListener&&!F("Presto")&&(a=function(){var e=Xd("IFRAME");e.style.display="none";document.documentElement.appendChild(e);var f=e.contentWindow;e=f.document;e.open();e.close();var g="callImmediate"+Math.random(),h="file:"==f.location.protocol?"*":f.location.protocol+"//"+f.location.host;e=Ta(function(k){if(("*"==h||k.origin==h)&&k.data==g)this.port1.onmessage()},this);
f.addEventListener("message",e,!1);this.port1={};this.port2={postMessage:function(){f.postMessage(g,h)}}});
if("undefined"!==typeof a&&!Xb()){var b=new a,c={},d=c;b.port1.onmessage=function(){if(void 0!==c.next){c=c.next;var e=c.dd;c.dd=null;e()}};
return function(e){d.next={dd:e};d=d.next;b.port2.postMessage(0)}}return function(e){C.setTimeout(e,0)}}
;function ae(a){C.setTimeout(function(){throw a;},0)}
;function be(){this.i=this.h=null}
be.prototype.add=function(a,b){var c=ce.get();c.set(a,b);this.i?this.i.next=c:this.h=c;this.i=c};
be.prototype.remove=function(){var a=null;this.h&&(a=this.h,this.h=this.h.next,this.h||(this.i=null),a.next=null);return a};
var ce=new Rd(function(){return new de},function(a){return a.reset()});
function de(){this.next=this.scope=this.fn=null}
de.prototype.set=function(a,b){this.fn=a;this.scope=b;this.next=null};
de.prototype.reset=function(){this.next=this.scope=this.fn=null};var ee,fe=!1,ge=new be;function he(a,b){ee||ie();fe||(ee(),fe=!0);ge.add(a,b)}
function ie(){if(C.Promise&&C.Promise.resolve){var a=C.Promise.resolve(void 0);ee=function(){a.then(je)}}else ee=function(){var b=je;
"function"!==typeof C.setImmediate||C.Window&&C.Window.prototype&&!Yb()&&C.Window.prototype.setImmediate==C.setImmediate?(Zd||(Zd=$d()),Zd(b)):C.setImmediate(b)}}
function je(){for(var a;a=ge.remove();){try{a.fn.call(a.scope)}catch(b){ae(b)}Sd(ce,a)}fe=!1}
;function ke(a){this.h=0;this.v=void 0;this.l=this.i=this.j=null;this.m=this.s=!1;if(a!=Za)try{var b=this;a.call(void 0,function(c){le(b,2,c)},function(c){le(b,3,c)})}catch(c){le(this,3,c)}}
function me(){this.next=this.context=this.h=this.i=this.child=null;this.j=!1}
me.prototype.reset=function(){this.context=this.h=this.i=this.child=null;this.j=!1};
var ne=new Rd(function(){return new me},function(a){a.reset()});
function oe(a,b,c){var d=ne.get();d.i=a;d.h=b;d.context=c;return d}
function pe(a){if(a instanceof ke)return a;var b=new ke(Za);le(b,2,a);return b}
function qe(a){return new ke(function(b,c){c(a)})}
function re(a,b,c){se(a,b,c,null)||he(Ua(b,a))}
function te(a){return new ke(function(b){var c=a.length,d=[];if(c)for(var e=function(h,k,l){c--;d[h]=k?{fulfilled:!0,value:l}:{fulfilled:!1,reason:l};0==c&&b(d)},f=0,g;f<a.length;f++)g=a[f],re(g,Ua(e,f,!0),Ua(e,f,!1));
else b(d)})}
ke.prototype.then=function(a,b,c){return ue(this,"function"===typeof a?a:null,"function"===typeof b?b:null,c)};
ke.prototype.$goog_Thenable=!0;m=ke.prototype;m.qc=function(a,b){return ue(this,null,a,b)};
m.catch=ke.prototype.qc;m.cancel=function(a){if(0==this.h){var b=new ve(a);he(function(){we(this,b)},this)}};
function we(a,b){if(0==a.h)if(a.j){var c=a.j;if(c.i){for(var d=0,e=null,f=null,g=c.i;g&&(g.j||(d++,g.child==a&&(e=g),!(e&&1<d)));g=g.next)e||(f=g);e&&(0==c.h&&1==d?we(c,b):(f?(d=f,d.next==c.l&&(c.l=d),d.next=d.next.next):xe(c),ye(c,e,3,b)))}a.j=null}else le(a,3,b)}
function ze(a,b){a.i||2!=a.h&&3!=a.h||Ae(a);a.l?a.l.next=b:a.i=b;a.l=b}
function ue(a,b,c,d){var e=oe(null,null,null);e.child=new ke(function(f,g){e.i=b?function(h){try{var k=b.call(d,h);f(k)}catch(l){g(l)}}:f;
e.h=c?function(h){try{var k=c.call(d,h);void 0===k&&h instanceof ve?g(h):f(k)}catch(l){g(l)}}:g});
e.child.j=a;ze(a,e);return e.child}
m.af=function(a){this.h=0;le(this,2,a)};
m.bf=function(a){this.h=0;le(this,3,a)};
function le(a,b,c){0==a.h&&(a===c&&(b=3,c=new TypeError("Promise cannot resolve to itself")),a.h=1,se(c,a.af,a.bf,a)||(a.v=c,a.h=b,a.j=null,Ae(a),3!=b||c instanceof ve||Be(a,c)))}
function se(a,b,c,d){if(a instanceof ke)return ze(a,oe(b||Za,c||null,d)),!0;if(a)try{var e=!!a.$goog_Thenable}catch(g){e=!1}else e=!1;if(e)return a.then(b,c,d),!0;if(Na(a))try{var f=a.then;if("function"===typeof f)return Ce(a,f,b,c,d),!0}catch(g){return c.call(d,g),!0}return!1}
function Ce(a,b,c,d,e){function f(k){h||(h=!0,d.call(e,k))}
function g(k){h||(h=!0,c.call(e,k))}
var h=!1;try{b.call(a,g,f)}catch(k){f(k)}}
function Ae(a){a.s||(a.s=!0,he(a.de,a))}
function xe(a){var b=null;a.i&&(b=a.i,a.i=b.next,b.next=null);a.i||(a.l=null);return b}
m.de=function(){for(var a;a=xe(this);)ye(this,a,this.h,this.v);this.s=!1};
function ye(a,b,c,d){if(3==c&&b.h&&!b.j)for(;a&&a.m;a=a.j)a.m=!1;if(b.child)b.child.j=null,De(b,c,d);else try{b.j?b.i.call(b.context):De(b,c,d)}catch(e){Ee.call(null,e)}Sd(ne,b)}
function De(a,b,c){2==b?a.i.call(a.context,c):a.h&&a.h.call(a.context,c)}
function Be(a,b){a.m=!0;he(function(){a.m&&Ee.call(null,b)})}
var Ee=ae;function ve(a){Xa.call(this,a)}
Va(ve,Xa);ve.prototype.name="cancel";function Fe(a,b){Od.call(this);this.j=a||1;this.i=b||C;this.m=Ta(this.Ze,this);this.s=Date.now()}
Va(Fe,Od);m=Fe.prototype;m.enabled=!1;m.Ca=null;m.setInterval=function(a){this.j=a;this.Ca&&this.enabled?(this.stop(),this.start()):this.Ca&&this.stop()};
m.Ze=function(){if(this.enabled){var a=Date.now()-this.s;0<a&&a<.8*this.j?this.Ca=this.i.setTimeout(this.m,this.j-a):(this.Ca&&(this.i.clearTimeout(this.Ca),this.Ca=null),Pd(this,"tick"),this.enabled&&(this.stop(),this.start()))}};
m.start=function(){this.enabled=!0;this.Ca||(this.Ca=this.i.setTimeout(this.m,this.j),this.s=Date.now())};
m.stop=function(){this.enabled=!1;this.Ca&&(this.i.clearTimeout(this.Ca),this.Ca=null)};
m.M=function(){Fe.va.M.call(this);this.stop();delete this.i};
function Ge(a,b,c){if("function"===typeof a)c&&(a=Ta(a,c));else if(a&&"function"==typeof a.handleEvent)a=Ta(a.handleEvent,a);else throw Error("Invalid listener argument");return 2147483647<Number(b)?-1:C.setTimeout(a,b||0)}
;function He(a){G.call(this);this.P=a;this.j=new Map;this.v=new Set;this.l=0;this.m=100;this.flushInterval=3E4;this.i=new Fe(this.flushInterval);this.i.listen("tick",this.qb,!1,this);Lc(this,this.i);this.s=!1}
w(He,G);m=He.prototype;m.sendIsolatedPayload=function(a){this.s=a;this.m=1};
function Ie(a){a.i.enabled||a.i.start();a.l++;a.l>=a.m&&a.qb()}
m.qb=function(){var a=this.j.values();a=[].concat(ja(a)).filter(function(b){return b.sb.size});
a.length&&this.P.flush(a,this.s);Je(a);this.l=0;this.i.enabled&&this.i.stop()};
m.Yc=function(a){var b=B.apply(1,arguments);this.j.has(a)||this.j.set(a,new Hc(a,b))};
m.Zc=function(a){var b=B.apply(1,arguments);this.j.has(a)||this.j.set(a,new Ic(a,b))};
function Ke(a,b){return a.v.has(b)?void 0:a.j.get(b)}
m.sc=function(a){this.Pd.apply(this,[a,1].concat(ja(B.apply(1,arguments))))};
m.Pd=function(a,b){var c=B.apply(2,arguments),d=Ke(this,a);d&&d instanceof Hc&&(d.j(b,c),Ie(this))};
m.record=function(a,b){var c=B.apply(2,arguments),d=Ke(this,a);d&&d instanceof Ic&&(d.record(b,c),Ie(this))};
function Je(a){for(var b=0;b<a.length;b++)a[b].clear()}
;function Le(a){this.h=a;this.h.Yc("/client_streamz/bg/fiec",{vb:3,ub:"rk"},{vb:2,ub:"ec"},{vb:3,ub:"em"})}
function Me(a,b,c,d){a.h.sc("/client_streamz/bg/fiec",b,c,d)}
function Ne(a){this.h=a;this.h.Zc("/client_streamz/bg/fil",{vb:3,ub:"rk"})}
Ne.prototype.record=function(a,b){this.h.record("/client_streamz/bg/fil",a,b)};
function Oe(a){this.h=a;this.h.Yc("/client_streamz/bg/fsc",{vb:3,ub:"rk"})}
function Pe(a){this.h=a;this.h.Zc("/client_streamz/bg/fsl",{vb:3,ub:"rk"})}
Pe.prototype.record=function(a,b){this.h.record("/client_streamz/bg/fsl",a,b)};var Qe={toString:function(a){var b=[],c=0;a-=-2147483648;b[c++]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".charAt(a%52);for(a=Math.floor(a/52);0<a;)b[c++]="abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789".charAt(a%62),a=Math.floor(a/62);return b.join("")}};function Re(a){function b(){c-=d;c-=e;c^=e>>>13;d-=e;d-=c;d^=c<<8;e-=c;e-=d;e^=d>>>13;c-=d;c-=e;c^=e>>>12;d-=e;d-=c;d^=c<<16;e-=c;e-=d;e^=d>>>5;c-=d;c-=e;c^=e>>>3;d-=e;d-=c;d^=c<<10;e-=c;e-=d;e^=d>>>15}
a=Se(a);for(var c=2654435769,d=2654435769,e=314159265,f=a.length,g=f,h=0;12<=g;g-=12,h+=12)c+=Te(a,h),d+=Te(a,h+4),e+=Te(a,h+8),b();e+=f;switch(g){case 11:e+=a[h+10]<<24;case 10:e+=a[h+9]<<16;case 9:e+=a[h+8]<<8;case 8:d+=a[h+7]<<24;case 7:d+=a[h+6]<<16;case 6:d+=a[h+5]<<8;case 5:d+=a[h+4];case 4:c+=a[h+3]<<24;case 3:c+=a[h+2]<<16;case 2:c+=a[h+1]<<8;case 1:c+=a[h+0]}b();return Qe.toString(e)}
function Se(a){for(var b=[],c=0;c<a.length;c++)b.push(a.charCodeAt(c));return b}
function Te(a,b){return a[b+0]+(a[b+1]<<8)+(a[b+2]<<16)+(a[b+3]<<24)}
;$b();var Ue=Vc()||F("iPod"),Ve=F("iPad");cc();bc();var We=ac()&&!Wc();var Xe={},Ye=null;function Ze(a,b){Ma(a);void 0===b&&(b=0);$e();b=Xe[b];for(var c=Array(Math.floor(a.length/3)),d=b[64]||"",e=0,f=0;e<a.length-2;e+=3){var g=a[e],h=a[e+1],k=a[e+2],l=b[g>>2];g=b[(g&3)<<4|h>>4];h=b[(h&15)<<2|k>>6];k=b[k&63];c[f++]=""+l+g+h+k}l=0;k=d;switch(a.length-e){case 2:l=a[e+1],k=b[(l&15)<<2]||d;case 1:a=a[e],c[f]=""+b[a>>2]+b[(a&3)<<4|l>>4]+k+d}return c.join("")}
function af(a){var b=a.length,c=3*b/4;c%3?c=Math.floor(c):-1!="=.".indexOf(a[b-1])&&(c=-1!="=.".indexOf(a[b-2])?c-2:c-1);var d=new Uint8Array(c),e=0;bf(a,function(f){d[e++]=f});
return e!==c?d.subarray(0,e):d}
function bf(a,b){function c(k){for(;d<a.length;){var l=a.charAt(d++),n=Ye[l];if(null!=n)return n;if(!/^[\s\xa0]*$/.test(l))throw Error("Unknown base64 encoding at char: "+l);}return k}
$e();for(var d=0;;){var e=c(-1),f=c(0),g=c(64),h=c(64);if(64===h&&-1===e)break;b(e<<2|f>>4);64!=g&&(b(f<<4&240|g>>2),64!=h&&b(g<<6&192|h))}}
function $e(){if(!Ye){Ye={};for(var a="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".split(""),b=["+/=","+/","-_=","-_.","-_"],c=0;5>c;c++){var d=a.concat(b[c].split(""));Xe[c]=d;for(var e=0;e<d.length;e++){var f=d[e];void 0===Ye[f]&&(Ye[f]=e)}}}}
;var cf="undefined"!==typeof Uint8Array,df=!cd&&"function"===typeof btoa;function ef(a){if(!df)return Ze(a);for(var b="",c=0,d=a.length-10240;c<d;)b+=String.fromCharCode.apply(null,a.subarray(c,c+=10240));b+=String.fromCharCode.apply(null,c?a.subarray(c):a);return btoa(b)}
var ff=/[-_.]/g,gf={"-":"+",_:"/",".":"="};function hf(a){return gf[a]||""}
function jf(a){return cf&&null!=a&&a instanceof Uint8Array}
var kf={};var lf;function mf(a){if(a!==kf)throw Error("illegal external caller");}
function nf(a,b){mf(b);this.value_=a;if(null!=a&&0===a.length)throw Error("ByteString should be constructed with non-empty values");}
nf.prototype.isEmpty=function(){return null==this.value_};
nf.prototype.sizeBytes=function(){mf(kf);var a=this.value_;if(null!=a&&!jf(a))if("string"===typeof a)if(df){ff.test(a)&&(a=a.replace(ff,hf));a=atob(a);for(var b=new Uint8Array(a.length),c=0;c<a.length;c++)b[c]=a.charCodeAt(c);a=b}else a=af(a);else La(a),a=null;return(a=null==a?a:this.value_=a)?a.length:0};function of(a){return Array.prototype.slice.call(a)}
;var pf="function"===typeof Symbol&&"symbol"===typeof Symbol()?Symbol():void 0;Math.max.apply(Math,ja(Object.values({Cf:1,Bf:2,Af:4,Ef:8,Df:16,sf:32,Ff:64,yf:128,xf:256,zf:512})));var qf=pf?function(a,b){a[pf]|=b}:function(a,b){void 0!==a.Aa?a.Aa|=b:Object.defineProperties(a,{Aa:{value:b,
configurable:!0,writable:!0,enumerable:!1}})};
function rf(a){var b=sf(a);1!==(b&1)&&(Object.isFrozen(a)&&(a=of(a)),tf(a,b|1));return a}
var uf=pf?function(a,b){a[pf]&=~b}:function(a,b){void 0!==a.Aa&&(a.Aa&=~b)},sf=pf?function(a){return a[pf]|0}:function(a){return a.Aa|0},vf=pf?function(a){return a[pf]}:function(a){return a.Aa},tf=pf?function(a,b){a[pf]=b}:function(a,b){void 0!==a.Aa?a.Aa=b:Object.defineProperties(a,{Aa:{value:b,
configurable:!0,writable:!0,enumerable:!1}})};
function wf(a,b){Object.isFrozen(a)&&(a=of(a));tf(a,b);return a}
function xf(a){qf(a,1);return a}
function yf(a,b){tf(b,(a|0)&-51)}
function zf(a,b){tf(b,(a|18)&-41)}
function Af(a){a=a>>10&1023;return 0===a?536870912:a}
;var Bf={};function Cf(a){return null!==a&&"object"===typeof a&&!Array.isArray(a)&&a.constructor===Object}
var Df,Ef,Ff=[];tf(Ff,23);Ef=Object.freeze(Ff);function Gf(a){if(a&2)throw Error();}
;function Hf(a){return a.displayName||a.name||"unknown type name"}
function If(a){if(null!=a){if("boolean"!==typeof a)throw Error("Expected boolean but got "+La(a)+": "+a);a=!!a}return a}
function Jf(a){La(a);return a}
function Kf(a){if(null!=a&&"string"!==typeof a)throw Error();return a}
function Lf(a,b){if(!(a instanceof b))throw Error("Expected instanceof "+Hf(b)+" but got "+(a&&Hf(a.constructor)));}
function Mf(a,b,c){var d=!1;if(null!=a&&"object"===typeof a&&!(d=Array.isArray(a))&&a.Lc===Bf)return a;if(d){var e=d=sf(a);0===e&&(e|=c&16);e|=c&2;e!==d&&tf(a,e);return new b(a)}}
;var Nf;function Of(a,b){sf(b);Nf=b;a=new a(b);Nf=void 0;return a}
function Pf(a,b,c){null==a&&(a=Nf);Nf=void 0;if(null==a){var d=48;c?(a=[c],d|=256):a=[];b&&(d=d&-1047553|(b&1023)<<10)}else{if(!Array.isArray(a))throw Error();d=sf(a);if(d&32)return a;d|=32;if(c&&(d|=256,c!==a[0]))throw Error();a:{c=a;var e=c.length;if(e){var f=e-1,g=c[f];if(Cf(g)){d|=128;b=(d>>8&1)-1;e=f-b;1024<=e&&(Qf(c,b,g),e=1023);d=d&-1047553|(e&1023)<<10;break a}}b&&(g=(d>>8&1)-1,b=Math.max(b,e-g),1024<b&&(Qf(c,g,{}),d|=128,b=1023),d=d&-1047553|(b&1023)<<10)}}tf(a,d);return a}
function Qf(a,b,c){for(var d=1023+b,e=a.length,f=d;f<e;f++){var g=a[f];null!=g&&g!==c&&(c[f-b]=g)}a.length=d+1;a[d]=c}
;function Rf(a,b){return Sf(b)}
function Sf(a){switch(typeof a){case "number":return isFinite(a)?a:String(a);case "boolean":return a?1:0;case "object":if(a&&!Array.isArray(a)){if(jf(a))return ef(a);if(a instanceof nf){var b=a.value_;return null==b?"":"string"===typeof b?b:a.value_=ef(b)}}}return a}
;function Tf(a,b,c){a=of(a);var d=a.length,e=b&128?a[d-1]:void 0;d+=e?-1:0;for(b=b&256?1:0;b<d;b++)a[b]=c(a[b]);if(e){b=a[b]={};for(var f in e)b[f]=c(e[f])}return a}
function Uf(a,b,c,d,e,f){if(null!=a){if(Array.isArray(a))a=e&&0==a.length&&sf(a)&1?void 0:f&&sf(a)&2?a:Vf(a,b,c,void 0!==d,e,f);else if(Cf(a)){var g={},h;for(h in a)g[h]=Uf(a[h],b,c,d,e,f);a=g}else a=b(a,d);return a}}
function Vf(a,b,c,d,e,f){var g=d||c?sf(a):0;d=d?!!(g&16):void 0;a=of(a);for(var h=0;h<a.length;h++)a[h]=Uf(a[h],b,c,d,e,f);c&&c(g,a);return a}
function Wf(a){return a.Lc===Bf?a.toJSON():Sf(a)}
;function Xf(a,b,c){c=void 0===c?zf:c;if(null!=a){if(cf&&a instanceof Uint8Array)return b?a:new Uint8Array(a);if(Array.isArray(a)){var d=sf(a);if(d&2)return a;if(b&&!(d&32)&&(d&16||0===d))return tf(a,d|18),a;a=Vf(a,Xf,d&4?zf:c,!0,!1,!0);b=sf(a);b&4&&b&2&&Object.freeze(a);return a}a.Lc===Bf&&(b=a.D,c=vf(b),a=c&2?a:Yf(a,b,c,!0));return a}}
function Yf(a,b,c,d){var e=d||c&2?zf:yf,f=!!(c&16);b=Tf(b,c,function(g){return Xf(g,f,e)});
qf(b,16|(d?2:0));return Of(a.constructor,b)}
function Zf(a){var b=a.D,c=vf(b);return c&2?Yf(a,b,c,!1):a}
;function $f(a,b){a=a.D;return ag(a,vf(a),b)}
function ag(a,b,c,d){if(-1===c)return null;if(c>=Af(b)){if(b&128)return a[a.length-1][c]}else{var e=a.length;if(d&&b&128&&(d=a[e-1][c],null!=d))return d;b=c+((b>>8&1)-1);if(b<e)return a[b]}}
function K(a,b,c,d){var e=a.D,f=vf(e);Gf(f);bg(e,f,b,c,d);return a}
function bg(a,b,c,d,e){Cf(d);var f=Af(b);if(c>=f||e){e=b;if(b&128)f=a[a.length-1];else{if(null==d)return;f=a[f+((b>>8&1)-1)]={};e|=128}f[c]=d;e&=-513;e!==b&&tf(a,e)}else a[c+((b>>8&1)-1)]=d,b&128&&(d=a[a.length-1],c in d&&delete d[c]),b&512&&tf(a,b&-513)}
function cg(a){return void 0!==dg(a,eg,11,!1)}
function fg(a,b,c,d){a=a.D;var e=vf(a);Gf(e);for(var f=0,g=0;g<c.length;g++){var h=c[g];null!=ag(a,e,h)&&(0!==f&&bg(a,e,f),f=h)}(c=f)&&c!==b&&null!=d&&bg(a,e,c);bg(a,e,b,d)}
function dg(a,b,c,d){a=a.D;var e=vf(a),f=ag(a,e,c,d);b=Mf(f,b,e);b!==f&&null!=b&&bg(a,e,c,b,d);return b}
function gg(a,b,c,d){d=void 0===d?!1:d;b=dg(a,b,c,d);if(null==b)return b;a=a.D;var e=vf(a);if(!(e&2)){var f=Zf(b);f!==b&&(b=f,bg(a,e,c,b,d))}return b}
function hg(a,b,c,d){null!=d?Lf(d,b):d=void 0;return K(a,c,d)}
function ig(a,b,c,d){var e=a.D,f=vf(e);Gf(f);if(null!=d){for(var g=!!d.length,h=0;h<d.length;h++){var k=d[h];Lf(k,b);g=g&&!(sf(k.D)&2)}b=sf(d);h=b|1;h=(g?h|8:h&-9)|4;h!=b&&(d=wf(d,h))}null==d&&(d=void 0);bg(e,f,c,d);return a}
function jg(){var a=new kg;return K(a,1,1)}
;function lg(a,b,c){this.D=Pf(a,b,c)}
m=lg.prototype;m.toJSON=function(){if(Df)var a=mg(this,this.D,!1);else a=Vf(this.D,Wf,void 0,void 0,!1,!1),a=mg(this,a,!0);return a};
m.serialize=function(){Df=!0;try{return JSON.stringify(this.toJSON(),Rf)}finally{Df=!1}};
m.clone=function(){var a=this.D;return Yf(this,a,vf(a),!1)};
m.Lc=Bf;m.toString=function(){return mg(this,this.D,!1).toString()};
function mg(a,b,c){var d=a.constructor.Va,e=vf(c?a.D:b),f=Af(e);e=!1;if(d){if(!c){b=of(b);var g;if(b.length&&Cf(g=b[b.length-1]))for(e=0;e<d.length;e++)if(d[e]>=f){Object.assign(b[b.length-1]={},g);break}e=!0}g=b;c=!c;f=vf(a.D);a=Af(f);f=(f>>8&1)-1;for(var h,k,l=0;l<d.length;l++)if(k=d[l],k<a){k+=f;var n=g[k];null==n?g[k]=c?Ef:xf([]):c&&n!==Ef&&rf(n)}else h||(n=void 0,g.length&&Cf(n=g[g.length-1])?h=n:g.push(h={})),n=h[k],null==h[k]?h[k]=c?Ef:xf([]):c&&n!==Ef&&rf(n)}d=b.length;if(!d)return b;var p;
if(Cf(h=b[d-1])){a:{var t=h;g={};c=!1;for(var r in t)a=t[r],Array.isArray(a)&&a!=a&&(c=!0),null!=a?g[r]=a:c=!0;if(c){for(var x in g){t=g;break a}t=null}}t!=h&&(p=!0);d--}for(;0<d;d--){h=b[d-1];if(null!=h)break;var y=!0}if(!p&&!y)return b;var z;e?z=b:z=Array.prototype.slice.call(b,0,d);b=z;e&&(b.length=d);t&&b.push(t);return b}
;function ng(a){this.D=Pf(a)}
w(ng,lg);var og=[1,2,3];function pg(a){this.D=Pf(a)}
w(pg,lg);var qg=[1,2,3];function rg(a){this.D=Pf(a)}
w(rg,lg);rg.Va=[1];function sg(a){this.D=Pf(a)}
w(sg,lg);sg.Va=[3,6,4];function tg(a){this.D=Pf(a)}
w(tg,lg);tg.Va=[1];function ug(a){if(!a)return"";if(/^about:(?:blank|srcdoc)$/.test(a))return window.origin||"";a.startsWith("blob:")&&(a=a.substring(5));a=a.split("#")[0].split("?")[0];a=a.toLowerCase();0==a.indexOf("//")&&(a=window.location.protocol+a);/^[\w\-]*:\/\//.test(a)||(a=window.location.href);var b=a.substring(a.indexOf("://")+3),c=b.indexOf("/");-1!=c&&(b=b.substring(0,c));c=a.substring(0,a.indexOf("://"));if(!c)throw Error("URI is missing protocol: "+a);if("http"!==c&&"https"!==c&&"chrome-extension"!==
c&&"moz-extension"!==c&&"file"!==c&&"android-app"!==c&&"chrome-search"!==c&&"chrome-untrusted"!==c&&"chrome"!==c&&"app"!==c&&"devtools"!==c)throw Error("Invalid URI scheme in origin: "+c);a="";var d=b.indexOf(":");if(-1!=d){var e=b.substring(d+1);b=b.substring(0,d);if("http"===c&&"80"!==e||"https"===c&&"443"!==e)a=":"+e}return c+"://"+b+a}
;function vg(){function a(){e[0]=1732584193;e[1]=4023233417;e[2]=2562383102;e[3]=271733878;e[4]=3285377520;n=l=0}
function b(p){for(var t=g,r=0;64>r;r+=4)t[r/4]=p[r]<<24|p[r+1]<<16|p[r+2]<<8|p[r+3];for(r=16;80>r;r++)p=t[r-3]^t[r-8]^t[r-14]^t[r-16],t[r]=(p<<1|p>>>31)&4294967295;p=e[0];var x=e[1],y=e[2],z=e[3],H=e[4];for(r=0;80>r;r++){if(40>r)if(20>r){var I=z^x&(y^z);var L=1518500249}else I=x^y^z,L=1859775393;else 60>r?(I=x&y|z&(x|y),L=2400959708):(I=x^y^z,L=3395469782);I=((p<<5|p>>>27)&4294967295)+I+H+L+t[r]&4294967295;H=z;z=y;y=(x<<30|x>>>2)&4294967295;x=p;p=I}e[0]=e[0]+p&4294967295;e[1]=e[1]+x&4294967295;e[2]=
e[2]+y&4294967295;e[3]=e[3]+z&4294967295;e[4]=e[4]+H&4294967295}
function c(p,t){if("string"===typeof p){p=unescape(encodeURIComponent(p));for(var r=[],x=0,y=p.length;x<y;++x)r.push(p.charCodeAt(x));p=r}t||(t=p.length);r=0;if(0==l)for(;r+64<t;)b(p.slice(r,r+64)),r+=64,n+=64;for(;r<t;)if(f[l++]=p[r++],n++,64==l)for(l=0,b(f);r+64<t;)b(p.slice(r,r+64)),r+=64,n+=64}
function d(){var p=[],t=8*n;56>l?c(h,56-l):c(h,64-(l-56));for(var r=63;56<=r;r--)f[r]=t&255,t>>>=8;b(f);for(r=t=0;5>r;r++)for(var x=24;0<=x;x-=8)p[t++]=e[r]>>x&255;return p}
for(var e=[],f=[],g=[],h=[128],k=1;64>k;++k)h[k]=0;var l,n;a();return{reset:a,update:c,digest:d,Zd:function(){for(var p=d(),t="",r=0;r<p.length;r++)t+="0123456789ABCDEF".charAt(Math.floor(p[r]/16))+"0123456789ABCDEF".charAt(p[r]%16);return t}}}
;function wg(a,b,c){var d=String(C.location.href);return d&&a&&b?[b,xg(ug(d),a,c||null)].join(" "):null}
function xg(a,b,c){var d=[],e=[];if(1==(Array.isArray(c)?2:1))return e=[b,a],bb(d,function(h){e.push(h)}),yg(e.join(" "));
var f=[],g=[];bb(c,function(h){g.push(h.key);f.push(h.value)});
c=Math.floor((new Date).getTime()/1E3);e=0==f.length?[c,b,a]:[f.join(":"),c,b,a];bb(d,function(h){e.push(h)});
a=yg(e.join(" "));a=[c,a];0==g.length||a.push(g.join(""));return a.join("_")}
function yg(a){var b=vg();b.update(a);return b.Zd().toLowerCase()}
;var zg={};function Ag(a){this.h=a||{cookie:""}}
m=Ag.prototype;m.isEnabled=function(){if(!C.navigator.cookieEnabled)return!1;if(!this.isEmpty())return!0;this.set("TESTCOOKIESENABLED","1",{jc:60});if("1"!==this.get("TESTCOOKIESENABLED"))return!1;this.remove("TESTCOOKIESENABLED");return!0};
m.set=function(a,b,c){var d=!1;if("object"===typeof c){var e=c.Wf;d=c.secure||!1;var f=c.domain||void 0;var g=c.path||void 0;var h=c.jc}if(/[;=\s]/.test(a))throw Error('Invalid cookie name "'+a+'"');if(/[;\r\n]/.test(b))throw Error('Invalid cookie value "'+b+'"');void 0===h&&(h=-1);c=f?";domain="+f:"";g=g?";path="+g:"";d=d?";secure":"";h=0>h?"":0==h?";expires="+(new Date(1970,1,1)).toUTCString():";expires="+(new Date(Date.now()+1E3*h)).toUTCString();this.h.cookie=a+"="+b+c+g+h+d+(null!=e?";samesite="+
e:"")};
m.get=function(a,b){for(var c=a+"=",d=(this.h.cookie||"").split(";"),e=0,f;e<d.length;e++){f=Eb(d[e]);if(0==f.lastIndexOf(c,0))return f.slice(c.length);if(f==a)return""}return b};
m.remove=function(a,b,c){var d=void 0!==this.get(a);this.set(a,"",{jc:0,path:b,domain:c});return d};
m.Ec=function(){return Bg(this).keys};
m.isEmpty=function(){return!this.h.cookie};
m.clear=function(){for(var a=Bg(this).keys,b=a.length-1;0<=b;b--)this.remove(a[b])};
function Bg(a){a=(a.h.cookie||"").split(";");for(var b=[],c=[],d,e,f=0;f<a.length;f++)e=Eb(a[f]),d=e.indexOf("="),-1==d?(b.push(""),c.push(e)):(b.push(e.substring(0,d)),c.push(e.substring(d+1)));return{keys:b,values:c}}
var Cg=new Ag("undefined"==typeof document?null:document);function Dg(a){return!!zg.FPA_SAMESITE_PHASE2_MOD||!(void 0===a||!a)}
function Eg(a){a=void 0===a?!1:a;var b=C.__SAPISID||C.__APISID||C.__3PSAPISID||C.__OVERRIDE_SID;Dg(a)&&(b=b||C.__1PSAPISID);if(b)return!0;if("undefined"!==typeof document){var c=new Ag(document);b=c.get("SAPISID")||c.get("APISID")||c.get("__Secure-3PAPISID")||c.get("SID")||c.get("OSID");Dg(a)&&(b=b||c.get("__Secure-1PAPISID"))}return!!b}
function Gg(a,b,c,d){(a=C[a])||"undefined"===typeof document||(a=(new Ag(document)).get(b));return a?wg(a,c,d):null}
function Hg(a,b){b=void 0===b?!1:b;var c=ug(String(C.location.href)),d=[];if(Eg(b)){c=0==c.indexOf("https:")||0==c.indexOf("chrome-extension:")||0==c.indexOf("moz-extension:");var e=c?C.__SAPISID:C.__APISID;e||"undefined"===typeof document||(e=new Ag(document),e=e.get(c?"SAPISID":"APISID")||e.get("__Secure-3PAPISID"));(e=e?wg(e,c?"SAPISIDHASH":"APISIDHASH",a):null)&&d.push(e);c&&Dg(b)&&((b=Gg("__1PSAPISID","__Secure-1PAPISID","SAPISID1PHASH",a))&&d.push(b),(a=Gg("__3PSAPISID","__Secure-3PAPISID",
"SAPISID3PHASH",a))&&d.push(a))}return 0==d.length?null:d.join(" ")}
;function Ig(a){this.D=Pf(a)}
w(Ig,lg);Ig.Va=[2];function Jg(a){this.h=this.i=this.j=a}
Jg.prototype.reset=function(){this.h=this.i=this.j};
Jg.prototype.getValue=function(){return this.i};function Kg(){}
Kg.prototype.serialize=function(a){var b=[];Lg(this,a,b);return b.join("")};
function Lg(a,b,c){if(null==b)c.push("null");else{if("object"==typeof b){if(Array.isArray(b)){var d=b;b=d.length;c.push("[");for(var e="",f=0;f<b;f++)c.push(e),Lg(a,d[f],c),e=",";c.push("]");return}if(b instanceof String||b instanceof Number||b instanceof Boolean)b=b.valueOf();else{c.push("{");e="";for(d in b)Object.prototype.hasOwnProperty.call(b,d)&&(f=b[d],"function"!=typeof f&&(c.push(e),Mg(d,c),c.push(":"),Lg(a,f,c),e=","));c.push("}");return}}switch(typeof b){case "string":Mg(b,c);break;case "number":c.push(isFinite(b)&&
!isNaN(b)?String(b):"null");break;case "boolean":c.push(String(b));break;case "function":c.push("null");break;default:throw Error("Unknown type: "+typeof b);}}}
var Ng={'"':'\\"',"\\":"\\\\","/":"\\/","\b":"\\b","\f":"\\f","\n":"\\n","\r":"\\r","\t":"\\t","\v":"\\u000b"},Og=/\uffff/.test("\uffff")?/[\\"\x00-\x1f\x7f-\uffff]/g:/[\\"\x00-\x1f\x7f-\xff]/g;function Mg(a,b){b.push('"',a.replace(Og,function(c){var d=Ng[c];d||(d="\\u"+(c.charCodeAt(0)|65536).toString(16).slice(1),Ng[c]=d);return d}),'"')}
;function Pg(){}
Pg.prototype.h=null;Pg.prototype.getOptions=function(){var a;(a=this.h)||(a={},Qg(this)&&(a[0]=!0,a[1]=!0),a=this.h=a);return a};var Rg;function Sg(){}
Va(Sg,Pg);function Tg(a){return(a=Qg(a))?new ActiveXObject(a):new XMLHttpRequest}
function Qg(a){if(!a.i&&"undefined"==typeof XMLHttpRequest&&"undefined"!=typeof ActiveXObject){for(var b=["MSXML2.XMLHTTP.6.0","MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP","Microsoft.XMLHTTP"],c=0;c<b.length;c++){var d=b[c];try{return new ActiveXObject(d),a.i=d}catch(e){}}throw Error("Could not create ActiveXObject. ActiveX might be disabled, or MSXML might not be installed");}return a.i}
Rg=new Sg;function Ug(a){Od.call(this);this.headers=new Map;this.W=a||null;this.i=!1;this.V=this.H=null;this.m=this.ja="";this.j=this.ba=this.v=this.Z=!1;this.s=0;this.P=null;this.Ha="";this.wa=this.xa=!1}
Va(Ug,Od);var Vg=/^https?$/i,Wg=["POST","PUT"],Xg=[];function Yg(a,b,c,d,e,f,g){var h=new Ug;Xg.push(h);b&&h.listen("complete",b);h.l.add("ready",h.Yd,!0,void 0,void 0);f&&(h.s=Math.max(0,f));g&&(h.xa=g);h.send(a,c,d,e)}
m=Ug.prototype;m.Yd=function(){this.dispose();gb(Xg,this)};
m.send=function(a,b,c,d){if(this.H)throw Error("[goog.net.XhrIo] Object is active with another request="+this.ja+"; newUri="+a);b=b?b.toUpperCase():"GET";this.ja=a;this.m="";this.Z=!1;this.i=!0;this.H=this.W?Tg(this.W):Tg(Rg);this.V=this.W?this.W.getOptions():Rg.getOptions();this.H.onreadystatechange=Ta(this.ud,this);try{this.getStatus(),this.ba=!0,this.H.open(b,String(a),!0),this.ba=!1}catch(g){this.getStatus();Zg(this,g);return}a=c||"";c=new Map(this.headers);if(d)if(Object.getPrototypeOf(d)===
Object.prototype)for(var e in d)c.set(e,d[e]);else if("function"===typeof d.keys&&"function"===typeof d.get){e=v(d.keys());for(var f=e.next();!f.done;f=e.next())f=f.value,c.set(f,d.get(f))}else throw Error("Unknown input type for opt_headers: "+String(d));d=Array.from(c.keys()).find(function(g){return"content-type"==g.toLowerCase()});
e=C.FormData&&a instanceof C.FormData;!(0<=ab(Wg,b))||d||e||c.set("Content-Type","application/x-www-form-urlencoded;charset=utf-8");b=v(c);for(d=b.next();!d.done;d=b.next())c=v(d.value),d=c.next().value,c=c.next().value,this.H.setRequestHeader(d,c);this.Ha&&(this.H.responseType=this.Ha);"withCredentials"in this.H&&this.H.withCredentials!==this.xa&&(this.H.withCredentials=this.xa);try{$g(this),0<this.s&&(this.wa=ah(this.H),this.getStatus(),this.wa?(this.H.timeout=this.s,this.H.ontimeout=Ta(this.Id,
this)):this.P=Ge(this.Id,this.s,this)),this.getStatus(),this.v=!0,this.H.send(a),this.v=!1}catch(g){this.getStatus(),Zg(this,g)}};
function ah(a){return cd&&"number"===typeof a.timeout&&void 0!==a.ontimeout}
m.Id=function(){"undefined"!=typeof Ka&&this.H&&(this.m="Timed out after "+this.s+"ms, aborting",this.getStatus(),Pd(this,"timeout"),this.abort(8))};
function Zg(a,b){a.i=!1;a.H&&(a.j=!0,a.H.abort(),a.j=!1);a.m=b;bh(a);ch(a)}
function bh(a){a.Z||(a.Z=!0,Pd(a,"complete"),Pd(a,"error"))}
m.abort=function(){this.H&&this.i&&(this.getStatus(),this.i=!1,this.j=!0,this.H.abort(),this.j=!1,Pd(this,"complete"),Pd(this,"abort"),ch(this))};
m.M=function(){this.H&&(this.i&&(this.i=!1,this.j=!0,this.H.abort(),this.j=!1),ch(this,!0));Ug.va.M.call(this)};
m.ud=function(){this.h()||(this.ba||this.v||this.j?dh(this):this.Ce())};
m.Ce=function(){dh(this)};
function dh(a){if(a.i&&"undefined"!=typeof Ka)if(a.V[1]&&4==eh(a)&&2==a.getStatus())a.getStatus();else if(a.v&&4==eh(a))Ge(a.ud,0,a);else if(Pd(a,"readystatechange"),a.isComplete()){a.getStatus();a.i=!1;try{if(fh(a))Pd(a,"complete"),Pd(a,"success");else{try{var b=2<eh(a)?a.H.statusText:""}catch(c){b=""}a.m=b+" ["+a.getStatus()+"]";bh(a)}}finally{ch(a)}}}
function ch(a,b){if(a.H){$g(a);var c=a.H,d=a.V[0]?function(){}:null;
a.H=null;a.V=null;b||Pd(a,"ready");try{c.onreadystatechange=d}catch(e){}}}
function $g(a){a.H&&a.wa&&(a.H.ontimeout=null);a.P&&(C.clearTimeout(a.P),a.P=null)}
m.isActive=function(){return!!this.H};
m.isComplete=function(){return 4==eh(this)};
function fh(a){var b=a.getStatus();a:switch(b){case 200:case 201:case 202:case 204:case 206:case 304:case 1223:var c=!0;break a;default:c=!1}if(!c){if(b=0===b)a=qc(1,String(a.ja)),!a&&C.self&&C.self.location&&(a=C.self.location.protocol.slice(0,-1)),b=!Vg.test(a?a.toLowerCase():"");c=b}return c}
function eh(a){return a.H?a.H.readyState:0}
m.getStatus=function(){try{return 2<eh(this)?this.H.status:-1}catch(a){return-1}};
m.getLastError=function(){return"string"===typeof this.m?this.m:String(this.m)};function gh(a){this.D=Pf(a)}
w(gh,lg);function hh(a){this.D=Pf(a)}
w(hh,lg);hh.Va=[1];function eg(a){this.D=Pf(a)}
w(eg,lg);var ih=["platform","platformVersion","architecture","model","uaFullVersion"];new hh;function kg(a){this.D=Pf(a)}
w(kg,lg);function jh(a){this.D=Pf(a,33)}
w(jh,lg);jh.Va=[3,20,27];function kh(a){this.D=Pf(a,19)}
w(kh,lg);kh.Va=[3,5];function lh(a){this.D=Pf(a,6)}
w(lh,lg);var mh=function(a){return function(b){if(null==b||""==b)b=new a;else{b=JSON.parse(b);if(!Array.isArray(b))throw Error(void 0);qf(b,16);b=Of(a,b)}return b}}(lh);
lh.Va=[5];function nh(a){this.D=Pf(a)}
w(nh,lg);var oh;oh=new function(a,b,c){this.h=a;this.fieldName=b;this.ctor=c;this.isRepeated=0;this.i=gg;this.defaultValue=void 0}(175237375,{Of:0},nh);function ph(a){Od.call(this);var b=this;this.componentId="";this.j=[];this.xa="";this.Ha=this.ja=-1;this.wa=!1;this.V=this.experimentIds=null;this.P=this.s=0;this.Wb=1;this.timeoutMillis=0;this.W=!1;Od.call(this);this.logSource=a.logSource;this.wb=a.wb||function(){};
this.m=new qh(a.logSource,a.fb);this.Cb=a.Cb;this.network=a.network;this.bufferSize=1E3;this.uc=Ua(Td,0,1);this.ba=a.cf||null;this.sessionIndex=a.sessionIndex||null;this.Nb=a.Nb||!1;this.pageId=a.pageId||null;this.logger=null;this.withCredentials=!a.hd;this.fb=a.fb||!1;!this.fb&&(65<=fc("Chromium")||45<=fc("Firefox")||12<=fc("Safari")||Wc()&&$c());var c=jg();rh(this.m,c);this.v=new Jg(1E4);this.i=new Fe(this.v.getValue());Lc(this,this.i);a=sh(this,a.Ud);Dd(this.i,"tick",a,!1,this);this.Z=new Fe(6E5);
Lc(this,this.Z);Dd(this.Z,"tick",a,!1,this);this.Nb||this.Z.start();this.fb||(Dd(document,"visibilitychange",function(){"hidden"===document.visibilityState&&b.zc()}),Dd(document,"pagehide",this.zc,!1,this))}
w(ph,Od);function sh(a,b){return b?function(){b().then(function(){a.flush()})}:function(){a.flush()}}
m=ph.prototype;m.M=function(){this.zc();Od.prototype.M.call(this)};
function th(a){a.ba||(a.ba=.01>a.uc()?"https://www.google.com/log?format=json&hasfast=true":"https://play.google.com/log?format=json&hasfast=true");return a.ba}
function uh(a,b){a.v=new Jg(1>b?1:b);a.i.setInterval(a.v.getValue())}
m.log=function(a){a=a.clone();var b=this.Wb++;a=K(a,21,b);this.componentId&&K(a,26,Kf(this.componentId));if(!$f(a,1)){b=a;var c=Date.now().toString();K(b,1,c)}null==$f(a,15)&&K(a,15,60*(new Date).getTimezoneOffset());this.experimentIds&&(b=this.experimentIds.clone(),hg(a,Ig,16,b));b=this.j.length-this.bufferSize+1;0<b&&(this.j.splice(0,b),this.s+=b);this.j.push(a);Pd(this,new vh(a));this.Nb||this.i.enabled||this.i.start()};
m.flush=function(a,b){var c=this;if(0===this.j.length)a&&a();else if(this.W)wh(this.m,3),xh(this);else{var d=Date.now();if(this.Ha>d&&this.ja<d)b&&b("throttled");else{wh(this.m,1);var e=yh(this.m,this.j,this.s,this.P);d={};var f=this.wb();f&&(d.Authorization=f);var g=th(this);this.sessionIndex&&(d["X-Goog-AuthUser"]=this.sessionIndex,g=Ac(g,"authuser",this.sessionIndex));this.pageId&&(d["X-Goog-PageId"]=this.pageId,g=Ac(g,"pageId",this.pageId));if(f&&this.xa===f)b&&b("stale-auth-token");else{this.j=
[];this.i.enabled&&this.i.stop();this.s=0;var h=e.serialize(),k;this.V&&this.V.isSupported(h.length)&&(k=this.V.compress(h));var l={url:g,body:h,Wd:1,Pc:d,requestType:"POST",withCredentials:this.withCredentials,timeoutMillis:this.timeoutMillis},n=function(r){c.v.reset();c.i.setInterval(c.v.getValue());if(r){var x=null;try{var y=JSON.stringify(JSON.parse(r.replace(")]}'\n","")));x=mh(y)}catch(H){}if(x){r=Number;y="-1";y=void 0===y?"0":y;var z=$f(x,1);r=r(null!=z?z:y);0<r&&(c.ja=Date.now(),c.Ha=c.ja+
r);x=oh.ctor?oh.i(x,oh.ctor,oh.h,!0):oh.i(x,oh.h,null,!0);if(r=null===x?void 0:x){x=-1;x=void 0===x?0:x;a:if(r=$f(r,1),null!=r){switch(typeof r){case "string":r=+r;break a;case "number":break a}r=void 0}x=null!=r?r:x;-1!==x&&(c.wa||uh(c,x))}}}a&&a();c.P=0},p=function(r,x){var y=e.D,z=vf(y),H=!!(z&2);
var I=H?1:2,L=!!(z&2);var P=z&2;var J=ag(y,z,3);Array.isArray(J)||(J=Ef);var V=sf(J);V&1||xf(J);P?V&2||qf(J,18):V&16&&!(V&2)&&uf(J,16);P=J;if(P!==Ef&&sf(P)&4)3===I||L||(L=Object.isFrozen(P),1===I?L||Object.freeze(P):(I=sf(P),J=I&-19,L&&(P=of(P),I=0,bg(y,z,3,P)),I!==J&&tf(P,J))),y=P;else{J=P;L=!!(z&2);var Z=!!(sf(J)&2);P=J;!L&&Z&&(J=of(J));V=z|(Z?2:0);Z=Z||void 0;for(var ca=0,ra=0;ca<J.length;ca++){var ma=Mf(J[ca],jh,V);void 0!==ma&&(Z=Z||vf(ma.D)&2,J[ra++]=ma)}ra<ca&&(J.length=ra);Z=!Z;V=sf(J);ca=
V|5;Z=Z?ca|8:ca&-9;V!=Z&&(J=wf(J,Z));P!==J&&bg(y,z,3,J);(L&&2!==I||1===I)&&Object.freeze(J);y=J}if(!(H||sf(y)&8)){for(H=0;H<y.length;H++)z=y[H],I=Zf(z),z!==I&&(y[H]=I);qf(y,8)}H=$f(e,14);z=c.v;z.h=Math.min(3E5,2*z.h);z.i=Math.min(3E5,z.h+Math.round(.2*(Math.random()-.5)*z.h));c.i.setInterval(c.v.getValue());401===r&&f&&(c.xa=f);H&&(c.s+=H);void 0===x&&(x=c.isRetryable(r));x&&(c.j=y.concat(c.j),c.Nb||c.i.enabled||c.i.start());b&&b("net-send-failed",r);++c.P},t=function(){c.network?c.network.send(l,
n,p):c.Cb&&c.Cb(l,n,p)};
k?k.then(function(r){l.Pc["Content-Encoding"]="gzip";l.Pc["Content-Type"]="application/binary";l.body=r;l.Wd=2;t()},function(){t()}):t()}}}};
m.zc=function(){zh(this.m,!0);this.flush();zh(this.m,!1)};
function xh(a){Ah(a,function(b,c){b=Ac(b,"format","json");var d=!1;try{d=window.navigator.sendBeacon(b,c.serialize())}catch(e){}a.W&&!d&&(a.W=!1);return d})}
function Ah(a,b){if(0!==a.j.length){var c=Ec(th(a),"format");c=yc(c,"auth",a.wb(),"authuser",a.sessionIndex||"0");for(var d=0;10>d&&a.j.length;++d){var e=a.j.slice(0,32),f=yh(a.m,e,a.s,a.P);if(!b(c,f)){++a.P;break}a.s=0;a.P=0;a.j=a.j.slice(e.length)}a.i.enabled&&a.i.stop()}}
m.isRetryable=function(a){return 500<=a&&600>a||401===a||0===a};
function vh(){Nc.call(this,"event-logged",void 0)}
w(vh,Nc);function qh(a,b){this.fb=b=void 0===b?!1:b;this.uach=this.locale=null;this.h=new kh;Number.isInteger(a)&&K(this.h,2,a);b||(this.locale=document.documentElement.getAttribute("lang"));rh(this,new kg)}
function rh(a,b){hg(a.h,kg,1,b);var c=$f(b,1);(null==c?c:c)||K(b,1,1);a.fb||(b=Bh(a),c=$f(b,5),(null==c||"string"===typeof c)&&c||K(b,5,Kf(a.locale)));a.uach&&(b=Bh(a),gg(b,hh,9)||hg(b,hh,9,a.uach))}
function wh(a,b){cg(gg(a.h,kg,1))&&(a=Ch(a),K(a,1,b))}
function zh(a,b){cg(gg(a.h,kg,1))&&(a=Ch(a),K(a,2,If(b)))}
function Dh(a,b){var c=void 0===c?ih:c;b(window,c).then(function(d){a.uach=d;d=Bh(a);hg(d,hh,9,a.uach);return!0}).catch(function(){return!1})}
function Bh(a){a=gg(a.h,kg,1);var b=gg(a,eg,11);b||(b=new eg,hg(a,eg,11,b));return b}
function Ch(a){a=Bh(a);var b=gg(a,gh,10);b||(b=new gh,K(b,2,If(!1)),hg(a,gh,10,b));return b}
function yh(a,b,c,d){c=void 0===c?0:c;d=void 0===d?0:d;if(cg(gg(a.h,kg,1))){var e=Ch(a);K(e,3,Jf(d))}a=a.h.clone();d=Date.now().toString();a=K(a,4,d);b=ig(a,jh,3,b);c&&K(b,14,c);return b}
;function Eh(a,b,c){Yg(a.url,function(d){d=d.target;if(fh(d)){try{var e=d.H?d.H.responseText:""}catch(f){e=""}b(e)}else c(d.getStatus())},a.requestType,a.body,a.Pc,a.timeoutMillis,a.withCredentials)}
;function Fh(a,b){G.call(this);this.logSource=a;this.sessionIndex=b;this.j="https://play.google.com/log?format=json&hasfast=true";this.l=!1;this.componentId="";this.Cb=Eh}
w(Fh,G);Fh.prototype.hd=function(){this.Z=!0;return this};function Gh(a,b,c,d,e,f){a=void 0===a?-1:a;b=void 0===b?"":b;c=void 0===c?"":c;d=void 0===d?!1:d;e=void 0===e?"":e;G.call(this);f?a=f:(a=new Fh(a,"0"),a.componentId=b,Lc(this,a),""!=c&&(a.j=c),d&&(a.l=!0),e&&(a.i=e),b=new ph({logSource:a.logSource,wb:a.wb?a.wb:Hg,sessionIndex:a.sessionIndex,Cb:a.Cb,cf:a.j,fb:a.l,Nb:!1,hd:a.Z,pageId:void 0,Ud:void 0,network:a.network?a.network:void 0}),Lc(a,b),a.v&&rh(b.m,a.v),a.i&&(c=a.i,d=Bh(b.m),K(d,7,Kf(c))),a.s&&(b.V=a.s),a.componentId&&(b.componentId=a.componentId),
a.m&&((c=a.m)?(b.experimentIds||(b.experimentIds=new Ig),c=c.serialize(),K(b.experimentIds,4,Kf(c))):b.experimentIds&&K(b.experimentIds,4,void 0,!1)),a.V&&(e=a.V,b.experimentIds||(b.experimentIds=new Ig),c=b.experimentIds.D,d=vf(c),Gf(d),e=null==e?Ef:rf(e),bg(c,d,2,e)),a.P&&(c=a.P,b.wa=!0,uh(b,c)),a.W&&Dh(b.m,a.W),a=b);this.i=a}
w(Gh,G);
Gh.prototype.flush=function(a){var b=a||[];if(b.length){a=new tg;for(var c=[],d=0;d<b.length;d++){var e=b[d],f=e;var g=new sg;g=K(g,1,Kf(f.i));for(var h=f,k=[],l=0;l<h.h.length;l++)k.push(h.h[l].ub);h=g.D;l=vf(h);Gf(l);if(null==k)bg(h,l,3);else{var n=sf(k);if(!(n&4)){if(n&2||Object.isFrozen(k))k=of(k);for(var p=0;p<k.length;p++){var t=k,r=p,x=k[p];if("string"!==typeof x)throw Error();t[r]=x}tf(k,n|5)}bg(h,l,3,k)}k=[];h=[];l=v(f.sb.keys());for(n=l.next();!n.done;n=l.next())h.push(n.value.split(","));for(l=
0;l<h.length;l++){n=h[l];p=f.l;t=f.Bc(n)||[];r=[];for(x=0;x<t.length;x++){var y=t[x],z=y&&y.ed;y=new pg;switch(p){case 3:fg(y,1,qg,Number(z));break;case 2:var H=y;z=Number(z);if(null!=z&&"number"!==typeof z)throw Error("Value of float/double field must be a number|null|undefined, found "+typeof z+": "+z);fg(H,2,qg,z)}r.push(y)}p=r;for(t=0;t<p.length;t++){r=p[t];x=new rg;r=hg(x,pg,2,r);x=n;y=[];H=f;z=[];for(var I=0;I<H.h.length;I++)z.push(H.h[I].vb);H=z;for(z=0;z<H.length;z++){I=H[z];var L=x[z],P=
new ng;switch(I){case 3:fg(P,1,og,Kf(String(L)));break;case 2:fg(P,2,og,Jf(Number(L)));break;case 1:fg(P,3,og,If("true"==L))}y.push(P)}ig(r,ng,1,y);k.push(r)}}ig(g,rg,4,k);c.push(g);e.clear()}ig(a,sg,1,c);b=this.i;a instanceof jh?b.log(a):(c=new jh,a=a.serialize(),a=K(c,8,Kf(a)),b.log(a));this.i.flush()}};function Hh(a){this.v=Ih();this.m=new Gh(1828);this.h=new He(this.m);this.s=new Ne(this.h);this.j=new Oe(this.h);this.l=new Pe(this.h);this.i=new Le(this.h);this.Oa=Re(a)}
function Ih(){var a,b,c;return null!=(c=null==(a=globalThis.performance)?void 0:null==(b=a.now)?void 0:b.call(a))?c:Date.now()}
;function Jh(){var a=this;this.promise=new Promise(function(b,c){a.resolve=b;a.reject=c})}
;function Kh(a){function b(r,x){Promise.resolve().then(function(){var y;null!=(y=c.oa)&&y.s.record(Ih()-y.v,y.Oa);g.resolve({Td:r,Ve:x})})}
var c=this;this.i=!1;var d=a.program;var e=a.me;if(a.Fe){var f;this.oa=null!=(f=a.oa)?f:new Hh(e)}var g=new Jh;this.j=g.promise;if(!C[e]){var h;null!=(h=this.oa)&&Me(h.i,h.Oa,1,"");var k;null!=(k=this.oa)&&k.h.qb()}else if(!C[e].a){var l;null!=(l=this.oa)&&Me(l.i,l.Oa,2,"");var n;null!=(n=this.oa)&&n.h.qb()}try{this.l=v((0,C[e].a)(d,b,!0)).next().value,this.Ue=g.promise.then(function(){})}catch(r){var p;
null!=(p=this.oa)&&Me(p.i,p.Oa,4,r.message);var t;null!=(t=this.oa)&&t.h.qb();throw r;}}
Kh.prototype.snapshot=function(a){var b=this;if(this.i)throw Error("Already disposed");var c=Ih(),d;null!=(d=this.oa)&&d.j.h.sc("/client_streamz/bg/fsc",d.Oa);return this.j.then(function(e){var f=e.Td;return new Promise(function(g){f(function(h){var k;null!=(k=b.oa)&&k.l.record(Ih()-c,k.Oa);g(h)},[a.gd,
a.We,a.ef])})})};
Kh.prototype.Fd=function(a){if(this.i)throw Error("Already disposed");var b=Ih(),c;null!=(c=this.oa)&&c.j.h.sc("/client_streamz/bg/fsc",c.Oa);a=this.l([a.gd,a.We,a.ef]);var d;null!=(d=this.oa)&&d.l.record(Ih()-b,d.Oa);return a};
Kh.prototype.dispose=function(){var a;null!=(a=this.oa)&&a.h.qb();this.i=!0;this.j.then(function(b){(b=b.Ve)&&b()})};
Kh.prototype.h=function(){return this.i};var Lh=window;xb("csi.gstatic.com");xb("googleads.g.doubleclick.net");xb("partner.googleadservices.com");xb("pubads.g.doubleclick.net");xb("securepubads.g.doubleclick.net");xb("tpc.googlesyndication.com");/*

 SPDX-License-Identifier: Apache-2.0
*/
var Mh;try{new URL("s://g"),Mh=!0}catch(a){Mh=!1}var Nh=Mh;function Oh(a){if(a instanceof Hb)a=Ib(a);else{b:if(Nh){try{var b=new URL(a)}catch(c){b="https:";break b}b=b.protocol}else c:{b=document.createElement("a");try{b.href=a}catch(c){b=void 0;break c}b=b.protocol;b=":"===b||""===b?"https:":b}a="javascript:"!==b?a:void 0}return a}
;var Ph={};function Qh(){}
function Rh(a){this.h=a}
w(Rh,Qh);Rh.prototype.toString=function(){return this.h};function Sh(a){var b="true".toString(),c=[new Rh(Th[0].toLowerCase(),Ph)];if(0===c.length)throw Error("");if(c.map(function(d){if(d instanceof Rh)d=d.h;else throw Error("");return d}).every(function(d){return 0!=="data-loaded".indexOf(d)}))throw Error('Attribute "data-loaded" does not match any of the allowed prefixes.');
a.setAttribute("data-loaded",b)}
;function Uh(){throw Error("unknown trace type");}
;function Vh(a){var b,c,d=null==(c=(b=(a.ownerDocument&&a.ownerDocument.defaultView||window).document).querySelector)?void 0:c.call(b,"script[nonce]");(b=d?d.nonce||d.getAttribute("nonce")||"":"")&&a.setAttribute("nonce",b)}
function Wh(a,b){a.src=Bb(b);Vh(a)}
;(function(){return""}).toString().indexOf("`");function Xh(a){this.ue=a}
function Yh(a){return new Xh(function(b){return b.substr(0,a.length+1).toLowerCase()===a+":"})}
var Zh=[Yh("data"),Yh("http"),Yh("https"),Yh("mailto"),Yh("ftp"),new Xh(function(a){return/^[^:]*([/?#]|$)/.test(a)})];function $h(a){var b=ai;if(b)for(var c in b)Object.prototype.hasOwnProperty.call(b,c)&&a(b[c],c,b)}
function bi(){var a=[];$h(function(b){a.push(b)});
return a}
var ai={ff:"allow-forms",gf:"allow-modals",hf:"allow-orientation-lock",jf:"allow-pointer-lock",kf:"allow-popups",lf:"allow-popups-to-escape-sandbox",mf:"allow-presentation",nf:"allow-same-origin",pf:"allow-scripts",qf:"allow-top-navigation",rf:"allow-top-navigation-by-user-activation"},ci=$a(function(){return bi()});
function di(){var a=ei(),b={};bb(ci(),function(c){a.sandbox&&a.sandbox.supports&&a.sandbox.supports(c)&&(b[c]=!0)});
return b}
function ei(){var a=void 0===a?document:a;return a.createElement("iframe")}
;function fi(a){"number"==typeof a&&(a=Math.round(a)+"px");return a}
;var gi=(new Date).getTime();var hi="client_dev_domain client_dev_regex_map client_dev_root_url client_rollout_override expflag forcedCapability jsfeat jsmode mods".split(" ");[].concat(ja(hi),["client_dev_set_cookie"]);"undefined"!==typeof TextDecoder&&new TextDecoder;var ii="undefined"!==typeof TextEncoder?new TextEncoder:null,ji=ii?function(a){return ii.encode(a)}:function(a){for(var b=[],c=0,d=0;d<a.length;d++){var e=a.charCodeAt(d);
128>e?b[c++]=e:(2048>e?b[c++]=e>>6|192:(55296==(e&64512)&&d+1<a.length&&56320==(a.charCodeAt(d+1)&64512)?(e=65536+((e&1023)<<10)+(a.charCodeAt(++d)&1023),b[c++]=e>>18|240,b[c++]=e>>12&63|128):b[c++]=e>>12|224,b[c++]=e>>6&63|128),b[c++]=e&63|128)}a=new Uint8Array(b.length);for(c=0;c<a.length;c++)a[c]=b[c];return a};function ki(a){Od.call(this);var b=this;this.v=this.j=0;this.Ba=null!=a?a:{ka:function(e,f){return setTimeout(e,f)},
ya:function(e){clearTimeout(e)}};
var c,d;this.i=null!=(d=null==(c=window.navigator)?void 0:c.onLine)?d:!0;this.m=function(){return A(function(e){return e.yield(li(b),0)})};
window.addEventListener("offline",this.m);window.addEventListener("online",this.m);this.v||mi(this)}
w(ki,Od);function ni(){var a=oi;ki.h||(ki.h=new ki(a));return ki.h}
ki.prototype.dispose=function(){window.removeEventListener("offline",this.m);window.removeEventListener("online",this.m);this.Ba.ya(this.v);delete ki.h};
ki.prototype.qa=function(){return this.i};
function mi(a){a.v=a.Ba.ka(function(){var b;return A(function(c){if(1==c.h)return a.i?(null==(b=window.navigator)?0:b.onLine)?c.A(3):c.yield(li(a),3):c.yield(li(a),3);mi(a);c.h=0})},3E4)}
function li(a,b){return a.s?a.s:a.s=new Promise(function(c){var d,e,f,g;return A(function(h){switch(h.h){case 1:return d=window.AbortController?new window.AbortController:void 0,f=null==(e=d)?void 0:e.signal,g=!1,ya(h,2,3),d&&(a.j=a.Ba.ka(function(){d.abort()},b||2E4)),h.yield(fetch("/generate_204",{method:"HEAD",
signal:f}),5);case 5:g=!0;case 3:h.Da=[h.j];h.l=0;h.s=0;a.s=void 0;a.j&&(a.Ba.ya(a.j),a.j=0);g!==a.i&&(a.i=g,a.i?Pd(a,"networkstatus-online"):Pd(a,"networkstatus-offline"));c(g);Aa(h);break;case 2:za(h),g=!1,h.A(3)}})})}
;function pi(){this.data_=[];this.h=-1}
pi.prototype.set=function(a,b){b=void 0===b?!0:b;0<=a&&52>a&&Number.isInteger(a)&&this.data_[a]!==b&&(this.data_[a]=b,this.h=-1)};
pi.prototype.get=function(a){return!!this.data_[a]};
function qi(a){-1===a.h&&(a.h=eb(a.data_,function(b,c,d){return c?b+Math.pow(2,d):b},0));
return a.h}
;function ri(a,b){this.h=a[C.Symbol.iterator]();this.i=b}
ri.prototype[Symbol.iterator]=function(){return this};
ri.prototype.next=function(){var a=this.h.next();return{value:a.done?void 0:this.i.call(void 0,a.value),done:a.done}};
function si(a,b){return new ri(a,b)}
;function ti(){this.blockSize=-1}
;function ui(){this.blockSize=-1;this.blockSize=64;this.h=[];this.m=[];this.s=[];this.j=[];this.j[0]=128;for(var a=1;a<this.blockSize;++a)this.j[a]=0;this.l=this.i=0;this.reset()}
Va(ui,ti);ui.prototype.reset=function(){this.h[0]=1732584193;this.h[1]=4023233417;this.h[2]=2562383102;this.h[3]=271733878;this.h[4]=3285377520;this.l=this.i=0};
function vi(a,b,c){c||(c=0);var d=a.s;if("string"===typeof b)for(var e=0;16>e;e++)d[e]=b.charCodeAt(c)<<24|b.charCodeAt(c+1)<<16|b.charCodeAt(c+2)<<8|b.charCodeAt(c+3),c+=4;else for(e=0;16>e;e++)d[e]=b[c]<<24|b[c+1]<<16|b[c+2]<<8|b[c+3],c+=4;for(e=16;80>e;e++){var f=d[e-3]^d[e-8]^d[e-14]^d[e-16];d[e]=(f<<1|f>>>31)&4294967295}b=a.h[0];c=a.h[1];var g=a.h[2],h=a.h[3],k=a.h[4];for(e=0;80>e;e++){if(40>e)if(20>e){f=h^c&(g^h);var l=1518500249}else f=c^g^h,l=1859775393;else 60>e?(f=c&g|h&(c|g),l=2400959708):
(f=c^g^h,l=3395469782);f=(b<<5|b>>>27)+f+k+l+d[e]&4294967295;k=h;h=g;g=(c<<30|c>>>2)&4294967295;c=b;b=f}a.h[0]=a.h[0]+b&4294967295;a.h[1]=a.h[1]+c&4294967295;a.h[2]=a.h[2]+g&4294967295;a.h[3]=a.h[3]+h&4294967295;a.h[4]=a.h[4]+k&4294967295}
ui.prototype.update=function(a,b){if(null!=a){void 0===b&&(b=a.length);for(var c=b-this.blockSize,d=0,e=this.m,f=this.i;d<b;){if(0==f)for(;d<=c;)vi(this,a,d),d+=this.blockSize;if("string"===typeof a)for(;d<b;){if(e[f]=a.charCodeAt(d),++f,++d,f==this.blockSize){vi(this,e);f=0;break}}else for(;d<b;)if(e[f]=a[d],++f,++d,f==this.blockSize){vi(this,e);f=0;break}}this.i=f;this.l+=b}};
ui.prototype.digest=function(){var a=[],b=8*this.l;56>this.i?this.update(this.j,56-this.i):this.update(this.j,this.blockSize-(this.i-56));for(var c=this.blockSize-1;56<=c;c--)this.m[c]=b&255,b/=256;vi(this,this.m);for(c=b=0;5>c;c++)for(var d=24;0<=d;d-=8)a[b]=this.h[c]>>d&255,++b;return a};function wi(a){return"string"==typeof a.className?a.className:a.getAttribute&&a.getAttribute("class")||""}
function xi(a,b){"string"==typeof a.className?a.className=b:a.setAttribute&&a.setAttribute("class",b)}
function yi(a,b){a.classList?b=a.classList.contains(b):(a=a.classList?a.classList:wi(a).match(/\S+/g)||[],b=0<=ab(a,b));return b}
function zi(){var a=document.body;a.classList?a.classList.remove("inverted-hdpi"):yi(a,"inverted-hdpi")&&xi(a,Array.prototype.filter.call(a.classList?a.classList:wi(a).match(/\S+/g)||[],function(b){return"inverted-hdpi"!=b}).join(" "))}
;function Ai(){}
Ai.prototype.next=function(){return Bi};
var Bi={done:!0,value:void 0};function Ci(a){return{value:a,done:!1}}
Ai.prototype.Ea=function(){return this};function Di(a){if(a instanceof Ei||a instanceof Fi||a instanceof Gi)return a;if("function"==typeof a.next)return new Ei(function(){return a});
if("function"==typeof a[Symbol.iterator])return new Ei(function(){return a[Symbol.iterator]()});
if("function"==typeof a.Ea)return new Ei(function(){return a.Ea()});
throw Error("Not an iterator or iterable.");}
function Ei(a){this.i=a}
Ei.prototype.Ea=function(){return new Fi(this.i())};
Ei.prototype[Symbol.iterator]=function(){return new Gi(this.i())};
Ei.prototype.h=function(){return new Gi(this.i())};
function Fi(a){this.i=a}
w(Fi,Ai);Fi.prototype.next=function(){return this.i.next()};
Fi.prototype[Symbol.iterator]=function(){return new Gi(this.i)};
Fi.prototype.h=function(){return new Gi(this.i)};
function Gi(a){Ei.call(this,function(){return a});
this.j=a}
w(Gi,Ei);Gi.prototype.next=function(){return this.j.next()};function Hi(a,b){this.i={};this.h=[];this.Xa=this.size=0;var c=arguments.length;if(1<c){if(c%2)throw Error("Uneven number of arguments");for(var d=0;d<c;d+=2)this.set(arguments[d],arguments[d+1])}else if(a)if(a instanceof Hi)for(c=a.Ec(),d=0;d<c.length;d++)this.set(c[d],a.get(c[d]));else for(d in a)this.set(d,a[d])}
m=Hi.prototype;m.Ec=function(){Ii(this);return this.h.concat()};
m.has=function(a){return Ji(this.i,a)};
m.equals=function(a,b){if(this===a)return!0;if(this.size!=a.size)return!1;b=b||Ki;Ii(this);for(var c,d=0;c=this.h[d];d++)if(!b(this.get(c),a.get(c)))return!1;return!0};
function Ki(a,b){return a===b}
m.isEmpty=function(){return 0==this.size};
m.clear=function(){this.i={};this.Xa=this.size=this.h.length=0};
m.remove=function(a){return this.delete(a)};
m.delete=function(a){return Ji(this.i,a)?(delete this.i[a],--this.size,this.Xa++,this.h.length>2*this.size&&Ii(this),!0):!1};
function Ii(a){if(a.size!=a.h.length){for(var b=0,c=0;b<a.h.length;){var d=a.h[b];Ji(a.i,d)&&(a.h[c++]=d);b++}a.h.length=c}if(a.size!=a.h.length){var e={};for(c=b=0;b<a.h.length;)d=a.h[b],Ji(e,d)||(a.h[c++]=d,e[d]=1),b++;a.h.length=c}}
m.get=function(a,b){return Ji(this.i,a)?this.i[a]:b};
m.set=function(a,b){Ji(this.i,a)||(this.size+=1,this.h.push(a),this.Xa++);this.i[a]=b};
m.forEach=function(a,b){for(var c=this.Ec(),d=0;d<c.length;d++){var e=c[d],f=this.get(e);a.call(b,f,e,this)}};
m.clone=function(){return new Hi(this)};
m.keys=function(){return Di(this.Ea(!0)).h()};
m.values=function(){return Di(this.Ea(!1)).h()};
m.entries=function(){var a=this;return si(this.keys(),function(b){return[b,a.get(b)]})};
m.Ea=function(a){Ii(this);var b=0,c=this.Xa,d=this,e=new Ai;e.next=function(){if(c!=d.Xa)throw Error("The map has changed since the iterator was created");if(b>=d.h.length)return Bi;var f=d.h[b++];return Ci(a?f:d.i[f])};
return e};
function Ji(a,b){return Object.prototype.hasOwnProperty.call(a,b)}
;function M(a){G.call(this);this.s=1;this.l=[];this.m=0;this.i=[];this.j={};this.v=!!a}
Va(M,G);m=M.prototype;m.subscribe=function(a,b,c){var d=this.j[a];d||(d=this.j[a]=[]);var e=this.s;this.i[e]=a;this.i[e+1]=b;this.i[e+2]=c;this.s=e+3;d.push(e);return e};
function Li(a,b,c,d){if(b=a.j[b]){var e=a.i;(b=b.find(function(f){return e[f+1]==c&&e[f+2]==d}))&&a.Jb(b)}}
m.Jb=function(a){var b=this.i[a];if(b){var c=this.j[b];0!=this.m?(this.l.push(a),this.i[a+1]=function(){}):(c&&gb(c,a),delete this.i[a],delete this.i[a+1],delete this.i[a+2])}return!!b};
m.cb=function(a,b){var c=this.j[a];if(c){for(var d=Array(arguments.length-1),e=1,f=arguments.length;e<f;e++)d[e-1]=arguments[e];if(this.v)for(e=0;e<c.length;e++){var g=c[e];Mi(this.i[g+1],this.i[g+2],d)}else{this.m++;try{for(e=0,f=c.length;e<f&&!this.h();e++)g=c[e],this.i[g+1].apply(this.i[g+2],d)}finally{if(this.m--,0<this.l.length&&0==this.m)for(;c=this.l.pop();)this.Jb(c)}}return 0!=e}return!1};
function Mi(a,b,c){he(function(){a.apply(b,c)})}
m.clear=function(a){if(a){var b=this.j[a];b&&(b.forEach(this.Jb,this),delete this.j[a])}else this.i.length=0,this.j={}};
m.M=function(){M.va.M.call(this);this.clear();this.l.length=0};function Ni(a){this.h=a}
Ni.prototype.set=function(a,b){void 0===b?this.h.remove(a):this.h.set(a,(new Kg).serialize(b))};
Ni.prototype.get=function(a){try{var b=this.h.get(a)}catch(c){return}if(null!==b)try{return JSON.parse(b)}catch(c){throw"Storage: Invalid value was encountered";}};
Ni.prototype.remove=function(a){this.h.remove(a)};function Oi(a){this.h=a}
Va(Oi,Ni);function Pi(a){this.data=a}
function Qi(a){return void 0===a||a instanceof Pi?a:new Pi(a)}
Oi.prototype.set=function(a,b){Oi.va.set.call(this,a,Qi(b))};
Oi.prototype.i=function(a){a=Oi.va.get.call(this,a);if(void 0===a||a instanceof Object)return a;throw"Storage: Invalid value was encountered";};
Oi.prototype.get=function(a){if(a=this.i(a)){if(a=a.data,void 0===a)throw"Storage: Invalid value was encountered";}else a=void 0;return a};function Ri(a){this.h=a}
Va(Ri,Oi);Ri.prototype.set=function(a,b,c){if(b=Qi(b)){if(c){if(c<Date.now()){Ri.prototype.remove.call(this,a);return}b.expiration=c}b.creation=Date.now()}Ri.va.set.call(this,a,b)};
Ri.prototype.i=function(a){var b=Ri.va.i.call(this,a);if(b){var c=b.creation,d=b.expiration;if(d&&d<Date.now()||c&&c>Date.now())Ri.prototype.remove.call(this,a);else return b}};function Si(){}
;function Ti(){}
Va(Ti,Si);Ti.prototype[Symbol.iterator]=function(){return Di(this.Ea(!0)).h()};
Ti.prototype.clear=function(){var a=Array.from(this);a=v(a);for(var b=a.next();!b.done;b=a.next())this.remove(b.value)};function Ui(a){this.h=a}
Va(Ui,Ti);m=Ui.prototype;m.isAvailable=function(){if(!this.h)return!1;try{return this.h.setItem("__sak","1"),this.h.removeItem("__sak"),!0}catch(a){return!1}};
m.set=function(a,b){try{this.h.setItem(a,b)}catch(c){if(0==this.h.length)throw"Storage mechanism: Storage disabled";throw"Storage mechanism: Quota exceeded";}};
m.get=function(a){a=this.h.getItem(a);if("string"!==typeof a&&null!==a)throw"Storage mechanism: Invalid value was encountered";return a};
m.remove=function(a){this.h.removeItem(a)};
m.Ea=function(a){var b=0,c=this.h,d=new Ai;d.next=function(){if(b>=c.length)return Bi;var e=c.key(b++);if(a)return Ci(e);e=c.getItem(e);if("string"!==typeof e)throw"Storage mechanism: Invalid value was encountered";return Ci(e)};
return d};
m.clear=function(){this.h.clear()};
m.key=function(a){return this.h.key(a)};function Vi(){var a=null;try{a=window.localStorage||null}catch(b){}this.h=a}
Va(Vi,Ui);function Wi(a,b){this.i=a;this.h=null;var c;if(c=cd)c=!(9<=Number(qd));if(c){Xi||(Xi=new Hi);this.h=Xi.get(a);this.h||(b?this.h=document.getElementById(b):(this.h=document.createElement("userdata"),this.h.addBehavior("#default#userData"),document.body.appendChild(this.h)),Xi.set(a,this.h));try{this.h.load(this.i)}catch(d){this.h=null}}}
Va(Wi,Ti);var Yi={".":".2E","!":".21","~":".7E","*":".2A","'":".27","(":".28",")":".29","%":"."},Xi=null;function Zi(a){return"_"+encodeURIComponent(a).replace(/[.!~*'()%]/g,function(b){return Yi[b]})}
m=Wi.prototype;m.isAvailable=function(){return!!this.h};
m.set=function(a,b){this.h.setAttribute(Zi(a),b);$i(this)};
m.get=function(a){a=this.h.getAttribute(Zi(a));if("string"!==typeof a&&null!==a)throw"Storage mechanism: Invalid value was encountered";return a};
m.remove=function(a){this.h.removeAttribute(Zi(a));$i(this)};
m.Ea=function(a){var b=0,c=this.h.XMLDocument.documentElement.attributes,d=new Ai;d.next=function(){if(b>=c.length)return Bi;var e=c[b++];if(a)return Ci(decodeURIComponent(e.nodeName.replace(/\./g,"%")).slice(1));e=e.nodeValue;if("string"!==typeof e)throw"Storage mechanism: Invalid value was encountered";return Ci(e)};
return d};
m.clear=function(){for(var a=this.h.XMLDocument.documentElement,b=a.attributes.length;0<b;b--)a.removeAttribute(a.attributes[b-1].nodeName);$i(this)};
function $i(a){try{a.h.save(a.i)}catch(b){throw"Storage mechanism: Quota exceeded";}}
;function aj(a,b){this.i=a;this.h=b+"::"}
Va(aj,Ti);aj.prototype.set=function(a,b){this.i.set(this.h+a,b)};
aj.prototype.get=function(a){return this.i.get(this.h+a)};
aj.prototype.remove=function(a){this.i.remove(this.h+a)};
aj.prototype.Ea=function(a){var b=this.i[Symbol.iterator](),c=this,d=new Ai;d.next=function(){var e=b.next();if(e.done)return e;for(e=e.value;e.slice(0,c.h.length)!=c.h;){e=b.next();if(e.done)return e;e=e.value}return Ci(a?e.slice(c.h.length):c.i.get(e))};
return d};/*

 (The MIT License)

 Copyright (C) 2014 by Vitaly Puzrin

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.

 -----------------------------------------------------------------------------
 Ported from zlib, which is under the following license
 https://github.com/madler/zlib/blob/master/zlib.h

 zlib.h -- interface of the 'zlib' general purpose compression library
   version 1.2.8, April 28th, 2013
   Copyright (C) 1995-2013 Jean-loup Gailly and Mark Adler
   This software is provided 'as-is', without any express or implied
   warranty.  In no event will the authors be held liable for any damages
   arising from the use of this software.
   Permission is granted to anyone to use this software for any purpose,
   including commercial applications, and to alter it and redistribute it
   freely, subject to the following restrictions:
   1. The origin of this software must not be misrepresented; you must not
      claim that you wrote the original software. If you use this software
      in a product, an acknowledgment in the product documentation would be
      appreciated but is not required.
   2. Altered source versions must be plainly marked as such, and must not be
      misrepresented as being the original software.
   3. This notice may not be removed or altered from any source distribution.
   Jean-loup Gailly        Mark Adler
   jloup@gzip.org          madler@alumni.caltech.edu
   The data format used by the zlib library is described by RFCs (Request for
   Comments) 1950 to 1952 in the files http://tools.ietf.org/html/rfc1950
   (zlib format), rfc1951 (deflate format) and rfc1952 (gzip format).
*/
var N={},bj="undefined"!==typeof Uint8Array&&"undefined"!==typeof Uint16Array&&"undefined"!==typeof Int32Array;N.assign=function(a){for(var b=Array.prototype.slice.call(arguments,1);b.length;){var c=b.shift();if(c){if("object"!==typeof c)throw new TypeError(c+"must be non-object");for(var d in c)Object.prototype.hasOwnProperty.call(c,d)&&(a[d]=c[d])}}return a};
N.Sc=function(a,b){if(a.length===b)return a;if(a.subarray)return a.subarray(0,b);a.length=b;return a};
var cj={rb:function(a,b,c,d,e){if(b.subarray&&a.subarray)a.set(b.subarray(c,c+d),e);else for(var f=0;f<d;f++)a[e+f]=b[c+f]},
kd:function(a){var b,c;var d=c=0;for(b=a.length;d<b;d++)c+=a[d].length;var e=new Uint8Array(c);d=c=0;for(b=a.length;d<b;d++){var f=a[d];e.set(f,c);c+=f.length}return e}},dj={rb:function(a,b,c,d,e){for(var f=0;f<d;f++)a[e+f]=b[c+f]},
kd:function(a){return[].concat.apply([],a)}};
N.Te=function(){bj?(N.pb=Uint8Array,N.Ga=Uint16Array,N.Od=Int32Array,N.assign(N,cj)):(N.pb=Array,N.Ga=Array,N.Od=Array,N.assign(N,dj))};
N.Te();var ej=!0;try{new Uint8Array(1)}catch(a){ej=!1}
function fj(a){var b,c,d=a.length,e=0;for(b=0;b<d;b++){var f=a.charCodeAt(b);if(55296===(f&64512)&&b+1<d){var g=a.charCodeAt(b+1);56320===(g&64512)&&(f=65536+(f-55296<<10)+(g-56320),b++)}e+=128>f?1:2048>f?2:65536>f?3:4}var h=new N.pb(e);for(b=c=0;c<e;b++)f=a.charCodeAt(b),55296===(f&64512)&&b+1<d&&(g=a.charCodeAt(b+1),56320===(g&64512)&&(f=65536+(f-55296<<10)+(g-56320),b++)),128>f?h[c++]=f:(2048>f?h[c++]=192|f>>>6:(65536>f?h[c++]=224|f>>>12:(h[c++]=240|f>>>18,h[c++]=128|f>>>12&63),h[c++]=128|f>>>
6&63),h[c++]=128|f&63);return h}
;var gj={};gj=function(a,b,c,d){var e=a&65535|0;a=a>>>16&65535|0;for(var f;0!==c;){f=2E3<c?2E3:c;c-=f;do e=e+b[d++]|0,a=a+e|0;while(--f);e%=65521;a%=65521}return e|a<<16|0};for(var hj={},ij,jj=[],kj=0;256>kj;kj++){ij=kj;for(var lj=0;8>lj;lj++)ij=ij&1?3988292384^ij>>>1:ij>>>1;jj[kj]=ij}hj=function(a,b,c,d){c=d+c;for(a^=-1;d<c;d++)a=a>>>8^jj[(a^b[d])&255];return a^-1};var mj={};mj={2:"need dictionary",1:"stream end",0:"","-1":"file error","-2":"stream error","-3":"data error","-4":"insufficient memory","-5":"buffer error","-6":"incompatible version"};function nj(a){for(var b=a.length;0<=--b;)a[b]=0}
var oj=[0,0,0,0,0,0,0,0,1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5,0],pj=[0,0,0,0,1,1,2,2,3,3,4,4,5,5,6,6,7,7,8,8,9,9,10,10,11,11,12,12,13,13],qj=[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2,3,7],rj=[16,17,18,0,8,7,9,6,10,5,11,4,12,3,13,2,14,1,15],sj=Array(576);nj(sj);var tj=Array(60);nj(tj);var uj=Array(512);nj(uj);var vj=Array(256);nj(vj);var wj=Array(29);nj(wj);var xj=Array(30);nj(xj);function yj(a,b,c,d,e){this.Gd=a;this.ge=b;this.ee=c;this.ae=d;this.ze=e;this.od=a&&a.length}
var zj,Aj,Bj;function Cj(a,b){this.jd=a;this.Bb=0;this.Wa=b}
function Dj(a,b){a.T[a.pending++]=b&255;a.T[a.pending++]=b>>>8&255}
function Ej(a,b,c){a.aa>16-c?(a.ia|=b<<a.aa&65535,Dj(a,a.ia),a.ia=b>>16-a.aa,a.aa+=c-16):(a.ia|=b<<a.aa&65535,a.aa+=c)}
function Fj(a,b,c){Ej(a,c[2*b],c[2*b+1])}
function Gj(a,b){var c=0;do c|=a&1,a>>>=1,c<<=1;while(0<--b);return c>>>1}
function Hj(a,b,c){var d=Array(16),e=0,f;for(f=1;15>=f;f++)d[f]=e=e+c[f-1]<<1;for(c=0;c<=b;c++)e=a[2*c+1],0!==e&&(a[2*c]=Gj(d[e]++,e))}
function Ij(a){var b;for(b=0;286>b;b++)a.la[2*b]=0;for(b=0;30>b;b++)a.eb[2*b]=0;for(b=0;19>b;b++)a.da[2*b]=0;a.la[512]=1;a.Na=a.Fb=0;a.sa=a.matches=0}
function Jj(a){8<a.aa?Dj(a,a.ia):0<a.aa&&(a.T[a.pending++]=a.ia);a.ia=0;a.aa=0}
function Kj(a,b,c){Jj(a);Dj(a,c);Dj(a,~c);N.rb(a.T,a.window,b,c,a.pending);a.pending+=c}
function Lj(a,b,c,d){var e=2*b,f=2*c;return a[e]<a[f]||a[e]===a[f]&&d[b]<=d[c]}
function Mj(a,b,c){for(var d=a.U[c],e=c<<1;e<=a.La;){e<a.La&&Lj(b,a.U[e+1],a.U[e],a.depth)&&e++;if(Lj(b,d,a.U[e],a.depth))break;a.U[c]=a.U[e];c=e;e<<=1}a.U[c]=d}
function Nj(a,b,c){var d=0;if(0!==a.sa){do{var e=a.T[a.Mb+2*d]<<8|a.T[a.Mb+2*d+1];var f=a.T[a.Ic+d];d++;if(0===e)Fj(a,f,b);else{var g=vj[f];Fj(a,g+256+1,b);var h=oj[g];0!==h&&(f-=wj[g],Ej(a,f,h));e--;g=256>e?uj[e]:uj[256+(e>>>7)];Fj(a,g,c);h=pj[g];0!==h&&(e-=xj[g],Ej(a,e,h))}}while(d<a.sa)}Fj(a,256,b)}
function Oj(a,b){var c=b.jd,d=b.Wa.Gd,e=b.Wa.od,f=b.Wa.ae,g,h=-1;a.La=0;a.yb=573;for(g=0;g<f;g++)0!==c[2*g]?(a.U[++a.La]=h=g,a.depth[g]=0):c[2*g+1]=0;for(;2>a.La;){var k=a.U[++a.La]=2>h?++h:0;c[2*k]=1;a.depth[k]=0;a.Na--;e&&(a.Fb-=d[2*k+1])}b.Bb=h;for(g=a.La>>1;1<=g;g--)Mj(a,c,g);k=f;do g=a.U[1],a.U[1]=a.U[a.La--],Mj(a,c,1),d=a.U[1],a.U[--a.yb]=g,a.U[--a.yb]=d,c[2*k]=c[2*g]+c[2*d],a.depth[k]=(a.depth[g]>=a.depth[d]?a.depth[g]:a.depth[d])+1,c[2*g+1]=c[2*d+1]=k,a.U[1]=k++,Mj(a,c,1);while(2<=a.La);a.U[--a.yb]=
a.U[1];g=b.jd;k=b.Bb;d=b.Wa.Gd;e=b.Wa.od;f=b.Wa.ge;var l=b.Wa.ee,n=b.Wa.ze,p,t=0;for(p=0;15>=p;p++)a.Ia[p]=0;g[2*a.U[a.yb]+1]=0;for(b=a.yb+1;573>b;b++){var r=a.U[b];p=g[2*g[2*r+1]+1]+1;p>n&&(p=n,t++);g[2*r+1]=p;if(!(r>k)){a.Ia[p]++;var x=0;r>=l&&(x=f[r-l]);var y=g[2*r];a.Na+=y*(p+x);e&&(a.Fb+=y*(d[2*r+1]+x))}}if(0!==t){do{for(p=n-1;0===a.Ia[p];)p--;a.Ia[p]--;a.Ia[p+1]+=2;a.Ia[n]--;t-=2}while(0<t);for(p=n;0!==p;p--)for(r=a.Ia[p];0!==r;)d=a.U[--b],d>k||(g[2*d+1]!==p&&(a.Na+=(p-g[2*d+1])*g[2*d],g[2*
d+1]=p),r--)}Hj(c,h,a.Ia)}
function Pj(a,b,c){var d,e=-1,f=b[1],g=0,h=7,k=4;0===f&&(h=138,k=3);b[2*(c+1)+1]=65535;for(d=0;d<=c;d++){var l=f;f=b[2*(d+1)+1];++g<h&&l===f||(g<k?a.da[2*l]+=g:0!==l?(l!==e&&a.da[2*l]++,a.da[32]++):10>=g?a.da[34]++:a.da[36]++,g=0,e=l,0===f?(h=138,k=3):l===f?(h=6,k=3):(h=7,k=4))}}
function Qj(a,b,c){var d,e=-1,f=b[1],g=0,h=7,k=4;0===f&&(h=138,k=3);for(d=0;d<=c;d++){var l=f;f=b[2*(d+1)+1];if(!(++g<h&&l===f)){if(g<k){do Fj(a,l,a.da);while(0!==--g)}else 0!==l?(l!==e&&(Fj(a,l,a.da),g--),Fj(a,16,a.da),Ej(a,g-3,2)):10>=g?(Fj(a,17,a.da),Ej(a,g-3,3)):(Fj(a,18,a.da),Ej(a,g-11,7));g=0;e=l;0===f?(h=138,k=3):l===f?(h=6,k=3):(h=7,k=4)}}}
function Rj(a){var b=4093624447,c;for(c=0;31>=c;c++,b>>>=1)if(b&1&&0!==a.la[2*c])return 0;if(0!==a.la[18]||0!==a.la[20]||0!==a.la[26])return 1;for(c=32;256>c;c++)if(0!==a.la[2*c])return 1;return 0}
var Sj=!1;function Tj(a,b,c){a.T[a.Mb+2*a.sa]=b>>>8&255;a.T[a.Mb+2*a.sa+1]=b&255;a.T[a.Ic+a.sa]=c&255;a.sa++;0===b?a.la[2*c]++:(a.matches++,b--,a.la[2*(vj[c]+256+1)]++,a.eb[2*(256>b?uj[b]:uj[256+(b>>>7)])]++);return a.sa===a.Pb-1}
;function Uj(a,b){a.msg=mj[b];return b}
function Vj(a){for(var b=a.length;0<=--b;)a[b]=0}
function Wj(a){var b=a.state,c=b.pending;c>a.J&&(c=a.J);0!==c&&(N.rb(a.output,b.T,b.Qb,c,a.Db),a.Db+=c,b.Qb+=c,a.Tc+=c,a.J-=c,b.pending-=c,0===b.pending&&(b.Qb=0))}
function Xj(a,b){var c=0<=a.na?a.na:-1,d=a.o-a.na,e=0;if(0<a.level){2===a.G.yc&&(a.G.yc=Rj(a));Oj(a,a.ic);Oj(a,a.dc);Pj(a,a.la,a.ic.Bb);Pj(a,a.eb,a.dc.Bb);Oj(a,a.bd);for(e=18;3<=e&&0===a.da[2*rj[e]+1];e--);a.Na+=3*(e+1)+14;var f=a.Na+3+7>>>3;var g=a.Fb+3+7>>>3;g<=f&&(f=g)}else f=g=d+5;if(d+4<=f&&-1!==c)Ej(a,b?1:0,3),Kj(a,c,d);else if(4===a.strategy||g===f)Ej(a,2+(b?1:0),3),Nj(a,sj,tj);else{Ej(a,4+(b?1:0),3);c=a.ic.Bb+1;d=a.dc.Bb+1;e+=1;Ej(a,c-257,5);Ej(a,d-1,5);Ej(a,e-4,4);for(f=0;f<e;f++)Ej(a,a.da[2*
rj[f]+1],3);Qj(a,a.la,c-1);Qj(a,a.eb,d-1);Nj(a,a.la,a.eb)}Ij(a);b&&Jj(a);a.na=a.o;Wj(a.G)}
function O(a,b){a.T[a.pending++]=b}
function Yj(a,b){a.T[a.pending++]=b>>>8&255;a.T[a.pending++]=b&255}
function Zj(a,b){var c=a.rd,d=a.o,e=a.ra,f=a.td,g=a.o>a.ga-262?a.o-(a.ga-262):0,h=a.window,k=a.Ya,l=a.Fa,n=a.o+258,p=h[d+e-1],t=h[d+e];a.ra>=a.nd&&(c>>=2);f>a.u&&(f=a.u);do{var r=b;if(h[r+e]===t&&h[r+e-1]===p&&h[r]===h[d]&&h[++r]===h[d+1]){d+=2;for(r++;h[++d]===h[++r]&&h[++d]===h[++r]&&h[++d]===h[++r]&&h[++d]===h[++r]&&h[++d]===h[++r]&&h[++d]===h[++r]&&h[++d]===h[++r]&&h[++d]===h[++r]&&d<n;);r=258-(n-d);d=n-258;if(r>e){a.Ab=b;e=r;if(r>=f)break;p=h[d+e-1];t=h[d+e]}}}while((b=l[b&k])>g&&0!==--c);return e<=
a.u?e:a.u}
function ak(a){var b=a.ga,c;do{var d=a.Md-a.u-a.o;if(a.o>=b+(b-262)){N.rb(a.window,a.window,b,b,0);a.Ab-=b;a.o-=b;a.na-=b;var e=c=a.hc;do{var f=a.head[--e];a.head[e]=f>=b?f-b:0}while(--c);e=c=b;do f=a.Fa[--e],a.Fa[e]=f>=b?f-b:0;while(--c);d+=b}if(0===a.G.ha)break;e=a.G;c=a.window;f=a.o+a.u;var g=e.ha;g>d&&(g=d);0===g?c=0:(e.ha-=g,N.rb(c,e.input,e.ib,g,f),1===e.state.wrap?e.F=gj(e.F,c,g,f):2===e.state.wrap&&(e.F=hj(e.F,c,g,f)),e.ib+=g,e.mb+=g,c=g);a.u+=c;if(3<=a.u+a.ma)for(d=a.o-a.ma,a.I=a.window[d],
a.I=(a.I<<a.Ka^a.window[d+1])&a.Ja;a.ma&&!(a.I=(a.I<<a.Ka^a.window[d+3-1])&a.Ja,a.Fa[d&a.Ya]=a.head[a.I],a.head[a.I]=d,d++,a.ma--,3>a.u+a.ma););}while(262>a.u&&0!==a.G.ha)}
function bk(a,b){for(var c;;){if(262>a.u){ak(a);if(262>a.u&&0===b)return 1;if(0===a.u)break}c=0;3<=a.u&&(a.I=(a.I<<a.Ka^a.window[a.o+3-1])&a.Ja,c=a.Fa[a.o&a.Ya]=a.head[a.I],a.head[a.I]=a.o);0!==c&&a.o-c<=a.ga-262&&(a.K=Zj(a,c));if(3<=a.K)if(c=Tj(a,a.o-a.Ab,a.K-3),a.u-=a.K,a.K<=a.Jc&&3<=a.u){a.K--;do a.o++,a.I=(a.I<<a.Ka^a.window[a.o+3-1])&a.Ja,a.Fa[a.o&a.Ya]=a.head[a.I],a.head[a.I]=a.o;while(0!==--a.K);a.o++}else a.o+=a.K,a.K=0,a.I=a.window[a.o],a.I=(a.I<<a.Ka^a.window[a.o+1])&a.Ja;else c=Tj(a,0,
a.window[a.o]),a.u--,a.o++;if(c&&(Xj(a,!1),0===a.G.J))return 1}a.ma=2>a.o?a.o:2;return 4===b?(Xj(a,!0),0===a.G.J?3:4):a.sa&&(Xj(a,!1),0===a.G.J)?1:2}
function ck(a,b){for(var c,d;;){if(262>a.u){ak(a);if(262>a.u&&0===b)return 1;if(0===a.u)break}c=0;3<=a.u&&(a.I=(a.I<<a.Ka^a.window[a.o+3-1])&a.Ja,c=a.Fa[a.o&a.Ya]=a.head[a.I],a.head[a.I]=a.o);a.ra=a.K;a.wd=a.Ab;a.K=2;0!==c&&a.ra<a.Jc&&a.o-c<=a.ga-262&&(a.K=Zj(a,c),5>=a.K&&(1===a.strategy||3===a.K&&4096<a.o-a.Ab)&&(a.K=2));if(3<=a.ra&&a.K<=a.ra){d=a.o+a.u-3;c=Tj(a,a.o-1-a.wd,a.ra-3);a.u-=a.ra-1;a.ra-=2;do++a.o<=d&&(a.I=(a.I<<a.Ka^a.window[a.o+3-1])&a.Ja,a.Fa[a.o&a.Ya]=a.head[a.I],a.head[a.I]=a.o);
while(0!==--a.ra);a.gb=0;a.K=2;a.o++;if(c&&(Xj(a,!1),0===a.G.J))return 1}else if(a.gb){if((c=Tj(a,0,a.window[a.o-1]))&&Xj(a,!1),a.o++,a.u--,0===a.G.J)return 1}else a.gb=1,a.o++,a.u--}a.gb&&(Tj(a,0,a.window[a.o-1]),a.gb=0);a.ma=2>a.o?a.o:2;return 4===b?(Xj(a,!0),0===a.G.J?3:4):a.sa&&(Xj(a,!1),0===a.G.J)?1:2}
function dk(a,b){for(var c,d,e,f=a.window;;){if(258>=a.u){ak(a);if(258>=a.u&&0===b)return 1;if(0===a.u)break}a.K=0;if(3<=a.u&&0<a.o&&(d=a.o-1,c=f[d],c===f[++d]&&c===f[++d]&&c===f[++d])){for(e=a.o+258;c===f[++d]&&c===f[++d]&&c===f[++d]&&c===f[++d]&&c===f[++d]&&c===f[++d]&&c===f[++d]&&c===f[++d]&&d<e;);a.K=258-(e-d);a.K>a.u&&(a.K=a.u)}3<=a.K?(c=Tj(a,1,a.K-3),a.u-=a.K,a.o+=a.K,a.K=0):(c=Tj(a,0,a.window[a.o]),a.u--,a.o++);if(c&&(Xj(a,!1),0===a.G.J))return 1}a.ma=0;return 4===b?(Xj(a,!0),0===a.G.J?3:4):
a.sa&&(Xj(a,!1),0===a.G.J)?1:2}
function ek(a,b){for(var c;;){if(0===a.u&&(ak(a),0===a.u)){if(0===b)return 1;break}a.K=0;c=Tj(a,0,a.window[a.o]);a.u--;a.o++;if(c&&(Xj(a,!1),0===a.G.J))return 1}a.ma=0;return 4===b?(Xj(a,!0),0===a.G.J?3:4):a.sa&&(Xj(a,!1),0===a.G.J)?1:2}
function fk(a,b,c,d,e){this.ne=a;this.ye=b;this.Be=c;this.xe=d;this.je=e}
var gk;gk=[new fk(0,0,0,0,function(a,b){var c=65535;for(c>a.ta-5&&(c=a.ta-5);;){if(1>=a.u){ak(a);if(0===a.u&&0===b)return 1;if(0===a.u)break}a.o+=a.u;a.u=0;var d=a.na+c;if(0===a.o||a.o>=d)if(a.u=a.o-d,a.o=d,Xj(a,!1),0===a.G.J)return 1;if(a.o-a.na>=a.ga-262&&(Xj(a,!1),0===a.G.J))return 1}a.ma=0;if(4===b)return Xj(a,!0),0===a.G.J?3:4;a.o>a.na&&Xj(a,!1);return 1}),
new fk(4,4,8,4,bk),new fk(4,5,16,8,bk),new fk(4,6,32,32,bk),new fk(4,4,16,16,ck),new fk(8,16,32,32,ck),new fk(8,16,128,128,ck),new fk(8,32,128,256,ck),new fk(32,128,258,1024,ck),new fk(32,258,258,4096,ck)];
function hk(){this.G=null;this.status=0;this.T=null;this.wrap=this.pending=this.Qb=this.ta=0;this.B=null;this.za=0;this.method=8;this.zb=-1;this.Ya=this.Vc=this.ga=0;this.window=null;this.Md=0;this.head=this.Fa=null;this.td=this.nd=this.strategy=this.level=this.Jc=this.rd=this.ra=this.u=this.Ab=this.o=this.gb=this.wd=this.K=this.na=this.Ka=this.Ja=this.Fc=this.hc=this.I=0;this.la=new N.Ga(1146);this.eb=new N.Ga(122);this.da=new N.Ga(78);Vj(this.la);Vj(this.eb);Vj(this.da);this.bd=this.dc=this.ic=
null;this.Ia=new N.Ga(16);this.U=new N.Ga(573);Vj(this.U);this.yb=this.La=0;this.depth=new N.Ga(573);Vj(this.depth);this.aa=this.ia=this.ma=this.matches=this.Fb=this.Na=this.Mb=this.sa=this.Pb=this.Ic=0}
function ik(a,b){if(!a||!a.state||5<b||0>b)return a?Uj(a,-2):-2;var c=a.state;if(!a.output||!a.input&&0!==a.ha||666===c.status&&4!==b)return Uj(a,0===a.J?-5:-2);c.G=a;var d=c.zb;c.zb=b;if(42===c.status)if(2===c.wrap)a.F=0,O(c,31),O(c,139),O(c,8),c.B?(O(c,(c.B.text?1:0)+(c.B.Ta?2:0)+(c.B.Sa?4:0)+(c.B.name?8:0)+(c.B.comment?16:0)),O(c,c.B.time&255),O(c,c.B.time>>8&255),O(c,c.B.time>>16&255),O(c,c.B.time>>24&255),O(c,9===c.level?2:2<=c.strategy||2>c.level?4:0),O(c,c.B.os&255),c.B.Sa&&c.B.Sa.length&&
(O(c,c.B.Sa.length&255),O(c,c.B.Sa.length>>8&255)),c.B.Ta&&(a.F=hj(a.F,c.T,c.pending,0)),c.za=0,c.status=69):(O(c,0),O(c,0),O(c,0),O(c,0),O(c,0),O(c,9===c.level?2:2<=c.strategy||2>c.level?4:0),O(c,3),c.status=113);else{var e=8+(c.Vc-8<<4)<<8;e|=(2<=c.strategy||2>c.level?0:6>c.level?1:6===c.level?2:3)<<6;0!==c.o&&(e|=32);c.status=113;Yj(c,e+(31-e%31));0!==c.o&&(Yj(c,a.F>>>16),Yj(c,a.F&65535));a.F=1}if(69===c.status)if(c.B.Sa){for(e=c.pending;c.za<(c.B.Sa.length&65535)&&(c.pending!==c.ta||(c.B.Ta&&
c.pending>e&&(a.F=hj(a.F,c.T,c.pending-e,e)),Wj(a),e=c.pending,c.pending!==c.ta));)O(c,c.B.Sa[c.za]&255),c.za++;c.B.Ta&&c.pending>e&&(a.F=hj(a.F,c.T,c.pending-e,e));c.za===c.B.Sa.length&&(c.za=0,c.status=73)}else c.status=73;if(73===c.status)if(c.B.name){e=c.pending;do{if(c.pending===c.ta&&(c.B.Ta&&c.pending>e&&(a.F=hj(a.F,c.T,c.pending-e,e)),Wj(a),e=c.pending,c.pending===c.ta)){var f=1;break}f=c.za<c.B.name.length?c.B.name.charCodeAt(c.za++)&255:0;O(c,f)}while(0!==f);c.B.Ta&&c.pending>e&&(a.F=hj(a.F,
c.T,c.pending-e,e));0===f&&(c.za=0,c.status=91)}else c.status=91;if(91===c.status)if(c.B.comment){e=c.pending;do{if(c.pending===c.ta&&(c.B.Ta&&c.pending>e&&(a.F=hj(a.F,c.T,c.pending-e,e)),Wj(a),e=c.pending,c.pending===c.ta)){f=1;break}f=c.za<c.B.comment.length?c.B.comment.charCodeAt(c.za++)&255:0;O(c,f)}while(0!==f);c.B.Ta&&c.pending>e&&(a.F=hj(a.F,c.T,c.pending-e,e));0===f&&(c.status=103)}else c.status=103;103===c.status&&(c.B.Ta?(c.pending+2>c.ta&&Wj(a),c.pending+2<=c.ta&&(O(c,a.F&255),O(c,a.F>>
8&255),a.F=0,c.status=113)):c.status=113);if(0!==c.pending){if(Wj(a),0===a.J)return c.zb=-1,0}else if(0===a.ha&&(b<<1)-(4<b?9:0)<=(d<<1)-(4<d?9:0)&&4!==b)return Uj(a,-5);if(666===c.status&&0!==a.ha)return Uj(a,-5);if(0!==a.ha||0!==c.u||0!==b&&666!==c.status){d=2===c.strategy?ek(c,b):3===c.strategy?dk(c,b):gk[c.level].je(c,b);if(3===d||4===d)c.status=666;if(1===d||3===d)return 0===a.J&&(c.zb=-1),0;if(2===d&&(1===b?(Ej(c,2,3),Fj(c,256,sj),16===c.aa?(Dj(c,c.ia),c.ia=0,c.aa=0):8<=c.aa&&(c.T[c.pending++]=
c.ia&255,c.ia>>=8,c.aa-=8)):5!==b&&(Ej(c,0,3),Kj(c,0,0),3===b&&(Vj(c.head),0===c.u&&(c.o=0,c.na=0,c.ma=0))),Wj(a),0===a.J))return c.zb=-1,0}if(4!==b)return 0;if(0>=c.wrap)return 1;2===c.wrap?(O(c,a.F&255),O(c,a.F>>8&255),O(c,a.F>>16&255),O(c,a.F>>24&255),O(c,a.mb&255),O(c,a.mb>>8&255),O(c,a.mb>>16&255),O(c,a.mb>>24&255)):(Yj(c,a.F>>>16),Yj(c,a.F&65535));Wj(a);0<c.wrap&&(c.wrap=-c.wrap);return 0!==c.pending?0:1}
;var jk={};jk=function(){this.input=null;this.mb=this.ha=this.ib=0;this.output=null;this.Tc=this.J=this.Db=0;this.msg="";this.state=null;this.yc=2;this.F=0};var kk=Object.prototype.toString;
function lk(a){if(!(this instanceof lk))return new lk(a);a=this.options=N.assign({level:-1,method:8,chunkSize:16384,windowBits:15,memLevel:8,strategy:0,to:""},a||{});a.raw&&0<a.windowBits?a.windowBits=-a.windowBits:a.gzip&&0<a.windowBits&&16>a.windowBits&&(a.windowBits+=16);this.err=0;this.msg="";this.ended=!1;this.chunks=[];this.G=new jk;this.G.J=0;var b=this.G;var c=a.level,d=a.method,e=a.windowBits,f=a.memLevel,g=a.strategy;if(b){var h=1;-1===c&&(c=6);0>e?(h=0,e=-e):15<e&&(h=2,e-=16);if(1>f||9<
f||8!==d||8>e||15<e||0>c||9<c||0>g||4<g)b=Uj(b,-2);else{8===e&&(e=9);var k=new hk;b.state=k;k.G=b;k.wrap=h;k.B=null;k.Vc=e;k.ga=1<<k.Vc;k.Ya=k.ga-1;k.Fc=f+7;k.hc=1<<k.Fc;k.Ja=k.hc-1;k.Ka=~~((k.Fc+3-1)/3);k.window=new N.pb(2*k.ga);k.head=new N.Ga(k.hc);k.Fa=new N.Ga(k.ga);k.Pb=1<<f+6;k.ta=4*k.Pb;k.T=new N.pb(k.ta);k.Mb=1*k.Pb;k.Ic=3*k.Pb;k.level=c;k.strategy=g;k.method=d;if(b&&b.state){b.mb=b.Tc=0;b.yc=2;c=b.state;c.pending=0;c.Qb=0;0>c.wrap&&(c.wrap=-c.wrap);c.status=c.wrap?42:113;b.F=2===c.wrap?
0:1;c.zb=0;if(!Sj){d=Array(16);for(f=g=0;28>f;f++)for(wj[f]=g,e=0;e<1<<oj[f];e++)vj[g++]=f;vj[g-1]=f;for(f=g=0;16>f;f++)for(xj[f]=g,e=0;e<1<<pj[f];e++)uj[g++]=f;for(g>>=7;30>f;f++)for(xj[f]=g<<7,e=0;e<1<<pj[f]-7;e++)uj[256+g++]=f;for(e=0;15>=e;e++)d[e]=0;for(e=0;143>=e;)sj[2*e+1]=8,e++,d[8]++;for(;255>=e;)sj[2*e+1]=9,e++,d[9]++;for(;279>=e;)sj[2*e+1]=7,e++,d[7]++;for(;287>=e;)sj[2*e+1]=8,e++,d[8]++;Hj(sj,287,d);for(e=0;30>e;e++)tj[2*e+1]=5,tj[2*e]=Gj(e,5);zj=new yj(sj,oj,257,286,15);Aj=new yj(tj,
pj,0,30,15);Bj=new yj([],qj,0,19,7);Sj=!0}c.ic=new Cj(c.la,zj);c.dc=new Cj(c.eb,Aj);c.bd=new Cj(c.da,Bj);c.ia=0;c.aa=0;Ij(c);c=0}else c=Uj(b,-2);0===c&&(b=b.state,b.Md=2*b.ga,Vj(b.head),b.Jc=gk[b.level].ye,b.nd=gk[b.level].ne,b.td=gk[b.level].Be,b.rd=gk[b.level].xe,b.o=0,b.na=0,b.u=0,b.ma=0,b.K=b.ra=2,b.gb=0,b.I=0);b=c}}else b=-2;if(0!==b)throw Error(mj[b]);a.header&&(b=this.G)&&b.state&&2===b.state.wrap&&(b.state.B=a.header);if(a.dictionary){var l;"string"===typeof a.dictionary?l=fj(a.dictionary):
"[object ArrayBuffer]"===kk.call(a.dictionary)?l=new Uint8Array(a.dictionary):l=a.dictionary;a=this.G;f=l;g=f.length;if(a&&a.state)if(l=a.state,b=l.wrap,2===b||1===b&&42!==l.status||l.u)b=-2;else{1===b&&(a.F=gj(a.F,f,g,0));l.wrap=0;g>=l.ga&&(0===b&&(Vj(l.head),l.o=0,l.na=0,l.ma=0),c=new N.pb(l.ga),N.rb(c,f,g-l.ga,l.ga,0),f=c,g=l.ga);c=a.ha;d=a.ib;e=a.input;a.ha=g;a.ib=0;a.input=f;for(ak(l);3<=l.u;){f=l.o;g=l.u-2;do l.I=(l.I<<l.Ka^l.window[f+3-1])&l.Ja,l.Fa[f&l.Ya]=l.head[l.I],l.head[l.I]=f,f++;while(--g);
l.o=f;l.u=2;ak(l)}l.o+=l.u;l.na=l.o;l.ma=l.u;l.u=0;l.K=l.ra=2;l.gb=0;a.ib=d;a.input=e;a.ha=c;l.wrap=b;b=0}else b=-2;if(0!==b)throw Error(mj[b]);this.Gf=!0}}
lk.prototype.push=function(a,b){var c=this.G,d=this.options.chunkSize;if(this.ended)return!1;var e=b===~~b?b:!0===b?4:0;"string"===typeof a?c.input=fj(a):"[object ArrayBuffer]"===kk.call(a)?c.input=new Uint8Array(a):c.input=a;c.ib=0;c.ha=c.input.length;do{0===c.J&&(c.output=new N.pb(d),c.Db=0,c.J=d);a=ik(c,e);if(1!==a&&0!==a)return mk(this,a),this.ended=!0,!1;if(0===c.J||0===c.ha&&(4===e||2===e))if("string"===this.options.to){var f=N.Sc(c.output,c.Db);b=f;f=f.length;if(65537>f&&(b.subarray&&ej||!b.subarray))b=
String.fromCharCode.apply(null,N.Sc(b,f));else{for(var g="",h=0;h<f;h++)g+=String.fromCharCode(b[h]);b=g}this.chunks.push(b)}else b=N.Sc(c.output,c.Db),this.chunks.push(b)}while((0<c.ha||0===c.J)&&1!==a);if(4===e)return(c=this.G)&&c.state?(d=c.state.status,42!==d&&69!==d&&73!==d&&91!==d&&103!==d&&113!==d&&666!==d?a=Uj(c,-2):(c.state=null,a=113===d?Uj(c,-3):0)):a=-2,mk(this,a),this.ended=!0,0===a;2===e&&(mk(this,0),c.J=0);return!0};
function mk(a,b){0===b&&(a.result="string"===a.options.to?a.chunks.join(""):N.kd(a.chunks));a.chunks=[];a.err=b;a.msg=a.G.msg}
function nk(a,b){b=b||{};b.gzip=!0;b=new lk(b);b.push(a,!0);if(b.err)throw b.msg||mj[b.err];return b.result}
;function ok(a){return Db(null===a?"null":void 0===a?"undefined":a)}
;function pk(a){this.name=a}
;var qk=new pk("rawColdConfigGroup");var rk=new pk("rawHotConfigGroup");var sk=new pk("commandExecutorCommand");function tk(a){this.D=Pf(a)}
w(tk,lg);var uk=new pk("continuationCommand");var vk=new pk("signalAction");var wk=new pk("webCommandMetadata");var xk=new pk("signalServiceEndpoint");var yk={wf:"EMBEDDED_PLAYER_MODE_UNKNOWN",tf:"EMBEDDED_PLAYER_MODE_DEFAULT",vf:"EMBEDDED_PLAYER_MODE_PFP",uf:"EMBEDDED_PLAYER_MODE_PFL"};var zk=new pk("feedbackEndpoint");function Ak(a){this.D=Pf(a)}
w(Ak,lg);var Bk=new pk("webPlayerShareEntityServiceEndpoint");var Ck=new pk("playlistEditEndpoint");var Dk=new pk("modifyChannelNotificationPreferenceEndpoint");var Ek=new pk("unsubscribeEndpoint");var Fk=new pk("subscribeEndpoint");function Gk(){var a=Hk;E("yt.ads.biscotti.getId_")||D("yt.ads.biscotti.getId_",a)}
function Ik(a){D("yt.ads.biscotti.lastId_",a)}
;function Jk(a,b){1<b.length?a[b[0]]=b[1]:1===b.length&&Object.assign(a,b[0])}
;var Kk=C.window,Lk,Mk,Nk=(null==Kk?void 0:null==(Lk=Kk.yt)?void 0:Lk.config_)||(null==Kk?void 0:null==(Mk=Kk.ytcfg)?void 0:Mk.data_)||{};D("yt.config_",Nk);function Ok(){Jk(Nk,arguments)}
function R(a,b){return a in Nk?Nk[a]:b}
function Pk(a){var b=Nk.EXPERIMENT_FLAGS;return b?b[a]:void 0}
;var Qk=[];function Rk(a){Qk.forEach(function(b){return b(a)})}
function Sk(a){return a&&window.yterr?function(){try{return a.apply(this,arguments)}catch(b){Tk(b)}}:a}
function Tk(a){var b=E("yt.logging.errors.log");b?b(a,"ERROR",void 0,void 0,void 0,void 0,void 0):(b=R("ERRORS",[]),b.push([a,"ERROR",void 0,void 0,void 0,void 0,void 0]),Ok("ERRORS",b));Rk(a)}
function Uk(a,b,c,d,e){var f=E("yt.logging.errors.log");f?f(a,"WARNING",b,c,d,void 0,e):(f=R("ERRORS",[]),f.push([a,"WARNING",b,c,d,void 0,e]),Ok("ERRORS",f))}
;var Vk=/^[\w.]*$/,Wk={q:!0,search_query:!0};function Xk(a,b){b=a.split(b);for(var c={},d=0,e=b.length;d<e;d++){var f=b[d].split("=");if(1==f.length&&f[0]||2==f.length)try{var g=Yk(f[0]||""),h=Yk(f[1]||"");g in c?Array.isArray(c[g])?hb(c[g],h):c[g]=[c[g],h]:c[g]=h}catch(p){var k=p,l=f[0],n=String(Xk);k.args=[{key:l,value:f[1],query:a,method:Zk==n?"unchanged":n}];Wk.hasOwnProperty(l)||Uk(k)}}return c}
var Zk=String(Xk);function $k(a){var b=[];ib(a,function(c,d){var e=encodeURIComponent(String(d)),f;Array.isArray(c)?f=c:f=[c];bb(f,function(g){""==g?b.push(e):b.push(e+"="+encodeURIComponent(String(g)))})});
return b.join("&")}
function al(a){"?"==a.charAt(0)&&(a=a.substr(1));return Xk(a,"&")}
function bl(a){return-1!=a.indexOf("?")?(a=(a||"").split("#")[0],a=a.split("?",2),al(1<a.length?a[1]:a[0])):{}}
function cl(a,b,c){var d=a.split("#",2);a=d[0];d=1<d.length?"#"+d[1]:"";var e=a.split("?",2);a=e[0];e=al(e[1]||"");for(var f in b)!c&&null!==e&&f in e||(e[f]=b[f]);return zc(a,e)+d}
function dl(a){if(!b)var b=window.location.href;var c=qc(1,a),d=rc(a);c&&d?(a=a.match(oc),b=b.match(oc),a=a[3]==b[3]&&a[1]==b[1]&&a[4]==b[4]):a=d?rc(b)==d&&(Number(qc(4,b))||null)==(Number(qc(4,a))||null):!0;return a}
function Yk(a){return a&&a.match(Vk)?a:decodeURIComponent(a.replace(/\+/g," "))}
;function el(a){var b=fl;a=void 0===a?E("yt.ads.biscotti.lastId_")||"":a;var c=Object,d=c.assign,e={};e.dt=gi;e.flash="0";a:{try{var f=b.h.top.location.href}catch(Ha){f=2;break a}f=f?f===b.i.location.href?0:1:2}e=(e.frm=f,e);try{e.u_tz=-(new Date).getTimezoneOffset();var g=void 0===g?Lh:g;try{var h=g.history.length}catch(Ha){h=0}e.u_his=h;var k;e.u_h=null==(k=Lh.screen)?void 0:k.height;var l;e.u_w=null==(l=Lh.screen)?void 0:l.width;var n;e.u_ah=null==(n=Lh.screen)?void 0:n.availHeight;var p;e.u_aw=
null==(p=Lh.screen)?void 0:p.availWidth;var t;e.u_cd=null==(t=Lh.screen)?void 0:t.colorDepth}catch(Ha){}h=b.h;try{var r=h.screenX;var x=h.screenY}catch(Ha){}try{var y=h.outerWidth;var z=h.outerHeight}catch(Ha){}try{var H=h.innerWidth;var I=h.innerHeight}catch(Ha){}try{var L=h.screenLeft;var P=h.screenTop}catch(Ha){}try{H=h.innerWidth,I=h.innerHeight}catch(Ha){}try{var J=h.screen.availWidth;var V=h.screen.availTop}catch(Ha){}r=[L,P,r,x,J,V,y,z,H,I];try{var Z=(b.h.top||window).document,ca="CSS1Compat"==
Z.compatMode?Z.documentElement:Z.body;var ra=(new Vd(ca.clientWidth,ca.clientHeight)).round()}catch(Ha){ra=new Vd(-12245933,-12245933)}Z=ra;ra={};var ma=void 0===ma?C:ma;ca=new pi;"SVGElement"in ma&&"createElementNS"in ma.document&&ca.set(0);x=di();x["allow-top-navigation-by-user-activation"]&&ca.set(1);x["allow-popups-to-escape-sandbox"]&&ca.set(2);ma.crypto&&ma.crypto.subtle&&ca.set(3);"TextDecoder"in ma&&"TextEncoder"in ma&&ca.set(4);ma=qi(ca);ra.bc=ma;ra.bih=Z.height;ra.biw=Z.width;ra.brdim=r.join();
b=b.i;b=(ra.vis=b.prerendering?3:{visible:1,hidden:2,prerender:3,preview:4,unloaded:5}[b.visibilityState||b.webkitVisibilityState||b.mozVisibilityState||""]||0,ra.wgl=!!Lh.WebGLRenderingContext,ra);c=d.call(c,e,b);c.ca_type="image";a&&(c.bid=a);return c}
var fl=new function(){var a=window.document;this.h=window;this.i=a};
D("yt.ads_.signals_.getAdSignalsString",function(a){return $k(el(a))});Date.now();navigator.userAgent.indexOf(" (CrKey ");function S(a){a=gl(a);return"string"===typeof a&&"false"===a?!1:!!a}
function hl(a,b){a=gl(a);return void 0===a&&void 0!==b?b:Number(a||0)}
function gl(a){var b=R("EXPERIMENTS_FORCED_FLAGS",{})||{};return void 0!==b[a]?b[a]:R("EXPERIMENT_FLAGS",{})[a]}
function il(){for(var a=[],b=R("EXPERIMENTS_FORCED_FLAGS",{}),c=v(Object.keys(b)),d=c.next();!d.done;d=c.next())d=d.value,a.push({key:d,value:String(b[d])});c=R("EXPERIMENT_FLAGS",{});var e=v(Object.keys(c));for(d=e.next();!d.done;d=e.next())d=d.value,d.startsWith("force_")&&void 0===b[d]&&a.push({key:d,value:String(c[d])});return a}
;var jl="XMLHttpRequest"in C?function(){return new XMLHttpRequest}:null;
function kl(){if(!jl)return null;var a=jl();return"open"in a?a:null}
function ll(a){switch(a&&"status"in a?a.status:-1){case 200:case 201:case 202:case 203:case 204:case 205:case 206:case 304:return!0;default:return!1}}
;function ml(a,b){"function"===typeof a&&(a=Sk(a));return window.setTimeout(a,b)}
;var nl={Authorization:"AUTHORIZATION","X-Goog-EOM-Visitor-Id":"EOM_VISITOR_DATA","X-Goog-Visitor-Id":"SANDBOXED_VISITOR_ID","X-Youtube-Domain-Admin-State":"DOMAIN_ADMIN_STATE","X-Youtube-Chrome-Connected":"CHROME_CONNECTED_HEADER","X-YouTube-Client-Name":"INNERTUBE_CONTEXT_CLIENT_NAME","X-YouTube-Client-Version":"INNERTUBE_CONTEXT_CLIENT_VERSION","X-YouTube-Delegation-Context":"INNERTUBE_CONTEXT_SERIALIZED_DELEGATION_CONTEXT","X-YouTube-Device":"DEVICE","X-Youtube-Identity-Token":"ID_TOKEN","X-YouTube-Page-CL":"PAGE_CL",
"X-YouTube-Page-Label":"PAGE_BUILD_LABEL","X-YouTube-Variants-Checksum":"VARIANTS_CHECKSUM","X-Goog-AuthUser":"SESSION_INDEX","X-Goog-PageId":"DELEGATED_SESSION_ID"},ol="app debugcss debugjs expflag force_ad_params force_ad_encrypted force_viral_ad_response_params forced_experiments innertube_snapshots innertube_goldens internalcountrycode internalipoverride absolute_experiments conditional_experiments sbb sr_bns_address".split(" ").concat(ja(hi)),pl=!1;
function ql(a,b){b=void 0===b?{}:b;var c=dl(a),d=S("web_ajax_ignore_global_headers_if_set"),e;for(e in nl){var f=R(nl[e]),g="X-Goog-AuthUser"===e||"X-Goog-PageId"===e;"X-Goog-Visitor-Id"!==e||f||(f=R("VISITOR_DATA"));!f||!c&&rc(a)||d&&void 0!==b[e]||(!S("move_vss_away_from_login_info_cookie")||"TVHTML5_UNPLUGGED"===R("INNERTUBE_CLIENT_NAME"))&&g||(b[e]=f)}S("move_vss_away_from_login_info_cookie")&&c&&R("SESSION_INDEX")&&"TVHTML5_UNPLUGGED"!==R("INNERTUBE_CLIENT_NAME")&&(b["X-Yt-Auth-Test"]="test");
"X-Goog-EOM-Visitor-Id"in b&&"X-Goog-Visitor-Id"in b&&delete b["X-Goog-Visitor-Id"];if(c||!rc(a))b["X-YouTube-Utc-Offset"]=String(-(new Date).getTimezoneOffset());if(c||!rc(a)){try{var h=(new Intl.DateTimeFormat).resolvedOptions().timeZone}catch(k){}h&&(b["X-YouTube-Time-Zone"]=h)}document.location.hostname.endsWith("youtubeeducation.com")||!c&&rc(a)||(b["X-YouTube-Ad-Signals"]=$k(el()));return b}
function rl(a){var b=window.location.search,c=rc(a);S("debug_handle_relative_url_for_query_forward_killswitch")||!c&&dl(a)&&(c=document.location.hostname);var d=pc(qc(5,a));d=(c=c&&(c.endsWith("youtube.com")||c.endsWith("youtube-nocookie.com")))&&d&&d.startsWith("/api/");if(!c||d)return a;var e=al(b),f={};bb(ol,function(g){e[g]&&(f[g]=e[g])});
return cl(a,f||{},!1)}
function sl(a,b){var c=b.format||"JSON";a=tl(a,b);var d=ul(a,b),e=!1,f=vl(a,function(k){if(!e){e=!0;h&&window.clearTimeout(h);var l=ll(k),n=null,p=400<=k.status&&500>k.status,t=500<=k.status&&600>k.status;if(l||p||t)n=wl(a,c,k,b.convertToSafeHtml);if(l)a:if(k&&204==k.status)l=!0;else{switch(c){case "XML":l=0==parseInt(n&&n.return_code,10);break a;case "RAW":l=!0;break a}l=!!n}n=n||{};p=b.context||C;l?b.onSuccess&&b.onSuccess.call(p,k,n):b.onError&&b.onError.call(p,k,n);b.onFinish&&b.onFinish.call(p,
k,n)}},b.method,d,b.headers,b.responseType,b.withCredentials);
d=b.timeout||0;if(b.onTimeout&&0<d){var g=b.onTimeout;var h=ml(function(){e||(e=!0,f.abort(),window.clearTimeout(h),g.call(b.context||C,f))},d)}return f}
function tl(a,b){b.includeDomain&&(a=document.location.protocol+"//"+document.location.hostname+(document.location.port?":"+document.location.port:"")+a);var c=R("XSRF_FIELD_NAME");if(b=b.urlParams)b[c]&&delete b[c],a=cl(a,b||{},!0);return a}
function ul(a,b){var c=R("XSRF_FIELD_NAME"),d=R("XSRF_TOKEN"),e=b.postBody||"",f=b.postParams,g=R("XSRF_FIELD_NAME"),h;b.headers&&(h=b.headers["Content-Type"]);b.excludeXsrf||rc(a)&&!b.withCredentials&&rc(a)!=document.location.hostname||"POST"!=b.method||h&&"application/x-www-form-urlencoded"!=h||b.postParams&&b.postParams[g]||(f||(f={}),f[c]=d);(S("ajax_parse_query_data_only_when_filled")&&f&&0<Object.keys(f).length||f)&&"string"===typeof e&&(e=al(e),sb(e,f),e=b.postBodyFormat&&"JSON"==b.postBodyFormat?
JSON.stringify(e):xc(e));f=e||f&&!lb(f);!pl&&f&&"POST"!=b.method&&(pl=!0,Tk(Error("AJAX request with postData should use POST")));return e}
function wl(a,b,c,d){var e=null;switch(b){case "JSON":try{var f=c.responseText}catch(g){throw d=Error("Error reading responseText"),d.params=a,Uk(d),g;}a=c.getResponseHeader("Content-Type")||"";f&&0<=a.indexOf("json")&&(")]}'\n"===f.substring(0,5)&&(f=f.substring(5)),e=JSON.parse(f));break;case "XML":if(a=(a=c.responseXML)?xl(a):null)e={},bb(a.getElementsByTagName("*"),function(g){e[g.tagName]=yl(g)})}d&&zl(e);
return e}
function zl(a){if(Na(a))for(var b in a){var c;(c="html_content"==b)||(c=b.length-5,c=0<=c&&b.indexOf("_html",c)==c);if(c){c=b;var d=a[b],e=ub();d=e?e.createHTML(d):d;a[c]=new hc(d)}else zl(a[b])}}
function xl(a){return a?(a=("responseXML"in a?a.responseXML:a).getElementsByTagName("root"))&&0<a.length?a[0]:null:null}
function yl(a){var b="";bb(a.childNodes,function(c){b+=c.nodeValue});
return b}
function Al(a,b){b.method="POST";b.postParams||(b.postParams={});return sl(a,b)}
function vl(a,b,c,d,e,f,g,h){function k(){4==(l&&"readyState"in l?l.readyState:0)&&b&&Sk(b)(l)}
c=void 0===c?"GET":c;d=void 0===d?"":d;h=void 0===h?!1:h;var l=kl();if(!l)return null;"onloadend"in l?l.addEventListener("loadend",k,!1):l.onreadystatechange=k;S("debug_forward_web_query_parameters")&&(a=rl(a));l.open(c,a,!0);f&&(l.responseType=f);g&&(l.withCredentials=!0);c="POST"==c&&(void 0===window.FormData||!(d instanceof FormData));if(e=ql(a,e))for(var n in e)l.setRequestHeader(n,e[n]),"content-type"==n.toLowerCase()&&(c=!1);c&&l.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
h&&"setAttributionReporting"in XMLHttpRequest.prototype&&l.setAttributionReporting({eventSourceEligible:!0,triggerEligible:!1});l.send(d);return l}
;var Bl=[{Kc:function(a){return"Cannot read property '"+a.key+"'"},
kc:{Error:[{regexp:/(Permission denied) to access property "([^']+)"/,groups:["reason","key"]}],TypeError:[{regexp:/Cannot read property '([^']+)' of (null|undefined)/,groups:["key","value"]},{regexp:/\u65e0\u6cd5\u83b7\u53d6\u672a\u5b9a\u4e49\u6216 (null|undefined) \u5f15\u7528\u7684\u5c5e\u6027\u201c([^\u201d]+)\u201d/,groups:["value","key"]},{regexp:/\uc815\uc758\ub418\uc9c0 \uc54a\uc74c \ub610\ub294 (null|undefined) \ucc38\uc870\uc778 '([^']+)' \uc18d\uc131\uc744 \uac00\uc838\uc62c \uc218 \uc5c6\uc2b5\ub2c8\ub2e4./,
groups:["value","key"]},{regexp:/No se puede obtener la propiedad '([^']+)' de referencia nula o sin definir/,groups:["key"]},{regexp:/Unable to get property '([^']+)' of (undefined or null) reference/,groups:["key","value"]},{regexp:/(null) is not an object \(evaluating '(?:([^.]+)\.)?([^']+)'\)/,groups:["value","base","key"]}]}},{Kc:function(a){return"Cannot call '"+a.key+"'"},
kc:{TypeError:[{regexp:/(?:([^ ]+)?\.)?([^ ]+) is not a function/,groups:["base","key"]},{regexp:/([^ ]+) called on (null or undefined)/,groups:["key","value"]},{regexp:/Object (.*) has no method '([^ ]+)'/,groups:["base","key"]},{regexp:/Object doesn't support property or method '([^ ]+)'/,groups:["key"]},{regexp:/\u30aa\u30d6\u30b8\u30a7\u30af\u30c8\u306f '([^']+)' \u30d7\u30ed\u30d1\u30c6\u30a3\u307e\u305f\u306f\u30e1\u30bd\u30c3\u30c9\u3092\u30b5\u30dd\u30fc\u30c8\u3057\u3066\u3044\u307e\u305b\u3093/,
groups:["key"]},{regexp:/\uac1c\uccb4\uac00 '([^']+)' \uc18d\uc131\uc774\ub098 \uba54\uc11c\ub4dc\ub97c \uc9c0\uc6d0\ud558\uc9c0 \uc54a\uc2b5\ub2c8\ub2e4./,groups:["key"]}]}},{Kc:function(a){return a.key+" is not defined"},
kc:{ReferenceError:[{regexp:/(.*) is not defined/,groups:["key"]},{regexp:/Can't find variable: (.*)/,groups:["key"]}]}}];var Dl={Ua:[],Ra:[{callback:Cl,weight:500}]};function Cl(a){if("JavaException"===a.name)return!0;a=a.stack;return a.includes("chrome://")||a.includes("chrome-extension://")||a.includes("moz-extension://")}
;function El(){this.Ra=[];this.Ua=[]}
var Fl;function Gl(){if(!Fl){var a=Fl=new El;a.Ua.length=0;a.Ra.length=0;Dl.Ua&&a.Ua.push.apply(a.Ua,Dl.Ua);Dl.Ra&&a.Ra.push.apply(a.Ra,Dl.Ra)}return Fl}
;var Hl=new M;function Il(a){function b(){return a.charCodeAt(d++)}
var c=a.length,d=0;do{var e=Jl(b);if(Infinity===e)break;var f=e>>3;switch(e&7){case 0:e=Jl(b);if(2===f)return e;break;case 1:if(2===f)return;d+=8;break;case 2:e=Jl(b);if(2===f)return a.substr(d,e);d+=e;break;case 5:if(2===f)return;d+=4;break;default:return}}while(d<c)}
function Jl(a){var b=a(),c=b&127;if(128>b)return c;b=a();c|=(b&127)<<7;if(128>b)return c;b=a();c|=(b&127)<<14;if(128>b)return c;b=a();return 128>b?c|(b&127)<<21:Infinity}
;function Kl(a,b,c,d){if(a)if(Array.isArray(a)){var e=d;for(d=0;d<a.length&&!(a[d]&&(e+=Ll(d,a[d],b,c),500<e));d++);d=e}else if("object"===typeof a)for(e in a){if(a[e]){var f=a[e];var g=b;var h=c;g="string"!==typeof f||"clickTrackingParams"!==e&&"trackingParams"!==e?0:(f=Il(atob(f.replace(/-/g,"+").replace(/_/g,"/"))))?Ll(e+".ve",f,g,h):0;d+=g;d+=Ll(e,a[e],b,c);if(500<d)break}}else c[b]=Ml(a),d+=c[b].length;else c[b]=Ml(a),d+=c[b].length;return d}
function Ll(a,b,c,d){c+="."+a;a=Ml(b);d[c]=a;return c.length+a.length}
function Ml(a){try{return("string"===typeof a?a:String(JSON.stringify(a))).substr(0,500)}catch(b){return"unable to serialize "+typeof a+" ("+b.message+")"}}
;function Nl(){this.Xe=!0}
function Ol(){Nl.h||(Nl.h=new Nl);return Nl.h}
function Pl(a,b){a={};var c=Hg([]);c&&(a.Authorization=c,c=b=null==b?void 0:b.sessionIndex,void 0===c&&(c=Number(R("SESSION_INDEX",0)),c=isNaN(c)?0:c),S("voice_search_auth_header_removal")||(a["X-Goog-AuthUser"]=c.toString()),"INNERTUBE_HOST_OVERRIDE"in Nk||(a["X-Origin"]=window.location.origin),void 0===b&&"DELEGATED_SESSION_ID"in Nk&&(a["X-Goog-PageId"]=R("DELEGATED_SESSION_ID")));return a}
;var Ql={identityType:"UNAUTHENTICATED_IDENTITY_TYPE_UNKNOWN"};function Rl(a){var b=this;this.i=void 0;this.h=!1;a.addEventListener("beforeinstallprompt",function(c){c.preventDefault();b.i=c});
a.addEventListener("appinstalled",function(){b.h=!0},{once:!0})}
function Sl(){if(!C.matchMedia)return"WEB_DISPLAY_MODE_UNKNOWN";try{return C.matchMedia("(display-mode: standalone)").matches?"WEB_DISPLAY_MODE_STANDALONE":C.matchMedia("(display-mode: minimal-ui)").matches?"WEB_DISPLAY_MODE_MINIMAL_UI":C.matchMedia("(display-mode: fullscreen)").matches?"WEB_DISPLAY_MODE_FULLSCREEN":C.matchMedia("(display-mode: browser)").matches?"WEB_DISPLAY_MODE_BROWSER":"WEB_DISPLAY_MODE_UNKNOWN"}catch(a){return"WEB_DISPLAY_MODE_UNKNOWN"}}
;function Tl(a,b,c,d,e){Cg.set(""+a,b,{jc:c,path:"/",domain:void 0===d?"youtube.com":d,secure:void 0===e?!1:e})}
function Ul(a){return Cg.get(""+a,void 0)}
function Vl(a,b,c){Cg.remove(""+a,void 0===b?"/":b,void 0===c?"youtube.com":c)}
function Wl(){if(!Cg.isEnabled())return!1;if(!Cg.isEmpty())return!0;Cg.set("TESTCOOKIESENABLED","1",{jc:60});if("1"!==Cg.get("TESTCOOKIESENABLED"))return!1;Cg.remove("TESTCOOKIESENABLED");return!0}
;var Xl=E("ytglobal.prefsUserPrefsPrefs_")||{};D("ytglobal.prefsUserPrefsPrefs_",Xl);function Yl(){this.h=R("ALT_PREF_COOKIE_NAME","PREF");this.i=R("ALT_PREF_COOKIE_DOMAIN","youtube.com");var a=Ul(this.h);a&&this.parse(a)}
var Zl;function $l(){Zl||(Zl=new Yl);return Zl}
m=Yl.prototype;m.get=function(a,b){am(a);bm(a);a=void 0!==Xl[a]?Xl[a].toString():null;return null!=a?a:b?b:""};
m.set=function(a,b){am(a);bm(a);if(null==b)throw Error("ExpectedNotNull");Xl[a]=b.toString()};
function cm(a){return!!((dm("f"+(Math.floor(a/31)+1))||0)&1<<a%31)}
m.remove=function(a){am(a);bm(a);delete Xl[a]};
m.clear=function(){for(var a in Xl)delete Xl[a]};
function bm(a){if(/^f([1-9][0-9]*)$/.test(a))throw Error("ExpectedRegexMatch: "+a);}
function am(a){if(!/^\w+$/.test(a))throw Error("ExpectedRegexMismatch: "+a);}
function dm(a){a=void 0!==Xl[a]?Xl[a].toString():null;return null!=a&&/^[A-Fa-f0-9]+$/.test(a)?parseInt(a,16):null}
m.parse=function(a){a=decodeURIComponent(a).split("&");for(var b=0;b<a.length;b++){var c=a[b].split("="),d=c[0];(c=c[1])&&(Xl[d]=c.toString())}};var em={bluetooth:"CONN_DISCO",cellular:"CONN_CELLULAR_UNKNOWN",ethernet:"CONN_WIFI",none:"CONN_NONE",wifi:"CONN_WIFI",wimax:"CONN_CELLULAR_4G",other:"CONN_UNKNOWN",unknown:"CONN_UNKNOWN","slow-2g":"CONN_CELLULAR_2G","2g":"CONN_CELLULAR_2G","3g":"CONN_CELLULAR_3G","4g":"CONN_CELLULAR_4G"},fm={"slow-2g":"EFFECTIVE_CONNECTION_TYPE_SLOW_2G","2g":"EFFECTIVE_CONNECTION_TYPE_2G","3g":"EFFECTIVE_CONNECTION_TYPE_3G","4g":"EFFECTIVE_CONNECTION_TYPE_4G"};
function gm(){var a=C.navigator;return a?a.connection:void 0}
function hm(){var a=gm();if(a){var b=em[a.type||"unknown"]||"CONN_UNKNOWN";a=em[a.effectiveType||"unknown"]||"CONN_UNKNOWN";"CONN_CELLULAR_UNKNOWN"===b&&"CONN_UNKNOWN"!==a&&(b=a);if("CONN_UNKNOWN"!==b)return b;if("CONN_UNKNOWN"!==a)return a}}
function im(){var a=gm();if(null!=a&&a.effectiveType)return fm.hasOwnProperty(a.effectiveType)?fm[a.effectiveType]:"EFFECTIVE_CONNECTION_TYPE_UNKNOWN"}
;function jm(a){var b=B.apply(1,arguments);var c=Error.call(this,a);this.message=c.message;"stack"in c&&(this.stack=c.stack);this.args=[].concat(ja(b))}
w(jm,Error);function km(){try{return lm(),!0}catch(a){return!1}}
function lm(a){if(void 0!==R("DATASYNC_ID"))return R("DATASYNC_ID");throw new jm("Datasync ID not set",void 0===a?"unknown":a);}
;function mm(){}
function nm(a,b){return om(a,0,b)}
mm.prototype.ka=function(a,b){return om(a,1,b)};
function pm(a){var b=E("yt.scheduler.instance.addImmediateJob");b?b(a):a()}
;function qm(){mm.apply(this,arguments)}
w(qm,mm);function rm(){qm.h||(qm.h=new qm);return qm.h}
function om(a,b,c){void 0!==c&&Number.isNaN(Number(c))&&(c=void 0);var d=E("yt.scheduler.instance.addJob");return d?d(a,b,c):void 0===c?(a(),NaN):ml(a,c||0)}
qm.prototype.ya=function(a){if(void 0===a||!Number.isNaN(Number(a))){var b=E("yt.scheduler.instance.cancelJob");b?b(a):window.clearTimeout(a)}};
qm.prototype.start=function(){var a=E("yt.scheduler.instance.start");a&&a()};
qm.prototype.pause=function(){var a=E("yt.scheduler.instance.pause");a&&a()};
var oi=rm();function sm(a){var b=new Vi;(b=b.isAvailable()?a?new aj(b,a):b:null)||(a=new Wi(a||"UserDataSharedStore"),b=a.isAvailable()?a:null);this.h=(a=b)?new Ri(a):null;this.i=document.domain||window.location.hostname}
sm.prototype.set=function(a,b,c,d){c=c||31104E3;this.remove(a);if(this.h)try{this.h.set(a,b,Date.now()+1E3*c);return}catch(f){}var e="";if(d)try{e=escape((new Kg).serialize(b))}catch(f){return}else e=escape(b);Tl(a,e,c,this.i)};
sm.prototype.get=function(a,b){var c=void 0,d=!this.h;if(!d)try{c=this.h.get(a)}catch(e){d=!0}if(d&&(c=Ul(a))&&(c=unescape(c),b))try{c=JSON.parse(c)}catch(e){this.remove(a),c=void 0}return c};
sm.prototype.remove=function(a){this.h&&this.h.remove(a);Vl(a,"/",this.i)};var tm=function(){var a;return function(){a||(a=new sm("ytidb"));return a}}();
function um(){var a;return null==(a=tm())?void 0:a.get("LAST_RESULT_ENTRY_KEY",!0)}
;var wm=[],xm,ym=!1;function zm(){var a={};for(xm=new Am(void 0===a.handleError?Bm:a.handleError,void 0===a.logEvent?Cm:a.logEvent);0<wm.length;)switch(a=wm.shift(),a.type){case "ERROR":xm.handleError(a.payload);break;case "EVENT":xm.logEvent(a.eventType,a.payload)}}
function Dm(a){ym||(xm?xm.handleError(a):(wm.push({type:"ERROR",payload:a}),10<wm.length&&wm.shift()))}
function Em(a,b){ym||(xm?xm.logEvent(a,b):(wm.push({type:"EVENT",eventType:a,payload:b}),10<wm.length&&wm.shift()))}
;function Fm(a){if(0<=a.indexOf(":"))throw Error("Database name cannot contain ':'");}
function Gm(a){return a.substr(0,a.indexOf(":"))||a}
;var Hm=Ue||Ve;function Im(a){var b=Rb();return b?0<=b.toLowerCase().indexOf(a):!1}
;var Jm={},Km=(Jm.AUTH_INVALID="No user identifier specified.",Jm.EXPLICIT_ABORT="Transaction was explicitly aborted.",Jm.IDB_NOT_SUPPORTED="IndexedDB is not supported.",Jm.MISSING_INDEX="Index not created.",Jm.MISSING_OBJECT_STORES="Object stores not created.",Jm.DB_DELETED_BY_MISSING_OBJECT_STORES="Database is deleted because expected object stores were not created.",Jm.DB_REOPENED_BY_MISSING_OBJECT_STORES="Database is reopened because expected object stores were not created.",Jm.UNKNOWN_ABORT="Transaction was aborted for unknown reasons.",
Jm.QUOTA_EXCEEDED="The current transaction exceeded its quota limitations.",Jm.QUOTA_MAYBE_EXCEEDED="The current transaction may have failed because of exceeding quota limitations.",Jm.EXECUTE_TRANSACTION_ON_CLOSED_DB="Can't start a transaction on a closed database",Jm.INCOMPATIBLE_DB_VERSION="The binary is incompatible with the database version",Jm),Lm={},Mm=(Lm.AUTH_INVALID="ERROR",Lm.EXECUTE_TRANSACTION_ON_CLOSED_DB="WARNING",Lm.EXPLICIT_ABORT="IGNORED",Lm.IDB_NOT_SUPPORTED="ERROR",Lm.MISSING_INDEX=
"WARNING",Lm.MISSING_OBJECT_STORES="ERROR",Lm.DB_DELETED_BY_MISSING_OBJECT_STORES="WARNING",Lm.DB_REOPENED_BY_MISSING_OBJECT_STORES="WARNING",Lm.QUOTA_EXCEEDED="WARNING",Lm.QUOTA_MAYBE_EXCEEDED="WARNING",Lm.UNKNOWN_ABORT="WARNING",Lm.INCOMPATIBLE_DB_VERSION="WARNING",Lm),Nm={},Om=(Nm.AUTH_INVALID=!1,Nm.EXECUTE_TRANSACTION_ON_CLOSED_DB=!1,Nm.EXPLICIT_ABORT=!1,Nm.IDB_NOT_SUPPORTED=!1,Nm.MISSING_INDEX=!1,Nm.MISSING_OBJECT_STORES=!1,Nm.DB_DELETED_BY_MISSING_OBJECT_STORES=!1,Nm.DB_REOPENED_BY_MISSING_OBJECT_STORES=
!1,Nm.QUOTA_EXCEEDED=!1,Nm.QUOTA_MAYBE_EXCEEDED=!0,Nm.UNKNOWN_ABORT=!0,Nm.INCOMPATIBLE_DB_VERSION=!1,Nm);function Pm(a,b,c,d,e){b=void 0===b?{}:b;c=void 0===c?Km[a]:c;d=void 0===d?Mm[a]:d;e=void 0===e?Om[a]:e;jm.call(this,c,Object.assign({},{name:"YtIdbKnownError",isSw:void 0===self.document,isIframe:self!==self.top,type:a},b));this.type=a;this.message=c;this.level=d;this.h=e;Object.setPrototypeOf(this,Pm.prototype)}
w(Pm,jm);function Qm(a,b){Pm.call(this,"MISSING_OBJECT_STORES",{expectedObjectStores:b,foundObjectStores:a},Km.MISSING_OBJECT_STORES);Object.setPrototypeOf(this,Qm.prototype)}
w(Qm,Pm);function Rm(a,b){var c=Error.call(this);this.message=c.message;"stack"in c&&(this.stack=c.stack);this.index=a;this.objectStore=b;Object.setPrototypeOf(this,Rm.prototype)}
w(Rm,Error);var Sm=["The database connection is closing","Can't start a transaction on a closed database","A mutation operation was attempted on a database that did not allow mutations"];
function Tm(a,b,c,d){b=Gm(b);var e=a instanceof Error?a:Error("Unexpected error: "+a);if(e instanceof Pm)return e;a={objectStoreNames:c,dbName:b,dbVersion:d};if("QuotaExceededError"===e.name)return new Pm("QUOTA_EXCEEDED",a);if(We&&"UnknownError"===e.name)return new Pm("QUOTA_MAYBE_EXCEEDED",a);if(e instanceof Rm)return new Pm("MISSING_INDEX",Object.assign({},a,{objectStore:e.objectStore,index:e.index}));if("InvalidStateError"===e.name&&Sm.some(function(f){return e.message.includes(f)}))return new Pm("EXECUTE_TRANSACTION_ON_CLOSED_DB",
a);
if("AbortError"===e.name)return new Pm("UNKNOWN_ABORT",a,e.message);e.args=[Object.assign({},a,{name:"IdbError",vd:e.name})];e.level="WARNING";return e}
function Um(a,b,c){var d=um();return new Pm("IDB_NOT_SUPPORTED",{context:{caller:a,publicName:b,version:c,hasSucceededOnce:null==d?void 0:d.hasSucceededOnce}})}
;function Vm(a){if(!a)throw Error();throw a;}
function Wm(a){return a}
function Xm(a){this.h=a}
function Ym(a){function b(e){if("PENDING"===d.state.status){d.state={status:"REJECTED",reason:e};e=v(d.i);for(var f=e.next();!f.done;f=e.next())f=f.value,f()}}
function c(e){if("PENDING"===d.state.status){d.state={status:"FULFILLED",value:e};e=v(d.h);for(var f=e.next();!f.done;f=e.next())f=f.value,f()}}
var d=this;this.state={status:"PENDING"};this.h=[];this.i=[];a=a.h;try{a(c,b)}catch(e){b(e)}}
Ym.all=function(a){return new Ym(new Xm(function(b,c){var d=[],e=a.length;0===e&&b(d);for(var f={nb:0};f.nb<a.length;f={nb:f.nb},++f.nb)Ym.resolve(a[f.nb]).then(function(g){return function(h){d[g.nb]=h;e--;0===e&&b(d)}}(f)).catch(function(g){c(g)})}))};
Ym.resolve=function(a){return new Ym(new Xm(function(b,c){a instanceof Ym?a.then(b,c):b(a)}))};
Ym.reject=function(a){return new Ym(new Xm(function(b,c){c(a)}))};
Ym.prototype.then=function(a,b){var c=this,d=null!=a?a:Wm,e=null!=b?b:Vm;return new Ym(new Xm(function(f,g){"PENDING"===c.state.status?(c.h.push(function(){Zm(c,c,d,f,g)}),c.i.push(function(){$m(c,c,e,f,g)})):"FULFILLED"===c.state.status?Zm(c,c,d,f,g):"REJECTED"===c.state.status&&$m(c,c,e,f,g)}))};
Ym.prototype.catch=function(a){return this.then(void 0,a)};
function Zm(a,b,c,d,e){try{if("FULFILLED"!==a.state.status)throw Error("calling handleResolve before the promise is fulfilled.");var f=c(a.state.value);f instanceof Ym?an(a,b,f,d,e):d(f)}catch(g){e(g)}}
function $m(a,b,c,d,e){try{if("REJECTED"!==a.state.status)throw Error("calling handleReject before the promise is rejected.");var f=c(a.state.reason);f instanceof Ym?an(a,b,f,d,e):d(f)}catch(g){e(g)}}
function an(a,b,c,d,e){b===c?e(new TypeError("Circular promise chain detected.")):c.then(function(f){f instanceof Ym?an(a,b,f,d,e):d(f)},function(f){e(f)})}
;function bn(a,b,c){function d(){c(a.error);f()}
function e(){b(a.result);f()}
function f(){try{a.removeEventListener("success",e),a.removeEventListener("error",d)}catch(g){}}
a.addEventListener("success",e);a.addEventListener("error",d)}
function cn(a){return new Promise(function(b,c){bn(a,b,c)})}
function dn(a){return new Ym(new Xm(function(b,c){bn(a,b,c)}))}
;function en(a,b){return new Ym(new Xm(function(c,d){function e(){var f=a?b(a):null;f?f.then(function(g){a=g;e()},d):c()}
e()}))}
;var fn=window,T=fn.ytcsi&&fn.ytcsi.now?fn.ytcsi.now:fn.performance&&fn.performance.timing&&fn.performance.now&&fn.performance.timing.navigationStart?function(){return fn.performance.timing.navigationStart+fn.performance.now()}:function(){return(new Date).getTime()};function gn(a,b){this.h=a;this.options=b;this.transactionCount=0;this.j=Math.round(T());this.i=!1}
m=gn.prototype;m.add=function(a,b,c){return hn(this,[a],{mode:"readwrite",ea:!0},function(d){return d.objectStore(a).add(b,c)})};
m.clear=function(a){return hn(this,[a],{mode:"readwrite",ea:!0},function(b){return b.objectStore(a).clear()})};
m.close=function(){this.h.close();var a;(null==(a=this.options)?0:a.closed)&&this.options.closed()};
m.count=function(a,b){return hn(this,[a],{mode:"readonly",ea:!0},function(c){return c.objectStore(a).count(b)})};
function jn(a,b,c){a=a.h.createObjectStore(b,c);return new kn(a)}
m.delete=function(a,b){return hn(this,[a],{mode:"readwrite",ea:!0},function(c){return c.objectStore(a).delete(b)})};
m.get=function(a,b){return hn(this,[a],{mode:"readonly",ea:!0},function(c){return c.objectStore(a).get(b)})};
function ln(a,b,c){return hn(a,[b],{mode:"readwrite",ea:!0},function(d){d=d.objectStore(b);return dn(d.h.put(c,void 0))})}
m.objectStoreNames=function(){return Array.from(this.h.objectStoreNames)};
function hn(a,b,c,d){var e,f,g,h,k,l,n,p,t,r,x,y;return A(function(z){switch(z.h){case 1:var H={mode:"readonly",ea:!1,tag:"IDB_TRANSACTION_TAG_UNKNOWN"};"string"===typeof c?H.mode=c:Object.assign(H,c);e=H;a.transactionCount++;f=e.ea?3:1;g=0;case 2:if(h){z.A(4);break}g++;k=Math.round(T());ya(z,5);l=a.h.transaction(b,e.mode);H=z.yield;var I=new mn(l);I=nn(I,d);return H.call(z,I,7);case 7:return n=z.i,p=Math.round(T()),on(a,k,p,g,void 0,b.join(),e),z.return(n);case 5:t=za(z);r=Math.round(T());x=Tm(t,
a.h.name,b.join(),a.h.version);if((y=x instanceof Pm&&!x.h)||g>=f)on(a,k,r,g,x,b.join(),e),h=x;z.A(2);break;case 4:return z.return(Promise.reject(h))}})}
function on(a,b,c,d,e,f,g){b=c-b;e?(e instanceof Pm&&("QUOTA_EXCEEDED"===e.type||"QUOTA_MAYBE_EXCEEDED"===e.type)&&Em("QUOTA_EXCEEDED",{dbName:Gm(a.h.name),objectStoreNames:f,transactionCount:a.transactionCount,transactionMode:g.mode}),e instanceof Pm&&"UNKNOWN_ABORT"===e.type&&(c-=a.j,0>c&&c>=Math.pow(2,31)&&(c=0),Em("TRANSACTION_UNEXPECTEDLY_ABORTED",{objectStoreNames:f,transactionDuration:b,transactionCount:a.transactionCount,dbDuration:c}),a.i=!0),pn(a,!1,d,f,b,g.tag),Dm(e)):pn(a,!0,d,f,b,g.tag)}
function pn(a,b,c,d,e,f){Em("TRANSACTION_ENDED",{objectStoreNames:d,connectionHasUnknownAbortedTransaction:a.i,duration:e,isSuccessful:b,tryCount:c,tag:void 0===f?"IDB_TRANSACTION_TAG_UNKNOWN":f})}
m.getName=function(){return this.h.name};
function kn(a){this.h=a}
m=kn.prototype;m.add=function(a,b){return dn(this.h.add(a,b))};
m.autoIncrement=function(){return this.h.autoIncrement};
m.clear=function(){return dn(this.h.clear()).then(function(){})};
function qn(a,b,c){a.h.createIndex(b,c,{unique:!1})}
m.count=function(a){return dn(this.h.count(a))};
function rn(a,b){return sn(a,{query:b},function(c){return c.delete().then(function(){return c.continue()})}).then(function(){})}
m.delete=function(a){return a instanceof IDBKeyRange?rn(this,a):dn(this.h.delete(a))};
m.get=function(a){return dn(this.h.get(a))};
m.index=function(a){try{return new tn(this.h.index(a))}catch(b){if(b instanceof Error&&"NotFoundError"===b.name)throw new Rm(a,this.h.name);throw b;}};
m.getName=function(){return this.h.name};
m.keyPath=function(){return this.h.keyPath};
function sn(a,b,c){a=a.h.openCursor(b.query,b.direction);return un(a).then(function(d){return en(d,c)})}
function mn(a){var b=this;this.h=a;this.i=new Map;this.aborted=!1;this.done=new Promise(function(c,d){b.h.addEventListener("complete",function(){c()});
b.h.addEventListener("error",function(e){e.currentTarget===e.target&&d(b.h.error)});
b.h.addEventListener("abort",function(){var e=b.h.error;if(e)d(e);else if(!b.aborted){e=Pm;for(var f=b.h.objectStoreNames,g=[],h=0;h<f.length;h++){var k=f.item(h);if(null===k)throw Error("Invariant: item in DOMStringList is null");g.push(k)}e=new e("UNKNOWN_ABORT",{objectStoreNames:g.join(),dbName:b.h.db.name,mode:b.h.mode});d(e)}})})}
function nn(a,b){var c=new Promise(function(d,e){try{b(a).then(function(f){d(f)}).catch(e)}catch(f){e(f),a.abort()}});
return Promise.all([c,a.done]).then(function(d){return v(d).next().value})}
mn.prototype.abort=function(){this.h.abort();this.aborted=!0;throw new Pm("EXPLICIT_ABORT");};
mn.prototype.objectStore=function(a){a=this.h.objectStore(a);var b=this.i.get(a);b||(b=new kn(a),this.i.set(a,b));return b};
function tn(a){this.h=a}
m=tn.prototype;m.count=function(a){return dn(this.h.count(a))};
m.delete=function(a){return vn(this,{query:a},function(b){return b.delete().then(function(){return b.continue()})})};
m.get=function(a){return dn(this.h.get(a))};
m.getKey=function(a){return dn(this.h.getKey(a))};
m.keyPath=function(){return this.h.keyPath};
m.unique=function(){return this.h.unique};
function vn(a,b,c){a=a.h.openCursor(void 0===b.query?null:b.query,void 0===b.direction?"next":b.direction);return un(a).then(function(d){return en(d,c)})}
function wn(a,b){this.request=a;this.cursor=b}
function un(a){return dn(a).then(function(b){return b?new wn(a,b):null})}
m=wn.prototype;m.advance=function(a){this.cursor.advance(a);return un(this.request)};
m.continue=function(a){this.cursor.continue(a);return un(this.request)};
m.delete=function(){return dn(this.cursor.delete()).then(function(){})};
m.getKey=function(){return this.cursor.key};
m.getValue=function(){return this.cursor.value};
m.update=function(a){return dn(this.cursor.update(a))};function xn(a,b,c){return new Promise(function(d,e){function f(){t||(t=new gn(g.result,{closed:p}));return t}
var g=void 0!==b?self.indexedDB.open(a,b):self.indexedDB.open(a);var h=c.Vd,k=c.blocking,l=c.Ye,n=c.upgrade,p=c.closed,t;g.addEventListener("upgradeneeded",function(r){try{if(null===r.newVersion)throw Error("Invariant: newVersion on IDbVersionChangeEvent is null");if(null===g.transaction)throw Error("Invariant: transaction on IDbOpenDbRequest is null");r.dataLoss&&"none"!==r.dataLoss&&Em("IDB_DATA_CORRUPTED",{reason:r.dataLossMessage||"unknown reason",dbName:Gm(a)});var x=f(),y=new mn(g.transaction);
n&&n(x,function(z){return r.oldVersion<z&&r.newVersion>=z},y);
y.done.catch(function(z){e(z)})}catch(z){e(z)}});
g.addEventListener("success",function(){var r=g.result;k&&r.addEventListener("versionchange",function(){k(f())});
r.addEventListener("close",function(){Em("IDB_UNEXPECTEDLY_CLOSED",{dbName:Gm(a),dbVersion:r.version});l&&l()});
d(f())});
g.addEventListener("error",function(){e(g.error)});
h&&g.addEventListener("blocked",function(){h()})})}
function yn(a,b,c){c=void 0===c?{}:c;return xn(a,b,c)}
function zn(a,b){b=void 0===b?{}:b;var c,d,e,f;return A(function(g){if(1==g.h)return ya(g,2),c=self.indexedDB.deleteDatabase(a),d=b,(e=d.Vd)&&c.addEventListener("blocked",function(){e()}),g.yield(cn(c),4);
if(2!=g.h)g.h=0,g.l=0;else throw f=za(g),Tm(f,a,"",-1);})}
;function An(a,b){this.name=a;this.options=b;this.j=!0;this.m=this.l=0}
An.prototype.i=function(a,b,c){c=void 0===c?{}:c;return yn(a,b,c)};
An.prototype.delete=function(a){a=void 0===a?{}:a;return zn(this.name,a)};
function Bn(a,b){return new Pm("INCOMPATIBLE_DB_VERSION",{dbName:a.name,oldVersion:a.options.version,newVersion:b})}
function Cn(a,b){if(!b)throw Um("openWithToken",Gm(a.name));return a.open()}
An.prototype.open=function(){function a(){var f,g,h,k,l,n,p,t,r,x;return A(function(y){switch(y.h){case 1:return g=null!=(f=Error().stack)?f:"",ya(y,2),y.yield(c.i(c.name,c.options.version,e),4);case 4:h=y.i;for(var z=c.options,H=[],I=v(Object.keys(z.Eb)),L=I.next();!L.done;L=I.next()){L=L.value;var P=z.Eb[L],J=void 0===P.Ge?Number.MAX_VALUE:P.Ge;!(h.h.version>=P.Lb)||h.h.version>=J||h.h.objectStoreNames.contains(L)||H.push(L)}k=H;if(0===k.length){y.A(5);break}l=Object.keys(c.options.Eb);n=h.objectStoreNames();
if(c.m<hl("ytidb_reopen_db_retries",0))return c.m++,h.close(),Dm(new Pm("DB_REOPENED_BY_MISSING_OBJECT_STORES",{dbName:c.name,expectedObjectStores:l,foundObjectStores:n})),y.return(a());if(!(c.l<hl("ytidb_remake_db_retries",1))){y.A(6);break}c.l++;return y.yield(c.delete(),7);case 7:return Dm(new Pm("DB_DELETED_BY_MISSING_OBJECT_STORES",{dbName:c.name,expectedObjectStores:l,foundObjectStores:n})),y.return(a());case 6:throw new Qm(n,l);case 5:return y.return(h);case 2:p=za(y);if(p instanceof DOMException?
"VersionError"!==p.name:"DOMError"in self&&p instanceof DOMError?"VersionError"!==p.name:!(p instanceof Object&&"message"in p)||"An attempt was made to open a database using a lower version than the existing version."!==p.message){y.A(8);break}return y.yield(c.i(c.name,void 0,Object.assign({},e,{upgrade:void 0})),9);case 9:t=y.i;r=t.h.version;if(void 0!==c.options.version&&r>c.options.version+1)throw t.close(),c.j=!1,Bn(c,r);return y.return(t);case 8:throw b(),p instanceof Error&&!S("ytidb_async_stack_killswitch")&&
(p.stack=p.stack+"\n"+g.substring(g.indexOf("\n")+1)),Tm(p,c.name,"",null!=(x=c.options.version)?x:-1);}})}
function b(){c.h===d&&(c.h=void 0)}
var c=this;if(!this.j)throw Bn(this);if(this.h)return this.h;var d,e={blocking:function(f){f.close()},
closed:b,Ye:b,upgrade:this.options.upgrade};return this.h=d=a()};var Dn=new An("YtIdbMeta",{Eb:{databases:{Lb:1}},upgrade:function(a,b){b(1)&&jn(a,"databases",{keyPath:"actualName"})}});
function En(a,b){var c;return A(function(d){if(1==d.h)return d.yield(Cn(Dn,b),2);c=d.i;return d.return(hn(c,["databases"],{ea:!0,mode:"readwrite"},function(e){var f=e.objectStore("databases");return f.get(a.actualName).then(function(g){if(g?a.actualName!==g.actualName||a.publicName!==g.publicName||a.userIdentifier!==g.userIdentifier:1)return dn(f.h.put(a,void 0)).then(function(){})})}))})}
function Fn(a,b){var c;return A(function(d){if(1==d.h)return a?d.yield(Cn(Dn,b),2):d.return();c=d.i;return d.return(c.delete("databases",a))})}
function Gn(a,b){var c,d;return A(function(e){return 1==e.h?(c=[],e.yield(Cn(Dn,b),2)):3!=e.h?(d=e.i,e.yield(hn(d,["databases"],{ea:!0,mode:"readonly"},function(f){c.length=0;return sn(f.objectStore("databases"),{},function(g){a(g.getValue())&&c.push(g.getValue());return g.continue()})}),3)):e.return(c)})}
function Hn(a){return Gn(function(b){return"LogsDatabaseV2"===b.publicName&&void 0!==b.userIdentifier},a)}
function In(a,b,c){return Gn(function(d){return c?void 0!==d.userIdentifier&&!a.includes(d.userIdentifier)&&c.includes(d.publicName):void 0!==d.userIdentifier&&!a.includes(d.userIdentifier)},b)}
function Jn(a){var b,c;return A(function(d){if(1==d.h)return b=lm("YtIdbMeta hasAnyMeta other"),d.yield(Gn(function(e){return void 0!==e.userIdentifier&&e.userIdentifier!==b},a),2);
c=d.i;return d.return(0<c.length)})}
;var Kn,Ln=new function(){}(new function(){});
function Mn(){var a,b,c,d;return A(function(e){switch(e.h){case 1:a=um();if(null==(b=a)?0:b.hasSucceededOnce)return e.return(!0);var f;if(f=Hm)f=/WebKit\/([0-9]+)/.exec(Rb()),f=!!(f&&600<=parseInt(f[1],10));f&&(f=/WebKit\/([0-9]+)/.exec(Rb()),f=!(f&&602<=parseInt(f[1],10)));if(f||dd)return e.return(!1);try{if(c=self,!(c.indexedDB&&c.IDBIndex&&c.IDBKeyRange&&c.IDBObjectStore))return e.return(!1)}catch(g){return e.return(!1)}if(!("IDBTransaction"in self&&"objectStoreNames"in IDBTransaction.prototype))return e.return(!1);
ya(e,2);d={actualName:"yt-idb-test-do-not-use",publicName:"yt-idb-test-do-not-use",userIdentifier:void 0};return e.yield(En(d,Ln),4);case 4:return e.yield(Fn("yt-idb-test-do-not-use",Ln),5);case 5:return e.return(!0);case 2:return za(e),e.return(!1)}})}
function Nn(){if(void 0!==Kn)return Kn;ym=!0;return Kn=Mn().then(function(a){ym=!1;var b;if(null!=(b=tm())&&b.h){var c;b={hasSucceededOnce:(null==(c=um())?void 0:c.hasSucceededOnce)||a};var d;null==(d=tm())||d.set("LAST_RESULT_ENTRY_KEY",b,2592E3,!0)}return a})}
function On(){return E("ytglobal.idbToken_")||void 0}
function Pn(){var a=On();return a?Promise.resolve(a):Nn().then(function(b){(b=b?Ln:void 0)&&D("ytglobal.idbToken_",b);return b})}
;var Qn=0;function Rn(a,b){Qn||(Qn=oi.ka(function(){var c,d,e,f,g;return A(function(h){switch(h.h){case 1:return h.yield(Pn(),2);case 2:c=h.i;if(!c)return h.return();d=!0;ya(h,3);return h.yield(In(a,c,b),5);case 5:e=h.i;if(!e.length){d=!1;h.A(6);break}f=e[0];return h.yield(zn(f.actualName),7);case 7:return h.yield(Fn(f.actualName,c),6);case 6:h.h=4;h.l=0;break;case 3:g=za(h),Dm(g),d=!1;case 4:oi.ya(Qn),Qn=0,d&&Rn(a,b),h.h=0}})}))}
function Sn(){var a;return A(function(b){return 1==b.h?b.yield(Pn(),2):(a=b.i)?b.return(Jn(a)):b.return(!1)})}
new Jh;function Tn(a){if(!km())throw a=new Pm("AUTH_INVALID",{dbName:a}),Dm(a),a;var b=lm();return{actualName:a+":"+b,publicName:a,userIdentifier:b}}
function Un(a,b,c,d){var e,f,g,h,k,l;return A(function(n){switch(n.h){case 1:return f=null!=(e=Error().stack)?e:"",n.yield(Pn(),2);case 2:g=n.i;if(!g)throw h=Um("openDbImpl",a,b),S("ytidb_async_stack_killswitch")||(h.stack=h.stack+"\n"+f.substring(f.indexOf("\n")+1)),Dm(h),h;Fm(a);k=c?{actualName:a,publicName:a,userIdentifier:void 0}:Tn(a);ya(n,3);return n.yield(En(k,g),5);case 5:return n.yield(yn(k.actualName,b,d),6);case 6:return n.return(n.i);case 3:return l=za(n),ya(n,7),n.yield(Fn(k.actualName,
g),9);case 9:n.h=8;n.l=0;break;case 7:za(n);case 8:throw l;}})}
function Vn(a,b,c){c=void 0===c?{}:c;return Un(a,b,!1,c)}
function Wn(a,b,c){c=void 0===c?{}:c;return Un(a,b,!0,c)}
function Xn(a,b){b=void 0===b?{}:b;var c,d;return A(function(e){if(1==e.h)return e.yield(Pn(),2);if(3!=e.h){c=e.i;if(!c)return e.return();Fm(a);d=Tn(a);return e.yield(zn(d.actualName,b),3)}return e.yield(Fn(d.actualName,c),0)})}
function Yn(a,b,c){a=a.map(function(d){return A(function(e){return 1==e.h?e.yield(zn(d.actualName,b),2):e.yield(Fn(d.actualName,c),0)})});
return Promise.all(a).then(function(){})}
function Zn(){var a=void 0===a?{}:a;var b,c;return A(function(d){if(1==d.h)return d.yield(Pn(),2);if(3!=d.h){b=d.i;if(!b)return d.return();Fm("LogsDatabaseV2");return d.yield(Hn(b),3)}c=d.i;return d.yield(Yn(c,a,b),0)})}
function $n(a,b){b=void 0===b?{}:b;var c;return A(function(d){if(1==d.h)return d.yield(Pn(),2);if(3!=d.h){c=d.i;if(!c)return d.return();Fm(a);return d.yield(zn(a,b),3)}return d.yield(Fn(a,c),0)})}
;function ao(a,b){An.call(this,a,b);this.options=b;Fm(a)}
w(ao,An);function bo(a,b){var c;return function(){c||(c=new ao(a,b));return c}}
ao.prototype.i=function(a,b,c){c=void 0===c?{}:c;return(this.options.pc?Wn:Vn)(a,b,Object.assign({},c))};
ao.prototype.delete=function(a){a=void 0===a?{}:a;return(this.options.pc?$n:Xn)(this.name,a)};
function co(a,b){return bo(a,b)}
;var eo={},fo=co("ytGcfConfig",{Eb:(eo.coldConfigStore={Lb:1},eo.hotConfigStore={Lb:1},eo),pc:!1,upgrade:function(a,b){b(1)&&(qn(jn(a,"hotConfigStore",{keyPath:"key",autoIncrement:!0}),"hotTimestampIndex","timestamp"),qn(jn(a,"coldConfigStore",{keyPath:"key",autoIncrement:!0}),"coldTimestampIndex","timestamp"))},
version:1});function go(a){return Cn(fo(),a)}
function ho(a,b,c){var d,e,f;return A(function(g){switch(g.h){case 1:return d={config:a,hashData:b,timestamp:T()},g.yield(go(c),2);case 2:return e=g.i,g.yield(e.clear("hotConfigStore"),3);case 3:return g.yield(ln(e,"hotConfigStore",d),4);case 4:return f=g.i,g.return(f)}})}
function io(a,b,c,d){var e,f,g;return A(function(h){switch(h.h){case 1:return e={config:a,hashData:b,configData:c,timestamp:T()},h.yield(go(d),2);case 2:return f=h.i,h.yield(f.clear("coldConfigStore"),3);case 3:return h.yield(ln(f,"coldConfigStore",e),4);case 4:return g=h.i,h.return(g)}})}
function jo(a){var b,c;return A(function(d){return 1==d.h?d.yield(go(a),2):3!=d.h?(b=d.i,c=void 0,d.yield(hn(b,["coldConfigStore"],{mode:"readwrite",ea:!0},function(e){return vn(e.objectStore("coldConfigStore").index("coldTimestampIndex"),{direction:"prev"},function(f){c=f.getValue()})}),3)):d.return(c)})}
function ko(a){var b,c;return A(function(d){return 1==d.h?d.yield(go(a),2):3!=d.h?(b=d.i,c=void 0,d.yield(hn(b,["hotConfigStore"],{mode:"readwrite",ea:!0},function(e){return vn(e.objectStore("hotConfigStore").index("hotTimestampIndex"),{direction:"prev"},function(f){c=f.getValue()})}),3)):d.return(c)})}
;function lo(){G.apply(this,arguments);this.i=[]}
w(lo,G);lo.prototype.M=function(){this.i.length=0;G.prototype.M.call(this)};function mo(){this.h=0;this.i=new lo}
function no(){var a;return null!=(a=E("yt.gcf.config.hotConfigGroup"))?a:null}
function oo(a,b,c){var d,e,f;return A(function(g){switch(g.h){case 1:if(!S("update_log_event_config")){g.A(0);break}c&&(a.j=c,D("yt.gcf.config.hotConfigGroup",a.j||null));a.hotHashData=b;D("yt.gcf.config.hotHashData",a.hotHashData||null);d=On();if(!d){g.A(3);break}if(c){g.A(4);break}return g.yield(ko(d),5);case 5:e=g.i,c=null==(f=e)?void 0:f.config;case 4:return g.yield(ho(c,b,d),3);case 3:if(c)for(var h=c,k=v(a.i.i),l=k.next();!l.done;l=k.next())l=l.value,l(h);g.h=0}})}
function po(a,b,c){var d,e,f,g;return A(function(h){if(1==h.h){if(!S("update_log_event_config"))return h.A(0);a.coldHashData=b;D("yt.gcf.config.coldHashData",a.coldHashData||null);return(d=On())?c?h.A(4):h.yield(jo(d),5):h.A(0)}4!=h.h&&(e=h.i,c=null==(f=e)?void 0:f.config);if(!c)return h.A(0);g=c.configData;return h.yield(io(c,b,g,d),0)})}
;function qo(){return"INNERTUBE_API_KEY"in Nk&&"INNERTUBE_API_VERSION"in Nk}
function ro(){return{innertubeApiKey:R("INNERTUBE_API_KEY"),innertubeApiVersion:R("INNERTUBE_API_VERSION"),oe:R("INNERTUBE_CONTEXT_CLIENT_CONFIG_INFO"),pd:R("INNERTUBE_CONTEXT_CLIENT_NAME","WEB"),Nf:R("INNERTUBE_CONTEXT_CLIENT_NAME",1),innertubeContextClientVersion:R("INNERTUBE_CONTEXT_CLIENT_VERSION"),qe:R("INNERTUBE_CONTEXT_HL"),pe:R("INNERTUBE_CONTEXT_GL"),re:R("INNERTUBE_HOST_OVERRIDE")||"",te:!!R("INNERTUBE_USE_THIRD_PARTY_AUTH",!1),se:!!R("INNERTUBE_OMIT_API_KEY_WHEN_AUTH_HEADER_IS_PRESENT",
!1),appInstallData:R("SERIALIZED_CLIENT_CONFIG_DATA")}}
function so(a){var b={client:{hl:a.qe,gl:a.pe,clientName:a.pd,clientVersion:a.innertubeContextClientVersion,configInfo:a.oe}};navigator.userAgent&&(b.client.userAgent=String(navigator.userAgent));var c=C.devicePixelRatio;c&&1!=c&&(b.client.screenDensityFloat=String(c));c=R("EXPERIMENTS_TOKEN","");""!==c&&(b.client.experimentsToken=c);c=il();0<c.length&&(b.request={internalExperimentFlags:c});c=a.pd;if(("WEB"===c||"MWEB"===c||1===c||2===c)&&b){var d;b.client.mainAppWebInfo=null!=(d=b.client.mainAppWebInfo)?
d:{};b.client.mainAppWebInfo.webDisplayMode=Sl()}(d=E("yt.embedded_player.embed_url"))&&b&&(b.thirdParty={embedUrl:d});var e;if(S("web_log_memory_total_kbytes")&&(null==(e=C.navigator)?0:e.deviceMemory)){var f;e=null==(f=C.navigator)?void 0:f.deviceMemory;b&&(b.client.memoryTotalKbytes=""+1E6*e)}a.appInstallData&&b&&(b.client.configInfo=b.client.configInfo||{},b.client.configInfo.appInstallData=a.appInstallData);(a=hm())&&b&&(b.client.connectionType=a);S("web_log_effective_connection_type")&&(a=im())&&
b&&(b.client.effectiveConnectionType=a);S("start_sending_config_hash")&&(mo.h||(a=new mo,mo.h=a),a=mo.h,f=T()-a.h,0!==a.h&&f<hl("send_config_hash_timer")?a=void 0:(f=E("yt.gcf.config.coldConfigData"),e=E("yt.gcf.config.hotHashData"),d=E("yt.gcf.config.coldHashData"),f&&e&&d&&(a.h=T()),a={coldConfigData:f,hotHashData:e,coldHashData:d}),e=a)&&(a=e.coldConfigData,f=e.coldHashData,e=e.hotHashData,a&&f&&e&&b&&(b.client.configInfo=b.client.configInfo||{},b.client.configInfo.coldConfigData=a,b.client.configInfo.coldHashData=
f,b.client.configInfo.hotHashData=e));R("DELEGATED_SESSION_ID")&&!S("pageid_as_header_web")&&(b.user={onBehalfOfUser:R("DELEGATED_SESSION_ID")});!S("fill_delegate_context_in_gel_killswitch")&&(a=R("INNERTUBE_CONTEXT_SERIALIZED_DELEGATION_CONTEXT"))&&(b.user=Object.assign({},b.user,{serializedDelegationContext:a}));a=Object;f=a.assign;e=b.client;d={};c=v(Object.entries(al(R("DEVICE",""))));for(var g=c.next();!g.done;g=c.next()){var h=v(g.value);g=h.next().value;h=h.next().value;"cbrand"===g?d.deviceMake=
h:"cmodel"===g?d.deviceModel=h:"cbr"===g?d.browserName=h:"cbrver"===g?d.browserVersion=h:"cos"===g?d.osName=h:"cosver"===g?d.osVersion=h:"cplatform"===g&&(d.platform=h)}b.client=f.call(a,e,d);return b}
function to(a,b,c){c=void 0===c?{}:c;var d={};R("EOM_VISITOR_DATA")?d={"X-Goog-EOM-Visitor-Id":R("EOM_VISITOR_DATA")}:d={"X-Goog-Visitor-Id":c.visitorData||R("VISITOR_DATA","")};if(b&&b.includes("www.youtube-nocookie.com"))return d;b=c.authorization||R("AUTHORIZATION");b||(a?b="Bearer "+E("gapi.auth.getToken")().Hf:(a=Pl(Ol()),S("pageid_as_header_web")||delete a["X-Goog-PageId"],d=Object.assign({},d,a)));b&&(d.Authorization=b);return d}
;function uo(a,b){this.version=a;this.args=b}
uo.prototype.serialize=function(){return{version:this.version,args:this.args}};function vo(a,b){this.topic=a;this.h=b}
vo.prototype.toString=function(){return this.topic};var wo=E("ytPubsub2Pubsub2Instance")||new M;M.prototype.subscribe=M.prototype.subscribe;M.prototype.unsubscribeByKey=M.prototype.Jb;M.prototype.publish=M.prototype.cb;M.prototype.clear=M.prototype.clear;D("ytPubsub2Pubsub2Instance",wo);var xo=E("ytPubsub2Pubsub2SubscribedKeys")||{};D("ytPubsub2Pubsub2SubscribedKeys",xo);var yo=E("ytPubsub2Pubsub2TopicToKeys")||{};D("ytPubsub2Pubsub2TopicToKeys",yo);var zo=E("ytPubsub2Pubsub2IsAsync")||{};D("ytPubsub2Pubsub2IsAsync",zo);
D("ytPubsub2Pubsub2SkipSubKey",null);function Ao(a,b){var c=Bo();c&&c.publish.call(c,a.toString(),a,b)}
function Co(a){var b=Do,c=Bo();if(!c)return 0;var d=c.subscribe(b.toString(),function(e,f){var g=E("ytPubsub2Pubsub2SkipSubKey");g&&g==d||(g=function(){if(xo[d])try{if(f&&b instanceof vo&&b!=e)try{var h=b.h,k=f;if(!k.args||!k.version)throw Error("yt.pubsub2.Data.deserialize(): serializedData is incomplete.");try{if(!h.Xa){var l=new h;h.Xa=l.version}var n=h.Xa}catch(z){}if(!n||k.version!=n)throw Error("yt.pubsub2.Data.deserialize(): serializedData version is incompatible.");try{n=Reflect;var p=n.construct;
var t=k.args,r=t.length;if(0<r){var x=Array(r);for(k=0;k<r;k++)x[k]=t[k];var y=x}else y=[];f=p.call(n,h,y)}catch(z){throw z.message="yt.pubsub2.Data.deserialize(): "+z.message,z;}}catch(z){throw z.message="yt.pubsub2.pubsub2 cross-binary conversion error for "+b.toString()+": "+z.message,z;}a.call(window,f)}catch(z){Tk(z)}},zo[b.toString()]?E("yt.scheduler.instance")?oi.ka(g):ml(g,0):g())});
xo[d]=!0;yo[b.toString()]||(yo[b.toString()]=[]);yo[b.toString()].push(d);return d}
function Eo(){var a=Fo,b=Co(function(c){a.apply(void 0,arguments);Go(b)});
return b}
function Go(a){var b=Bo();b&&("number"===typeof a&&(a=[a]),bb(a,function(c){b.unsubscribeByKey(c);delete xo[c]}))}
function Bo(){return E("ytPubsub2Pubsub2Instance")}
;function Ho(a,b,c){c=void 0===c?{sampleRate:.1}:c;Math.random()<Math.min(.02,c.sampleRate/100)&&Ao("meta_logging_csi_event",{timerName:a,dg:b})}
;var Io=hl("max_body_size_to_compress",5E5),Jo=hl("min_body_size_to_compress",500),Ko=!0,Lo=0,Mo=0,No=hl("compression_performance_threshold_lr",250),Oo=hl("slow_compressions_before_abandon_count",4);
function Po(a,b,c,d){var e=T(),f={startTime:e,ticks:{},infos:{}};if(Ko)try{var g=Qo(b);if(null==g||!(g>Io||g<Jo)){var h=nk(ji(b)),k=T();f.ticks.gelc=k;Mo++;S("disable_compression_due_to_performance_degredation")&&k-e>=No&&(Lo++,S("abandon_compression_after_N_slow_zips")?Mo===hl("compression_disable_point")&&Lo>Oo&&(Ko=!1):Ko=!1);Ro(f);c.headers||(c.headers={});c.headers["Content-Encoding"]="gzip";c.postBody=h;c.postParams=void 0}d(a,c)}catch(l){Uk(l),d(a,c)}else d(a,c)}
function So(a){var b=void 0===b?!1:b;var c=void 0===c?!1:c;var d=T(),e={startTime:d,ticks:{},infos:{}},f=b?E("yt.logging.gzipForFetch",!1):!0;if(Ko&&f){if(!a.body)return a;try{var g=c?a.body:"string"===typeof a.body?a.body:JSON.stringify(a.body);f=g;if(!c&&"string"===typeof g){var h=Qo(g);if(null!=h&&(h>Io||h<Jo))return a;f=nk(ji(g),b?{level:1}:void 0);var k=T();e.ticks.gelc=k;if(b){Mo++;if((S("disable_compression_due_to_performance_degredation")||S("disable_compression_due_to_performance_degradation_lr"))&&
k-d>=No)if(Lo++,S("abandon_compression_after_N_slow_zips")||S("abandon_compression_after_N_slow_zips_lr")){b=Lo/Mo;var l=Oo/hl("compression_disable_point");0<Mo&&0===Mo%hl("compression_disable_point")&&b>=l&&(Ko=!1)}else Ko=!1;Ro(e)}}a.headers=Object.assign({},{"Content-Encoding":"gzip"},a.headers||{});a.body=f;return a}catch(n){return Uk(n),a}}else return a}
function Qo(a){try{return(new Blob(a.split(""))).size}catch(b){return Uk(b),null}}
function Ro(a){S("gel_compression_csi_killswitch")||!S("log_gel_compression_latency")&&!S("log_gel_compression_latency_lr")||Ho("gel_compression",a,{sampleRate:.1})}
;function To(a){a=Object.assign({},a);delete a.Authorization;var b=Hg();if(b){var c=new ui;c.update(R("INNERTUBE_API_KEY"));c.update(b);a.hash=Ze(c.digest(),3)}return a}
;var Uo;function Vo(){Uo||(Uo=new sm("yt.innertube"));return Uo}
function Wo(a,b,c,d){if(d)return null;d=Vo().get("nextId",!0)||1;var e=Vo().get("requests",!0)||{};e[d]={method:a,request:b,authState:To(c),requestTime:Math.round(T())};Vo().set("nextId",d+1,86400,!0);Vo().set("requests",e,86400,!0);return d}
function Xo(a){var b=Vo().get("requests",!0)||{};delete b[a];Vo().set("requests",b,86400,!0)}
function Yo(a){var b=Vo().get("requests",!0);if(b){for(var c in b){var d=b[c];if(!(6E4>Math.round(T())-d.requestTime)){var e=d.authState,f=To(to(!1));ob(e,f)&&(e=d.request,"requestTimeMs"in e&&(e.requestTimeMs=Math.round(T())),Zo(a,d.method,e,{}));delete b[c]}}Vo().set("requests",b,86400,!0)}}
;function $o(a){this.Yb=this.h=!1;this.potentialEsfErrorCounter=this.i=0;this.handleError=function(){};
this.xb=function(){};
this.now=Date.now;this.Ob=!1;var b;this.Hd=null!=(b=a.Hd)?b:100;var c;this.Bd=null!=(c=a.Bd)?c:1;var d;this.zd=null!=(d=a.zd)?d:2592E6;var e;this.xd=null!=(e=a.xd)?e:12E4;var f;this.Ad=null!=(f=a.Ad)?f:5E3;var g;this.R=null!=(g=a.R)?g:void 0;this.ec=!!a.ec;var h;this.cc=null!=(h=a.cc)?h:.1;var k;this.lc=null!=(k=a.lc)?k:10;a.handleError&&(this.handleError=a.handleError);a.xb&&(this.xb=a.xb);a.Ob&&(this.Ob=a.Ob);a.Yb&&(this.Yb=a.Yb);this.S=a.S;this.Ba=a.Ba;this.Y=a.Y;this.X=a.X;this.Pa=a.Pa;this.Nc=
a.Nc;this.Mc=a.Mc;ap(this)&&(!this.S||this.S("networkless_logging"))&&bp(this)}
function bp(a){ap(a)&&!a.Ob&&(a.h=!0,a.ec&&Math.random()<=a.cc&&a.Y.Xd(a.R),cp(a),a.X.qa()&&a.Sb(),a.X.listen(a.Nc,a.Sb.bind(a)),a.X.listen(a.Mc,a.cd.bind(a)))}
m=$o.prototype;m.writeThenSend=function(a,b){var c=this;b=void 0===b?{}:b;if(ap(this)&&this.h){var d={url:a,options:b,timestamp:this.now(),status:"NEW",sendCount:0};this.Y.set(d,this.R).then(function(e){d.id=e;c.X.qa()&&dp(c,d)}).catch(function(e){dp(c,d);
ep(c,e)})}else this.Pa(a,b)};
m.sendThenWrite=function(a,b,c){var d=this;b=void 0===b?{}:b;if(ap(this)&&this.h){var e={url:a,options:b,timestamp:this.now(),status:"NEW",sendCount:0};this.S&&this.S("nwl_skip_retry")&&(e.skipRetry=c);if(this.X.qa()||this.S&&this.S("nwl_aggressive_send_then_write")&&!e.skipRetry){if(!e.skipRetry){var f=b.onError?b.onError:function(){};
b.onError=function(g,h){return A(function(k){if(1==k.h)return k.yield(d.Y.set(e,d.R).catch(function(l){ep(d,l)}),2);
f(g,h);k.h=0})}}this.Pa(a,b,e.skipRetry)}else this.Y.set(e,this.R).catch(function(g){d.Pa(a,b,e.skipRetry);
ep(d,g)})}else this.Pa(a,b,this.S&&this.S("nwl_skip_retry")&&c)};
m.sendAndWrite=function(a,b){var c=this;b=void 0===b?{}:b;if(ap(this)&&this.h){var d={url:a,options:b,timestamp:this.now(),status:"NEW",sendCount:0},e=!1,f=b.onSuccess?b.onSuccess:function(){};
d.options.onSuccess=function(g,h){void 0!==d.id?c.Y.tb(d.id,c.R):e=!0;c.X.hb&&c.S&&c.S("vss_network_hint")&&c.X.hb(!0);f(g,h)};
this.Pa(d.url,d.options);this.Y.set(d,this.R).then(function(g){d.id=g;e&&c.Y.tb(d.id,c.R)}).catch(function(g){ep(c,g)})}else this.Pa(a,b)};
m.Sb=function(){var a=this;if(!ap(this))throw Um("throttleSend");this.i||(this.i=this.Ba.ka(function(){var b;return A(function(c){if(1==c.h)return c.yield(a.Y.md("NEW",a.R),2);if(3!=c.h)return b=c.i,b?c.yield(dp(a,b),3):(a.cd(),c.return());a.i&&(a.i=0,a.Sb());c.h=0})},this.Hd))};
m.cd=function(){this.Ba.ya(this.i);this.i=0};
function dp(a,b){var c,d;return A(function(e){switch(e.h){case 1:if(!ap(a))throw c=Um("immediateSend"),c;if(void 0===b.id){e.A(2);break}return e.yield(a.Y.we(b.id,a.R),3);case 3:(d=e.i)||a.xb(Error("The request cannot be found in the database."));case 2:if(fp(a,b,a.zd)){e.A(4);break}a.xb(Error("Networkless Logging: Stored logs request expired age limit"));if(void 0===b.id){e.A(5);break}return e.yield(a.Y.tb(b.id,a.R),5);case 5:return e.return();case 4:b.skipRetry||(b=gp(a,b));if(!b){e.A(0);break}if(!b.skipRetry||
void 0===b.id){e.A(8);break}return e.yield(a.Y.tb(b.id,a.R),8);case 8:a.Pa(b.url,b.options,!!b.skipRetry),e.h=0}})}
function gp(a,b){if(!ap(a))throw Um("updateRequestHandlers");var c=b.options.onError?b.options.onError:function(){};
b.options.onError=function(e,f){var g,h,k,l;return A(function(n){switch(n.h){case 1:g=hp(f);(h=ip(f))&&a.S&&a.S("web_enable_error_204")&&a.handleError(Error("Request failed due to compression"),b.url,f);if(!(a.S&&a.S("nwl_consider_error_code")&&g||a.S&&!a.S("nwl_consider_error_code")&&a.potentialEsfErrorCounter<=a.lc)){n.A(2);break}if(!a.X.oc){n.A(3);break}return n.yield(a.X.oc(),3);case 3:if(a.X.qa()){n.A(2);break}c(e,f);if(!a.S||!a.S("nwl_consider_error_code")||void 0===(null==(k=b)?void 0:k.id)){n.A(6);
break}return n.yield(a.Y.Qc(b.id,a.R,!1),6);case 6:return n.return();case 2:if(a.S&&a.S("nwl_consider_error_code")&&!g&&a.potentialEsfErrorCounter>a.lc)return n.return();a.potentialEsfErrorCounter++;if(void 0===(null==(l=b)?void 0:l.id)){n.A(8);break}return b.sendCount<a.Bd?n.yield(a.Y.Qc(b.id,a.R,!0,h?!1:void 0),12):n.yield(a.Y.tb(b.id,a.R),8);case 12:a.Ba.ka(function(){a.X.qa()&&a.Sb()},a.Ad);
case 8:c(e,f),n.h=0}})};
var d=b.options.onSuccess?b.options.onSuccess:function(){};
b.options.onSuccess=function(e,f){var g;return A(function(h){if(1==h.h)return void 0===(null==(g=b)?void 0:g.id)?h.A(2):h.yield(a.Y.tb(b.id,a.R),2);a.X.hb&&a.S&&a.S("vss_network_hint")&&a.X.hb(!0);d(e,f);h.h=0})};
return b}
function fp(a,b,c){b=b.timestamp;return a.now()-b>=c?!1:!0}
function cp(a){if(!ap(a))throw Um("retryQueuedRequests");a.Y.md("QUEUED",a.R).then(function(b){b&&!fp(a,b,a.xd)?a.Ba.ka(function(){return A(function(c){if(1==c.h)return void 0===b.id?c.A(2):c.yield(a.Y.Qc(b.id,a.R),2);cp(a);c.h=0})}):a.X.qa()&&a.Sb()})}
function ep(a,b){a.Nd&&!a.X.qa()?a.Nd(b):a.handleError(b)}
function ap(a){return!!a.R||a.Yb}
function hp(a){var b;return(a=null==a?void 0:null==(b=a.error)?void 0:b.code)&&400<=a&&599>=a?!1:!0}
function ip(a){var b;a=null==a?void 0:null==(b=a.error)?void 0:b.code;return!(400!==a&&415!==a)}
;var jp;
function kp(){if(jp)return jp();var a={};jp=co("LogsDatabaseV2",{Eb:(a.LogsRequestsStore={Lb:2},a),pc:!1,upgrade:function(b,c,d){c(2)&&jn(b,"LogsRequestsStore",{keyPath:"id",autoIncrement:!0});c(3);c(5)&&(d=d.objectStore("LogsRequestsStore"),d.h.indexNames.contains("newRequest")&&d.h.deleteIndex("newRequest"),qn(d,"newRequestV2",["status","interface","timestamp"]));c(7)&&b.h.objectStoreNames.contains("sapisid")&&b.h.deleteObjectStore("sapisid");c(9)&&b.h.objectStoreNames.contains("SWHealthLog")&&b.h.deleteObjectStore("SWHealthLog")},
version:9});return jp()}
;function lp(a){return Cn(kp(),a)}
function mp(a,b){var c,d,e,f;return A(function(g){if(1==g.h)return c={startTime:T(),infos:{transactionType:"YT_IDB_TRANSACTION_TYPE_WRITE"},ticks:{}},g.yield(lp(b),2);if(3!=g.h)return d=g.i,e=Object.assign({},a,{options:JSON.parse(JSON.stringify(a.options)),interface:R("INNERTUBE_CONTEXT_CLIENT_NAME",0)}),g.yield(ln(d,"LogsRequestsStore",e),3);f=g.i;c.ticks.tc=T();np(c);return g.return(f)})}
function op(a,b){var c,d,e,f,g,h,k;return A(function(l){if(1==l.h)return c={startTime:T(),infos:{transactionType:"YT_IDB_TRANSACTION_TYPE_READ"},ticks:{}},l.yield(lp(b),2);if(3!=l.h)return d=l.i,e=R("INNERTUBE_CONTEXT_CLIENT_NAME",0),f=[a,e,0],g=[a,e,T()],h=IDBKeyRange.bound(f,g),k=void 0,l.yield(hn(d,["LogsRequestsStore"],{mode:"readwrite",ea:!0},function(n){return vn(n.objectStore("LogsRequestsStore").index("newRequestV2"),{query:h,direction:"prev"},function(p){p.getValue()&&(k=p.getValue(),"NEW"===
a&&(k.status="QUEUED",p.update(k)))})}),3);
c.ticks.tc=T();np(c);return l.return(k)})}
function pp(a,b){var c;return A(function(d){if(1==d.h)return d.yield(lp(b),2);c=d.i;return d.return(hn(c,["LogsRequestsStore"],{mode:"readwrite",ea:!0},function(e){var f=e.objectStore("LogsRequestsStore");return f.get(a).then(function(g){if(g)return g.status="QUEUED",dn(f.h.put(g,void 0)).then(function(){return g})})}))})}
function qp(a,b,c,d){c=void 0===c?!0:c;var e;return A(function(f){if(1==f.h)return f.yield(lp(b),2);e=f.i;return f.return(hn(e,["LogsRequestsStore"],{mode:"readwrite",ea:!0},function(g){var h=g.objectStore("LogsRequestsStore");return h.get(a).then(function(k){return k?(k.status="NEW",c&&(k.sendCount+=1),void 0!==d&&(k.options.compress=d),dn(h.h.put(k,void 0)).then(function(){return k})):Ym.resolve(void 0)})}))})}
function rp(a,b){var c;return A(function(d){if(1==d.h)return d.yield(lp(b),2);c=d.i;return d.return(c.delete("LogsRequestsStore",a))})}
function sp(a){var b,c;return A(function(d){if(1==d.h)return d.yield(lp(a),2);b=d.i;c=T()-2592E6;return d.yield(hn(b,["LogsRequestsStore"],{mode:"readwrite",ea:!0},function(e){return sn(e.objectStore("LogsRequestsStore"),{},function(f){if(f.getValue().timestamp<=c)return f.delete().then(function(){return f.continue()})})}),0)})}
function tp(){A(function(a){return a.yield(Zn(),0)})}
function np(a){S("nwl_csi_killswitch")||Ho("networkless_performance",a,{sampleRate:1})}
;var up={accountStateChangeSignedIn:23,accountStateChangeSignedOut:24,delayedEventMetricCaptured:11,latencyActionBaselined:6,latencyActionInfo:7,latencyActionTicked:5,offlineTransferStatusChanged:2,offlineImageDownload:335,playbackStartStateChanged:9,systemHealthCaptured:3,mangoOnboardingCompleted:10,mangoPushNotificationReceived:230,mangoUnforkDbMigrationError:121,mangoUnforkDbMigrationSummary:122,mangoUnforkDbMigrationPreunforkDbVersionNumber:133,mangoUnforkDbMigrationPhoneMetadata:134,mangoUnforkDbMigrationPhoneStorage:135,
mangoUnforkDbMigrationStep:142,mangoAsyncApiMigrationEvent:223,mangoDownloadVideoResult:224,mangoHomepageVideoCount:279,mangoHomeV3State:295,mangoImageClientCacheHitEvent:273,sdCardStatusChanged:98,framesDropped:12,thumbnailHovered:13,deviceRetentionInfoCaptured:14,thumbnailLoaded:15,backToAppEvent:318,streamingStatsCaptured:17,offlineVideoShared:19,appCrashed:20,youThere:21,offlineStateSnapshot:22,mdxSessionStarted:25,mdxSessionConnected:26,mdxSessionDisconnected:27,bedrockResourceConsumptionSnapshot:28,
nextGenWatchWatchSwiped:29,kidsAccountsSnapshot:30,zeroStepChannelCreated:31,tvhtml5SearchCompleted:32,offlineSharePairing:34,offlineShareUnlock:35,mdxRouteDistributionSnapshot:36,bedrockRepetitiveActionTimed:37,unpluggedDegradationInfo:229,uploadMp4HeaderMoved:38,uploadVideoTranscoded:39,uploadProcessorStarted:46,uploadProcessorEnded:47,uploadProcessorReady:94,uploadProcessorRequirementPending:95,uploadProcessorInterrupted:96,uploadFrontendEvent:241,assetPackDownloadStarted:41,assetPackDownloaded:42,
assetPackApplied:43,assetPackDeleted:44,appInstallAttributionEvent:459,playbackSessionStopped:45,adBlockerMessagingShown:48,distributionChannelCaptured:49,dataPlanCpidRequested:51,detailedNetworkTypeCaptured:52,sendStateUpdated:53,receiveStateUpdated:54,sendDebugStateUpdated:55,receiveDebugStateUpdated:56,kidsErrored:57,mdxMsnSessionStatsFinished:58,appSettingsCaptured:59,mdxWebSocketServerHttpError:60,mdxWebSocketServer:61,startupCrashesDetected:62,coldStartInfo:435,offlinePlaybackStarted:63,liveChatMessageSent:225,
liveChatUserPresent:434,liveChatBeingModerated:457,liveCreationCameraUpdated:64,liveCreationEncodingCaptured:65,liveCreationError:66,liveCreationHealthUpdated:67,liveCreationVideoEffectsCaptured:68,liveCreationStageOccured:75,liveCreationBroadcastScheduled:123,liveCreationArchiveReplacement:149,liveCreationCostreamingConnection:421,liveCreationStreamWebrtcStats:288,mdxSessionRecoveryStarted:69,mdxSessionRecoveryCompleted:70,mdxSessionRecoveryStopped:71,visualElementShown:72,visualElementHidden:73,
visualElementGestured:78,visualElementStateChanged:208,screenCreated:156,playbackAssociated:202,visualElementAttached:215,playbackContextEvent:214,cloudCastingPlaybackStarted:74,webPlayerApiCalled:76,tvhtml5AccountDialogOpened:79,foregroundHeartbeat:80,foregroundHeartbeatScreenAssociated:111,kidsOfflineSnapshot:81,mdxEncryptionSessionStatsFinished:82,playerRequestCompleted:83,liteSchedulerStatistics:84,mdxSignIn:85,spacecastMetadataLookupRequested:86,spacecastBatchLookupRequested:87,spacecastSummaryRequested:88,
spacecastPlayback:89,spacecastDiscovery:90,tvhtml5LaunchUrlComponentChanged:91,mdxBackgroundPlaybackRequestCompleted:92,mdxBrokenAdditionalDataDeviceDetected:93,tvhtml5LocalStorage:97,tvhtml5DeviceStorageStatus:147,autoCaptionsAvailable:99,playbackScrubbingEvent:339,flexyState:100,interfaceOrientationCaptured:101,mainAppBrowseFragmentCache:102,offlineCacheVerificationFailure:103,offlinePlaybackExceptionDigest:217,vrCopresenceStats:104,vrCopresenceSyncStats:130,vrCopresenceCommsStats:137,vrCopresencePartyStats:153,
vrCopresenceEmojiStats:213,vrCopresenceEvent:141,vrCopresenceFlowTransitEvent:160,vrPlaybackEvent:345,kidsAgeGateTracking:105,offlineDelayAllowedTracking:106,mainAppAutoOfflineState:107,videoAsThumbnailDownload:108,videoAsThumbnailPlayback:109,liteShowMore:110,renderingError:118,kidsProfilePinGateTracking:119,abrTrajectory:124,scrollEvent:125,streamzIncremented:126,kidsProfileSwitcherTracking:127,kidsProfileCreationTracking:129,buyFlowStarted:136,mbsConnectionInitiated:138,mbsPlaybackInitiated:139,
mbsLoadChildren:140,liteProfileFetcher:144,mdxRemoteTransaction:146,reelPlaybackError:148,reachabilityDetectionEvent:150,mobilePlaybackEvent:151,courtsidePlayerStateChanged:152,musicPersistentCacheChecked:154,musicPersistentCacheCleared:155,playbackInterrupted:157,playbackInterruptionResolved:158,fixFopFlow:159,anrDetection:161,backstagePostCreationFlowEnded:162,clientError:163,gamingAccountLinkStatusChanged:164,liteHousewarming:165,buyFlowEvent:167,kidsParentalGateTracking:168,kidsSignedOutSettingsStatus:437,
kidsSignedOutPauseHistoryFixStatus:438,tvhtml5WatchdogViolation:444,ypcUpgradeFlow:169,yongleStudy:170,ypcUpdateFlowStarted:171,ypcUpdateFlowCancelled:172,ypcUpdateFlowSucceeded:173,ypcUpdateFlowFailed:174,liteGrowthkitPromo:175,paymentFlowStarted:341,transactionFlowShowPaymentDialog:405,transactionFlowStarted:176,transactionFlowSecondaryDeviceStarted:222,transactionFlowSecondaryDeviceSignedOutStarted:383,transactionFlowCancelled:177,transactionFlowPaymentCallBackReceived:387,transactionFlowPaymentSubmitted:460,
transactionFlowPaymentSucceeded:329,transactionFlowSucceeded:178,transactionFlowFailed:179,transactionFlowPlayBillingConnectionStartEvent:428,transactionFlowSecondaryDeviceSuccess:458,transactionFlowErrorEvent:411,liteVideoQualityChanged:180,watchBreakEnablementSettingEvent:181,watchBreakFrequencySettingEvent:182,videoEffectsCameraPerformanceMetrics:183,adNotify:184,startupTelemetry:185,playbackOfflineFallbackUsed:186,outOfMemory:187,ypcPauseFlowStarted:188,ypcPauseFlowCancelled:189,ypcPauseFlowSucceeded:190,
ypcPauseFlowFailed:191,uploadFileSelected:192,ypcResumeFlowStarted:193,ypcResumeFlowCancelled:194,ypcResumeFlowSucceeded:195,ypcResumeFlowFailed:196,adsClientStateChange:197,ypcCancelFlowStarted:198,ypcCancelFlowCancelled:199,ypcCancelFlowSucceeded:200,ypcCancelFlowFailed:201,ypcCancelFlowGoToPaymentProcessor:402,ypcDeactivateFlowStarted:320,ypcRedeemFlowStarted:203,ypcRedeemFlowCancelled:204,ypcRedeemFlowSucceeded:205,ypcRedeemFlowFailed:206,ypcFamilyCreateFlowStarted:258,ypcFamilyCreateFlowCancelled:259,
ypcFamilyCreateFlowSucceeded:260,ypcFamilyCreateFlowFailed:261,ypcFamilyManageFlowStarted:262,ypcFamilyManageFlowCancelled:263,ypcFamilyManageFlowSucceeded:264,ypcFamilyManageFlowFailed:265,restoreContextEvent:207,embedsAdEvent:327,autoplayTriggered:209,clientDataErrorEvent:210,experimentalVssValidation:211,tvhtml5TriggeredEvent:212,tvhtml5FrameworksFieldTrialResult:216,tvhtml5FrameworksFieldTrialStart:220,musicOfflinePreferences:218,watchTimeSegment:219,appWidthLayoutError:221,accountRegistryChange:226,
userMentionAutoCompleteBoxEvent:227,downloadRecommendationEnablementSettingEvent:228,musicPlaybackContentModeChangeEvent:231,offlineDbOpenCompleted:232,kidsFlowEvent:233,kidsFlowCorpusSelectedEvent:234,videoEffectsEvent:235,unpluggedOpsEogAnalyticsEvent:236,playbackAudioRouteEvent:237,interactionLoggingDebugModeError:238,offlineYtbRefreshed:239,kidsFlowError:240,musicAutoplayOnLaunchAttempted:242,deviceContextActivityEvent:243,deviceContextEvent:244,templateResolutionException:245,musicSideloadedPlaylistServiceCalled:246,
embedsStorageAccessNotChecked:247,embedsHasStorageAccessResult:248,embedsItpPlayedOnReload:249,embedsRequestStorageAccessResult:250,embedsShouldRequestStorageAccessResult:251,embedsRequestStorageAccessState:256,embedsRequestStorageAccessFailedState:257,embedsItpWatchLaterResult:266,searchSuggestDecodingPayloadFailure:252,siriShortcutActivated:253,tvhtml5KeyboardPerformance:254,latencyActionSpan:255,elementsLog:267,ytbFileOpened:268,tfliteModelError:269,tvhtml5ApiTest:270,yongleUsbSetup:271,touStrikeInterstitialEvent:272,
liteStreamToSave:274,appBundleClientEvent:275,ytbFileCreationFailed:276,adNotifyFailure:278,ytbTransferFailed:280,blockingRequestFailed:281,liteAccountSelector:282,liteAccountUiCallbacks:283,dummyPayload:284,browseResponseValidationEvent:285,entitiesError:286,musicIosBackgroundFetch:287,mdxNotificationEvent:289,layersValidationError:290,musicPwaInstalled:291,liteAccountCleanup:292,html5PlayerHealthEvent:293,watchRestoreAttempt:294,liteAccountSignIn:296,notaireEvent:298,kidsVoiceSearchEvent:299,adNotifyFilled:300,
delayedEventDropped:301,analyticsSearchEvent:302,systemDarkThemeOptOutEvent:303,flowEvent:304,networkConnectivityBaselineEvent:305,ytbFileImported:306,downloadStreamUrlExpired:307,directSignInEvent:308,lyricImpressionEvent:309,accessibilityStateEvent:310,tokenRefreshEvent:311,genericAttestationExecution:312,tvhtml5VideoSeek:313,unpluggedAutoPause:314,scrubbingEvent:315,bedtimeReminderEvent:317,tvhtml5UnexpectedRestart:319,tvhtml5StabilityTraceEvent:478,tvhtml5OperationHealth:467,tvhtml5WatchKeyEvent:321,
voiceLanguageChanged:322,tvhtml5LiveChatStatus:323,parentToolsCorpusSelectedEvent:324,offerAdsEnrollmentInitiated:325,networkQualityIntervalEvent:326,deviceStartupMetrics:328,heartbeatActionPlayerTransitioned:330,tvhtml5Lifecycle:331,heartbeatActionPlayerHalted:332,adaptiveInlineMutedSettingEvent:333,mainAppLibraryLoadingState:334,thirdPartyLogMonitoringEvent:336,appShellAssetLoadReport:337,tvhtml5AndroidAttestation:338,tvhtml5StartupSoundEvent:340,iosBackgroundRefreshTask:342,iosBackgroundProcessingTask:343,
sliEventBatch:344,postImpressionEvent:346,musicSideloadedPlaylistExport:347,idbUnexpectedlyClosed:348,voiceSearchEvent:349,mdxSessionCastEvent:350,idbQuotaExceeded:351,idbTransactionEnded:352,idbTransactionAborted:353,tvhtml5KeyboardLogging:354,idbIsSupportedCompleted:355,creatorStudioMobileEvent:356,idbDataCorrupted:357,parentToolsAppChosenEvent:358,webViewBottomSheetResized:359,activeStateControllerScrollPerformanceSummary:360,navigatorValidation:361,mdxSessionHeartbeat:362,clientHintsPolyfillDiagnostics:363,
clientHintsPolyfillEvent:364,proofOfOriginTokenError:365,kidsAddedAccountSummary:366,musicWearableDevice:367,ypcRefundFlowEvent:368,tvhtml5PlaybackMeasurementEvent:369,tvhtml5WatermarkMeasurementEvent:370,clientExpGcfPropagationEvent:371,mainAppReferrerIntent:372,leaderLockEnded:373,leaderLockAcquired:374,googleHatsEvent:375,persistentLensLaunchEvent:376,parentToolsChildWelcomeChosenEvent:378,browseThumbnailPreloadEvent:379,finalPayload:380,mdxDialAdditionalDataUpdateEvent:381,webOrchestrationTaskLifecycleRecord:382,
startupSignalEvent:384,accountError:385,gmsDeviceCheckEvent:386,accountSelectorEvent:388,accountUiCallbacks:389,mdxDialAdditionalDataProbeEvent:390,downloadsSearchIcingApiStats:391,downloadsSearchIndexUpdatedEvent:397,downloadsSearchIndexSnapshot:398,dataPushClientEvent:392,kidsCategorySelectedEvent:393,mdxDeviceManagementSnapshotEvent:394,prefetchRequested:395,prefetchableCommandExecuted:396,gelDebuggingEvent:399,webLinkTtsPlayEnd:400,clipViewInvalid:401,persistentStorageStateChecked:403,cacheWipeoutEvent:404,
playerEvent:410,sfvEffectPipelineStartedEvent:412,sfvEffectPipelinePausedEvent:429,sfvEffectPipelineEndedEvent:413,sfvEffectChosenEvent:414,sfvEffectLoadedEvent:415,sfvEffectUserInteractionEvent:465,sfvEffectFirstFrameProcessedLatencyEvent:416,sfvEffectAggregatedFramesProcessedLatencyEvent:417,sfvEffectAggregatedFramesDroppedEvent:418,sfvEffectPipelineErrorEvent:430,sfvEffectGraphFrozenEvent:419,sfvEffectGlThreadBlockedEvent:420,mdeVideoChangedEvent:442,mdePlayerPerformanceMetrics:472,genericClientExperimentEvent:423,
homePreloadTaskScheduled:424,homePreloadTaskExecuted:425,homePreloadCacheHit:426,polymerPropertyChangedInObserver:427,applicationStarted:431,networkCronetRttBatch:432,networkCronetRttSummary:433,repeatChapterLoopEvent:436,seekCancellationEvent:462,offlineTransferStarted:4,musicOfflineMixtapePreferencesChanged:16,mangoDailyNewVideosNotificationAttempt:40,mangoDailyNewVideosNotificationError:77,dtwsPlaybackStarted:112,dtwsTileFetchStarted:113,dtwsTileFetchCompleted:114,dtwsTileFetchStatusChanged:145,
dtwsKeyframeDecoderBufferSent:115,dtwsTileUnderflowedOnNonkeyframe:116,dtwsBackfillFetchStatusChanged:143,dtwsBackfillUnderflowed:117,dtwsAdaptiveLevelChanged:128,blockingVisitorIdTimeout:277,liteSocial:18,mobileJsInvocation:297,biscottiBasedDetection:439,coWatchStateChange:440,embedsVideoDataDidChange:441,shortsFirst:443,cruiseControlEvent:445,qoeClientLoggingContext:446,atvRecommendationJobExecuted:447,tvhtml5UserFeedback:448,producerProjectCreated:449,producerProjectOpened:450,producerProjectDeleted:451,
producerProjectElementAdded:453,producerProjectElementRemoved:454,tvhtml5ShowClockEvent:455,deviceCapabilityCheckMetrics:456,youtubeClearcutEvent:461,offlineBrowseFallbackEvent:463,getCtvTokenEvent:464,startupDroppedFramesSummary:466,screenshotEvent:468,miniAppPlayEvent:469,elementsDebugCounters:470,fontLoadEvent:471,webKillswitchReceived:473,webKillswitchExecuted:474,cameraOpenEvent:475,manualSmoothnessMeasurement:476,tvhtml5AppQualityEvent:477,polymerPropertyAccessEvent:479,miniAppSdkUsage:480};var vp={},wp=co("ServiceWorkerLogsDatabase",{Eb:(vp.SWHealthLog={Lb:1},vp),pc:!0,upgrade:function(a,b){b(1)&&qn(jn(a,"SWHealthLog",{keyPath:"id",autoIncrement:!0}),"swHealthNewRequest",["interface","timestamp"])},
version:1});function xp(a){return Cn(wp(),a)}
function yp(a){var b,c;A(function(d){if(1==d.h)return d.yield(xp(a),2);b=d.i;c=T()-2592E6;return d.yield(hn(b,["SWHealthLog"],{mode:"readwrite",ea:!0},function(e){return sn(e.objectStore("SWHealthLog"),{},function(f){if(f.getValue().timestamp<=c)return f.delete().then(function(){return f.continue()})})}),0)})}
function zp(a){var b;return A(function(c){if(1==c.h)return c.yield(xp(a),2);b=c.i;return c.yield(b.clear("SWHealthLog"),0)})}
;var Ap={},Bp=0;function Cp(a){var b=new Image,c=""+Bp++;Ap[c]=b;b.onload=b.onerror=function(){delete Ap[c]};
b.src=a}
;function Dp(){this.h=new Map;this.i=!1}
function Ep(){if(!Dp.h){var a=E("yt.networkRequestMonitor.instance")||new Dp;D("yt.networkRequestMonitor.instance",a);Dp.h=a}return Dp.h}
Dp.prototype.requestComplete=function(a,b){b&&(this.i=!0);a=this.removeParams(a);this.h.get(a)||this.h.set(a,b)};
Dp.prototype.isEndpointCFR=function(a){a=this.removeParams(a);return(a=this.h.get(a))?!1:!1===a&&this.i?!0:null};
Dp.prototype.removeParams=function(a){return a.split("?")[0]};
Dp.prototype.removeParams=Dp.prototype.removeParams;Dp.prototype.isEndpointCFR=Dp.prototype.isEndpointCFR;Dp.prototype.requestComplete=Dp.prototype.requestComplete;Dp.getInstance=Ep;var Fp;function Gp(){Fp||(Fp=new sm("yt.offline"));return Fp}
function Hp(a){if(S("offline_error_handling")){var b=Gp().get("errors",!0)||{};b[a.message]={name:a.name,stack:a.stack};a.level&&(b[a.message].level=a.level);Gp().set("errors",b,2592E3,!0)}}
;function Ip(){Od.call(this);var a=this;this.j=!1;this.i=ni();this.i.listen("networkstatus-online",function(){if(a.j&&S("offline_error_handling")){var b=Gp().get("errors",!0);if(b){for(var c in b)if(b[c]){var d=new jm(c,"sent via offline_errors");d.name=b[c].name;d.stack=b[c].stack;d.level=b[c].level;Tk(d)}Gp().set("errors",{},2592E3,!0)}}})}
w(Ip,Od);function Jp(){if(!Ip.h){var a=E("yt.networkStatusManager.instance")||new Ip;D("yt.networkStatusManager.instance",a);Ip.h=a}return Ip.h}
m=Ip.prototype;m.qa=function(){return this.i.qa()};
m.hb=function(a){this.i.i=a};
m.le=function(){var a=window.navigator.onLine;return void 0===a?!0:a};
m.be=function(){this.j=!0};
m.listen=function(a,b){return this.i.listen(a,b)};
m.oc=function(a){a=li(this.i,a);a.then(function(b){S("use_cfr_monitor")&&Ep().requestComplete("generate_204",b)});
return a};
Ip.prototype.sendNetworkCheckRequest=Ip.prototype.oc;Ip.prototype.listen=Ip.prototype.listen;Ip.prototype.enableErrorFlushing=Ip.prototype.be;Ip.prototype.getWindowStatus=Ip.prototype.le;Ip.prototype.networkStatusHint=Ip.prototype.hb;Ip.prototype.isNetworkAvailable=Ip.prototype.qa;Ip.getInstance=Jp;function Kp(a){a=void 0===a?{}:a;Od.call(this);var b=this;this.i=this.s=0;this.j=Jp();var c=E("yt.networkStatusManager.instance.listen").bind(this.j);c&&(a.nc?(this.nc=a.nc,c("networkstatus-online",function(){Lp(b,"publicytnetworkstatus-online")}),c("networkstatus-offline",function(){Lp(b,"publicytnetworkstatus-offline")})):(c("networkstatus-online",function(){Pd(b,"publicytnetworkstatus-online")}),c("networkstatus-offline",function(){Pd(b,"publicytnetworkstatus-offline")})))}
w(Kp,Od);Kp.prototype.qa=function(){var a=E("yt.networkStatusManager.instance.isNetworkAvailable");return a?a.bind(this.j)():!0};
Kp.prototype.hb=function(a){var b=E("yt.networkStatusManager.instance.networkStatusHint").bind(this.j);b&&b(a)};
Kp.prototype.oc=function(a){var b=this,c;return A(function(d){c=E("yt.networkStatusManager.instance.sendNetworkCheckRequest").bind(b.j);return S("skip_network_check_if_cfr")&&Ep().isEndpointCFR("generate_204")?d.return(new Promise(function(e){var f;b.hb((null==(f=window.navigator)?void 0:f.onLine)||!0);e(b.qa())})):c?d.return(c(a)):d.return(!0)})};
function Lp(a,b){a.nc?a.i?(oi.ya(a.s),a.s=oi.ka(function(){a.m!==b&&(Pd(a,b),a.m=b,a.i=T())},a.nc-(T()-a.i))):(Pd(a,b),a.m=b,a.i=T()):Pd(a,b)}
;var Mp;function Np(){var a=$o.call;Mp||(Mp=new Kp({Sf:!0,Lf:!0}));a.call($o,this,{Y:{Xd:sp,tb:rp,md:op,we:pp,Qc:qp,set:mp},X:Mp,handleError:function(b,c,d){var e,f=null==d?void 0:null==(e=d.error)?void 0:e.code;if(400===f||415===f){var g;Uk(new jm(b.message,c,null==d?void 0:null==(g=d.error)?void 0:g.code),void 0,void 0,void 0,!0)}else Tk(b)},
xb:Uk,Pa:Op,now:T,Nd:Hp,Ba:rm(),Nc:"publicytnetworkstatus-online",Mc:"publicytnetworkstatus-offline",ec:!0,cc:.1,lc:hl("potential_esf_error_limit",10),S:S,Ob:!(km()&&Pp())});this.j=new Jh;S("networkless_immediately_drop_all_requests")&&tp();$n("LogsDatabaseV2")}
w(Np,$o);function Qp(){var a=E("yt.networklessRequestController.instance");a||(a=new Np,D("yt.networklessRequestController.instance",a),S("networkless_logging")&&Pn().then(function(b){a.R=b;bp(a);a.j.resolve();a.ec&&Math.random()<=a.cc&&a.R&&yp(a.R);S("networkless_immediately_drop_sw_health_store")&&Rp(a)}));
return a}
Np.prototype.writeThenSend=function(a,b){b||(b={});km()||(this.h=!1);$o.prototype.writeThenSend.call(this,a,b)};
Np.prototype.sendThenWrite=function(a,b,c){b||(b={});km()||(this.h=!1);$o.prototype.sendThenWrite.call(this,a,b,c)};
Np.prototype.sendAndWrite=function(a,b){b||(b={});km()||(this.h=!1);$o.prototype.sendAndWrite.call(this,a,b)};
Np.prototype.awaitInitialization=function(){return this.j.promise};
function Rp(a){var b;A(function(c){if(!a.R)throw b=Um("clearSWHealthLogsDb"),b;return c.return(zp(a.R).catch(function(d){a.handleError(d)}))})}
function Op(a,b,c){b=S("web_fp_via_jspb")?Object.assign({},b):b;S("use_cfr_monitor")&&Sp(a,b);if(S("use_request_time_ms_header"))b.headers&&(b.headers["X-Goog-Request-Time"]=JSON.stringify(Math.round(T())));else{var d;if(null==(d=b.postParams)?0:d.requestTimeMs)b.postParams.requestTimeMs=Math.round(T())}if(c&&0===Object.keys(b).length){var e=void 0===e?"":e;var f=void 0===f?!1:f;var g=void 0===g?!1:g;if(a)if(e)vl(a,void 0,"POST",e);else if(R("USE_NET_AJAX_FOR_PING_TRANSPORT",!1))vl(a,void 0,"GET",
"",void 0,void 0,f,g);else{b:{try{var h=new Ya({url:a});if(h.j&&h.i||h.l){var k=pc(qc(5,a)),l;if(!(l=!k||!k.endsWith("/aclk"))){var n=a.search(Cc),p=Bc(a,0,"ri",n);if(0>p)var t=null;else{var r=a.indexOf("&",p);if(0>r||r>n)r=n;t=decodeURIComponent(a.slice(p+3,-1!==r?r:0).replace(/\+/g," "))}l="1"!==t}var x=!l;break b}}catch(z){}x=!1}if(x){b:{try{if(window.navigator&&window.navigator.sendBeacon&&window.navigator.sendBeacon(a,"")){var y=!0;break b}}catch(z){}y=!1}c=y?!0:!1}else c=!1;c||Cp(a)}}else b.compress?
b.postBody?("string"!==typeof b.postBody&&(b.postBody=JSON.stringify(b.postBody)),Po(a,b.postBody,b,sl)):Po(a,JSON.stringify(b.postParams),b,Al):sl(a,b)}
function Sp(a,b){var c=b.onError?b.onError:function(){};
b.onError=function(e,f){Ep().requestComplete(a,!1);c(e,f)};
var d=b.onSuccess?b.onSuccess:function(){};
b.onSuccess=function(e,f){Ep().requestComplete(a,!0);d(e,f)}}
function Pp(){return"www.youtube-nocookie.com"!==rc(document.location.toString())}
;var Tp=!1,Up=C.ytNetworklessLoggingInitializationOptions||{isNwlInitialized:Tp};D("ytNetworklessLoggingInitializationOptions",Up);function Vp(){var a;A(function(b){if(1==b.h)return b.yield(Pn(),2);a=b.i;if(!a||!km()&&!S("nwl_init_require_datasync_id_killswitch")||!Pp())return b.A(0);Tp=!0;Up.isNwlInitialized=Tp;return b.yield(Qp().awaitInitialization(),0)})}
;function Wp(a){var b=this;this.config_=null;a?this.config_=a:qo()&&(this.config_=ro());nm(function(){Yo(b)},5E3)}
Wp.prototype.isReady=function(){!this.config_&&qo()&&(this.config_=ro());return!!this.config_};
function Zo(a,b,c,d){function e(x){x=void 0===x?!1:x;var y;if(d.retry&&"www.youtube-nocookie.com"!=h&&(x||S("skip_ls_gel_retry")||"application/json"!==g.headers["Content-Type"]||(y=Wo(b,c,l,k)),y)){var z=g.onSuccess,H=g.onFetchSuccess;g.onSuccess=function(L,P){Xo(y);z(L,P)};
c.onFetchSuccess=function(L,P){Xo(y);H(L,P)}}try{if(x&&d.retry&&!d.sd.bypassNetworkless)g.method="POST",d.sd.writeThenSend?Qp().writeThenSend(r,g):Qp().sendAndWrite(r,g);
else if(d.compress)if(g.postBody){var I=g.postBody;"string"!==typeof I&&(I=JSON.stringify(g.postBody));Po(r,I,g,sl)}else Po(r,JSON.stringify(g.postParams),g,Al);else S("web_all_payloads_via_jspb")?sl(r,g):Al(r,g)}catch(L){if("InvalidAccessError"==L.name)y&&(Xo(y),y=0),Uk(Error("An extension is blocking network request."));else throw L;}y&&nm(function(){Yo(a)},5E3)}
!R("VISITOR_DATA")&&"visitor_id"!==b&&.01>Math.random()&&Uk(new jm("Missing VISITOR_DATA when sending innertube request.",b,c,d));if(!a.isReady()){var f=new jm("innertube xhrclient not ready",b,c,d);Tk(f);throw f;}var g={headers:d.headers||{},method:"POST",postParams:c,postBody:d.postBody,postBodyFormat:d.postBodyFormat||"JSON",onTimeout:function(){d.onTimeout()},
onFetchTimeout:d.onTimeout,onSuccess:function(x,y){if(d.onSuccess)d.onSuccess(y)},
onFetchSuccess:function(x){if(d.onSuccess)d.onSuccess(x)},
onError:function(x,y){if(d.onError)d.onError(y)},
onFetchError:function(x){if(d.onError)d.onError(x)},
timeout:d.timeout,withCredentials:!0,compress:d.compress};g.headers["Content-Type"]||(g.headers["Content-Type"]="application/json");var h="";(f=a.config_.re)&&(h=f);var k=a.config_.te||!1,l=to(k,h,d);Object.assign(g.headers,l);(f=g.headers.Authorization)&&!h&&k&&(g.headers["x-origin"]=window.location.origin);var n="/youtubei/"+a.config_.innertubeApiVersion+"/"+b,p={alt:"json"},t=a.config_.se&&f;t=t&&f.startsWith("Bearer");t||(p.key=a.config_.innertubeApiKey);var r=cl(""+h+n,p||{},!0);(E("ytNetworklessLoggingInitializationOptions")?
Up.isNwlInitialized:Tp)?Nn().then(function(x){e(x)}):e(!1)}
;var Xp=0,Yp=fd?"webkit":ed?"moz":cd?"ms":bd?"o":"";D("ytDomDomGetNextId",E("ytDomDomGetNextId")||function(){return++Xp});var Zp={stopImmediatePropagation:1,stopPropagation:1,preventMouseEvent:1,preventManipulation:1,preventDefault:1,layerX:1,layerY:1,screenX:1,screenY:1,scale:1,rotation:1,webkitMovementX:1,webkitMovementY:1};
function $p(a){this.type="";this.state=this.source=this.data=this.currentTarget=this.relatedTarget=this.target=null;this.charCode=this.keyCode=0;this.metaKey=this.shiftKey=this.ctrlKey=this.altKey=!1;this.rotation=this.clientY=this.clientX=0;this.scale=1;this.changedTouches=this.touches=null;try{if(a=a||window.event){this.event=a;for(var b in a)b in Zp||(this[b]=a[b]);this.scale=a.scale;this.rotation=a.rotation;var c=a.target||a.srcElement;c&&3==c.nodeType&&(c=c.parentNode);this.target=c;var d=a.relatedTarget;
if(d)try{d=d.nodeName?d:null}catch(e){d=null}else"mouseover"==this.type?d=a.fromElement:"mouseout"==this.type&&(d=a.toElement);this.relatedTarget=d;this.clientX=void 0!=a.clientX?a.clientX:a.pageX;this.clientY=void 0!=a.clientY?a.clientY:a.pageY;this.keyCode=a.keyCode?a.keyCode:a.which;this.charCode=a.charCode||("keypress"==this.type?this.keyCode:0);this.altKey=a.altKey;this.ctrlKey=a.ctrlKey;this.shiftKey=a.shiftKey;this.metaKey=a.metaKey;this.h=a.pageX;this.i=a.pageY}}catch(e){}}
function aq(a){if(document.body&&document.documentElement){var b=document.body.scrollTop+document.documentElement.scrollTop;a.h=a.clientX+(document.body.scrollLeft+document.documentElement.scrollLeft);a.i=a.clientY+b}}
$p.prototype.preventDefault=function(){this.event&&(this.event.returnValue=!1,this.event.preventDefault&&this.event.preventDefault())};
$p.prototype.stopPropagation=function(){this.event&&(this.event.cancelBubble=!0,this.event.stopPropagation&&this.event.stopPropagation())};
$p.prototype.stopImmediatePropagation=function(){this.event&&(this.event.cancelBubble=!0,this.event.stopImmediatePropagation&&this.event.stopImmediatePropagation())};var kb=C.ytEventsEventsListeners||{};D("ytEventsEventsListeners",kb);var bq=C.ytEventsEventsCounter||{count:0};D("ytEventsEventsCounter",bq);
function cq(a,b,c,d){d=void 0===d?{}:d;a.addEventListener&&("mouseenter"!=b||"onmouseenter"in document?"mouseleave"!=b||"onmouseenter"in document?"mousewheel"==b&&"MozBoxSizing"in document.documentElement.style&&(b="MozMousePixelScroll"):b="mouseout":b="mouseover");return jb(function(e){var f="boolean"===typeof e[4]&&e[4]==!!d,g=Na(e[4])&&Na(d)&&ob(e[4],d);return!!e.length&&e[0]==a&&e[1]==b&&e[2]==c&&(f||g)})}
var dq=$a(function(){var a=!1;try{var b=Object.defineProperty({},"capture",{get:function(){a=!0}});
window.addEventListener("test",null,b)}catch(c){}return a});
function eq(a,b,c,d){d=void 0===d?{}:d;if(!a||!a.addEventListener&&!a.attachEvent)return"";var e=cq(a,b,c,d);if(e)return e;e=++bq.count+"";var f=!("mouseenter"!=b&&"mouseleave"!=b||!a.addEventListener||"onmouseenter"in document);var g=f?function(h){h=new $p(h);if(!Yd(h.relatedTarget,function(k){return k==a}))return h.currentTarget=a,h.type=b,c.call(a,h)}:function(h){h=new $p(h);
h.currentTarget=a;return c.call(a,h)};
g=Sk(g);a.addEventListener?("mouseenter"==b&&f?b="mouseover":"mouseleave"==b&&f?b="mouseout":"mousewheel"==b&&"MozBoxSizing"in document.documentElement.style&&(b="MozMousePixelScroll"),dq()||"boolean"===typeof d?a.addEventListener(b,g,d):a.addEventListener(b,g,!!d.capture)):a.attachEvent("on"+b,g);kb[e]=[a,b,c,g,d];return e}
function fq(a){a&&("string"==typeof a&&(a=[a]),bb(a,function(b){if(b in kb){var c=kb[b],d=c[0],e=c[1],f=c[3];c=c[4];d.removeEventListener?dq()||"boolean"===typeof c?d.removeEventListener(e,f,c):d.removeEventListener(e,f,!!c.capture):d.detachEvent&&d.detachEvent("on"+e,f);delete kb[b]}}))}
;function gq(a){this.P=a;this.i=null;this.m=0;this.v=null;this.s=0;this.j=[];for(a=0;4>a;a++)this.j.push(0);this.l=0;this.W=eq(window,"mousemove",Ta(this.Z,this));a=Ta(this.V,this);"function"===typeof a&&(a=Sk(a));this.ba=window.setInterval(a,25)}
Va(gq,G);gq.prototype.Z=function(a){void 0===a.h&&aq(a);var b=a.h;void 0===a.i&&aq(a);this.i=new Ud(b,a.i)};
gq.prototype.V=function(){if(this.i){var a=T();if(0!=this.m){var b=this.v,c=this.i,d=b.x-c.x;b=b.y-c.y;d=Math.sqrt(d*d+b*b)/(a-this.m);this.j[this.l]=.5<Math.abs((d-this.s)/this.s)?1:0;for(c=b=0;4>c;c++)b+=this.j[c]||0;3<=b&&this.P();this.s=d}this.m=a;this.v=this.i;this.l=(this.l+1)%4}};
gq.prototype.M=function(){window.clearInterval(this.ba);fq(this.W)};var hq=new Set([174,173,175]),iq={};
function jq(a){var b=void 0===a?{}:a;a=void 0===b.De?!1:b.De;b=void 0===b.ce?!0:b.ce;if(null==E("_lact",window)){var c=parseInt(R("LACT"),10);c=isFinite(c)?Date.now()-Math.max(c,0):-1;D("_lact",c,window);D("_fact",c,window);-1==c&&kq();eq(document,"keydown",kq);eq(document,"keyup",kq);eq(document,"mousedown",kq);eq(document,"mouseup",kq);a?eq(window,"touchmove",function(){lq("touchmove",200)},{passive:!0}):(eq(window,"resize",function(){lq("resize",200)}),b&&eq(window,"scroll",function(){lq("scroll",
200)}));
new gq(function(){lq("mouse",100)});
eq(document,"touchstart",kq,{passive:!0});eq(document,"touchend",kq,{passive:!0})}}
function lq(a,b){iq[a]||(iq[a]=!0,oi.ka(function(){kq();iq[a]=!1},b))}
function kq(a){var b;if(null!=(b=E("experiment.flags",window))&&b.enable_lact_reset_by_volume_buttons||!hq.has(null==a?void 0:a.keyCode))null==E("_lact",window)&&jq(),a=Date.now(),D("_lact",a,window),-1==E("_fact",window)&&D("_fact",a,window),(a=E("ytglobal.ytUtilActivityCallback_"))&&a()}
function mq(){var a=E("_lact",window);return null==a?-1:Math.max(Date.now()-a,0)}
;var nq=C.ytPubsubPubsubInstance||new M,oq=C.ytPubsubPubsubSubscribedKeys||{},pq=C.ytPubsubPubsubTopicToKeys||{},qq=C.ytPubsubPubsubIsSynchronous||{};function rq(a,b){var c=vq();if(c&&b){var d=c.subscribe(a,function(){var e=arguments;var f=function(){oq[d]&&b.apply&&"function"==typeof b.apply&&b.apply(window,e)};
try{qq[a]?f():ml(f,0)}catch(g){Tk(g)}},void 0);
oq[d]=!0;pq[a]||(pq[a]=[]);pq[a].push(d);return d}return 0}
function wq(a){var b=vq();b&&("number"===typeof a?a=[a]:"string"===typeof a&&(a=[parseInt(a,10)]),bb(a,function(c){b.unsubscribeByKey(c);delete oq[c]}))}
function xq(a,b){var c=vq();c&&c.publish.apply(c,arguments)}
function yq(a){var b=vq();if(b)if(b.clear(a),a)zq(a);else for(var c in pq)zq(c)}
function vq(){return C.ytPubsubPubsubInstance}
function zq(a){pq[a]&&(a=pq[a],bb(a,function(b){oq[b]&&delete oq[b]}),a.length=0)}
M.prototype.subscribe=M.prototype.subscribe;M.prototype.unsubscribeByKey=M.prototype.Jb;M.prototype.publish=M.prototype.cb;M.prototype.clear=M.prototype.clear;D("ytPubsubPubsubInstance",nq);D("ytPubsubPubsubTopicToKeys",pq);D("ytPubsubPubsubIsSynchronous",qq);D("ytPubsubPubsubSubscribedKeys",oq);var Aq=Symbol("injectionDeps");function Bq(a){this.name=a}
Bq.prototype.toString=function(){return"InjectionToken("+this.name+")"};
function Cq(a){this.key=a}
function Dq(){this.h=new Map;this.i=new Map}
Dq.prototype.resolve=function(a){return a instanceof Cq?Eq(this,a.key,[],!0):Eq(this,a,[])};
function Eq(a,b,c,d){d=void 0===d?!1:d;if(-1<c.indexOf(b))throw Error("Deps cycle for: "+b);if(a.i.has(b))return a.i.get(b);if(!a.h.has(b)){if(d)return;throw Error("No provider for: "+b);}d=a.h.get(b);c.push(b);if(void 0!==d.Kd)var e=d.Kd;else if(d.df)e=d[Aq]?Fq(a,d[Aq],c):[],e=d.df.apply(d,ja(e));else if(d.Jd){e=d.Jd;var f=e[Aq]?Fq(a,e[Aq],c):[];e=new (Function.prototype.bind.apply(e,[null].concat(ja(f))))}else throw Error("Could not resolve providers for: "+b);c.pop();d.ag||a.i.set(b,e);return e}
function Fq(a,b,c){return b?b.map(function(d){return d instanceof Cq?Eq(a,d.key,c,!0):Eq(a,d,c)}):[]}
;var Gq;function Hq(){Gq||(Gq=new Dq);return Gq}
;var Iq=window;function Jq(){var a,b;return"h5vcc"in Iq&&(null==(a=Iq.h5vcc.traceEvent)?0:a.traceBegin)&&(null==(b=Iq.h5vcc.traceEvent)?0:b.traceEnd)?1:"performance"in Iq&&Iq.performance.mark&&Iq.performance.measure?2:0}
function Kq(a){switch(Jq()){case 1:Iq.h5vcc.traceEvent.traceBegin("YTLR",a);break;case 2:Iq.performance.mark(a+"-start");break;case 0:break;default:Uh()}}
function Lq(a){switch(Jq()){case 1:Iq.h5vcc.traceEvent.traceEnd("YTLR",a);break;case 2:var b=a+"-start",c=a+"-end";Iq.performance.mark(c);Iq.performance.measure(a,b,c);break;case 0:break;default:Uh()}}
;var Mq=S("web_enable_lifecycle_monitoring")&&0!==Jq();function Nq(a){var b=this;var c=void 0===c?0:c;var d=void 0===d?rm():d;this.j=c;this.scheduler=d;this.i=new Jh;this.h=a;for(a={ab:0};a.ab<this.h.length;a={Ib:a.Ib,ab:a.ab},a.ab++)a.Ib=this.h[a.ab],c=function(e){return function(){e.Ib.Hc();b.h[e.ab].mc=!0;b.h.every(function(f){return!0===f.mc})&&b.i.resolve()}}(a),d=this.getPriority(a.Ib),d=om(c,d),this.h[a.ab]=Object.assign({},a.Ib,{Hc:c,
jobId:d})}
function Oq(a){var b=Array.from(a.h.keys()).sort(function(d,e){return a.getPriority(a.h[e])-a.getPriority(a.h[d])});
b=v(b);for(var c=b.next();!c.done;c=b.next())c=a.h[c.value],void 0===c.jobId||c.mc||(a.scheduler.ya(c.jobId),om(c.Hc,10))}
Nq.prototype.cancel=function(){for(var a=v(this.h),b=a.next();!b.done;b=a.next())b=b.value,void 0===b.jobId||b.mc||this.scheduler.ya(b.jobId),b.mc=!0;this.i.resolve()};
Nq.prototype.getPriority=function(a){var b;return null!=(b=a.priority)?b:this.j};function Pq(a){this.state=a;this.plugins=[];this.l=void 0;this.v={};Mq&&Kq(this.state)}
m=Pq.prototype;m.install=function(a){this.plugins.push(a);return this};
m.uninstall=function(){var a=this;B.apply(0,arguments).forEach(function(b){b=a.plugins.indexOf(b);-1<b&&a.plugins.splice(b,1)})};
m.transition=function(a,b){var c=this;Mq&&Lq(this.state);var d=this.transitions.find(function(f){return Array.isArray(f.from)?f.from.find(function(g){return g===c.state&&f.to===a}):f.from===c.state&&f.to===a});
if(d){this.j&&(Oq(this.j),this.j=void 0);Qq(this,a,b);this.state=a;Mq&&Kq(this.state);d=d.action.bind(this);var e=this.plugins.filter(function(f){return f[a]}).map(function(f){return f[a]});
d(Rq(this,e),b)}else throw Error("no transition specified from "+this.state+" to "+a);};
function Rq(a,b){var c=b.filter(function(e){return 10===Sq(a,e)}),d=b.filter(function(e){return 10!==Sq(a,e)});
return a.v.Zf?function(){var e=B.apply(0,arguments);return A(function(f){if(1==f.h)return f.yield(a.Je.apply(a,[c].concat(ja(e))),2);a.Ed.apply(a,[d].concat(ja(e)));f.h=0})}:function(){var e=B.apply(0,arguments);
a.Ke.apply(a,[c].concat(ja(e)));a.Ed.apply(a,[d].concat(ja(e)))}}
m.Ke=function(a){var b=B.apply(1,arguments);rm();for(var c=v(a),d=c.next(),e={};!d.done;e={ob:e.ob},d=c.next())e.ob=d.value,pm(function(f){return function(){Tq(f.ob.name);f.ob.callback.apply(f.ob,ja(b));Uq(f.ob.name)}}(e))};
m.Je=function(a){var b=B.apply(1,arguments),c,d,e,f;return A(function(g){1==g.h&&(rm(),c=v(a),d=c.next(),e={});if(3!=g.h){if(d.done)return g.A(0);e.bb=d.value;e.Gb=void 0;f=function(h){return function(){Tq(h.bb.name);var k=h.bb.callback.apply(h.bb,ja(b));"function"===typeof(null==k?void 0:k.then)?h.Gb=k.then(function(){Uq(h.bb.name)}):Uq(h.bb.name)}}(e);
pm(f);return e.Gb?g.yield(e.Gb,3):g.A(3)}e={bb:e.bb,Gb:e.Gb};d=c.next();return g.A(2)})};
m.Ed=function(a){var b=B.apply(1,arguments),c=this,d=a.map(function(e){return{Hc:function(){Tq(e.name);e.callback.apply(e,ja(b));Uq(e.name)},
priority:Sq(c,e)}});
d.length&&(this.j=new Nq(d))};
function Sq(a,b){var c,d;return null!=(d=null!=(c=a.l)?c:b.priority)?d:0}
function Tq(a){Mq&&a&&Kq(a)}
function Uq(a){Mq&&a&&Lq(a)}
function Qq(a,b,c){Mq&&console.groupCollapsed&&console.groupEnd&&(console.groupCollapsed("["+a.constructor.name+"] '"+a.state+"' to '"+b+"'"),console.log("with message: ",c),console.groupEnd())}
ea.Object.defineProperties(Pq.prototype,{currentState:{configurable:!0,enumerable:!0,get:function(){return this.state}}});function Vq(a){Pq.call(this,void 0===a?"none":a);this.h=null;this.l=10;this.transitions=[{from:"none",to:"application_navigating",action:this.i},{from:"application_navigating",to:"none",action:this.m},{from:"application_navigating",to:"application_navigating",action:function(){}},
{from:"none",to:"none",action:function(){}}]}
var Wq;w(Vq,Pq);Vq.prototype.i=function(a,b){var c=this;this.h=nm(function(){"application_navigating"===c.currentState&&c.transition("none")},5E3);
a(null==b?void 0:b.event)};
Vq.prototype.m=function(a,b){this.h&&(oi.ya(this.h),this.h=null);a(null==b?void 0:b.event)};
function Xq(){Wq||(Wq=new Vq);return Wq}
;function Yq(){this.store={};this.h={}}
Yq.prototype.storePayload=function(a,b){a=Zq(a);this.store[a]?this.store[a].push(b):(this.h={},this.store[a]=[b]);return a};
Yq.prototype.smartExtractMatchingEntries=function(a){if(!a.keys.length)return[];for(var b=$q(this,a.keys.splice(0,1)[0]),c=[],d=0;d<b.length;d++)this.store[b[d]]&&a.sizeLimit&&(this.store[b[d]].length<=a.sizeLimit?(c.push.apply(c,ja(this.store[b[d]])),delete this.store[b[d]]):c.push.apply(c,ja(this.store[b[d]].splice(0,a.sizeLimit))));(null==a?0:a.sizeLimit)&&c.length<(null==a?void 0:a.sizeLimit)&&(a.sizeLimit-=c.length,c.push.apply(c,ja(this.smartExtractMatchingEntries(a))));return c};
Yq.prototype.extractMatchingEntries=function(a){a=$q(this,a);for(var b=[],c=0;c<a.length;c++)this.store[a[c]]&&(b.push.apply(b,ja(this.store[a[c]])),delete this.store[a[c]]);return b};
Yq.prototype.getSequenceCount=function(a){a=$q(this,a);for(var b=0,c=0;c<a.length;c++){var d=void 0;b+=(null==(d=this.store[a[c]])?void 0:d.length)||0}return b};
function $q(a,b){var c=Zq(b);if(a.h[c])return a.h[c];var d=Object.keys(a.store)||[];if(1>=d.length&&Zq(b)===d[0])return d;for(var e=[],f=0;f<d.length;f++){var g=d[f].split("/");if(ar(b.auth,g[0])){var h=b.isJspb;ar(void 0===h?"undefined":h?"true":"false",g[1])&&ar(b.cttAuthInfo,g[2])&&(h=b.tier,h=void 0===h?"undefined":JSON.stringify(h),ar(h,g[3])&&e.push(d[f]))}}return a.h[c]=e}
function ar(a,b){return void 0===a||"undefined"===a?!0:a===b}
Yq.prototype.getSequenceCount=Yq.prototype.getSequenceCount;Yq.prototype.extractMatchingEntries=Yq.prototype.extractMatchingEntries;Yq.prototype.smartExtractMatchingEntries=Yq.prototype.smartExtractMatchingEntries;Yq.prototype.storePayload=Yq.prototype.storePayload;function Zq(a){return[void 0===a.auth?"undefined":a.auth,void 0===a.isJspb?"undefined":a.isJspb,void 0===a.cttAuthInfo?"undefined":a.cttAuthInfo,void 0===a.tier?"undefined":a.tier].join("/")}
;function U(a,b){if(a)return a[b.name]}
;var br=hl("initial_gel_batch_timeout",2E3),cr=hl("gel_queue_timeout_max_ms",6E4),dr=Math.pow(2,16)-1,er=void 0;function fr(){this.j=this.h=this.i=0}
var gr=new fr,hr=new fr,ir=new fr,jr=new fr,kr,lr=!0,mr=C.ytLoggingTransportTokensToCttTargetIds_||{};D("ytLoggingTransportTokensToCttTargetIds_",mr);var nr={};function or(){var a=E("yt.logging.ims");a||(a=new Yq,D("yt.logging.ims",a));return a}
function pr(a,b){if("log_event"===a.endpoint){var c=qr(a);a:{var d=Object.keys(a.payload);d=v(d);for(var e=d.next();!e.done;e=d.next())if(e=e.value,up[e]){d=e;break a}d=void 0}var f;a:if(S("enable_web_tiered_gel")){d=up[d||""];var g,h;if(e=null==Hq().resolve(new Cq(mo))?void 0:null==(f=no())?void 0:null==(g=f.loggingHotConfig)?void 0:null==(h=g.eventLoggingConfig)?void 0:h.payloadPolicies)for(f=0;f<e.length;f++)if(e[f].payloadNumber===d){f=rr(e[f].tier);break a}f=200}else f=void 0;400===f?sr(a,b):
(nr[c]=!0,f={cttAuthInfo:c,isJspb:!1,tier:f},or().storePayload(f,a.payload),tr(b,c,f))}}
function tr(a,b,c){function d(){ur({writeThenSend:!0},S("flush_only_full_queue")?b:void 0,e,c.tier)}
var e=!1;e=void 0===e?!1:e;a&&(er=new a);a=hl("tvhtml5_logging_max_batch_ads_fork")||hl("web_logging_max_batch")||100;var f=T(),g=vr(e,c.tier),h=g.j,k=0;c&&(k=or().getSequenceCount(c));1E3<=k?d():k>=a?kr||(kr=wr(function(){d();kr=void 0},0)):10<=f-h&&(xr(e,c.tier),g.j=f)}
function sr(a,b){if("log_event"===a.endpoint){var c=qr(a),d=new Map;d.set(c,[a.payload]);b&&(er=new b);return new ke(function(e,f){er&&er.isReady()?yr(d,er,e,f,{bypassNetworkless:!0},!0):e()})}}
function qr(a){var b="";if(a.dangerousLogToVisitorSession)b="visitorOnlyApprovedKey";else if(a.cttAuthInfo){b=a.cttAuthInfo;var c={};b.videoId?c.videoId=b.videoId:b.playlistId&&(c.playlistId=b.playlistId);mr[a.cttAuthInfo.token]=c;b=a.cttAuthInfo.token}return b}
function ur(a,b,c,d){a=void 0===a?{}:a;c=void 0===c?!1:c;new ke(function(e,f){var g=vr(c,d);zr(g.i);zr(g.h);g.h=0;er&&er.isReady()?void 0===d&&S("enable_web_tiered_gel")?Ar(e,f,a,b,c,300):Ar(e,f,a,b,c,d):(xr(c,d),e())})}
function Ar(a,b,c,d,e,f){var g=er;c=void 0===c?{}:c;e=void 0===e?!1:e;f=void 0===f?200:f;var h=new Map;var k={isJspb:e,cttAuthInfo:d,tier:f};e={isJspb:e,cttAuthInfo:d};if(void 0!==d)f=S("enable_web_tiered_gel")?or().smartExtractMatchingEntries({keys:[k,e],sizeLimit:1E3}):or().extractMatchingEntries(e),h.set(d,f);else for(d=v(Object.keys(nr)),k=d.next();!k.done;k=d.next())k=k.value,e=S("enable_web_tiered_gel")?or().smartExtractMatchingEntries({keys:[{isJspb:!1,cttAuthInfo:k,tier:f},{isJspb:!1,cttAuthInfo:k}],
sizeLimit:1E3}):or().extractMatchingEntries({isJspb:!1,cttAuthInfo:k}),0<e.length&&h.set(k,e),(S("web_fp_via_jspb_and_json")&&c.writeThenSend||!S("web_fp_via_jspb_and_json"))&&delete nr[k];yr(h,g,a,b,c)}
function xr(a,b){a=void 0===a?!1:a;b=void 0===b?200:b;var c=vr(a,b),d=c===jr||c===ir?5E3:cr;S("web_gel_timeout_cap")&&!c.h&&(d=wr(function(){ur({writeThenSend:!0},void 0,a,b)},d),c.h=d);
zr(c.i);d=R("LOGGING_BATCH_TIMEOUT",hl("web_gel_debounce_ms",1E4));S("shorten_initial_gel_batch_timeout")&&lr&&(d=br);d=wr(function(){ur({writeThenSend:!0},void 0,a,b)},d);
c.i=d}
function yr(a,b,c,d,e,f){e=void 0===e?{}:e;var g=Math.round(T()),h=a.size;a=v(a);for(var k=a.next(),l={};!k.done;l={Tb:l.Tb,Za:l.Za,Hb:l.Hb,Vb:l.Vb,Ub:l.Ub},k=a.next()){var n=v(k.value);k=n.next().value;n=n.next().value;l.Za=qb({context:so(b.config_||ro())});if(!Ma(n)&&!S("throw_err_when_logevent_malformed_killswitch")){d();break}l.Za.events=n;(n=mr[k])&&Br(l.Za,k,n);delete mr[k];l.Hb="visitorOnlyApprovedKey"===k;Cr(l.Za,g,l.Hb);S("always_send_and_write")&&(e.writeThenSend=!1);l.Vb=function(p){S("update_log_event_config")&&
oi.ka(function(){return A(function(t){return t.yield(Dr(p),0)})});
h--;h||c()};
l.Tb=0;l.Ub=function(p){return function(){p.Tb++;if(e.bypassNetworkless&&1===p.Tb)try{Zo(b,"log_event",p.Za,Er({writeThenSend:!0},p.Hb,p.Vb,p.Ub,f)),lr=!1}catch(t){Tk(t),d()}h--;h||c()}}(l);
try{Zo(b,"log_event",l.Za,Er(e,l.Hb,l.Vb,l.Ub,f)),lr=!1}catch(p){Tk(p),d()}}}
function Er(a,b,c,d,e){a={retry:!0,onSuccess:c,onError:d,sd:a,dangerousLogToVisitorSession:b,If:!!e,headers:{},postBodyFormat:"",postBody:"",compress:S("compress_gel")||S("compress_gel_lr")};Fr()&&(a.headers["X-Goog-Request-Time"]=JSON.stringify(Math.round(T())));return a}
function Cr(a,b,c){Fr()||(a.requestTimeMs=String(b));S("unsplit_gel_payloads_in_logs")&&(a.unsplitGelPayloadsInLogs=!0);!c&&(b=R("EVENT_ID"))&&((c=R("BATCH_CLIENT_COUNTER")||0)||(c=Math.floor(Math.random()*dr/2)),c++,c>dr&&(c=1),Ok("BATCH_CLIENT_COUNTER",c),a.serializedClientEventId={serializedEventId:b,clientCounter:String(c)})}
function Br(a,b,c){if(c.videoId)var d="VIDEO";else if(c.playlistId)d="PLAYLIST";else return;a.credentialTransferTokenTargetId=c;a.context=a.context||{};a.context.user=a.context.user||{};a.context.user.credentialTransferTokens=[{token:b,scope:d}]}
function Fr(){return S("use_request_time_ms_header")||S("lr_use_request_time_ms_header")}
function wr(a,b){return S("transport_use_scheduler")?S("logging_avoid_blocking_during_navigation")||S("lr_logging_avoid_blocking_during_navigation")?nm(function(){if("none"===Xq().currentState)a();else{var c={};Xq().install((c.none={callback:a},c))}},b):nm(a,b):ml(a,b)}
function zr(a){S("transport_use_scheduler")?oi.ya(a):window.clearTimeout(a)}
function Dr(a){var b,c,d,e,f,g,h,k,l,n;return A(function(p){return 1==p.h?(d=null==(b=a)?void 0:null==(c=b.responseContext)?void 0:c.globalConfigGroup,e=U(d,rk),g=null==(f=d)?void 0:f.hotHashData,h=U(d,qk),l=null==(k=d)?void 0:k.coldHashData,(n=Hq().resolve(new Cq(mo)))?g?e?p.yield(oo(n,g,e),2):p.yield(oo(n,g),2):p.A(2):p.return()):l?h?p.yield(po(n,l,h),0):p.yield(po(n,l),0):p.A(0)})}
function vr(a,b){b=void 0===b?200:b;return a?300===b?jr:hr:300===b?ir:gr}
function rr(a){switch(a){case "DELAYED_EVENT_TIER_UNSPECIFIED":return 0;case "DELAYED_EVENT_TIER_DEFAULT":return 100;case "DELAYED_EVENT_TIER_DISPATCH_TO_EMPTY":return 200;case "DELAYED_EVENT_TIER_FAST":return 300;case "DELAYED_EVENT_TIER_IMMEDIATE":return 400;default:return 200}}
;var Gr=C.ytLoggingGelSequenceIdObj_||{};D("ytLoggingGelSequenceIdObj_",Gr);
function Hr(a,b,c,d){d=void 0===d?{}:d;var e={},f=Math.round(d.timestamp||T());e.eventTimeMs=f<Number.MAX_SAFE_INTEGER?f:0;e[a]=b;a=mq();e.context={lastActivityMs:String(d.timestamp||!isFinite(a)?-1:a)};S("log_sequence_info_on_gel_web")&&d.sequenceGroup&&(a=e.context,b=d.sequenceGroup,Gr[b]=b in Gr?Gr[b]+1:0,a.sequence={index:Gr[b],groupKey:b},d.endOfSequence&&delete Gr[d.sequenceGroup]);(d.sendIsolatedPayload?sr:pr)({endpoint:"log_event",payload:e,cttAuthInfo:d.cttAuthInfo,dangerousLogToVisitorSession:d.dangerousLogToVisitorSession},
c)}
;function Cm(a,b,c){c=void 0===c?{}:c;var d=Wp;R("ytLoggingEventsDefaultDisabled",!1)&&Wp===Wp&&(d=null);S("web_all_payloads_via_jspb")&&!c.timestamp&&(c.lact=mq(),c.timestamp=T());Hr(a,b,d,c)}
;D("ytLoggingGelSequenceIdObj_",C.ytLoggingGelSequenceIdObj_||{});var Ir=new Set,Jr=0,Kr=0,Lr=0,Mr=[],Nr=["PhantomJS","Googlebot","TO STOP THIS SECURITY SCAN go/scan"];function Bm(a){Or(a)}
function Pr(a){Or(a,"WARNING")}
function Qr(a){a instanceof Error?Or(a):(a=Na(a)?JSON.stringify(a):String(a),a=new jm(a),a.name="RejectedPromiseError",Pr(a))}
function Or(a,b,c,d,e,f,g,h){f=void 0===f?{}:f;f.name=c||R("INNERTUBE_CONTEXT_CLIENT_NAME",1);f.version=d||R("INNERTUBE_CONTEXT_CLIENT_VERSION");c=f;b=void 0===b?"ERROR":b;g=void 0===g?!1:g;b=void 0===b?"ERROR":b;g=void 0===g?!1:g;if(a&&(a.hasOwnProperty("level")&&a.level&&(b=a.level),S("console_log_js_exceptions")&&(d=[],d.push("Name: "+a.name),d.push("Message: "+a.message),a.hasOwnProperty("params")&&d.push("Error Params: "+JSON.stringify(a.params)),a.hasOwnProperty("args")&&d.push("Error args: "+
JSON.stringify(a.args)),d.push("File name: "+a.fileName),d.push("Stacktrace: "+a.stack),d=d.join("\n"),window.console.log(d,a)),!(5<=Jr))){d=Mr;var k=Oc(a);e=k.message||"Unknown Error";f=k.name||"UnknownError";var l=k.stack||a.i||"Not available";if(l.startsWith(f+": "+e)){var n=l.split("\n");n.shift();l=n.join("\n")}n=k.lineNumber||"Not available";k=k.fileName||"Not available";var p=0;if(a.hasOwnProperty("args")&&a.args&&a.args.length)for(var t=0;t<a.args.length&&!(p=Kl(a.args[t],"params."+t,c,p),
500<=p);t++);else if(a.hasOwnProperty("params")&&a.params){var r=a.params;if("object"===typeof a.params)for(t in r){if(r[t]){var x="params."+t,y=Ml(r[t]);c[x]=y;p+=x.length+y.length;if(500<p)break}}else c.params=Ml(r)}if(d.length)for(t=0;t<d.length&&!(p=Kl(d[t],"params.context."+t,c,p),500<=p);t++);navigator.vendor&&!c.hasOwnProperty("vendor")&&(c["device.vendor"]=navigator.vendor);t={message:e,name:f,lineNumber:n,fileName:k,stack:l,params:c,sampleWeight:1};c=Number(a.columnNumber);isNaN(c)||(t.lineNumber=
t.lineNumber+":"+c);if("IGNORED"===a.level)a=0;else a:{a=Gl();c=v(a.Ua);for(d=c.next();!d.done;d=c.next())if(d=d.value,t.message&&t.message.match(d.Tf)){a=d.weight;break a}a=v(a.Ra);for(c=a.next();!c.done;c=a.next())if(c=c.value,c.callback(t)){a=c.weight;break a}a=1}t.sampleWeight=a;a=v(Bl);for(c=a.next();!c.done;c=a.next())if(c=c.value,c.kc[t.name])for(e=v(c.kc[t.name]),d=e.next();!d.done;d=e.next())if(f=d.value,d=t.message.match(f.regexp)){t.params["params.error.original"]=d[0];e=f.groups;f={};
for(n=0;n<e.length;n++)f[e[n]]=d[n+1],t.params["params.error."+e[n]]=d[n+1];t.message=c.Kc(f);break}t.params||(t.params={});a=Gl();t.params["params.errorServiceSignature"]="msg="+a.Ua.length+"&cb="+a.Ra.length;t.params["params.serviceWorker"]="false";C.document&&C.document.querySelectorAll&&(t.params["params.fscripts"]=String(document.querySelectorAll("script:not([nonce])").length));xb("sample").constructor!==vb&&(t.params["params.fconst"]="true");window.yterr&&"function"===typeof window.yterr&&window.yterr(t);
if(0!==t.sampleWeight&&!Ir.has(t.message)){if(g&&S("web_enable_error_204"))Rr(void 0===b?"ERROR":b,t);else{b=void 0===b?"ERROR":b;"ERROR"===b?(Hl.cb("handleError",t),S("record_app_crashed_web")&&0===Lr&&1===t.sampleWeight&&(Lr++,g={appCrashType:"APP_CRASH_TYPE_BREAKPAD"},S("report_client_error_with_app_crash_ks")||(g.systemHealth={crashData:{clientError:{logMessage:{message:t.message}}}}),Cm("appCrashed",g)),Kr++):"WARNING"===b&&Hl.cb("handleWarning",t);if(S("kevlar_gel_error_routing")){g=b;h=void 0===
h?{}:h;b:{a=v(Nr);for(c=a.next();!c.done;c=a.next())if(Im(c.value.toLowerCase())){a=!0;break b}a=!1}if(a)h=void 0;else{c={stackTrace:t.stack};t.fileName&&(c.filename=t.fileName);a=t.lineNumber&&t.lineNumber.split?t.lineNumber.split(":"):[];0!==a.length&&(1!==a.length||isNaN(Number(a[0]))?2!==a.length||isNaN(Number(a[0]))||isNaN(Number(a[1]))||(c.lineNumber=Number(a[0]),c.columnNumber=Number(a[1])):c.lineNumber=Number(a[0]));a={level:"ERROR_LEVEL_UNKNOWN",message:t.message,errorClassName:t.name,sampleWeight:t.sampleWeight};
"ERROR"===g?a.level="ERROR_LEVEL_ERROR":"WARNING"===g&&(a.level="ERROR_LEVEL_WARNNING");c={isObfuscated:!0,browserStackInfo:c};h.pageUrl=window.location.href;h.kvPairs=[];R("FEXP_EXPERIMENTS")&&(h.experimentIds=R("FEXP_EXPERIMENTS"));e=R("LATEST_ECATCHER_SERVICE_TRACKING_PARAMS");if(!Pk("web_disable_gel_stp_ecatcher_killswitch")&&e)for(f=v(Object.keys(e)),d=f.next();!d.done;d=f.next())d=d.value,h.kvPairs.push({key:d,value:String(e[d])});if(e=t.params)for(f=v(Object.keys(e)),d=f.next();!d.done;d=f.next())d=
d.value,h.kvPairs.push({key:"client."+d,value:String(e[d])});d=R("SERVER_NAME");e=R("SERVER_VERSION");d&&e&&(h.kvPairs.push({key:"server.name",value:d}),h.kvPairs.push({key:"server.version",value:e}));h={errorMetadata:h,stackTrace:c,logMessage:a}}h&&(Cm("clientError",h),("ERROR"===g||S("errors_flush_gel_always_killswitch"))&&ur(void 0,void 0,!1))}S("suppress_error_204_logging")||Rr(b,t)}try{Ir.add(t.message)}catch(z){}Jr++}}}
function Rr(a,b){var c=b.params||{};a={urlParams:{a:"logerror",t:"jserror",type:b.name,msg:b.message.substr(0,250),line:b.lineNumber,level:a,"client.name":c.name},postParams:{url:R("PAGE_NAME",window.location.href),file:b.fileName},method:"POST"};c.version&&(a["client.version"]=c.version);if(a.postParams){b.stack&&(a.postParams.stack=b.stack);b=v(Object.keys(c));for(var d=b.next();!d.done;d=b.next())d=d.value,a.postParams["client."+d]=c[d];if(c=R("LATEST_ECATCHER_SERVICE_TRACKING_PARAMS"))for(b=v(Object.keys(c)),
d=b.next();!d.done;d=b.next())d=d.value,a.postParams[d]=c[d];c=R("SERVER_NAME");b=R("SERVER_VERSION");c&&b&&(a.postParams["server.name"]=c,a.postParams["server.version"]=b)}sl(R("ECATCHER_REPORT_HOST","")+"/error_204",a)}
;function Sr(){this.register=new Map}
function Tr(a){a=v(a.register.values());for(var b=a.next();!b.done;b=a.next())b.value.Vf("ABORTED")}
Sr.prototype.clear=function(){Tr(this);this.register.clear()};
var Ur=new Sr;var Vr=Date.now().toString();
function Wr(){a:{if(window.crypto&&window.crypto.getRandomValues)try{var a=Array(16),b=new Uint8Array(16);window.crypto.getRandomValues(b);for(var c=0;c<a.length;c++)a[c]=b[c];var d=a;break a}catch(e){}d=Array(16);for(a=0;16>a;a++){b=Date.now();for(c=0;c<b%23;c++)d[a]=Math.random();d[a]=Math.floor(256*Math.random())}if(Vr)for(a=1,b=0;b<Vr.length;b++)d[a%16]=d[a%16]^d[(a-1)%16]/4^Vr.charCodeAt(b),a++}a=[];for(b=0;b<d.length;b++)a.push("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_".charAt(d[b]&63));
return a.join("")}
;var Xr,Yr=C.ytLoggingDocDocumentNonce_;Yr||(Yr=Wr(),D("ytLoggingDocDocumentNonce_",Yr));Xr=Yr;function Zr(a){this.h=a}
m=Zr.prototype;m.getAsJson=function(){var a={};void 0!==this.h.trackingParams?a.trackingParams=this.h.trackingParams:(a.veType=this.h.veType,void 0!==this.h.veCounter&&(a.veCounter=this.h.veCounter),void 0!==this.h.elementIndex&&(a.elementIndex=this.h.elementIndex));void 0!==this.h.dataElement&&(a.dataElement=this.h.dataElement.getAsJson());void 0!==this.h.youtubeData&&(a.youtubeData=this.h.youtubeData);this.h.isCounterfactual&&(a.isCounterfactual=!0);return a};
m.getAsJspb=function(){var a=new Ak;if(void 0!==this.h.trackingParams){var b=this.h.trackingParams;if(null!=b)if("string"===typeof b)b=b?new nf(b,kf):lf||(lf=new nf(null,kf));else if(b.constructor!==nf)if(jf(b))b instanceof Uint8Array||Array.isArray(b),b=b.length?new nf(new Uint8Array(b),kf):lf||(lf=new nf(null,kf));else throw Error();K(a,1,b)}else void 0!==this.h.veType&&K(a,2,Jf(this.h.veType)),void 0!==this.h.veCounter&&K(a,6,Jf(this.h.veCounter)),void 0!==this.h.elementIndex&&K(a,3,Jf(this.h.elementIndex)),
this.h.isCounterfactual&&K(a,5,If(!0));void 0!==this.h.dataElement&&(b=this.h.dataElement.getAsJspb(),hg(a,Ak,7,b));void 0!==this.h.youtubeData&&hg(a,tk,8,this.h.jspbYoutubeData);return a};
m.toString=function(){return JSON.stringify(this.getAsJson())};
m.isClientVe=function(){return!this.h.trackingParams&&!!this.h.veType};
m.getLoggingDirectives=function(){return this.h.loggingDirectives};function $r(a){a=void 0===a?0:a;return 0===a?"client-screen-nonce":"client-screen-nonce."+a}
function as(a){a=void 0===a?0:a;return S("new_csn_storage_design")?R("client-screen-nonce-store",{})[a]:R($r(a))}
function bs(a,b){b=void 0===b?0:b;if(S("new_csn_storage_design")){var c=R("client-screen-nonce-store");c||(c={},Ok("client-screen-nonce-store",c));c[b]=a}Ok($r(b),a)}
function cs(a){a=void 0===a?0:a;return 0===a?"ROOT_VE_TYPE":"ROOT_VE_TYPE."+a}
function ds(a){return R(cs(void 0===a?0:a))}
D("yt_logging_screen.getRootVeType",ds);function es(){var a=R("csn-to-ctt-auth-info");a||(a={},Ok("csn-to-ctt-auth-info",a));return a}
function gs(){return Object.values(R("client-screen-nonce-store",{})).filter(function(a){return void 0!==a})}
function hs(a){a=as(void 0===a?0:a);if(!a&&!R("USE_CSN_FALLBACK",!0))return null;a||(a="UNDEFINED_CSN");return a?a:null}
D("yt_logging_screen.getCurrentCsn",hs);function is(a,b,c){var d=es();(c=hs(c))&&delete d[c];b&&(d[a]=b)}
function js(a){return es()[a]}
D("yt_logging_screen.getCttAuthInfo",js);D("yt_logging_screen.setCurrentScreen",function(a,b,c,d){c=void 0===c?0:c;if(a!==as(c)||b!==R(cs(c)))if(is(a,d,c),bs(a,c),Ok(cs(c),b),b=function(){setTimeout(function(){a&&Cm("foregroundHeartbeatScreenAssociated",{clientDocumentNonce:Xr,clientScreenNonce:a})},0)},"requestAnimationFrame"in window)try{window.requestAnimationFrame(b)}catch(e){b()}else b()});var ks=window.yt&&window.yt.msgs_||window.ytcfg&&window.ytcfg.msgs||{};D("yt.msgs_",ks);function ls(a){Jk(ks,arguments)}
;function ms(){var a=pb(ns),b;return(new ke(function(c,d){a.onSuccess=function(e){ll(e)?c(new ps(e)):d(new qs("Request failed, status="+(e&&"status"in e?e.status:-1),"net.badstatus",e))};
a.onError=function(e){d(new qs("Unknown request error","net.unknown",e))};
a.onTimeout=function(e){d(new qs("Request timed out","net.timeout",e))};
b=sl("//googleads.g.doubleclick.net/pagead/id",a)})).qc(function(c){c instanceof ve&&b.abort();
return qe(c)})}
function qs(a,b,c){Xa.call(this,a+", errorCode="+b);this.errorCode=b;this.xhr=c;this.name="PromiseAjaxError"}
w(qs,Xa);function ps(a){this.xhr=a}
;function rs(){this.h=0;this.value_=null}
rs.prototype.then=function(a,b,c){return 1===this.h&&a?(a=a.call(c,this.value_))&&"function"===typeof a.then?a:ss(a):2===this.h&&b?(a=b.call(c,this.value_))&&"function"===typeof a.then?a:ts(a):this};
rs.prototype.getValue=function(){return this.value_};
rs.prototype.isRejected=function(){return 2==this.h};
rs.prototype.$goog_Thenable=!0;function ts(a){var b=new rs;a=void 0===a?null:a;b.h=2;b.value_=void 0===a?null:a;return b}
function ss(a){var b=new rs;a=void 0===a?null:a;b.h=1;b.value_=void 0===a?null:a;return b}
;function us(a,b){var c=void 0===c?{}:c;a={method:void 0===b?"POST":b,mode:dl(a)?"same-origin":"cors",credentials:dl(a)?"same-origin":"include"};b={};for(var d=v(Object.keys(c)),e=d.next();!e.done;e=d.next())e=e.value,c[e]&&(b[e]=c[e]);0<Object.keys(b).length&&(a.headers=b);return a}
;function vs(){return Eg()||(Ue||Ve)&&Im("applewebkit")&&!Im("version")&&(!Im("safari")||Im("gsa/"))||hd&&Im("version/")?!0:R("EOM_VISITOR_DATA")?!1:!0}
;function ws(a){a:{var b="EMBEDDED_PLAYER_MODE_UNKNOWN";window.location.hostname.includes("youtubeeducation.com")&&(b="EMBEDDED_PLAYER_MODE_PFL");var c=a.raw_embedded_player_response;if(!c&&(a=a.embedded_player_response))try{c=JSON.parse(a)}catch(e){break a}if(c)b:for(var d in yk)if(yk[d]==c.embeddedPlayerMode){b=yk[d];break b}}return"EMBEDDED_PLAYER_MODE_PFL"===b}
;function xs(a){Xa.call(this,a.message||a.description||a.name);this.isMissing=a instanceof ys;this.isTimeout=a instanceof qs&&"net.timeout"==a.errorCode;this.isCanceled=a instanceof ve}
w(xs,Xa);xs.prototype.name="BiscottiError";function ys(){Xa.call(this,"Biscotti ID is missing from server")}
w(ys,Xa);ys.prototype.name="BiscottiMissingError";var ns={format:"RAW",method:"GET",timeout:5E3,withCredentials:!0},zs=null;function As(){if(S("disable_biscotti_fetch_entirely_for_all_web_clients"))return Error("Biscotti id fetching has been disabled entirely.");if(!vs())return Error("User has not consented - not fetching biscotti id.");var a=R("PLAYER_VARS",{});if("1"==nb(a))return Error("Biscotti ID is not available in private embed mode");if(ws(a))return Error("Biscotti id fetching has been disabled for pfl.")}
function Hk(){var a=As();if(void 0!==a)return qe(a);zs||(zs=ms().then(Bs).qc(function(b){return Cs(2,b)}));
return zs}
function Bs(a){a=a.xhr.responseText;if(0!=a.lastIndexOf(")]}'",0))throw new ys;a=JSON.parse(a.substr(4));if(1<(a.type||1))throw new ys;a=a.id;Ik(a);zs=ss(a);Ds(18E5,2);return a}
function Cs(a,b){b=new xs(b);Ik("");zs=ts(b);0<a&&Ds(12E4,a-1);throw b;}
function Ds(a,b){ml(function(){ms().then(Bs,function(c){return Cs(b,c)}).qc(Za)},a)}
function Es(){try{var a=E("yt.ads.biscotti.getId_");return a?a():Hk()}catch(b){return qe(b)}}
;function Fs(a){if("1"!=nb(R("PLAYER_VARS",{}))){a&&Gk();try{Es().then(function(){},function(){}),ml(Fs,18E5)}catch(b){Tk(b)}}}
;function Gs(){var a=$l(),b=cm(119),c=1<window.devicePixelRatio;if(document.body&&yi(document.body,"exp-invert-logo"))if(c&&!yi(document.body,"inverted-hdpi")){var d=document.body;if(d.classList)d.classList.add("inverted-hdpi");else if(!yi(d,"inverted-hdpi")){var e=wi(d);xi(d,e+(0<e.length?" inverted-hdpi":"inverted-hdpi"))}}else!c&&yi(document.body,"inverted-hdpi")&&zi();if(b!=c){b="f"+(Math.floor(119/31)+1);d=dm(b)||0;d=c?d|67108864:d&-67108865;0===d?delete Xl[b]:(c=d.toString(16),Xl[b]=c.toString());
c=!0;S("web_secure_pref_cookie_killswitch")&&(c=!1);b=a.h;d=[];for(f in Xl)Xl.hasOwnProperty(f)&&d.push(f+"="+encodeURIComponent(String(Xl[f])));var f=d.join("&");Tl(b,f,63072E3,a.i,c)}}
;var Hs=new Map([["dark","USER_INTERFACE_THEME_DARK"],["light","USER_INTERFACE_THEME_LIGHT"]]);function Is(){var a=void 0===a?window.location.href:a;if(S("kevlar_disable_theme_param"))return null;pc(qc(5,a));try{var b=bl(a).theme;return Hs.get(b)||null}catch(c){}return null}
;function Js(){this.h={};if(this.i=Wl()){var a=Ul("CONSISTENCY");a&&Ks(this,{encryptedTokenJarContents:a})}}
Js.prototype.handleResponse=function(a,b){if(!b)throw Error("request needs to be passed into ConsistencyService");var c,d;b=(null==(c=b.Ma.context)?void 0:null==(d=c.request)?void 0:d.consistencyTokenJars)||[];var e;if(a=null==(e=a.responseContext)?void 0:e.consistencyTokenJar){e=v(b);for(c=e.next();!c.done;c=e.next())delete this.h[c.value.encryptedTokenJarContents];Ks(this,a)}};
function Ks(a,b){if(b.encryptedTokenJarContents&&(a.h[b.encryptedTokenJarContents]=b,"string"===typeof b.expirationSeconds)){var c=Number(b.expirationSeconds);setTimeout(function(){delete a.h[b.encryptedTokenJarContents]},1E3*c);
a.i&&Tl("CONSISTENCY",b.encryptedTokenJarContents,c,void 0,!0)}}
;var Ls=window.location.hostname.split(".").slice(-2).join(".");function Ms(){var a=R("LOCATION_PLAYABILITY_TOKEN");"TVHTML5"===R("INNERTUBE_CLIENT_NAME")&&(this.h=Ns(this))&&(a=this.h.get("yt-location-playability-token"));a&&(this.locationPlayabilityToken=a,this.i=void 0)}
var Os;function Ps(){Os=E("yt.clientLocationService.instance");Os||(Os=new Ms,D("yt.clientLocationService.instance",Os));return Os}
m=Ms.prototype;m.setLocationOnInnerTubeContext=function(a){a.client||(a.client={});this.i?(a.client.locationInfo||(a.client.locationInfo={}),a.client.locationInfo.latitudeE7=Math.floor(1E7*this.i.coords.latitude),a.client.locationInfo.longitudeE7=Math.floor(1E7*this.i.coords.longitude),a.client.locationInfo.horizontalAccuracyMeters=Math.round(this.i.coords.accuracy),a.client.locationInfo.forceLocationPlayabilityTokenRefresh=!0):this.locationPlayabilityToken&&(a.client.locationPlayabilityToken=this.locationPlayabilityToken)};
m.handleResponse=function(a){var b;a=null==(b=a.responseContext)?void 0:b.locationPlayabilityToken;void 0!==a&&(this.locationPlayabilityToken=a,this.i=void 0,"TVHTML5"===R("INNERTUBE_CLIENT_NAME")?(this.h=Ns(this))&&this.h.set("yt-location-playability-token",a,15552E3):Tl("YT_CL",JSON.stringify({loctok:a}),15552E3,Ls,!0))};
function Ns(a){return void 0===a.h?new sm("yt-client-location"):a.h}
m.clearLocationPlayabilityToken=function(a){"TVHTML5"===a?(this.h=Ns(this))&&this.h.remove("yt-location-playability-token"):Vl("YT_CL")};
m.getCurrentPositionFromGeolocation=function(){var a=this;if(!(navigator&&navigator.geolocation&&navigator.geolocation.getCurrentPosition))return Promise.reject(Error("Geolocation unsupported"));var b=!1,c=1E4;"MWEB"===R("INNERTUBE_CLIENT_NAME")&&(b=!0,c=15E3);return new Promise(function(d,e){navigator.geolocation.getCurrentPosition(function(f){a.i=f;d(f)},function(f){e(f)},{enableHighAccuracy:b,
maximumAge:0,timeout:c})})};
m.createUnpluggedLocationInfo=function(a){var b={};a=a.coords;if(null==a?0:a.latitude)b.latitudeE7=Math.floor(1E7*a.latitude);if(null==a?0:a.longitude)b.longitudeE7=Math.floor(1E7*a.longitude);if(null==a?0:a.accuracy)b.locationRadiusMeters=Math.round(a.accuracy);return b};function Qs(a,b){if(!a)return!1;var c,d=null==(c=U(a,xk))?void 0:c.signal;if(d&&b.lb)return!!b.lb[d];var e;if((c=null==(e=U(a,uk))?void 0:e.request)&&b.xc)return!!b.xc[c];for(var f in a)if(b.wc[f])return!0;return!1}
function Rs(a,b){var c,d=null==(c=U(a,xk))?void 0:c.signal;if(d&&b.lb&&(c=b.lb[d]))return c();var e;if((c=null==(e=U(a,uk))?void 0:e.request)&&b.xc&&(e=b.xc[c]))return e();for(var f in a)if(b.wc[f]&&(a=b.wc[f]))return a()}
;function Ss(a){return function(){return new a}}
;var Ts={},Us=(Ts.WEB_UNPLUGGED="^unplugged/",Ts.WEB_UNPLUGGED_ONBOARDING="^unplugged/",Ts.WEB_UNPLUGGED_OPS="^unplugged/",Ts.WEB_UNPLUGGED_PUBLIC="^unplugged/",Ts.WEB_CREATOR="^creator/",Ts.WEB_KIDS="^kids/",Ts.WEB_EXPERIMENTS="^experiments/",Ts.WEB_MUSIC="^music/",Ts.WEB_REMIX="^music/",Ts.WEB_MUSIC_EMBEDDED_PLAYER="^music/",Ts.WEB_MUSIC_EMBEDDED_PLAYER="^main_app/|^sfv/",Ts);
function Vs(a){var b=void 0===b?"UNKNOWN_INTERFACE":b;if(1===a.length)return a[0];var c=Us[b];if(c){var d=new RegExp(c),e=v(a);for(c=e.next();!c.done;c=e.next())if(c=c.value,d.exec(c))return c}var f=[];Object.entries(Us).forEach(function(g){var h=v(g);g=h.next().value;h=h.next().value;b!==g&&f.push(h)});
d=new RegExp(f.join("|"));a.sort(function(g,h){return g.length-h.length});
e=v(a);for(c=e.next();!c.done;c=e.next())if(c=c.value,!d.exec(c))return c;return a[0]}
;function Ws(){}
Ws.prototype.m=function(a,b,c){b=void 0===b?{}:b;c=void 0===c?Ql:c;var d=a.clickTrackingParams,e=this.l,f=!1;f=void 0===f?!1:f;e=void 0===e?!1:e;var g=R("INNERTUBE_CONTEXT");if(g){g=qb(g);S("web_no_tracking_params_in_shell_killswitch")||delete g.clickTracking;g.client||(g.client={});var h=g.client;"MWEB"===h.clientName&&(h.clientFormFactor=R("IS_TABLET")?"LARGE_FORM_FACTOR":"SMALL_FORM_FACTOR");h.screenWidthPoints=window.innerWidth;h.screenHeightPoints=window.innerHeight;h.screenPixelDensity=Math.round(window.devicePixelRatio||
1);h.screenDensityFloat=window.devicePixelRatio||1;h.utcOffsetMinutes=-Math.floor((new Date).getTimezoneOffset());var k=void 0===k?!1:k;$l();var l="USER_INTERFACE_THEME_LIGHT";cm(165)?l="USER_INTERFACE_THEME_DARK":cm(174)?l="USER_INTERFACE_THEME_LIGHT":!S("kevlar_legacy_browsers")&&window.matchMedia&&window.matchMedia("(prefers-color-scheme)").matches&&window.matchMedia("(prefers-color-scheme: dark)").matches&&(l="USER_INTERFACE_THEME_DARK");k=k?l:Is()||l;h.userInterfaceTheme=k;if(!f){if(k=hm())h.connectionType=
k;S("web_log_effective_connection_type")&&(k=im())&&(g.client.effectiveConnectionType=k)}var n;if(S("web_log_memory_total_kbytes")&&(null==(n=C.navigator)?0:n.deviceMemory)){var p;n=null==(p=C.navigator)?void 0:p.deviceMemory;g.client.memoryTotalKbytes=""+1E6*n}p=bl(C.location.href);!S("web_populate_internal_geo_killswitch")&&p.internalcountrycode&&(h.internalGeo=p.internalcountrycode);"MWEB"===h.clientName||"WEB"===h.clientName?(h.mainAppWebInfo={graftUrl:C.location.href},S("kevlar_woffle")&&Rl.h&&
(p=Rl.h,h.mainAppWebInfo.pwaInstallabilityStatus=!p.h&&p.i?"PWA_INSTALLABILITY_STATUS_CAN_BE_INSTALLED":"PWA_INSTALLABILITY_STATUS_UNKNOWN"),h.mainAppWebInfo.webDisplayMode=Sl(),h.mainAppWebInfo.isWebNativeShareAvailable=navigator&&void 0!==navigator.share):"TVHTML5"===h.clientName&&(!S("web_lr_app_quality_killswitch")&&(p=R("LIVING_ROOM_APP_QUALITY"))&&(h.tvAppInfo=Object.assign(h.tvAppInfo||{},{appQuality:p})),p=R("LIVING_ROOM_CERTIFICATION_SCOPE"))&&(h.tvAppInfo=Object.assign(h.tvAppInfo||{},{certificationScope:p}));
if(!S("web_populate_time_zone_itc_killswitch")){b:{if("undefined"!==typeof Intl)try{var t=(new Intl.DateTimeFormat).resolvedOptions().timeZone;break b}catch(V){}t=void 0}t&&(h.timeZone=t)}(t=R("EXPERIMENTS_TOKEN",""))?h.experimentsToken=t:delete h.experimentsToken;t=il();Js.h||(Js.h=new Js);h=Js.h.h;p=[];n=0;for(var r in h)p[n++]=h[r];g.request=Object.assign({},g.request,{internalExperimentFlags:t,consistencyTokenJars:p});!S("web_prequest_context_killswitch")&&(r=R("INNERTUBE_CONTEXT_PREQUEST_CONTEXT"))&&
(g.request.externalPrequestContext=r);t=$l();r=cm(58);t=t.get("gsml","");g.user=Object.assign({},g.user);r&&(g.user.enableSafetyMode=r);t&&(g.user.lockedSafetyMode=!0);S("warm_op_csn_cleanup")?e&&(f=hs())&&(g.clientScreenNonce=f):!f&&(f=hs())&&(g.clientScreenNonce=f);d&&(g.clickTracking={clickTrackingParams:d});if(d=E("yt.mdx.remote.remoteClient_"))g.remoteClient=d;Ps().setLocationOnInnerTubeContext(g);try{var x=el(),y=x.bid;delete x.bid;g.adSignalsInfo={params:[],bid:y};var z=v(Object.entries(x));
for(var H=z.next();!H.done;H=z.next()){var I=v(H.value),L=I.next().value,P=I.next().value;x=L;y=P;d=void 0;null==(d=g.adSignalsInfo.params)||d.push({key:x,value:""+y})}}catch(V){Or(V)}z=g}else Or(Error("Error: No InnerTubeContext shell provided in ytconfig.")),z={};z={context:z};if(H=this.h(a)){this.i(z,H,b);var J;b="/youtubei/v1/"+Vs(this.j());(H=null==(J=U(a.commandMetadata,wk))?void 0:J.apiUrl)&&(b=H);J=b;(b=R("INNERTUBE_HOST_OVERRIDE"))&&(J=String(b)+String(sc(J)));b={};b.key=R("INNERTUBE_API_KEY");
S("json_condensed_response")&&(b.prettyPrint="false");J=cl(J,b||{},!1);a=Object.assign({},{command:a},void 0);a={input:J,jb:us(J),Ma:z,config:a};a.config.Xb?a.config.Xb.identity=c:a.config.Xb={identity:c};return a}Or(new jm("Error: Failed to create Request from Command.",a))};
ea.Object.defineProperties(Ws.prototype,{l:{configurable:!0,enumerable:!0,get:function(){return!1}}});function Xs(){}
w(Xs,Ws);Xs.prototype.m=function(){return{input:"/getDatasyncIdsEndpoint",jb:us("/getDatasyncIdsEndpoint","GET"),Ma:{}}};
Xs.prototype.j=function(){return[]};
Xs.prototype.h=function(){};
Xs.prototype.i=function(){};var Ys={},Zs=(Ys.GET_DATASYNC_IDS=Ss(Xs),Ys);function $s(a,b){var c=void 0===c?!0:c;var d=R("VALID_SESSION_TEMPDATA_DOMAINS",[]),e=rc(window.location.href);e&&d.push(e);e=rc(a);if(0<=ab(d,e)||!e&&0==a.lastIndexOf("/",0))if(d=document.createElement("a"),ic(d,a),a=d.href)if(a=sc(a),a=tc(a))if(c&&!b.csn&&(b.itct||b.ved)&&(b=Object.assign({csn:hs()},b)),f){var f=parseInt(f,10);isFinite(f)&&0<f&&at(a,b,f)}else at(a,b)}
function at(a,b,c){a="ST-"+nc(a).toString(36);b=b?xc(b):"";c=c||5;vs()&&Tl(a,b,c)}
;function bt(){try{return!!self.localStorage}catch(a){return!1}}
;function ct(a){a=a.match(/(.*)::.*::.*/);if(null!==a)return a[1]}
function dt(a){if(bt()){var b=Object.keys(window.localStorage);b=v(b);for(var c=b.next();!c.done;c=b.next()){c=c.value;var d=ct(c);void 0===d||a.includes(d)||self.localStorage.removeItem(c)}}}
function et(){if(!bt())return!1;var a=lm(),b=Object.keys(window.localStorage);b=v(b);for(var c=b.next();!c.done;c=b.next())if(c=ct(c.value),void 0!==c&&c!==a)return!0;return!1}
;function ft(a){if(Eg()){var b=R("VALID_SESSION_TEMPDATA_DOMAINS",[]);var c=rc(window.location.href);c&&b.push(c);c=rc(a);0<=ab(b,c)||!c&&0==a.lastIndexOf("/",0)?(b=sc(a),(b=tc(b))?(b="ST-"+nc(b).toString(36),b=(b=Ul(b)||null)?al(b):{}):b=null):b=null;null==b&&(b={});c=R("LOGIN_INFO");S("copy_login_info_to_st_cookie")&&c&&(b.session_logininfo=c);$s(a,b)}}
;function gt(a){var b=B.apply(1,arguments);if(!ht(a)||b.some(function(d){return!ht(d)}))throw Error("Only objects may be merged.");
b=v(b);for(var c=b.next();!c.done;c=b.next())jt(a,c.value);return a}
function jt(a,b){for(var c in b)if(ht(b[c])){if(c in a&&!ht(a[c]))throw Error("Cannot merge an object into a non-object.");c in a||(a[c]={});jt(a[c],b[c])}else if(kt(b[c])){if(c in a&&!kt(a[c]))throw Error("Cannot merge an array into a non-array.");c in a||(a[c]=[]);lt(a[c],b[c])}else a[c]=b[c];return a}
function lt(a,b){b=v(b);for(var c=b.next();!c.done;c=b.next())c=c.value,ht(c)?a.push(jt({},c)):kt(c)?a.push(lt([],c)):a.push(c);return a}
function ht(a){return"object"===typeof a&&!Array.isArray(a)}
function kt(a){return"object"===typeof a&&Array.isArray(a)}
;function mt(a){var b;(b=E("ytcsi."+(a||"")+"data_"))||(b={tick:{},info:{}},D("ytcsi."+(a||"")+"data_",b));return b}
function nt(){var a=mt();a.info||(a.info={});return a.info}
function ot(a){a=mt(a);a.metadata||(a.metadata={});return a.metadata}
function pt(a){a=mt(a);a.tick||(a.tick={});return a.tick}
function qt(a){a=mt(a);if(a.gel){var b=a.gel;b.gelInfos||(b.gelInfos={});b.gelTicks||(b.gelTicks={})}else a.gel={gelTicks:{},gelInfos:{}};return a.gel}
function rt(a){a=qt(a);a.gelInfos||(a.gelInfos={});return a.gelInfos}
function st(a){var b=mt(a).nonce;b||(b=Wr(),mt(a).nonce=b);return b}
;function tt(){var a=E("ytcsi.debug");a||(a=[],D("ytcsi.debug",a),D("ytcsi.reference",{}));return a}
function ut(a){a=a||"";var b=E("ytcsi.reference");b||(tt(),b=E("ytcsi.reference"));if(b[a])return b[a];var c=tt(),d={timerName:a,info:{},tick:{},span:{},jspbInfo:[]};c.push(d);return b[a]=d}
;var W={},vt=(W.auto_search="LATENCY_ACTION_AUTO_SEARCH",W.ad_to_ad="LATENCY_ACTION_AD_TO_AD",W.ad_to_video="LATENCY_ACTION_AD_TO_VIDEO",W["analytics.explore"]="LATENCY_ACTION_CREATOR_ANALYTICS_EXPLORE",W.app_startup="LATENCY_ACTION_APP_STARTUP",W["artist.analytics"]="LATENCY_ACTION_CREATOR_ARTIST_ANALYTICS",W["artist.events"]="LATENCY_ACTION_CREATOR_ARTIST_CONCERTS",W["artist.presskit"]="LATENCY_ACTION_CREATOR_ARTIST_PROFILE",W["asset.claimed_videos"]="LATENCY_ACTION_CREATOR_CMS_ASSET_CLAIMED_VIDEOS",
W["asset.composition"]="LATENCY_ACTION_CREATOR_CMS_ASSET_COMPOSITION",W["asset.composition_ownership"]="LATENCY_ACTION_CREATOR_CMS_ASSET_COMPOSITION_OWNERSHIP",W["asset.composition_policy"]="LATENCY_ACTION_CREATOR_CMS_ASSET_COMPOSITION_POLICY",W["asset.embeds"]="LATENCY_ACTION_CREATOR_CMS_ASSET_EMBEDS",W["asset.issues"]="LATENCY_ACTION_CREATOR_CMS_ASSET_ISSUES",W["asset.licenses"]="LATENCY_ACTION_CREATOR_CMS_ASSET_LICENSES",W["asset.metadata"]="LATENCY_ACTION_CREATOR_CMS_ASSET_METADATA",W["asset.ownership"]=
"LATENCY_ACTION_CREATOR_CMS_ASSET_OWNERSHIP",W["asset.policy"]="LATENCY_ACTION_CREATOR_CMS_ASSET_POLICY",W["asset.references"]="LATENCY_ACTION_CREATOR_CMS_ASSET_REFERENCES",W["asset.shares"]="LATENCY_ACTION_CREATOR_CMS_ASSET_SHARES",W["asset.sound_recordings"]="LATENCY_ACTION_CREATOR_CMS_ASSET_SOUND_RECORDINGS",W["asset_group.assets"]="LATENCY_ACTION_CREATOR_CMS_ASSET_GROUP_ASSETS",W["asset_group.campaigns"]="LATENCY_ACTION_CREATOR_CMS_ASSET_GROUP_CAMPAIGNS",W["asset_group.claimed_videos"]="LATENCY_ACTION_CREATOR_CMS_ASSET_GROUP_CLAIMED_VIDEOS",
W["asset_group.metadata"]="LATENCY_ACTION_CREATOR_CMS_ASSET_GROUP_METADATA",W["song.analytics"]="LATENCY_ACTION_CREATOR_SONG_ANALYTICS",W.browse="LATENCY_ACTION_BROWSE",W.cast_splash="LATENCY_ACTION_CAST_SPLASH",W.channels="LATENCY_ACTION_CHANNELS",W.creator_channel_dashboard="LATENCY_ACTION_CREATOR_CHANNEL_DASHBOARD",W["channel.analytics"]="LATENCY_ACTION_CREATOR_CHANNEL_ANALYTICS",W["channel.comments"]="LATENCY_ACTION_CREATOR_CHANNEL_COMMENTS",W["channel.content"]="LATENCY_ACTION_CREATOR_POST_LIST",
W["channel.content.promotions"]="LATENCY_ACTION_CREATOR_PROMOTION_LIST",W["channel.copyright"]="LATENCY_ACTION_CREATOR_CHANNEL_COPYRIGHT",W["channel.editing"]="LATENCY_ACTION_CREATOR_CHANNEL_EDITING",W["channel.monetization"]="LATENCY_ACTION_CREATOR_CHANNEL_MONETIZATION",W["channel.music"]="LATENCY_ACTION_CREATOR_CHANNEL_MUSIC",W["channel.music_storefront"]="LATENCY_ACTION_CREATOR_CHANNEL_MUSIC_STOREFRONT",W["channel.playlists"]="LATENCY_ACTION_CREATOR_CHANNEL_PLAYLISTS",W["channel.translations"]=
"LATENCY_ACTION_CREATOR_CHANNEL_TRANSLATIONS",W["channel.videos"]="LATENCY_ACTION_CREATOR_CHANNEL_VIDEOS",W["channel.live_streaming"]="LATENCY_ACTION_CREATOR_LIVE_STREAMING",W.chips="LATENCY_ACTION_CHIPS",W["dialog.copyright_strikes"]="LATENCY_ACTION_CREATOR_DIALOG_COPYRIGHT_STRIKES",W["dialog.video_copyright"]="LATENCY_ACTION_CREATOR_DIALOG_VIDEO_COPYRIGHT",W["dialog.uploads"]="LATENCY_ACTION_CREATOR_DIALOG_UPLOADS",W.direct_playback="LATENCY_ACTION_DIRECT_PLAYBACK",W.embed="LATENCY_ACTION_EMBED",
W.entity_key_serialization_perf="LATENCY_ACTION_ENTITY_KEY_SERIALIZATION_PERF",W.entity_key_deserialization_perf="LATENCY_ACTION_ENTITY_KEY_DESERIALIZATION_PERF",W.explore="LATENCY_ACTION_EXPLORE",W.home="LATENCY_ACTION_HOME",W.library="LATENCY_ACTION_LIBRARY",W.live="LATENCY_ACTION_LIVE",W.live_pagination="LATENCY_ACTION_LIVE_PAGINATION",W.mini_app="LATENCY_ACTION_MINI_APP_PLAY",W.onboarding="LATENCY_ACTION_ONBOARDING",W.owner="LATENCY_ACTION_CREATOR_CMS_DASHBOARD",W["owner.allowlist"]="LATENCY_ACTION_CREATOR_CMS_ALLOWLIST",
W["owner.analytics"]="LATENCY_ACTION_CREATOR_CMS_ANALYTICS",W["owner.art_tracks"]="LATENCY_ACTION_CREATOR_CMS_ART_TRACKS",W["owner.assets"]="LATENCY_ACTION_CREATOR_CMS_ASSETS",W["owner.asset_groups"]="LATENCY_ACTION_CREATOR_CMS_ASSET_GROUPS",W["owner.bulk"]="LATENCY_ACTION_CREATOR_CMS_BULK_HISTORY",W["owner.campaigns"]="LATENCY_ACTION_CREATOR_CMS_CAMPAIGNS",W["owner.channel_invites"]="LATENCY_ACTION_CREATOR_CMS_CHANNEL_INVITES",W["owner.channels"]="LATENCY_ACTION_CREATOR_CMS_CHANNELS",W["owner.claimed_videos"]=
"LATENCY_ACTION_CREATOR_CMS_CLAIMED_VIDEOS",W["owner.claims"]="LATENCY_ACTION_CREATOR_CMS_MANUAL_CLAIMING",W["owner.claims.manual"]="LATENCY_ACTION_CREATOR_CMS_MANUAL_CLAIMING",W["owner.delivery"]="LATENCY_ACTION_CREATOR_CMS_CONTENT_DELIVERY",W["owner.delivery_templates"]="LATENCY_ACTION_CREATOR_CMS_DELIVERY_TEMPLATES",W["owner.issues"]="LATENCY_ACTION_CREATOR_CMS_ISSUES",W["owner.licenses"]="LATENCY_ACTION_CREATOR_CMS_LICENSES",W["owner.pitch_music"]="LATENCY_ACTION_CREATOR_CMS_PITCH_MUSIC",W["owner.policies"]=
"LATENCY_ACTION_CREATOR_CMS_POLICIES",W["owner.releases"]="LATENCY_ACTION_CREATOR_CMS_RELEASES",W["owner.reports"]="LATENCY_ACTION_CREATOR_CMS_REPORTS",W["owner.videos"]="LATENCY_ACTION_CREATOR_CMS_VIDEOS",W.parent_profile_settings="LATENCY_ACTION_KIDS_PARENT_PROFILE_SETTINGS",W.parent_tools_collection="LATENCY_ACTION_PARENT_TOOLS_COLLECTION",W.parent_tools_dashboard="LATENCY_ACTION_PARENT_TOOLS_DASHBOARD",W.player_att="LATENCY_ACTION_PLAYER_ATTESTATION",W["playlist.videos"]="LATENCY_ACTION_CREATOR_PLAYLIST_VIDEO_LIST",
W["post.comments"]="LATENCY_ACTION_CREATOR_POST_COMMENTS",W["post.edit"]="LATENCY_ACTION_CREATOR_POST_EDIT",W.prebuffer="LATENCY_ACTION_PREBUFFER",W.prefetch="LATENCY_ACTION_PREFETCH",W.profile_settings="LATENCY_ACTION_KIDS_PROFILE_SETTINGS",W.profile_switcher="LATENCY_ACTION_LOGIN",W.reel_watch="LATENCY_ACTION_REEL_WATCH",W.results="LATENCY_ACTION_RESULTS",W["promotion.edit"]="LATENCY_ACTION_CREATOR_PROMOTION_EDIT",W.search_ui="LATENCY_ACTION_SEARCH_UI",W.search_suggest="LATENCY_ACTION_SUGGEST",
W.search_zero_state="LATENCY_ACTION_SEARCH_ZERO_STATE",W.secret_code="LATENCY_ACTION_KIDS_SECRET_CODE",W.seek="LATENCY_ACTION_PLAYER_SEEK",W.settings="LATENCY_ACTION_SETTINGS",W.store="LATENCY_ACTION_STORE",W.tenx="LATENCY_ACTION_TENX",W.video_to_ad="LATENCY_ACTION_VIDEO_TO_AD",W.watch="LATENCY_ACTION_WATCH",W.watch_it_again="LATENCY_ACTION_KIDS_WATCH_IT_AGAIN",W["watch,watch7"]="LATENCY_ACTION_WATCH",W["watch,watch7_html5"]="LATENCY_ACTION_WATCH",W["watch,watch7ad"]="LATENCY_ACTION_WATCH",W["watch,watch7ad_html5"]=
"LATENCY_ACTION_WATCH",W.wn_comments="LATENCY_ACTION_LOAD_COMMENTS",W.ww_rqs="LATENCY_ACTION_WHO_IS_WATCHING",W["video.analytics"]="LATENCY_ACTION_CREATOR_VIDEO_ANALYTICS",W["video.claims"]="LATENCY_ACTION_CREATOR_VIDEO_CLAIMS",W["video.comments"]="LATENCY_ACTION_CREATOR_VIDEO_COMMENTS",W["video.copyright"]="LATENCY_ACTION_CREATOR_VIDEO_COPYRIGHT",W["video.edit"]="LATENCY_ACTION_CREATOR_VIDEO_EDIT",W["video.editor"]="LATENCY_ACTION_CREATOR_VIDEO_VIDEO_EDITOR",W["video.editor_async"]="LATENCY_ACTION_CREATOR_VIDEO_VIDEO_EDITOR_ASYNC",
W["video.live_settings"]="LATENCY_ACTION_CREATOR_VIDEO_LIVE_SETTINGS",W["video.live_streaming"]="LATENCY_ACTION_CREATOR_VIDEO_LIVE_STREAMING",W["video.monetization"]="LATENCY_ACTION_CREATOR_VIDEO_MONETIZATION",W["video.policy"]="LATENCY_ACTION_CREATOR_VIDEO_POLICY",W["video.rights_management"]="LATENCY_ACTION_CREATOR_VIDEO_RIGHTS_MANAGEMENT",W["video.translations"]="LATENCY_ACTION_CREATOR_VIDEO_TRANSLATIONS",W.voice_assistant="LATENCY_ACTION_VOICE_ASSISTANT",W.cast_load_by_entity_to_watch="LATENCY_ACTION_CAST_LOAD_BY_ENTITY_TO_WATCH",
W.networkless_performance="LATENCY_ACTION_NETWORKLESS_PERFORMANCE",W.gel_compression="LATENCY_ACTION_GEL_COMPRESSION",W.gel_jspb_serialize="LATENCY_ACTION_GEL_JSPB_SERIALIZE",W),X={},wt=(X.ad_allowed="adTypesAllowed",X.yt_abt="adBreakType",X.ad_cpn="adClientPlaybackNonce",X.ad_docid="adVideoId",X.yt_ad_an="adNetworks",X.ad_at="adType",X.aida="appInstallDataAgeMs",X.browse_id="browseId",X.p="httpProtocol",X.t="transportProtocol",X.cpn="clientPlaybackNonce",X.ccs="creatorInfo.creatorCanaryState",X.ctop=
"creatorInfo.topEntityType",X.csn="clientScreenNonce",X.docid="videoId",X.GetHome_rid="requestIds",X.GetSearch_rid="requestIds",X.GetPlayer_rid="requestIds",X.GetWatchNext_rid="requestIds",X.GetBrowse_rid="requestIds",X.GetLibrary_rid="requestIds",X.is_continuation="isContinuation",X.is_nav="isNavigation",X.b_p="kabukiInfo.browseParams",X.is_prefetch="kabukiInfo.isPrefetch",X.is_secondary_nav="kabukiInfo.isSecondaryNav",X.nav_type="kabukiInfo.navigationType",X.prev_browse_id="kabukiInfo.prevBrowseId",
X.query_source="kabukiInfo.querySource",X.voz_type="kabukiInfo.vozType",X.yt_lt="loadType",X.mver="creatorInfo.measurementVersion",X.yt_ad="isMonetized",X.nr="webInfo.navigationReason",X.nrsu="navigationRequestedSameUrl",X.pnt="performanceNavigationTiming",X.prt="playbackRequiresTap",X.plt="playerInfo.playbackType",X.pis="playerInfo.playerInitializedState",X.paused="playerInfo.isPausedOnLoad",X.yt_pt="playerType",X.fmt="playerInfo.itag",X.yt_pl="watchInfo.isPlaylist",X.yt_pre="playerInfo.preloadType",
X.yt_ad_pr="prerollAllowed",X.pa="previousAction",X.yt_red="isRedSubscriber",X.rce="mwebInfo.responseContentEncoding",X.rc="resourceInfo.resourceCache",X.scrh="screenHeight",X.scrw="screenWidth",X.st="serverTimeMs",X.ssdm="shellStartupDurationMs",X.br_trs="tvInfo.bedrockTriggerState",X.kebqat="kabukiInfo.earlyBrowseRequestInfo.abandonmentType",X.kebqa="kabukiInfo.earlyBrowseRequestInfo.adopted",X.label="tvInfo.label",X.is_mdx="tvInfo.isMdx",X.preloaded="tvInfo.isPreloaded",X.aac_type="tvInfo.authAccessCredentialType",
X.upg_player_vis="playerInfo.visibilityState",X.query="unpluggedInfo.query",X.upg_chip_ids_string="unpluggedInfo.upgChipIdsString",X.yt_vst="videoStreamType",X.vph="viewportHeight",X.vpw="viewportWidth",X.yt_vis="isVisible",X.rcl="mwebInfo.responseContentLength",X.GetSettings_rid="requestIds",X.GetTrending_rid="requestIds",X.GetMusicSearchSuggestions_rid="requestIds",X.REQUEST_ID="requestIds",X),xt="isContinuation isNavigation kabukiInfo.earlyBrowseRequestInfo.adopted kabukiInfo.isPrefetch kabukiInfo.isSecondaryNav isMonetized navigationRequestedSameUrl performanceNavigationTiming playerInfo.isPausedOnLoad prerollAllowed isRedSubscriber tvInfo.isMdx tvInfo.isPreloaded isVisible watchInfo.isPlaylist playbackRequiresTap".split(" "),
zt={},At=(zt.ccs="CANARY_STATE_",zt.mver="MEASUREMENT_VERSION_",zt.pis="PLAYER_INITIALIZED_STATE_",zt.yt_pt="LATENCY_PLAYER_",zt.pa="LATENCY_ACTION_",zt.ctop="TOP_ENTITY_TYPE_",zt.yt_vst="VIDEO_STREAM_TYPE_",zt),Bt="all_vc ap aq c cbr cbrand cbrver cmodel cos cosver cplatform ctheme cver ei l_an l_mm plid srt yt_fss yt_li vpst vpni2 vpil2 icrc icrt pa GetAccountOverview_rid GetHistory_rid cmt d_vpct d_vpnfi d_vpni nsru pc pfa pfeh pftr pnc prerender psc rc start tcrt tcrc ssr vpr vps yt_abt yt_fn yt_fs yt_pft yt_pre yt_pt yt_pvis ytu_pvis yt_ref yt_sts tds".split(" ");
function Ct(a,b,c){c=qt(c);if(c.gelInfos)c.gelInfos[a]=!0;else{var d={};c.gelInfos=(d[a]=!0,d)}if(a.match("_rid")){var e=a.split("_rid")[0];a="REQUEST_ID"}if(a in wt){c=wt[a];0<=ab(xt,c)&&(b=!!b);a in At&&"string"===typeof b&&(b=At[a]+b.toUpperCase());a=b;b=c.split(".");for(var f=d={},g=0;g<b.length-1;g++){var h=b[g];f[h]={};f=f[h]}f[b[b.length-1]]="requestIds"===c?[{id:a,endpoint:e}]:a;return gt({},d)}0<=ab(Bt,a)||Pr(new jm("Unknown label logged with GEL CSI",a))}
;function Dt(a,b){uo.call(this,1,arguments);this.timer=b}
w(Dt,uo);var Et=new vo("aft-recorded",Dt);var Ft=C.ytLoggingLatencyUsageStats_||{};D("ytLoggingLatencyUsageStats_",Ft);function Gt(){this.h=0}
function Ht(){Gt.h||(Gt.h=new Gt);return Gt.h}
Gt.prototype.tick=function(a,b,c,d){It(this,"tick_"+a+"_"+b)||Cm("latencyActionTicked",{tickName:a,clientActionNonce:b},{timestamp:c,cttAuthInfo:d})};
Gt.prototype.info=function(a,b,c){var d=Object.keys(a).join("");It(this,"info_"+d+"_"+b)||(a=Object.assign({},a),a.clientActionNonce=b,Cm("latencyActionInfo",a,{cttAuthInfo:c}))};
Gt.prototype.jspbInfo=function(){};
Gt.prototype.span=function(a,b,c){var d=Object.keys(a).join("");It(this,"span_"+d+"_"+b)||(a.clientActionNonce=b,Cm("latencyActionSpan",a,{cttAuthInfo:c}))};
function It(a,b){Ft[b]=Ft[b]||{count:0};var c=Ft[b];c.count++;c.time=T();a.h||(a.h=nm(function(){var d=T(),e;for(e in Ft)Ft[e]&&6E4<d-Ft[e].time&&delete Ft[e];a&&(a.h=0)},5E3));
return 5<c.count?(6===c.count&&1>1E5*Math.random()&&(c=new jm("CSI data exceeded logging limit with key",b.split("_")),0<=b.indexOf("plev")||Pr(c)),!0):!1}
;var Jt=window;function Kt(){this.timing={};this.clearResourceTimings=function(){};
this.webkitClearResourceTimings=function(){};
this.mozClearResourceTimings=function(){};
this.msClearResourceTimings=function(){};
this.oClearResourceTimings=function(){}}
function Lt(){var a;if(S("csi_use_performance_navigation_timing")||S("csi_use_performance_navigation_timing_tvhtml5")){var b,c,d,e=null==Y?void 0:null==(a=Y.getEntriesByType)?void 0:null==(b=a.call(Y,"navigation"))?void 0:null==(c=b[0])?void 0:null==(d=c.toJSON)?void 0:d.call(c);e?(e.requestStart=Mt(e.requestStart),e.responseEnd=Mt(e.responseEnd),e.redirectStart=Mt(e.redirectStart),e.redirectEnd=Mt(e.redirectEnd),e.domainLookupEnd=Mt(e.domainLookupEnd),e.connectStart=Mt(e.connectStart),e.connectEnd=
Mt(e.connectEnd),e.responseStart=Mt(e.responseStart),e.secureConnectionStart=Mt(e.secureConnectionStart),e.domainLookupStart=Mt(e.domainLookupStart),e.isPerformanceNavigationTiming=!0,a=e):a=Y.timing}else a=Y.timing;return a}
function Mt(a){return Math.round(Nt()+a)}
function Nt(){return(S("csi_use_time_origin")||S("csi_use_time_origin_tvhtml5"))&&Y.timeOrigin?Math.floor(Y.timeOrigin):Y.timing.navigationStart}
var Y=Jt.performance||Jt.mozPerformance||Jt.msPerformance||Jt.webkitPerformance||new Kt;var Ot=!1,Pt={'script[name="scheduler/scheduler"]':"sj",'script[name="player/base"]':"pj",'link[rel="preload"][name="player/embed"]':"pej",'link[rel="stylesheet"][name="www-player"]':"pc",'link[rel="stylesheet"][name="player/www-player"]':"pc",'script[name="desktop_polymer/desktop_polymer"]':"dpj",'link[rel="import"][name="desktop_polymer"]':"dph",'script[name="mobile-c3"]':"mcj",'link[rel="stylesheet"][name="mobile-c3"]':"mcc",'script[name="player-plasma-ias-phone/base"]':"mcppj",'script[name="player-plasma-ias-tablet/base"]':"mcptj",
'link[rel="stylesheet"][name="mobile-polymer-player-ias"]':"mcpc",'link[rel="stylesheet"][name="mobile-polymer-player-svg-ias"]':"mcpsc",'script[name="mobile_blazer_core_mod"]':"mbcj",'link[rel="stylesheet"][name="mobile_blazer_css"]':"mbc",'script[name="mobile_blazer_logged_in_users_mod"]':"mbliuj",'script[name="mobile_blazer_logged_out_users_mod"]':"mblouj",'script[name="mobile_blazer_noncore_mod"]':"mbnj","#player_css":"mbpc",'script[name="mobile_blazer_desktopplayer_mod"]':"mbpj",'link[rel="stylesheet"][name="mobile_blazer_tablet_css"]':"mbtc",
'script[name="mobile_blazer_watch_mod"]':"mbwj"};Ta(Y.clearResourceTimings||Y.webkitClearResourceTimings||Y.mozClearResourceTimings||Y.msClearResourceTimings||Y.oClearResourceTimings||Za,Y);function Qt(a,b,c){if(null!==b){if("yt_lt"===a){var d="string"===typeof b?b:""+b;ot(c).loadType=d}(a=Ct(a,b,c))&&Rt(a,c)}}
function Rt(a,b){var c=ut(b||"");gt(c.info,a);a.loadType&&(c=a.loadType,ot(b).loadType=c);gt(rt(b),a);c=st(b);b=mt(b).cttAuthInfo;Ht().info(a,c,b)}
function St(a){var b,c,d,e,f=(null!=(e=null==Hq().resolve(new Cq(mo))?void 0:null==(b=no())?void 0:null==(c=b.loggingHotConfig)?void 0:null==(d=c.csiConfig)?void 0:d.debugTicks)?e:[]).map(function(g){return Object.values(g)[0]});
if(0<f.length)for(b=0;b<f.length;b++)if(a===f[b])return!0;return!1}
function Tt(a,b,c){var d=st(c),e;if(e=S("web_csi_debug_sample_enabled")&&d){var f,g,h;e=(null==Hq().resolve(new Cq(mo))?void 0:null==(f=no())?void 0:null==(g=f.loggingHotConfig)?void 0:null==(h=g.csiConfig)?void 0:h.debugSampleWeight)||0;if(0!==e&&St(a)){for(g=f=0;g<d.length;g++)f=(31*f+d.charCodeAt(g))%Number.MAX_SAFE_INTEGER;e=0!==f%1E5%e;mt(c).debugTicksExcludedLogged||(f={},f.debugTicksExcluded=e,Rt(f,c));mt(c).debugTicksExcludedLogged=!0}else e=!1}if(!e){b||"_"===a[0]||(e=a,Y.mark&&(0==e.lastIndexOf("mark_",
0)||(e="mark_"+e),c&&(e+=" ("+c+")"),Y.mark(e)));e=ut(c||"");e.tick[a]=b||T();if(e.callback&&e.callback[a])for(e=v(e.callback[a]),f=e.next();!f.done;f=e.next())f=f.value,f();e=qt(c);e.gelTicks&&(e.gelTicks[a]=!0);f=pt(c);e=b||T();S("log_repeated_ytcsi_ticks")?a in f||(f[a]=e):f[a]=e;f=mt(c).cttAuthInfo;"_start"===a?(a=Ht(),It(a,"baseline_"+d)||Cm("latencyActionBaselined",{clientActionNonce:d},{timestamp:b,cttAuthInfo:f})):Ht().tick(a,d,b,f);Ut(c);return e}}
function Vt(){var a=document;if("visibilityState"in a)a=a.visibilityState;else{var b=Yp+"VisibilityState";a=b in a?a[b]:void 0}switch(a){case "hidden":return 0;case "visible":return 1;case "prerender":return 2;case "unloaded":return 3;default:return-1}}
function Wt(a,b){a=document.querySelector(a);if(!a)return!1;var c="",d=a.nodeName;"SCRIPT"===d?(c=a.src,c||(c=a.getAttribute("data-timing-href"))&&(c=window.location.protocol+c)):"LINK"===d&&(c=a.href);lc()&&a.setAttribute("nonce",lc());return c?(a=Y.getEntriesByName(c))&&a[0]&&(a=a[0],c=Nt(),Tt("rsf_"+b,c+Math.round(a.fetchStart)),Tt("rse_"+b,c+Math.round(a.responseEnd)),void 0!==a.transferSize&&0===a.transferSize)?!0:!1:!1}
function Xt(){var a=window.location.protocol,b=Y.getEntriesByType("resource");b=cb(b,function(c){return 0===c.name.indexOf(a+"//fonts.gstatic.com/s/")});
(b=eb(b,function(c,d){return d.duration>c.duration?d:c},{duration:0}))&&0<b.startTime&&0<b.responseEnd&&(Tt("wffs",Mt(b.startTime)),Tt("wffe",Mt(b.responseEnd)))}
function Yt(a){var b=Zt("aft",a);if(b)return b;b=R((a||"")+"TIMING_AFT_KEYS",["ol"]);for(var c=b.length,d=0;d<c;d++){var e=Zt(b[d],a);if(e)return e}return NaN}
function Zt(a,b){if(a=pt(b)[a])return"number"===typeof a?a:a[a.length-1]}
function Ut(a){var b=Zt("_start",a),c=Yt(a);b&&c&&!Ot&&(Ao(Et,new Dt(Math.round(c-b),a)),Ot=!0)}
function $t(a,b){for(var c=v(Object.keys(b)),d=c.next();!d.done;d=c.next())if(d=d.value,!Object.keys(a).includes(d)||"object"===typeof b[d]&&!$t(a[d],b[d]))return!1;return!0}
function au(){if(Y.getEntriesByType){var a=Y.getEntriesByType("paint");if(a=fb(a,function(b){return"first-paint"===b.name}))return Mt(a.startTime)}a=Y.timing;
return a.Ae?Math.max(0,a.Ae):0}
;function bu(a,b){Sk(function(){ut("").info.actionType=a;b&&Ok("TIMING_AFT_KEYS",b);Ok("TIMING_ACTION",a);var c=R("TIMING_INFO",{}),d;for(d in c)c.hasOwnProperty(d)&&Qt(d,c[d]);c={isNavigation:!0,actionType:vt[R("TIMING_ACTION")]||"LATENCY_ACTION_UNKNOWN"};if(d=R("PREVIOUS_ACTION"))c.previousAction=vt[d]||"LATENCY_ACTION_UNKNOWN";if(d=R("CLIENT_PROTOCOL"))c.httpProtocol=d;if(d=R("CLIENT_TRANSPORT"))c.transportProtocol=d;(d=hs())&&"UNDEFINED_CSN"!==d&&(c.clientScreenNonce=d);d=Vt();if(1===d||-1===d)c.isVisible=
!0;ot();nt();c.loadType="cold";d=nt();var e=Lt(),f=Nt(),g=R("CSI_START_TIMESTAMP_MILLIS",0);0<g&&!S("embeds_web_enable_csi_start_override_killswitch")&&(f=g);f&&(Tt("srt",e.responseStart),1!==d.prerender&&Tt("_start",f,void 0));d=au();0<d&&Tt("fpt",d);d=Lt();d.isPerformanceNavigationTiming&&Rt({performanceNavigationTiming:!0});Tt("nreqs",d.requestStart,void 0);Tt("nress",d.responseStart,void 0);Tt("nrese",d.responseEnd,void 0);0<d.redirectEnd-d.redirectStart&&(Tt("nrs",d.redirectStart,void 0),Tt("nre",
d.redirectEnd,void 0));0<d.domainLookupEnd-d.domainLookupStart&&(Tt("ndnss",d.domainLookupStart,void 0),Tt("ndnse",d.domainLookupEnd,void 0));0<d.connectEnd-d.connectStart&&(Tt("ntcps",d.connectStart,void 0),Tt("ntcpe",d.connectEnd,void 0));d.secureConnectionStart>=Nt()&&0<d.connectEnd-d.secureConnectionStart&&(Tt("nstcps",d.secureConnectionStart,void 0),Tt("ntcpe",d.connectEnd,void 0));Y&&"getEntriesByType"in Y&&Xt();d=[];if(document.querySelector&&Y&&Y.getEntriesByName)for(var h in Pt)Pt.hasOwnProperty(h)&&
(e=Pt[h],Wt(h,e)&&d.push(e));if(0<d.length)for(c.resourceInfo=[],h=v(d),d=h.next();!d.done;d=h.next())c.resourceInfo.push({resourceCache:d.value});Rt(c);c=nt();h=rt();if("cold"===ot().loadType&&("cold"===c.yt_lt||"cold"===h.loadType)){d=pt();e=qt();e=e.gelTicks?e.gelTicks:e.gelTicks={};for(var k in d)if(!(k in e))if("number"===typeof d[k])Tt(k,Zt(k));else if(S("log_repeated_ytcsi_ticks"))for(f=v(d[k]),g=f.next();!g.done;g=f.next())g=g.value,Tt(k.slice(1),g);k={};d=!1;e=v(Object.keys(c));for(f=e.next();!f.done;f=
e.next())f=f.value,(f=Ct(f,c[f]))&&!$t(rt(),f)&&(gt(h,f),gt(k,f),d=!0);d&&Rt(k)}D("ytglobal.timingready_",!0);k=R("TIMING_ACTION");E("ytglobal.timingready_")&&k&&cu()&&Yt()&&Ut()})()}
function du(a,b,c,d){Sk(Qt)(a,b,c,d)}
function eu(a,b,c){return Sk(Tt)(a,b,c)}
function cu(){return Sk(function(){return"_start"in pt()})()}
function fu(){Sk(function(){var a=st();requestAnimationFrame(function(){setTimeout(function(){a===st()&&eu("ol",void 0,void 0)},0)})})()}
var gu=window;gu.ytcsi&&(gu.ytcsi.info=du,gu.ytcsi.tick=eu);var hu="tokens consistency mss client_location entities adblock_detection response_received_commands store PLAYER_PRELOAD".split(" "),iu=["type.googleapis.com/youtube.api.pfiinnertube.YoutubeApiInnertube.BrowseResponse"];function ju(a,b,c,d){this.j=a;this.X=b;this.m=c;this.l=d;this.i=void 0;this.h=new Map;a.lb||(a.lb={});a.lb=Object.assign({},Zs,a.lb)}
function ku(a,b,c,d){if(void 0!==ju.h){if(d=ju.h,a=[a!==d.j,b!==d.X,c!==d.m,!1,!1,!1,void 0!==d.i],a.some(function(e){return e}))throw new jm("InnerTubeTransportService is already initialized",a);
}else ju.h=new ju(a,b,c,d)}
function lu(a){var b={signalServiceEndpoint:{signal:"GET_DATASYNC_IDS"}};var c=void 0===c?Ql:c;var d=Rs(b,a.j);if(!d)return qe(new jm("Error: No request builder found for command.",b));var e=d.m(b,void 0,c);return e?(ft(e.input),new ke(function(f){var g,h,k;return A(function(l){if(1==l.h){h="cors"===(null==(g=e.jb)?void 0:g.mode)?"cors":void 0;if(a.m.Xe){var n=e.config,p;n=null==n?void 0:null==(p=n.Xb)?void 0:p.sessionIndex;p=Pl(0,{sessionIndex:n});k=Object.assign({},mu(h),p);return l.A(2)}return l.yield(nu(e.config,
h),3)}2!=l.h&&(k=l.i);f(ou(a,e,k));l.h=0})})):qe(new jm("Error: Failed to build request for command.",b))}
function pu(a,b,c){var d;if(b&&!(null==b?0:null==(d=b.Xf)?0:d.cg)&&a.l){d=v(hu);for(var e=d.next();!e.done;e=d.next())e=e.value,a.l[e]&&a.l[e].handleResponse(b,c)}}
function ou(a,b,c){var d,e,f,g,h,k,l,n,p,t,r,x,y,z,H,I,L,P,J,V,Z,ca,ra,ma,Ha,Fg,sq,tq,uq;return A(function(ha){switch(ha.h){case 1:ha.A(2);break;case 3:if((d=ha.i)&&!d.isExpired())return ha.return(Promise.resolve(d.h()));case 2:if(!(null==(e=b)?0:null==(f=e.Ma)?0:f.context)){ha.A(4);break}g=b.Ma.context;ha.A(5);break;case 5:h=v([]),k=h.next();case 7:if(k.done){ha.A(4);break}l=k.value;return ha.yield(l.Uf(g),8);case 8:k=h.next();ha.A(7);break;case 4:if(null==(n=a.i)||!n.Yf(b.input,b.Ma)){ha.A(11);
break}return ha.yield(a.i.Rf(b.input,b.Ma),12);case 12:return p=ha.i,S("kevlar_process_local_innertube_responses_killswitch")||pu(a,p,b),ha.return(p);case 11:return(x=null==(r=b.config)?void 0:r.Oa)&&a.h.has(x)&&S("web_memoize_inflight_requests")?t=a.h.get(x):(y=JSON.stringify(b.Ma),I=null!=(H=null==(z=b.jb)?void 0:z.headers)?H:{},b.jb=Object.assign({},b.jb,{headers:Object.assign({},I,c)}),L=Object.assign({},b.jb),"POST"===b.jb.method&&(L=Object.assign({},L,{body:y})),(null==(P=b.config)?0:P.He)&&
eu(b.config.He),J=function(){return a.X.fetch(b.input,L,b.config)},t=J(),x&&a.h.set(x,t)),ha.yield(t,13);
case 13:if((V=ha.i)&&"error"in V&&(null==(Z=V)?0:null==(ca=Z.error)?0:ca.details))for(ra=V.error.details,ma=v(ra),Ha=ma.next();!Ha.done;Ha=ma.next())Fg=Ha.value,(sq=Fg["@type"])&&-1<iu.indexOf(sq)&&(delete Fg["@type"],V=Fg);x&&a.h.has(x)&&a.h.delete(x);(null==(tq=b.config)?0:tq.Ie)&&eu(b.config.Ie);if(V||null==(uq=a.i)||!uq.Jf(b.input,b.Ma)){ha.A(14);break}return ha.yield(a.i.Qf(b.input,b.Ma),15);case 15:V=ha.i;case 14:return pu(a,V,b),ha.return(V||void 0)}})}
function nu(a,b){var c,d,e,f;return A(function(g){if(1==g.h){e=null==(c=a)?void 0:null==(d=c.Xb)?void 0:d.sessionIndex;var h=g.yield;var k=pe(Pl(0,{sessionIndex:e}));return h.call(g,k,2)}f=g.i;return g.return(Promise.resolve(Object.assign({},mu(b),f)))})}
function mu(a){var b={"Content-Type":"application/json"};R("EOM_VISITOR_DATA")?b["X-Goog-EOM-Visitor-Id"]=R("EOM_VISITOR_DATA"):R("VISITOR_DATA")&&(b["X-Goog-Visitor-Id"]=R("VISITOR_DATA"));b["X-Youtube-Bootstrap-Logged-In"]=R("LOGGED_IN",!1);"cors"!==a&&((a=R("INNERTUBE_CONTEXT_CLIENT_NAME"))&&(b["X-Youtube-Client-Name"]=a),(a=R("INNERTUBE_CONTEXT_CLIENT_VERSION"))&&(b["X-Youtube-Client-Version"]=a),(a=R("CHROME_CONNECTED_HEADER"))&&(b["X-Youtube-Chrome-Connected"]=a),(a=R("DOMAIN_ADMIN_STATE"))&&
(b["X-Youtube-Domain-Admin-State"]=a));return b}
;var qu=new Bq("INNERTUBE_TRANSPORT_TOKEN");var ru=["share/get_web_player_share_panel"],su=["feedback"],tu=["notification/modify_channel_preference"],uu=["browse/edit_playlist"],vu=["subscription/subscribe"],wu=["subscription/unsubscribe"];function xu(){}
w(xu,Ws);xu.prototype.j=function(){return vu};
xu.prototype.h=function(a){return U(a,Fk)||void 0};
xu.prototype.i=function(a,b,c){c=void 0===c?{}:c;b.channelIds&&(a.channelIds=b.channelIds);b.siloName&&(a.siloName=b.siloName);b.params&&(a.params=b.params);c.botguardResponse&&(a.botguardResponse=c.botguardResponse);c.feature&&(a.clientFeature=c.feature)};
ea.Object.defineProperties(xu.prototype,{l:{configurable:!0,enumerable:!0,get:function(){return!0}}});function yu(){}
w(yu,Ws);yu.prototype.j=function(){return wu};
yu.prototype.h=function(a){return U(a,Ek)||void 0};
yu.prototype.i=function(a,b){b.channelIds&&(a.channelIds=b.channelIds);b.siloName&&(a.siloName=b.siloName);b.params&&(a.params=b.params)};
ea.Object.defineProperties(yu.prototype,{l:{configurable:!0,enumerable:!0,get:function(){return!0}}});function zu(){}
w(zu,Ws);zu.prototype.j=function(){return su};
zu.prototype.h=function(a){return U(a,zk)||void 0};
zu.prototype.i=function(a,b,c){a.feedbackTokens=[];b.feedbackToken&&a.feedbackTokens.push(b.feedbackToken);if(b=b.cpn||c.cpn)a.feedbackContext={cpn:b};a.isFeedbackTokenUnencrypted=!!c.is_feedback_token_unencrypted;a.shouldMerge=!1;c.extra_feedback_tokens&&(a.shouldMerge=!0,a.feedbackTokens=a.feedbackTokens.concat(c.extra_feedback_tokens))};
ea.Object.defineProperties(zu.prototype,{l:{configurable:!0,enumerable:!0,get:function(){return!0}}});function Au(){}
w(Au,Ws);Au.prototype.j=function(){return tu};
Au.prototype.h=function(a){return U(a,Dk)||void 0};
Au.prototype.i=function(a,b){b.params&&(a.params=b.params);b.secondaryParams&&(a.secondaryParams=b.secondaryParams)};function Bu(){}
w(Bu,Ws);Bu.prototype.j=function(){return uu};
Bu.prototype.h=function(a){return U(a,Ck)||void 0};
Bu.prototype.i=function(a,b){b.actions&&(a.actions=b.actions);b.params&&(a.params=b.params);b.playlistId&&(a.playlistId=b.playlistId)};function Cu(){}
w(Cu,Ws);Cu.prototype.j=function(){return ru};
Cu.prototype.h=function(a){return U(a,Bk)};
Cu.prototype.i=function(a,b,c){c=void 0===c?{}:c;b.serializedShareEntity&&(a.serializedSharedEntity=b.serializedShareEntity);c.includeListId&&(a.includeListId=!0)};var Du=new Bq("NETWORK_SLI_TOKEN");function Eu(a){this.h=a}
Eu.prototype.fetch=function(a,b){var c=this,d,e,f;return A(function(g){c.h&&(d=pc(qc(5,Ec(a,"key")))||"/UNKNOWN_PATH",c.h.start(d));e=b;S("wug_networking_gzip_request")&&(e=So(b));f=new window.Request(a,e);return S("web_fetch_promise_cleanup_killswitch")?g.return(Promise.resolve(fetch(f).then(function(h){return c.handleResponse(h)}).catch(function(h){Pr(h)}))):g.return(fetch(f).then(function(h){return c.handleResponse(h)}).catch(function(h){Pr(h)}))})};
Eu.prototype.handleResponse=function(a){var b=a.text().then(function(c){return JSON.parse(c.replace(")]}'",""))});
a.redirected||a.ok?this.h&&this.h.success():(this.h&&this.h.Mf(),b=b.then(function(c){Pr(new jm("Error: API fetch failed",a.status,a.url,c));return Object.assign({},c,{errorMetadata:{status:a.status}})}));
return b};
Eu[Aq]=[new Cq(Du)];var Fu=new Bq("NETWORK_MANAGER_TOKEN");var Gu;function Hu(){var a=Iu,b=Ju,c=Ku;this.l=Lu;this.navigate=a;this.i=b;this.j=c;this.h=new Set}
function Mu(a,b,c){if(Nu(b))Ou(a,b,c);else{var d=a.l(b,c);if(null==c?0:c.vc)d.vc=c.vc;0===d.type?a.navigate?Pu(d.command)?Qu(a,d.command)||(S("logging_avoid_blocking_during_navigation")&&Xq().transition("application_navigating"),b=a.navigate(d)||[],te(b).then(function(){a.h.delete(d.command)})):Or(Error("Error: Command handler page requests need to specify a url.")):Or(Error("Error: Command handler navigate function was called but not set.")):1===d.type?a.i?Qu(a,d.command)||(b=a.i(d),te(b).then(function(){a.h.delete(d.command)})):
Or(Error("Error: Command handler handle service request function was called but not set.")):2===d.type&&(a.j?a.j(d):Or(Error("Error: Command handler send action was called but not set.")))}}
function Qu(a,b){if(a.h.has(b))return!0;a.h.add(b);return!1}
function Nu(a){var b=!!U(a,sk),c;a="CLIENT_SIGNAL"===(null==(c=U(a,xk))?void 0:c.signal);return b||a}
function Ou(a,b,c){var d=U(b,sk);if(d)var e=(null==d?void 0:d.commands)||[];else{var f;if("CLIENT_SIGNAL"===(null==(f=U(b,xk))?void 0:f.signal)){var g;e=(null==(g=U(b,xk))?void 0:g.actions)||[]}}if(e)for(b=v(e),e=b.next();!e.done;e=b.next()){e=e.value;try{Mu(a,e,c)}catch(h){h instanceof Error&&Or(h)}}else Or(Error("Could not handle the meta command."))}
function Pu(a){var b;return!(null==(b=U(null==a?void 0:a.commandMetadata,wk))||!b.url)}
;function Ru(){var a,b,c;return A(function(d){if(1==d.h)return a=Hq().resolve(qu),a?d.yield(lu(a),2):(Pr(Error("InnertubeTransportService unavailable in fetchDatasyncIds")),d.return(void 0));if(b=d.i){if(b.errorMetadata)return Pr(Error("Datasync IDs fetch responded with "+b.errorMetadata.status+": "+b.error)),d.return(void 0);c=b.Kf;return d.return(c)}Pr(Error("Network request to get Datasync IDs failed."));return d.return(void 0)})}
;var Su=C.caches,Tu;function Uu(a){var b=a.indexOf(":");return-1===b?{vd:a}:{vd:a.substring(0,b),datasyncId:a.substring(b+1)}}
function Vu(){return A(function(a){if(void 0!==Tu)return a.return(Tu);Tu=new Promise(function(b){var c;return A(function(d){switch(d.h){case 1:return ya(d,2),d.yield(Su.open("test-only"),4);case 4:return d.yield(Su.delete("test-only"),5);case 5:d.h=3;d.l=0;break;case 2:if(c=za(d),c instanceof Error&&"SecurityError"===c.name)return b(!1),d.return();case 3:b("caches"in window),d.h=0}})});
return a.return(Tu)})}
function Wu(a){var b,c,d,e,f,g,h;A(function(k){if(1==k.h)return k.yield(Vu(),2);if(3!=k.h){if(!k.i)return k.return(!1);b=[];return k.yield(Su.keys(),3)}c=k.i;d=v(c);for(e=d.next();!e.done;e=d.next())f=e.value,g=Uu(f),h=g.datasyncId,!h||a.includes(h)||b.push(Su.delete(f));return k.return(Promise.all(b).then(function(l){return l.some(function(n){return n})}))})}
function Xu(){var a,b,c,d,e,f,g;return A(function(h){if(1==h.h)return h.yield(Vu(),2);if(3!=h.h){if(!h.i)return h.return(!1);a=lm("cache contains other");return h.yield(Su.keys(),3)}b=h.i;c=v(b);for(d=c.next();!d.done;d=c.next())if(e=d.value,f=Uu(e),(g=f.datasyncId)&&g!==a)return h.return(!0);return h.return(!1)})}
;function Yu(){Ru().then(function(a){a&&(Rn(a),Wu(a),dt(a))})}
function Zu(){var a=new Kp;oi.ka(function(){var b,c,d,e;return A(function(f){switch(f.h){case 1:if(S("ytidb_clear_optimizations_killswitch")){f.A(2);break}b=lm("clear");if(b.startsWith("V")&&b.endsWith("||")){var g=[b];Rn(g);Wu(g);dt(g);return f.return()}c=et();return f.yield(Xu(),3);case 3:return d=f.i,f.yield(Sn(),4);case 4:if(e=f.i,!c&&!d&&!e)return f.return();case 2:a.qa()?Yu():a.l.add("publicytnetworkstatus-online",Yu,!0,void 0,void 0),f.h=0}})})}
;var Th=ia(["data-"]);function $u(a){a&&(a.dataset?a.dataset[av("loaded")]="true":Sh(a))}
function bv(a,b){return a?a.dataset?a.dataset[av(b)]:a.getAttribute("data-"+b):null}
var cv={};function av(a){return cv[a]||(cv[a]=String(a).replace(/\-([a-z])/g,function(b,c){return c.toUpperCase()}))}
;var dv=/\.vflset|-vfl[a-zA-Z0-9_+=-]+/,ev=/-[a-zA-Z]{2,3}_[a-zA-Z]{2,3}(?=(\/|$))/;function fv(a,b,c){c=void 0===c?null:c;if(window.spf&&spf.script){c="";if(a){var d=a.indexOf("jsbin/"),e=a.lastIndexOf(".js"),f=d+6;-1<d&&-1<e&&e>f&&(c=a.substring(f,e),c=c.replace(dv,""),c=c.replace(ev,""),c=c.replace("debug-",""),c=c.replace("tracing-",""))}spf.script.load(a,c,b)}else gv(a,b,c)}
function gv(a,b,c){c=void 0===c?null:c;var d=hv(a),e=document.getElementById(d),f=e&&bv(e,"loaded"),g=e&&!f;f?b&&b():(b&&(f=rq(d,b),b=""+Oa(b),iv[b]=f),g||(e=jv(a,d,function(){if(!bv(e,"loaded")){$u(e);xq(d);var h=Ua(yq,d);ml(h,0)}},c)))}
function jv(a,b,c,d){d=void 0===d?null:d;var e=Xd("SCRIPT");e.id=b;e.onload=function(){c&&setTimeout(c,0)};
e.onreadystatechange=function(){switch(e.readyState){case "loaded":case "complete":e.onload()}};
d&&e.setAttribute("nonce",d);Wh(e,ok(a));a=document.getElementsByTagName("head")[0]||document.body;a.insertBefore(e,a.firstChild);return e}
function kv(a){a=hv(a);var b=document.getElementById(a);b&&(yq(a),b.parentNode.removeChild(b))}
function lv(a,b){a&&b&&(a=""+Oa(b),(a=iv[a])&&wq(a))}
function hv(a){var b=document.createElement("a");ic(b,a);a=b.href.replace(/^[a-zA-Z]+:\/\//,"//");return"js-"+nc(a)}
var iv={};var mv=[],nv=!1;function ov(){if(!S("disable_biscotti_fetch_for_ad_blocker_detection")&&!S("disable_biscotti_fetch_entirely_for_all_web_clients")&&vs()){var a=R("PLAYER_VARS",{});if("1"!=nb(a)&&!ws(a)){var b=function(){nv=!0;"google_ad_status"in window?Ok("DCLKSTAT",1):Ok("DCLKSTAT",2)};
try{fv("//static.doubleclick.net/instream/ad_status.js",b)}catch(c){}mv.push(oi.ka(function(){if(!(nv||"google_ad_status"in window)){try{lv("//static.doubleclick.net/instream/ad_status.js",b)}catch(c){}nv=!0;Ok("DCLKSTAT",3)}},5E3))}}}
function pv(){var a=Number(R("DCLKSTAT",0));return isNaN(a)?0:a}
;function qv(a){Pq.call(this,void 0===a?"document_active":a);var b=this;this.l=10;this.h=new Map;this.transitions=[{from:"document_active",to:"document_disposed_preventable",action:this.fa},{from:"document_active",to:"document_disposed",action:this.m},{from:"document_disposed_preventable",to:"document_disposed",action:this.m},{from:"document_disposed_preventable",to:"flush_logs",action:this.s},{from:"document_disposed_preventable",to:"document_active",action:this.i},{from:"document_disposed",to:"flush_logs",
action:this.s},{from:"document_disposed",to:"document_active",action:this.i},{from:"document_disposed",to:"document_disposed",action:function(){}},
{from:"flush_logs",to:"document_active",action:this.i}];window.addEventListener("pagehide",function(c){b.transition("document_disposed",{event:c})});
window.addEventListener("beforeunload",function(c){b.transition("document_disposed_preventable",{event:c})})}
w(qv,Pq);qv.prototype.fa=function(a,b){if(!this.h.get("document_disposed_preventable")){a(null==b?void 0:b.event);var c,d;if((null==b?0:null==(c=b.event)?0:c.defaultPrevented)||(null==b?0:null==(d=b.event)?0:d.returnValue)){b.event.returnValue||(b.event.returnValue=!0);b.event.defaultPrevented||b.event.preventDefault();this.h=new Map;this.transition("document_active");return}}this.h.set("document_disposed_preventable",!0);this.h.get("document_disposed")?this.transition("flush_logs"):this.transition("document_disposed")};
qv.prototype.m=function(a,b){this.h.get("document_disposed")?this.transition("document_active"):(a(null==b?void 0:b.event),this.h.set("document_disposed",!0),this.transition("flush_logs"))};
qv.prototype.s=function(a,b){a(null==b?void 0:b.event);this.transition("document_active")};
qv.prototype.i=function(){this.h=new Map};function rv(a){Pq.call(this,void 0===a?"document_visibility_unknown":a);var b=this;this.transitions=[{from:"document_visibility_unknown",to:"document_visible",action:this.i},{from:"document_visibility_unknown",to:"document_hidden",action:this.h},{from:"document_visibility_unknown",to:"document_foregrounded",action:this.s},{from:"document_visibility_unknown",to:"document_backgrounded",action:this.m},{from:"document_visible",to:"document_hidden",action:this.h},{from:"document_visible",to:"document_foregrounded",
action:this.s},{from:"document_visible",to:"document_visible",action:this.i},{from:"document_foregrounded",to:"document_visible",action:this.i},{from:"document_foregrounded",to:"document_hidden",action:this.h},{from:"document_foregrounded",to:"document_foregrounded",action:this.s},{from:"document_hidden",to:"document_visible",action:this.i},{from:"document_hidden",to:"document_backgrounded",action:this.m},{from:"document_hidden",to:"document_hidden",action:this.h},{from:"document_backgrounded",to:"document_hidden",
action:this.h},{from:"document_backgrounded",to:"document_backgrounded",action:this.m},{from:"document_backgrounded",to:"document_visible",action:this.i}];document.addEventListener("visibilitychange",function(c){"visible"===document.visibilityState?b.transition("document_visible",{event:c}):b.transition("document_hidden",{event:c})});
S("visibility_lifecycles_dynamic_backgrounding")&&(window.addEventListener("blur",function(c){b.transition("document_backgrounded",{event:c})}),window.addEventListener("focus",function(c){b.transition("document_foregrounded",{event:c})}))}
w(rv,Pq);rv.prototype.i=function(a,b){a(null==b?void 0:b.event);S("visibility_lifecycles_dynamic_backgrounding")&&this.transition("document_foregrounded")};
rv.prototype.h=function(a,b){a(null==b?void 0:b.event);S("visibility_lifecycles_dynamic_backgrounding")&&this.transition("document_backgrounded")};
rv.prototype.m=function(a,b){a(null==b?void 0:b.event)};
rv.prototype.s=function(a,b){a(null==b?void 0:b.event)};function sv(){this.l=new qv;this.m=new rv}
sv.prototype.install=function(){var a=B.apply(0,arguments),b=this;a.forEach(function(c){b.l.install(c)});
a.forEach(function(c){b.m.install(c)})};function tv(a){uo.call(this,1,arguments);this.csn=a}
w(tv,uo);var Do=new vo("screen-created",tv),uv=[],vv=0;function wv(a,b,c,d){var e=d.filter(function(h){h.csn!==b?(h.csn=b,h=!0):h=!1;return h}),f={cttAuthInfo:js(b)||void 0,
sequenceGroup:b};d=v(d);for(var g=d.next();!g.done;g=d.next())g=g.value.getAsJson(),(lb(g)||!g.trackingParams&&!g.veType)&&Pr(Error("Child VE logged with no data"));c={csn:b,parentVe:c.getAsJson(),childVes:db(e,function(h){return h.getAsJson()})};
"UNDEFINED_CSN"===b?xv("visualElementAttached",f,c):a?Hr("visualElementAttached",c,a,f):Cm("visualElementAttached",c,f)}
function xv(a,b,c){uv.push({payloadName:a,payload:c,Pf:void 0,options:b});vv||(vv=Eo())}
function Fo(a){if(uv){for(var b=v(uv),c=b.next();!c.done;c=b.next())c=c.value,c.payload&&(c.payload.csn=a.csn,Cm(c.payloadName,c.payload,c.options));uv.length=0}vv=0}
;function yv(){this.l=[];this.i=new Map;this.h=new Map;this.j=new Set}
yv.prototype.clickCommand=function(a,b,c){var d=a.clickTrackingParams;c=void 0===c?0:c;if(d)if(c=hs(void 0===c?0:c)){a=this.client;var e=new Zr({trackingParams:d});d={cttAuthInfo:js(c)||void 0,sequenceGroup:c};e={csn:c,ve:e.getAsJson(),gestureType:"INTERACTION_LOGGING_GESTURE_TYPE_GENERIC_CLICK"};b&&(e.clientData=b);"UNDEFINED_CSN"===c?xv("visualElementGestured",d,e):a?Hr("visualElementGestured",e,a,d):Cm("visualElementGestured",e,d);b=!0}else b=!1;else b=!1;return b};
yv.prototype.visualElementStateChanged=function(a,b,c){c=void 0===c?0:c;if(0===c&&this.j.has(c))this.l.push([a,b]);else{var d=c;d=void 0===d?0:d;c=hs(d);a||(a=(a=ds(void 0===d?0:d))?new Zr({veType:a,youtubeData:void 0,jspbYoutubeData:void 0}):null);var e=a;c&&e&&(a=this.client,d={cttAuthInfo:js(c)||void 0,sequenceGroup:c},b={csn:c,ve:e.getAsJson(),clientData:b},"UNDEFINED_CSN"===c?xv("visualElementStateChanged",d,b):a?Hr("visualElementStateChanged",b,a,d):Cm("visualElementStateChanged",b,d))}};
function zv(a,b){if(void 0===b)for(var c=gs(),d=0;d<c.length;d++)void 0!==c[d]&&zv(a,c[d]);else a.i.forEach(function(e,f){(f=a.h.get(f))&&wv(a.client,b,f,e)}),a.i.clear(),a.h.clear(),a.m=void 0}
;function Av(){sv.call(this);var a={};this.install((a.document_disposed={callback:this.h},a));S("combine_ve_grafts")&&(a={},this.install((a.document_disposed={callback:this.i},a)));a={};this.install((a.flush_logs={callback:this.j},a))}
w(Av,sv);Av.prototype.j=function(){Cm("finalPayload",{csn:hs()})};
Av.prototype.h=function(){Tr(Ur)};
Av.prototype.i=function(){var a=zv;yv.h||(yv.h=new yv);a(yv.h)};function Bv(){}
function Cv(){var a=E("ytglobal.storage_");a||(a=new Bv,D("ytglobal.storage_",a));return a}
Bv.prototype.estimate=function(){var a,b,c;return A(function(d){a=navigator;return(null==(b=a.storage)?0:b.estimate)?d.return(a.storage.estimate()):(null==(c=a.webkitTemporaryStorage)?0:c.queryUsageAndQuota)?d.return(Dv()):d.return()})};
function Dv(){var a=navigator;return new Promise(function(b,c){var d;null!=(d=a.webkitTemporaryStorage)&&d.queryUsageAndQuota?a.webkitTemporaryStorage.queryUsageAndQuota(function(e,f){b({usage:e,quota:f})},function(e){c(e)}):c(Error("webkitTemporaryStorage is not supported."))})}
D("ytglobal.storageClass_",Bv);function Am(a,b){var c=this;this.handleError=a;this.h=b;this.i=!1;void 0===self.document||self.addEventListener("beforeunload",function(){c.i=!0});
this.j=Math.random()<=hl("ytidb_transaction_ended_event_rate_limit_session",.2)}
Am.prototype.logEvent=function(a,b){switch(a){case "IDB_DATA_CORRUPTED":S("idb_data_corrupted_killswitch")||this.h("idbDataCorrupted",b);break;case "IDB_UNEXPECTEDLY_CLOSED":this.h("idbUnexpectedlyClosed",b);break;case "IS_SUPPORTED_COMPLETED":S("idb_is_supported_completed_killswitch")||this.h("idbIsSupportedCompleted",b);break;case "QUOTA_EXCEEDED":Ev(this,b);break;case "TRANSACTION_ENDED":this.j&&Math.random()<=hl("ytidb_transaction_ended_event_rate_limit_transaction",.1)&&this.h("idbTransactionEnded",
b);break;case "TRANSACTION_UNEXPECTEDLY_ABORTED":a=Object.assign({},b,{hasWindowUnloaded:this.i}),this.h("idbTransactionAborted",a)}};
function Ev(a,b){Cv().estimate().then(function(c){c=Object.assign({},b,{isSw:void 0===self.document,isIframe:self!==self.top,deviceStorageUsageMbytes:Fv(null==c?void 0:c.usage),deviceStorageQuotaMbytes:Fv(null==c?void 0:c.quota)});a.h("idbQuotaExceeded",c)})}
function Fv(a){return"undefined"===typeof a?"-1":String(Math.ceil(a/1048576))}
;function Gv(a){this.args=void 0===a?null:a;this.returnValue=[]}
;var Hv=new Map;function Iv(a,b){if(!a)return null;a=Object.keys(a);a=v(a);for(var c=a.next();!c.done;c=a.next()){c=c.value;var d=c.toLowerCase();if(-1<d.indexOf(b,d.length-b.length))return c}return null}
;function Jv(a,b,c){var d;d||(d={bubbles:!0,cancelable:!1,composed:!0});null!==c&&void 0!==c&&(d.detail=c);b=new CustomEvent(b,d);a.dispatchEvent(b)}
;function Kv(a,b){b=new Gv(b);Jv(a,"yt-action",b);return b.returnValue}
function Lv(a,b,c,d){b&&b.length&&b.forEach(function(e){var f=Iv(e,"action")||Iv(e,"command")||Iv(e,"endpoint");if(f){var g="yt"+f;var h=Hv.get(g);h?g=h:(f="yt-"+f.replace(/([A-Z])/g,"-$1").toLowerCase(),Hv.set(g,f),g=f);U(e,vk)&&(g+="-"+U(e,vk).signal.toLowerCase().replace(/_/g,"-"))}else g=null;g&&(S("handle_service_request_actions")&&e.commandMetadata&&e.commandMetadata.webCommandMetadata&&e.commandMetadata.webCommandMetadata.sendPost?Mv(c?c:a,[e]):Kv(a,[e,c,d]))})}
function Mv(a,b){var c=[a];b&&c.push.apply(c,b);b=Kv(a,c);return 0<b.length&&(b=b[0],Jv(a,"yt-service-request-sent",b),b&&b.ajaxPromise)?(b.ajaxPromise.then(function(d){Jv(a,"yt-service-request-completed",d)},function(d){Jv(a,"yt-service-request-error",{error:d,
params:c})},a),b.ajaxPromise):pe()}
;function Lu(a,b,c){b=void 0===b?{}:b;var d,e=null==(d=U(a.commandMetadata,wk))?void 0:d.url;d=b.form||{};!c||d.element||d.skipDefaultElement||(b.form=b.form||{},b.form.element=c);if(e&&"/service_ajax"!==e)return{type:0,command:a,form:b.form};if(S("kevlar_service_command_check")){if(c=Hq().resolve(qu),Qs(a,c.j))return Object.assign({},{type:1,command:a},b)}else{var f;if(null==(f=U(a.commandMetadata,wk))?0:f.apiUrl)return Object.assign({},{type:1,command:a},b)}return{type:2,command:a,form:b.form}}
function Ju(a){if(a.form){var b=a.form,c=Object.assign({},b);b=b.element;c=(delete c.element,c);if(b)return[Mv(b,[a.command,c,a.vc])]}return[]}
function Ku(a){if(a.form){var b=a.form,c=Object.assign({},b);b=b.element;c=(delete c.element,c);b&&Lv(b,[a.command],b,c)}}
;function Nv(a,b,c){G.call(this);var d=this;c=c||R("POST_MESSAGE_ORIGIN")||window.document.location.protocol+"//"+window.document.location.hostname;this.j=b||null;this.targetOrigin="*";this.l=c;this.sessionId=null;this.channel="widget";this.P=!!a;this.v=function(e){a:if(!("*"!=d.l&&e.origin!=d.l||d.j&&e.source!=d.j||"string"!==typeof e.data)){try{var f=JSON.parse(e.data)}catch(g){break a}if(!(null==f||d.P&&(d.sessionId&&d.sessionId!=f.id||d.channel&&d.channel!=f.channel))&&f)switch(f.event){case "listening":"null"!=
e.origin&&(d.l=d.targetOrigin=e.origin);d.j=e.source;d.sessionId=f.id;d.i&&(d.i(),d.i=null);break;case "command":d.m&&(!d.s||0<=ab(d.s,f.func))&&d.m(f.func,f.args,e.origin)}}};
this.s=this.i=this.m=null;window.addEventListener("message",this.v)}
w(Nv,G);Nv.prototype.sendMessage=function(a,b){if(b=b||this.j){this.sessionId&&(a.id=this.sessionId);this.channel&&(a.channel=this.channel);try{var c=JSON.stringify(a);b.postMessage(c,this.targetOrigin)}catch(d){Uk(d)}}};
Nv.prototype.M=function(){window.removeEventListener("message",this.v);G.prototype.M.call(this)};function Ov(){this.i=[];this.isReady=!1;this.j={};var a=this.h=new Nv(!!R("WIDGET_ID_ENFORCE")),b=this.Ee.bind(this);a.m=b;a.s=null;this.h.channel="widget";if(a=R("WIDGET_ID"))this.h.sessionId=a}
m=Ov.prototype;m.Ee=function(a,b,c){"addEventListener"===a&&b?this.Gc(b[0],c):this.Wc(a,b,c)};
m.Wc=function(){};
m.Ac=function(a){var b=this;return function(c){return b.sendMessage(a,c)}};
m.Gc=function(a,b){this.j[a]||"onReady"===a||(this.addEventListener(a,this.Ac(a,b)),this.j[a]=!0)};
m.addEventListener=function(){};
m.he=function(){this.isReady=!0;this.sendMessage("initialDelivery",this.Dc());this.sendMessage("onReady");bb(this.i,this.Cd,this);this.i=[]};
m.Dc=function(){return null};
function Pv(a,b){a.sendMessage("infoDelivery",b)}
m.Cd=function(a){this.isReady?this.h.sendMessage(a):this.i.push(a)};
m.sendMessage=function(a,b){this.Cd({event:a,info:void 0===b?null:b})};
m.dispose=function(){this.h=null};var Qv={},Rv=(Qv["api.invalidparam"]=2,Qv.auth=150,Qv["drm.auth"]=150,Qv["heartbeat.net"]=150,Qv["heartbeat.servererror"]=150,Qv["heartbeat.stop"]=150,Qv["html5.unsupportedads"]=5,Qv["fmt.noneavailable"]=5,Qv["fmt.decode"]=5,Qv["fmt.unplayable"]=5,Qv["html5.missingapi"]=5,Qv["html5.unsupportedlive"]=5,Qv["drm.unavailable"]=5,Qv["mrm.blocked"]=151,Qv);var Sv=new Set("endSeconds startSeconds mediaContentUrl suggestedQuality videoId rct rctn".split(" "));function Tv(a){return(0===a.search("cue")||0===a.search("load"))&&"loadModule"!==a}
function Uv(a,b,c){if("string"===typeof a)return{videoId:a,startSeconds:b,suggestedQuality:c};b={};c=v(Sv);for(var d=c.next();!d.done;d=c.next())d=d.value,a[d]&&(b[d]=a[d]);return b}
function Vv(a,b,c,d){if(Na(a)&&!Array.isArray(a)){b="playlist list listType index startSeconds suggestedQuality".split(" ");c={};for(d=0;d<b.length;d++){var e=b[d];a[e]&&(c[e]=a[e])}return c}b={index:b,startSeconds:c,suggestedQuality:d};"string"===typeof a&&16===a.length?b.list="PL"+a:b.playlist=a;return b}
;function Wv(a){Ov.call(this);this.listeners=[];this.l=!1;this.api=a;this.addEventListener("onReady",this.onReady.bind(this));this.addEventListener("onVideoProgress",this.Qe.bind(this));this.addEventListener("onVolumeChange",this.Re.bind(this));this.addEventListener("onApiChange",this.Le.bind(this));this.addEventListener("onPlaybackQualityChange",this.Ne.bind(this));this.addEventListener("onPlaybackRateChange",this.Oe.bind(this));this.addEventListener("onStateChange",this.Pe.bind(this));this.addEventListener("onWebglSettingsChanged",
this.Se.bind(this))}
w(Wv,Ov);m=Wv.prototype;
m.Wc=function(a,b,c){if(this.api.isExternalMethodAvailable(a,c)){b=b||[];if(0<b.length&&Tv(a)){var d=b;if(Na(d[0])&&!Array.isArray(d[0]))var e=d[0];else switch(e={},a){case "loadVideoById":case "cueVideoById":e=Uv(d[0],void 0!==d[1]?Number(d[1]):void 0,d[2]);break;case "loadVideoByUrl":case "cueVideoByUrl":e=d[0];"string"===typeof e&&(e={mediaContentUrl:e,startSeconds:void 0!==d[1]?Number(d[1]):void 0,suggestedQuality:d[2]});b:{if((d=e.mediaContentUrl)&&(d=/\/([ve]|embed)\/([^#?]+)/.exec(d))&&d[2]){d=
d[2];break b}d=null}e.videoId=d;e=Uv(e);break;case "loadPlaylist":case "cuePlaylist":e=Vv(d[0],d[1],d[2],d[3])}b.length=1;b[0]=e}this.api.handleExternalCall(a,b,c);Tv(a)&&Pv(this,this.Dc())}};
m.Gc=function(a,b){"onReady"===a?this.api.logApiCall(a+" invocation",b):"onError"===a&&this.l&&(this.api.logApiCall(a+" invocation",b,this.errorCode),this.errorCode=void 0);this.api.logApiCall(a+" registration",b);Ov.prototype.Gc.call(this,a,b)};
m.Ac=function(a,b){var c=this,d=Ov.prototype.Ac.call(this,a,b);return function(e){"onError"===a?c.api.logApiCall(a+" invocation",b,e):c.api.logApiCall(a+" invocation",b);d(e)}};
m.onReady=function(){var a=this.he.bind(this);this.h.i=a;a=this.api.getVideoData();if(!a.isPlayable){this.l=!0;a=a.errorCode;var b=void 0===b?5:b;this.errorCode=a?Rv[a]||b:b;this.sendMessage("onError",this.errorCode.toString())}};
m.addEventListener=function(a,b){this.listeners.push({eventType:a,listener:b});this.api.addEventListener(a,b)};
m.Dc=function(){if(!this.api)return null;var a=this.api.getApiInterface();gb(a,"getVideoData");for(var b={apiInterface:a},c=0,d=a.length;c<d;c++){var e=a[c];if(0===e.search("get")||0===e.search("is")){var f=0;0===e.search("get")?f=3:0===e.search("is")&&(f=2);f=e.charAt(f).toLowerCase()+e.substr(f+1);try{var g=this.api[e]();b[f]=g}catch(h){}}}b.videoData=this.api.getVideoData();b.currentTimeLastUpdated_=Date.now()/1E3;return b};
m.Pe=function(a){a={playerState:a,currentTime:this.api.getCurrentTime(),duration:this.api.getDuration(),videoData:this.api.getVideoData(),videoStartBytes:0,videoBytesTotal:this.api.getVideoBytesTotal(),videoLoadedFraction:this.api.getVideoLoadedFraction(),playbackQuality:this.api.getPlaybackQuality(),availableQualityLevels:this.api.getAvailableQualityLevels(),currentTimeLastUpdated_:Date.now()/1E3,playbackRate:this.api.getPlaybackRate(),mediaReferenceTime:this.api.getMediaReferenceTime()};this.api.getVideoUrl&&
(a.videoUrl=this.api.getVideoUrl());this.api.getVideoContentRect&&(a.videoContentRect=this.api.getVideoContentRect());this.api.getProgressState&&(a.progressState=this.api.getProgressState());this.api.getPlaylist&&(a.playlist=this.api.getPlaylist());this.api.getPlaylistIndex&&(a.playlistIndex=this.api.getPlaylistIndex());this.api.getStoryboardFormat&&(a.storyboardFormat=this.api.getStoryboardFormat());Pv(this,a)};
m.Ne=function(a){Pv(this,{playbackQuality:a})};
m.Oe=function(a){Pv(this,{playbackRate:a})};
m.Le=function(){for(var a=this.api.getOptions(),b={namespaces:a},c=0,d=a.length;c<d;c++){var e=a[c],f=this.api.getOptions(e);a.join(", ");b[e]={options:f};for(var g=0,h=f.length;g<h;g++){var k=f[g],l=this.api.getOption(e,k);b[e][k]=l}}this.sendMessage("apiInfoDelivery",b)};
m.Re=function(){Pv(this,{muted:this.api.isMuted(),volume:this.api.getVolume()})};
m.Qe=function(a){a={currentTime:a,videoBytesLoaded:this.api.getVideoBytesLoaded(),videoLoadedFraction:this.api.getVideoLoadedFraction(),currentTimeLastUpdated_:Date.now()/1E3,playbackRate:this.api.getPlaybackRate(),mediaReferenceTime:this.api.getMediaReferenceTime()};this.api.getProgressState&&(a.progressState=this.api.getProgressState());Pv(this,a)};
m.Se=function(){var a={sphericalProperties:this.api.getSphericalProperties()};Pv(this,a)};
m.dispose=function(){Ov.prototype.dispose.call(this);for(var a=0;a<this.listeners.length;a++){var b=this.listeners[a];this.api.removeEventListener(b.eventType,b.listener)}this.listeners=[]};function Xv(a){G.call(this);this.i={};this.started=!1;this.connection=a;this.connection.subscribe("command",this.yd,this)}
w(Xv,G);m=Xv.prototype;m.start=function(){this.started||this.h()||(this.started=!0,this.connection.kb("RECEIVING"))};
m.kb=function(a,b){this.started&&!this.h()&&this.connection.kb(a,b)};
m.yd=function(a,b,c){if(this.started&&!this.h()){var d=b||{};switch(a){case "addEventListener":"string"===typeof d.event&&this.addListener(d.event);break;case "removeEventListener":"string"===typeof d.event&&this.removeListener(d.event);break;default:this.api.isReady()&&this.api.isExternalMethodAvailable(a,c||null)&&(b=Yv(a,b||{}),c=this.api.handleExternalCall(a,b,c||null),(c=Zv(a,c))&&this.kb(a,c))}}};
m.addListener=function(a){if(!(a in this.i)){var b=this.Me.bind(this,a);this.i[a]=b;this.addEventListener(a,b)}};
m.Me=function(a,b){this.started&&!this.h()&&this.connection.kb(a,this.Cc(a,b))};
m.Cc=function(a,b){if(null!=b)return{value:b}};
m.removeListener=function(a){a in this.i&&(this.removeEventListener(a,this.i[a]),delete this.i[a])};
m.M=function(){var a=this.connection;a.h()||Li(a.i,"command",this.yd,this);this.connection=null;for(var b in this.i)this.i.hasOwnProperty(b)&&this.removeListener(b);G.prototype.M.call(this)};function $v(a,b){Xv.call(this,b);this.api=a;this.start()}
w($v,Xv);$v.prototype.addEventListener=function(a,b){this.api.addEventListener(a,b)};
$v.prototype.removeEventListener=function(a,b){this.api.removeEventListener(a,b)};
function Yv(a,b){switch(a){case "loadVideoById":return a=Uv(b),[a];case "cueVideoById":return a=Uv(b),[a];case "loadVideoByPlayerVars":return[b];case "cueVideoByPlayerVars":return[b];case "loadPlaylist":return a=Vv(b),[a];case "cuePlaylist":return a=Vv(b),[a];case "seekTo":return[b.seconds,b.allowSeekAhead];case "playVideoAt":return[b.index];case "setVolume":return[b.volume];case "setPlaybackQuality":return[b.suggestedQuality];case "setPlaybackRate":return[b.suggestedRate];case "setLoop":return[b.loopPlaylists];
case "setShuffle":return[b.shufflePlaylist];case "getOptions":return[b.module];case "getOption":return[b.module,b.option];case "setOption":return[b.module,b.option,b.value];case "handleGlobalKeyDown":return[b.keyCode,b.shiftKey,b.ctrlKey,b.altKey,b.metaKey,b.key,b.code]}return[]}
function Zv(a,b){switch(a){case "isMuted":return{muted:b};case "getVolume":return{volume:b};case "getPlaybackRate":return{playbackRate:b};case "getAvailablePlaybackRates":return{availablePlaybackRates:b};case "getVideoLoadedFraction":return{videoLoadedFraction:b};case "getPlayerState":return{playerState:b};case "getCurrentTime":return{currentTime:b};case "getPlaybackQuality":return{playbackQuality:b};case "getAvailableQualityLevels":return{availableQualityLevels:b};case "getDuration":return{duration:b};
case "getVideoUrl":return{videoUrl:b};case "getVideoEmbedCode":return{videoEmbedCode:b};case "getPlaylist":return{playlist:b};case "getPlaylistIndex":return{playlistIndex:b};case "getOptions":return{options:b};case "getOption":return{option:b}}}
$v.prototype.Cc=function(a,b){switch(a){case "onReady":return;case "onStateChange":return{playerState:b};case "onPlaybackQualityChange":return{playbackQuality:b};case "onPlaybackRateChange":return{playbackRate:b};case "onError":return{errorCode:b}}return Xv.prototype.Cc.call(this,a,b)};
$v.prototype.M=function(){Xv.prototype.M.call(this);delete this.api};function aw(a){a=void 0===a?!1:a;G.call(this);this.i=new M(a);Lc(this,this.i)}
Va(aw,G);aw.prototype.subscribe=function(a,b,c){return this.h()?0:this.i.subscribe(a,b,c)};
aw.prototype.m=function(a,b){this.h()||this.i.cb.apply(this.i,arguments)};function bw(a,b,c){aw.call(this);this.l=a;this.j=b;this.id=c}
w(bw,aw);bw.prototype.kb=function(a,b){this.h()||this.l.kb(this.j,this.id,a,b)};
bw.prototype.M=function(){this.j=this.l=null;aw.prototype.M.call(this)};function cw(a,b,c){G.call(this);this.i=a;this.origin=c;this.j=eq(window,"message",this.l.bind(this));this.connection=new bw(this,a,b);Lc(this,this.connection)}
w(cw,G);cw.prototype.kb=function(a,b,c,d){this.h()||a!==this.i||(a={id:b,command:c},d&&(a.data=d),this.i.postMessage(JSON.stringify(a),this.origin))};
cw.prototype.l=function(a){if(!this.h()&&a.origin===this.origin){var b=a.data;if("string"===typeof b){try{b=JSON.parse(b)}catch(d){return}if(b.command){var c=this.connection;c.h()||c.m("command",b.command,b.data,a.origin)}}}};
cw.prototype.M=function(){fq(this.j);this.i=null;G.prototype.M.call(this)};function dw(){this.state=1;this.h=null}
m=dw.prototype;m.initialize=function(a,b,c){if(a.program){var d,e=null!=(d=a.interpreterUrl)?d:null;if(a.interpreterSafeScript){d=a.interpreterSafeScript.privateDoNotAccessOrElseSafeScriptWrappedValue||"";var f=ub();d=f?f.createScript(d):d;d=new zb(d,yb)}else d=null!=(f=a.interpreterScript)?f:null;a.interpreterSafeUrl&&(e=a.interpreterSafeUrl,xb("From proto message. b/166824318"),e=Db(e.privateDoNotAccessOrElseTrustedResourceUrlWrappedValue||"").toString());ew(this,d,e,a.program,b,c)}else Pr(Error("Cannot initialize botguard without program"))};
function ew(a,b,c,d,e,f){var g=void 0===g?"trayride":g;c?(a.state=2,fv(c,function(){window[g]?fw(a,d,g,e):(a.state=3,kv(c),Pr(new jm("Unable to load Botguard","from "+c)))},f)):b?(f=Xd("SCRIPT"),b instanceof zb?(b instanceof zb&&b.constructor===zb?b=b.j:(La(b),b="type_error:SafeScript"),f.textContent=b,Vh(f)):f.textContent=b,f.nonce=lc(),document.head.appendChild(f),document.head.removeChild(f),window[g]?fw(a,d,g,e):(a.state=4,Pr(new jm("Unable to load Botguard from JS")))):Pr(new jm("Unable to load VM; no url or JS provided"))}
function fw(a,b,c,d){a.state=5;try{var e=new Kh({program:b,me:c,Fe:S("att_web_record_metrics")});e.Ue.then(function(){a.state=6;d&&d(b)});
a.Rc(e)}catch(f){a.state=7,f instanceof Error&&Pr(f)}}
m.invoke=function(a){a=void 0===a?{}:a;return this.Uc()?this.Ld({gd:a}):null};
m.dispose=function(){this.Xc()};
m.Xc=function(){this.Rc(null);this.state=8};
m.Uc=function(){return!!this.h};
m.Ld=function(a){return this.h.Fd(a)};
m.Rc=function(a){Jc(this.h);this.h=a};function gw(){var a=E("yt.abuse.playerAttLoader");return a&&["bgvma","bgvmb","bgvmc"].every(function(b){return b in a})?a:null}
;function hw(){dw.apply(this,arguments)}
w(hw,dw);hw.prototype.Xc=function(){this.state=8};
hw.prototype.Rc=function(a){var b;null==(b=gw())||b.bgvma();a?(b={bgvma:a.dispose.bind(a),bgvmb:a.snapshot.bind(a),bgvmc:a.Fd.bind(a)},D("yt.abuse.playerAttLoader",b),D("yt.abuse.playerAttLoaderRun",function(c){return a.snapshot(c)})):(D("yt.abuse.playerAttLoader",null),D("yt.abuse.playerAttLoaderRun",null))};
hw.prototype.Uc=function(){return!!gw()};
hw.prototype.Ld=function(a){return gw().bgvmc(a)};var iw=new hw;function jw(){return iw.Uc()}
function kw(a){a=void 0===a?{}:a;return iw.invoke(a)}
;function lw(a){a=a||{};var b={},c={};this.url=a.url||"";this.args=a.args||pb(b);this.assets=a.assets||{};this.attrs=a.attrs||pb(c);this.fallback=a.fallback||null;this.fallbackMessage=a.fallbackMessage||null;this.html5=!!a.html5;this.disable=a.disable||{};this.loaded=!!a.loaded;this.messages=a.messages||{}}
lw.prototype.clone=function(){var a=new lw,b;for(b in this)if(this.hasOwnProperty(b)){var c=this[b];"object"==La(c)?a[b]=pb(c):a[b]=c}return a};var mw=/cssbin\/(?:debug-)?([a-zA-Z0-9_-]+?)(?:-2x|-web|-rtl|-vfl|.css)/;function nw(a){a=a||"";if(window.spf){var b=a.match(mw);spf.style.load(a,b?b[1]:"",void 0)}else ow(a)}
function ow(a){var b=pw(a),c=document.getElementById(b),d=c&&bv(c,"loaded");d||c&&!d||(c=qw(a,b,function(){if(!bv(c,"loaded")){$u(c);xq(b);var e=Ua(yq,b);ml(e,0)}}))}
function qw(a,b,c){var d=document.createElement("link");d.id=b;d.onload=function(){c&&setTimeout(c,0)};
a=ok(a);jc(d,a);(document.getElementsByTagName("head")[0]||document.body).appendChild(d);return d}
function pw(a){var b=Xd("A");ic(b,new Hb(a,Mb));a=b.href.replace(/^[a-zA-Z]+:\/\//,"//");return"css-"+nc(a)}
;function rw(){G.call(this);this.i=[]}
w(rw,G);rw.prototype.M=function(){for(;this.i.length;){var a=this.i.pop();a.target.removeEventListener(a.name,a.callback,void 0)}G.prototype.M.call(this)};function sw(){rw.apply(this,arguments)}
w(sw,rw);function tw(a,b,c,d,e){G.call(this);var f=this;this.v=b;this.webPlayerContextConfig=d;this.uc=e;this.Ha=!1;this.api={};this.Qa=this.s=null;this.W=new M;this.i={};this.ba=this.wa=this.elementId=this.Kb=this.config=null;this.Z=!1;this.l=this.P=null;this.xa={};this.Qd=["onReady"];this.lastError=null;this.Wb=NaN;this.V={};this.Rd=new sw(this);this.ja=0;this.j=this.m=a;Lc(this,this.W);uw(this);vw(this);Lc(this,this.Rd);c?this.ja=ml(function(){f.loadNewVideoConfig(c)},0):d&&(ww(this),xw(this))}
w(tw,G);m=tw.prototype;m.getId=function(){return this.v};
m.loadNewVideoConfig=function(a){if(!this.h()){this.ja&&(window.clearTimeout(this.ja),this.ja=0);var b=a||{};b instanceof lw||(b=new lw(b));this.config=b;this.setConfig(a);xw(this);this.isReady()&&yw(this)}};
function ww(a){var b;a.webPlayerContextConfig?b=a.webPlayerContextConfig.rootElementId:b=a.config.attrs.id;a.elementId=b||a.elementId;"video-player"===a.elementId&&(a.elementId=a.v,a.webPlayerContextConfig?a.webPlayerContextConfig.rootElementId=a.v:a.config.attrs.id=a.v);var c;(null==(c=a.j)?void 0:c.id)===a.elementId&&(a.elementId+="-player",a.webPlayerContextConfig?a.webPlayerContextConfig.rootElementId=a.elementId:a.config.attrs.id=a.elementId)}
m.setConfig=function(a){this.Kb=a;this.config=zw(a);ww(this);if(!this.wa){var b;this.wa=Aw(this,(null==(b=this.config.args)?void 0:b.jsapicallback)||"onYouTubePlayerReady")}this.config.args?this.config.args.jsapicallback=null:this.config.args={jsapicallback:null};var c;if(null==(c=this.config)?0:c.attrs)a=this.config.attrs,(b=a.width)&&this.j&&(this.j.style.width=fi(Number(b)||b)),(a=a.height)&&this.j&&(this.j.style.height=fi(Number(a)||a))};
function yw(a){if(a.config&&!0!==a.config.loaded)if(a.config.loaded=!0,!a.config.args||"0"!==a.config.args.autoplay&&0!==a.config.args.autoplay&&!1!==a.config.args.autoplay){var b;a.api.loadVideoByPlayerVars(null!=(b=a.config.args)?b:null)}else a.api.cueVideoByPlayerVars(a.config.args)}
function Bw(a){var b=!0,c=Cw(a);c&&a.config&&(a=Dw(a),b=bv(c,"version")===a);return b&&!!E("yt.player.Application.create")}
function xw(a){if(!a.h()&&!a.Z){var b=Bw(a);if(b&&"html5"===(Cw(a)?"html5":null))a.ba="html5",a.isReady()||Ew(a);else if(Fw(a),a.ba="html5",b&&a.l&&a.m)a.m.appendChild(a.l),Ew(a);else{a.config&&(a.config.loaded=!0);var c=!1;a.P=function(){c=!0;var d=Gw(a,"player_bootstrap_method")?E("yt.player.Application.createAlternate")||E("yt.player.Application.create"):E("yt.player.Application.create");var e=a.config?zw(a.config):void 0;d&&d(a.m,e,a.webPlayerContextConfig,a.uc);Ew(a)};
a.Z=!0;b?a.P():(fv(Dw(a),a.P),(b=Hw(a))&&nw(b),Iw(a)&&!c&&D("yt.player.Application.create",null))}}}
function Cw(a){var b=Wd(a.elementId);!b&&a.j&&a.j.querySelector&&(b=a.j.querySelector("#"+a.elementId));return b}
function Ew(a){if(!a.h()){var b=Cw(a),c=!1;b&&b.getApiInterface&&b.getApiInterface()&&(c=!0);if(c){a.Z=!1;if(!Gw(a,"html5_remove_not_servable_check_killswitch")){var d;if((null==b?0:b.isNotServable)&&a.config&&(null==b?0:b.isNotServable(null==(d=a.config.args)?void 0:d.video_id)))return}Jw(a)}else a.Wb=ml(function(){Ew(a)},50)}}
function Jw(a){uw(a);a.Ha=!0;var b=Cw(a);if(b){a.s=Kw(a,b,"addEventListener");a.Qa=Kw(a,b,"removeEventListener");var c=b.getApiInterface();c=c.concat(b.getInternalApiInterface());for(var d=a.api,e=0;e<c.length;e++){var f=c[e];d[f]||(d[f]=Kw(a,b,f))}}for(var g in a.i)a.i.hasOwnProperty(g)&&a.s&&a.s(g,a.i[g]);yw(a);a.wa&&a.wa(a.api);a.W.cb("onReady",a.api)}
function Kw(a,b,c){var d=b[c];return function(){var e=B.apply(0,arguments);try{return a.lastError=null,d.apply(b,e)}catch(f){"sendAbandonmentPing"!==c&&(f.params=c,a.lastError=f,Pr(f))}}}
function uw(a){a.Ha=!1;if(a.Qa)for(var b in a.i)a.i.hasOwnProperty(b)&&a.Qa(b,a.i[b]);for(var c in a.V)a.V.hasOwnProperty(c)&&window.clearTimeout(Number(c));a.V={};a.s=null;a.Qa=null;b=a.api;for(var d in b)b.hasOwnProperty(d)&&(b[d]=null);b.addEventListener=function(e,f){a.addEventListener(e,f)};
b.removeEventListener=function(e,f){a.removeEventListener(e,f)};
b.destroy=function(){a.dispose()};
b.getLastError=function(){return a.getLastError()};
b.getPlayerType=function(){return a.getPlayerType()};
b.getCurrentVideoConfig=function(){return a.Kb};
b.loadNewVideoConfig=function(e){a.loadNewVideoConfig(e)};
b.isReady=function(){return a.isReady()}}
m.isReady=function(){return this.Ha};
function vw(a){a.addEventListener("WATCH_LATER_VIDEO_ADDED",function(b){xq("WATCH_LATER_VIDEO_ADDED",b)});
a.addEventListener("WATCH_LATER_VIDEO_REMOVED",function(b){xq("WATCH_LATER_VIDEO_REMOVED",b)})}
m.addEventListener=function(a,b){var c=this,d=Aw(this,b);d&&(0<=ab(this.Qd,a)||this.i[a]||(b=Lw(this,a),this.s&&this.s(a,b)),this.W.subscribe(a,d),"onReady"===a&&this.isReady()&&ml(function(){d(c.api)},0))};
m.removeEventListener=function(a,b){this.h()||(b=Aw(this,b))&&Li(this.W,a,b)};
function Aw(a,b){var c=b;if("string"===typeof b){if(a.xa[b])return a.xa[b];c=function(){var d=B.apply(0,arguments),e=E(b);if(e)try{e.apply(C,d)}catch(f){Or(f)}};
a.xa[b]=c}return c?c:null}
function Lw(a,b){var c="ytPlayer"+b+a.v;a.i[b]=c;C[c]=function(d){var e=ml(function(){if(!a.h()){try{a.W.cb(b,null!=d?d:void 0)}catch(h){Pr(new jm("PlayerProxy error when creating global callback",{error:h,event:b,playerId:a.v,data:d}))}var f=a.V,g=String(e);g in f&&delete f[g]}},0);
mb(a.V,String(e))};
return c}
m.getPlayerType=function(){return this.ba||(Cw(this)?"html5":null)};
m.getLastError=function(){return this.lastError};
function Fw(a){a.cancel();uw(a);a.ba=null;a.config&&(a.config.loaded=!1);var b=Cw(a);b&&(Bw(a)||!Iw(a)?a.l=b:(b&&b.destroy&&b.destroy(),a.l=null));if(a.m)for(a=a.m;b=a.firstChild;)a.removeChild(b)}
m.cancel=function(){this.P&&lv(Dw(this),this.P);window.clearTimeout(this.Wb);this.Z=!1};
m.M=function(){Fw(this);if(this.l&&this.config&&this.l.destroy)try{this.l.destroy()}catch(b){Or(b)}this.xa=null;for(var a in this.i)this.i.hasOwnProperty(a)&&(C[this.i[a]]=null);this.Kb=this.config=this.api=null;delete this.m;delete this.j;G.prototype.M.call(this)};
function Iw(a){var b,c;a=null==(b=a.config)?void 0:null==(c=b.args)?void 0:c.fflags;return!!a&&-1!==a.indexOf("player_destroy_old_version=true")}
function Dw(a){return a.webPlayerContextConfig?a.webPlayerContextConfig.jsUrl:(a=a.config.assets)?a.js:""}
function Hw(a){return a.webPlayerContextConfig?a.webPlayerContextConfig.cssUrl:(a=a.config.assets)?a.css:""}
function Gw(a,b){if(a.webPlayerContextConfig)var c=a.webPlayerContextConfig.serializedExperimentFlags;else{var d;if(null==(d=a.config)?0:d.args)c=a.config.args.fflags}return"true"===Xk(c||"","&")[b]}
function zw(a){for(var b={},c=v(Object.keys(a)),d=c.next();!d.done;d=c.next()){d=d.value;var e=a[d];b[d]="object"===typeof e?pb(e):e}return b}
;var Mw={},Nw="player_uid_"+(1E9*Math.random()>>>0);function Ow(a,b){var c="player",d=!1;d=void 0===d?!0:d;c="string"===typeof c?Wd(c):c;var e=Nw+"_"+Oa(c),f=Mw[e];if(f&&d)return Pw(a,b)?f.api.loadVideoByPlayerVars(a.args||null):f.loadNewVideoConfig(a),f.api;f=new tw(c,e,a,b,void 0);Mw[e]=f;xq("player-added",f.api);Mc(f,function(){delete Mw[f.getId()]});
return f.api}
function Pw(a,b){return b&&b.serializedExperimentFlags?b.serializedExperimentFlags.includes("web_player_remove_playerproxy=true"):a&&a.args&&a.args.fflags?a.args.fflags.includes("web_player_remove_playerproxy=true"):!1}
;var Qw=null,Rw=null,Sw=null;function Tw(){Uw()}
function Vw(){Uw()}
function Uw(){var a=Qw.getVideoData(1);a=a.title?a.title+" - YouTube":"YouTube";document.title!==a&&(document.title=a)}
function Iu(a){var b,c;if(a=null==(b=a.command)?void 0:null==(c=b.urlEndpoint)?void 0:c.url)b=window,c=Oh(a),void 0!==c&&b.open(c,void 0,void 0);return[]}
function Ww(){Qw&&Qw.sendAbandonmentPing&&Qw.sendAbandonmentPing();R("PL_ATT")&&iw.dispose();for(var a=oi,b=0,c=mv.length;b<c;b++)a.ya(mv[b]);mv.length=0;kv("//static.doubleclick.net/instream/ad_status.js");nv=!1;Ok("DCLKSTAT",0);Kc(Sw,Rw);Qw&&(Qw.removeEventListener("onVideoDataChange",Tw),Qw.destroy())}
;function Xw(a,b,c){b=void 0===b?{}:b;c=void 0===c?!1:c;var d=R("EVENT_ID");d&&(b.ei||(b.ei=d));b&&$s(a,b);if(c)return!1;if((window.ytspf||{}).enabled)spf.navigate(a);else{var e=void 0===e?{}:e;var f=void 0===f?"":f;var g=void 0===g?window:g;b=g.location;a=zc(a,e)+f;var h=void 0===h?Zh:h;a:{h=void 0===h?Zh:h;for(e=0;e<h.length;++e)if(f=h[e],f instanceof Xh&&f.ue(a)){h=new Hb(a,Mb);break a}h=void 0}h=Oh(h||Nb);void 0!==h&&(b.href=h)}return!0}
;D("yt.setConfig",Ok);D("yt.config.set",Ok);D("yt.setMsg",ls);D("yt.msgs.set",ls);D("yt.logging.errors.log",Or);
D("writeEmbed",function(){var a=R("PLAYER_CONFIG");if(!a){var b=R("PLAYER_VARS");b&&(a={args:b})}Fs(!0);"gvn"===a.args.ps&&(document.body.style.backgroundColor="transparent");a.attrs||(a.attrs={width:"100%",height:"100%",id:"video-player"});var c=document.referrer;b=R("POST_MESSAGE_ORIGIN");window!==window.top&&c&&c!==document.URL&&(a.args.loaderUrl=c);bu("embed",["ol"]);c=R("WEB_PLAYER_CONTEXT_CONFIGS").WEB_PLAYER_CONTEXT_CONFIG_ID_EMBEDDED_PLAYER;if(!c.serializedForcedExperimentIds){var d=bl(window.location.href);
d.forced_experiments&&(c.serializedForcedExperimentIds=d.forced_experiments)}var e;(null==(e=a.args)?0:e.autoplay)&&bu("watch",["pbs","pbu","pbp"]);Qw=Ow(a,c);S("embeds_enable_server_driven_watch_again_on_youtube")&&!Hu.h&&(Hu.h=new Hu);Qw.addEventListener("onVideoDataChange",Tw);Qw.addEventListener("onReady",Vw);S("embeds_enable_server_driven_watch_again_on_youtube")&&Qw.addEventListener("innertubeCommand",function(f){Mu(Hu.h,f)});
a=R("POST_MESSAGE_ID","player");R("ENABLE_JS_API")?Sw=new Wv(Qw):R("ENABLE_POST_API")&&"string"===typeof a&&"string"===typeof b&&(Rw=new cw(window.parent,a,b),Sw=new $v(Qw,Rw.connection));ov();S("ytidb_create_logger_embed_killswitch")||zm();a={};Av.h||(Av.h=new Av);Av.h.install((a.flush_logs={callback:function(){ur()}},a));
Vp();S("ytidb_clear_embedded_player")&&oi.ka(function(){var f,g;if(!Gu){var h=Hq(),k={Oc:Fu,Jd:Eu};h.h.set(k.Oc,k);k={wc:{feedbackEndpoint:Ss(zu),modifyChannelNotificationPreferenceEndpoint:Ss(Au),playlistEditEndpoint:Ss(Bu),subscribeEndpoint:Ss(xu),unsubscribeEndpoint:Ss(yu),webPlayerShareEntityServiceEndpoint:Ss(Cu)}};var l=Ps(),n={};l&&(n.client_location=l);void 0===f&&(f=Ol());void 0===g&&(g=h.resolve(Fu));ku(k,g,f,n);f={Oc:qu,Kd:ju.h};h.h.set(f.Oc,f);Gu=h.resolve(qu)}Zu()})});
var Yw=Sk(function(){fu();Gs()}),Zw=Sk(function(a){a.persisted||(fu(),Gs())}),$w=Sk(function(a){S("embeds_web_enable_dispose_player_if_page_not_cached_killswitch")?Ww():a.persisted||Ww()}),ax=Sk(Ww);
window.addEventListener?(window.addEventListener("load",Yw),window.addEventListener("pageshow",Zw),window.addEventListener("pagehide",$w)):window.attachEvent&&(window.attachEvent("onload",Yw),window.attachEvent("onunload",ax));
window.onerror=function(a,b,c,d,e){b=void 0===b?"Unknown file":b;c=void 0===c?0:c;var f=!1,g=Pk("log_window_onerror_fraction");if(g&&Math.random()<g)f=!0;else{g=document.getElementsByTagName("script");for(var h=0,k=g.length;h<k;h++)if(0<g[h].src.indexOf("/debug-")){f=!0;break}}f&&(f=!1,e?f=!0:("string"===typeof a?g=a:ErrorEvent&&a instanceof ErrorEvent?(f=!0,g=a.message,b=a.filename,c=a.lineno,d=a.colno):(g="Unknown error",b="Unknown file",c=0),e=new jm(g),e.name="UnhandledWindowError",e.message=
g,e.fileName=b,e.lineNumber=c,isNaN(d)?delete e.columnNumber:e.columnNumber=d),f?Or(e):Pr(e))};
Ee=Qr;window.addEventListener("unhandledrejection",function(a){Qr(a.reason)});
bb(R("ERRORS")||[],function(a){Or.apply(null,a)});
Ok("ERRORS",[]);D("yt.abuse.player.botguardInitialized",E("yt.abuse.player.botguardInitialized")||jw);D("yt.abuse.player.invokeBotguard",E("yt.abuse.player.invokeBotguard")||kw);D("yt.abuse.dclkstatus.checkDclkStatus",E("yt.abuse.dclkstatus.checkDclkStatus")||pv);D("yt.player.exports.navigate",E("yt.player.exports.navigate")||Xw);D("yt.util.activity.init",E("yt.util.activity.init")||jq);D("yt.util.activity.getTimeSinceActive",E("yt.util.activity.getTimeSinceActive")||mq);
D("yt.util.activity.setTimestamp",E("yt.util.activity.setTimestamp")||kq);}).call(this);
