/**
 *  Copyright (c) 2010 Alethia Inc,
 *  http://www.alethia-inc.com
 *  Developed by Travis Tidwell | travist at alethia-inc.com 
 *
 *  License:  GPL version 3.
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *  
 *  The above copyright notice and this permission notice shall be included in
 *  all copies or substantial portions of the Software.

 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *  THE SOFTWARE.
 */
(function($) {
  // Extend the media namespace
  jQuery.media = jQuery.extend( {}, {
    // Add the sha256 object.
    sha256 : function() {
      /* A JavaScript implementation of the SHA family of hashes, as defined in FIPS PUB 180-2
      * as well as the corresponding HMAC implementation as defined in FIPS PUB 198a
      * Version 1.2 Copyright Brian Turek 2009
      * Distributed under the BSD License
      * See http://jssha.sourceforge.net/ for more information
      *
      * Several functions taken from Paul Johnson
      */
      function jsSHA(o,p){jsSHA.charSize=8;jsSHA.b64pad="";jsSHA.hexCase=0;var q=null;var r=null;var s=function(a){var b=[];var c=(1<<jsSHA.charSize)-1;var d=a.length*jsSHA.charSize;for(var i=0;i<d;i+=jsSHA.charSize){b[i>>5]|=(a.charCodeAt(i/jsSHA.charSize)&c)<<(32-jsSHA.charSize-i%32)}return b};var u=function(a){var b=[];var c=a.length;for(var i=0;i<c;i+=2){var d=parseInt(a.substr(i,2),16);if(!isNaN(d)){b[i>>3]|=d<<(24-(4*(i%8)))}else{return"INVALID HEX STRING"}}return b};var v=null;var w=null;if("HEX"===p){if(0!==(o.length%2)){return"TEXT MUST BE IN BYTE INCREMENTS"}v=o.length*4;w=u(o)}else if(("ASCII"===p)||('undefined'===typeof(p))){v=o.length*jsSHA.charSize;w=s(o)}else{return"UNKNOWN TEXT INPUT TYPE"}var A=function(a){var b=jsSHA.hexCase?"0123456789ABCDEF":"0123456789abcdef";var c="";var d=a.length*4;for(var i=0;i<d;i++){c+=b.charAt((a[i>>2]>>((3-i%4)*8+4))&0xF)+b.charAt((a[i>>2]>>((3-i%4)*8))&0xF)}return c};var B=function(a){var b="ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";var c="";var d=a.length*4;for(var i=0;i<d;i+=3){var e=(((a[i>>2]>>8*(3-i%4))&0xFF)<<16)|(((a[i+1>>2]>>8*(3-(i+1)%4))&0xFF)<<8)|((a[i+2>>2]>>8*(3-(i+2)%4))&0xFF);for(var j=0;j<4;j++){if(i*8+j*6>a.length*32){c+=jsSHA.b64pad}else{c+=b.charAt((e>>6*(3-j))&0x3F)}}}return c};var C=function(x,n){if(n<32){return(x>>>n)|(x<<(32-n))}else{return x}};var D=function(x,n){if(n<32){return x>>>n}else{return 0}};var E=function(x,y,z){return(x&y)^(~x&z)};var F=function(x,y,z){return(x&y)^(x&z)^(y&z)};var G=function(x){return C(x,2)^C(x,13)^C(x,22)};var I=function(x){return C(x,6)^C(x,11)^C(x,25)};var J=function(x){return C(x,7)^C(x,18)^D(x,3)};var L=function(x){return C(x,17)^C(x,19)^D(x,10)};var M=function(x,y){var a=(x&0xFFFF)+(y&0xFFFF);var b=(x>>>16)+(y>>>16)+(a>>>16);return((b&0xFFFF)<<16)|(a&0xFFFF)};var N=function(a,b,c,d){var e=(a&0xFFFF)+(b&0xFFFF)+(c&0xFFFF)+(d&0xFFFF);var f=(a>>>16)+(b>>>16)+(c>>>16)+(d>>>16)+(e>>>16);return((f&0xFFFF)<<16)|(e&0xFFFF)};var O=function(a,b,c,d,e){var f=(a&0xFFFF)+(b&0xFFFF)+(c&0xFFFF)+(d&0xFFFF)+(e&0xFFFF);var g=(a>>>16)+(b>>>16)+(c>>>16)+(d>>>16)+(e>>>16)+(f>>>16);return((g&0xFFFF)<<16)|(f&0xFFFF)};var P=function(j,k,l){var W=[];var a,b,c,d,e,f,g,h;var m,T2;var H;var K=[0x428A2F98,0x71374491,0xB5C0FBCF,0xE9B5DBA5,0x3956C25B,0x59F111F1,0x923F82A4,0xAB1C5ED5,0xD807AA98,0x12835B01,0x243185BE,0x550C7DC3,0x72BE5D74,0x80DEB1FE,0x9BDC06A7,0xC19BF174,0xE49B69C1,0xEFBE4786,0x0FC19DC6,0x240CA1CC,0x2DE92C6F,0x4A7484AA,0x5CB0A9DC,0x76F988DA,0x983E5152,0xA831C66D,0xB00327C8,0xBF597FC7,0xC6E00BF3,0xD5A79147,0x06CA6351,0x14292967,0x27B70A85,0x2E1B2138,0x4D2C6DFC,0x53380D13,0x650A7354,0x766A0ABB,0x81C2C92E,0x92722C85,0xA2BFE8A1,0xA81A664B,0xC24B8B70,0xC76C51A3,0xD192E819,0xD6990624,0xF40E3585,0x106AA070,0x19A4C116,0x1E376C08,0x2748774C,0x34B0BCB5,0x391C0CB3,0x4ED8AA4A,0x5B9CCA4F,0x682E6FF3,0x748F82EE,0x78A5636F,0x84C87814,0x8CC70208,0x90BEFFFA,0xA4506CEB,0xBEF9A3F7,0xC67178F2];if(l==="SHA-224"){H=[0xc1059ed8,0x367cd507,0x3070dd17,0xf70e5939,0xffc00b31,0x68581511,0x64f98fa7,0xbefa4fa4]}else{H=[0x6A09E667,0xBB67AE85,0x3C6EF372,0xA54FF53A,0x510E527F,0x9B05688C,0x1F83D9AB,0x5BE0CD19]}j[k>>5]|=0x80<<(24-k%32);j[((k+1+64>>9)<<4)+15]=k;var n=j.length;for(var i=0;i<n;i+=16){a=H[0];b=H[1];c=H[2];d=H[3];e=H[4];f=H[5];g=H[6];h=H[7];for(var t=0;t<64;t++){if(t<16){W[t]=j[t+i]}else{W[t]=N(L(W[t-2]),W[t-7],J(W[t-15]),W[t-16])}m=O(h,I(e),E(e,f,g),K[t],W[t]);T2=M(G(a),F(a,b,c));h=g;g=f;f=e;e=M(d,m);d=c;c=b;b=a;a=M(m,T2)}H[0]=M(a,H[0]);H[1]=M(b,H[1]);H[2]=M(c,H[2]);H[3]=M(d,H[3]);H[4]=M(e,H[4]);H[5]=M(f,H[5]);H[6]=M(g,H[6]);H[7]=M(h,H[7])}switch(l){case"SHA-224":return[H[0],H[1],H[2],H[3],H[4],H[5],H[6]];case"SHA-256":return H;default:return[]}};this.getHash=function(a,b){var c=null;var d=w.slice();switch(b){case"HEX":c=A;break;case"B64":c=B;break;default:return"FORMAT NOT RECOGNIZED"}switch(a){case"SHA-224":if(q===null){q=P(d,v,a)}return c(q);case"SHA-256":if(r===null){r=P(d,v,a)}return c(r);default:return"HASH NOT RECOGNIZED"}};this.getHMAC=function(a,b,c,d){var e=null;var f=null;var g=[];var h=[];var j=null;var k=null;var l=null;switch(d){case"HEX":e=A;break;case"B64":e=B;break;default:return"FORMAT NOT RECOGNIZED"}switch(c){case"SHA-224":l=224;break;case"SHA-256":l=256;break;default:return"HASH NOT RECOGNIZED"}if("HEX"===b){if(0!==(a.length%2)){return"KEY MUST BE IN BYTE INCREMENTS"}f=u(a);k=a.length*4}else if("ASCII"===b){f=s(a);k=a.length*jsSHA.charSize}else{return"UNKNOWN KEY INPUT TYPE"}if(512<k){f=P(f,k,c);f[15]&=0xFFFFFF00}else if(512>k){f[15]&=0xFFFFFF00}for(var i=0;i<=15;i++){g[i]=f[i]^0x36363636;h[i]=f[i]^0x5C5C5C5C}j=P(g.concat(w),512+v,c);j=P(h.concat(j),512+l,c);return(e(j))}}

      // But I wrote this...   ;)
      this.encrypt = function( key, input ) {
        var shaObj = new jsSHA(input, "ASCII");
        return shaObj.getHMAC(key, "ASCII", "SHA-256", "HEX");
      };
    }
  }, jQuery.media );
})(jQuery);
