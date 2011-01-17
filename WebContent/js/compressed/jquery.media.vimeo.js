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
(function(a){jQuery.media=jQuery.media?jQuery.media:{};window.onVimeoReady=function(b){b=b.replace("_media","");jQuery.media.players[b].node.player.media.player.onReady();};window.onVimeoFinish=function(b){b=b.replace("_media","");jQuery.media.players[b].node.player.media.player.onFinished();};window.onVimeoLoading=function(c,b){b=b.replace("_media","");jQuery.media.players[b].node.player.media.player.onLoading(c);};window.onVimeoPlay=function(b){b=b.replace("_media","");jQuery.media.players[b].node.player.media.player.onPlaying();};window.onVimeoPause=function(b){b=b.replace("_media","");jQuery.media.players[b].node.player.media.player.onPaused();};window.onVimeoProgress=function(c,b){b=b.replace("_media","");jQuery.media.players[b].node.player.media.player.onProgress(c);};jQuery.media.playerTypes=jQuery.extend(jQuery.media.playerTypes,{vimeo:function(b){return(b.search(/^http(s)?\:\/\/(www\.)?vimeo\.com/i)===0);}});jQuery.fn.mediavimeo=function(c,b){return new (function(f,e,d){this.display=f;var g=this;this.player=null;this.videoFile=null;this.ready=false;this.bytesLoaded=0;this.bytesTotal=0;this.currentVolume=1;this.createMedia=function(j,l){this.videoFile=j;this.ready=false;var i=(e.id+"_media");var h={clip_id:this.getId(j.path),width:"100%",height:"100%",js_api:"1",js_onLoad:"onVimeoReady",js_swf_id:i};var k=Math.floor(Math.random()*1000000);var m="http://vimeo.com/moogaloop.swf?rand="+k;jQuery.media.utils.insertFlash(this.display,m,i,"100%","100%",h,e.wmode,function(n){g.player=n;g.loadPlayer();});};this.getId=function(i){var h=/^http[s]?\:\/\/(www\.)?vimeo\.com\/([0-9]+)/i;return(i.search(h)==0)?i.replace(h,"$2"):i;};this.loadMedia=function(h){this.bytesLoaded=0;this.bytesTotal=0;this.createMedia(h);};this.onReady=function(){this.ready=true;this.loadPlayer();};this.loadPlayer=function(){if(this.ready&&this.player){this.player.api_addEventListener("onProgress","onVimeoProgress");this.player.api_addEventListener("onFinish","onVimeoFinish");this.player.api_addEventListener("onLoading","onVimeoLoading");this.player.api_addEventListener("onPlay","onVimeoPlay");this.player.api_addEventListener("onPause","onVimeoPause");d({type:"playerready"});this.playMedia();}};this.onFinished=function(){d({type:"complete"});};this.onLoading=function(h){this.bytesLoaded=h.bytesLoaded;this.bytesTotal=h.bytesTotal;};this.onPlaying=function(){d({type:"playing"});};this.onPaused=function(){d({type:"paused"});};this.playMedia=function(){d({type:"playing"});this.player.api_play();};this.onProgress=function(h){d({type:"progress"});};this.pauseMedia=function(){d({type:"paused"});this.player.api_pause();};this.stopMedia=function(){this.pauseMedia();this.player.api_unload();};this.seekMedia=function(h){this.player.api_seekTo(h);};this.setVolume=function(h){this.currentVolume=h;this.player.api_setVolume((h*100));};this.getVolume=function(){return this.currentVolume;};this.getDuration=function(){return this.player.api_getDuration();};this.getCurrentTime=function(){return this.player.api_getCurrentTime();};this.getBytesLoaded=function(){return this.bytesLoaded;};this.getBytesTotal=function(){return this.bytesTotal;};this.setQuality=function(h){};this.getQuality=function(){return"";};this.hasControls=function(){return true;};this.showControls=function(h){};this.getEmbedCode=function(){return"This video cannot be embedded.";};this.getMediaLink=function(){return"This video currently does not have a link.";};})(this,c,b);};})(jQuery);