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
(function(a){jQuery.media=jQuery.media?jQuery.media:{};jQuery.media.defaults=jQuery.extend(jQuery.media.defaults,{protocol:"auto",server:"drupal",template:"default",baseURL:"",debug:false,draggable:false,resizable:false,showPlaylist:true,autoNext:true,prefix:"",zIndex:400});jQuery.media.ids=jQuery.extend(jQuery.media.ids,{loading:"#mediaplayerloading",player:"#mediaplayer",menu:"#mediamenu",titleBar:"#mediatitlebar",node:"#medianode",playlist:"#mediaplaylist",control:"#mediacontrol"});jQuery.media.players={};jQuery.media.loadCallbacks={};jQuery.media.playlists={};jQuery.media.controllers={};jQuery.media.onLoaded=function(b,d){var c=jQuery.media.players[b];if(c&&c.display&&c.loaded){d(c);}else{if(!jQuery.media.loadCallbacks[b]){jQuery.media.loadCallbacks[b]=[];}jQuery.media.loadCallbacks[b].push(d);}};jQuery.media.addElement=function(d,f,c){if(f&&f[c]){var e=jQuery.media.players[d];if(e){switch(c){case"playlist":e.addPlaylist(f.playlist);break;case"controller":e.addController(f.controller);break;}}else{var b=c+"s";if(!jQuery.media[b][d]){jQuery.media[b][d]=[];}jQuery.media[b][d].push(f[c]);}}};jQuery.media.addController=function(b,c){jQuery.media.addElement(b,c,"controller");};jQuery.media.addPlaylist=function(b,c){jQuery.media.addElement(b,c,"playlist");};jQuery.fn.mediaplayer=function(b){if(this.length===0){return null;}return new (function(e,f){f=jQuery.media.utils.getSettings(f);if(!f.id){f.id=jQuery.media.utils.getId(e);}this.dialog=e;this.display=this.dialog.find(f.ids.player);var j=this;var c=[];jQuery.media.utils.checkVisibility(this.display,c);jQuery.media.players[f.id]=this;this.loaded=false;var d=0;f.template=jQuery.media.templates[f.template](this,f);if(f.template.getSettings){f=jQuery.extend(f,f.template.getSettings());}a(window).keyup(function(i){switch(i.keyCode){case 0:j.onSpaceBar();break;case 113:case 27:j.onEscKey();break;}});if(jQuery.media[f.protocol]){this.protocol=jQuery.media[f.protocol](f);}if(jQuery.media[f.server]){this.server=jQuery.media[f.server](this.protocol,f);}this.menu=this.dialog.find(f.ids.menu).mediamenu(this.server,f);if(this.menu){this.menu.display.bind("menuclose",function(){j.showMenu(false);});}this.menuOn=false;this.maxOn=!f.showPlaylist;this.fullScreen=false;this.playlist=null;this.activePlaylist=null;this.controller=null;this.activeController=null;this.showMenu=function(i){if(f.template.onMenu){this.menuOn=i;f.template.onMenu(this.menuOn);}};this.onEscKey=function(){if(this.fullScreen){this.fullScreen=false;if(this.node&&this.node.player){this.node.player.fullScreen(this.fullScreen);}}};this.onSpaceBar=function(){if(this.fullScreen&&this.node&&this.node.player){this.node.player.togglePlayPause();}};this.addPlayerEvents=function(i){i.display.bind("menu",function(k){j.showMenu(!j.menuOn);});i.display.bind("maximize",function(k){j.maximize(!j.maxOn);});i.display.bind("fullscreen",function(k){j.fullScreen=!j.fullScreen;if(j.node&&j.node.player){j.node.player.fullScreen(j.fullScreen);}});};this.titleBar=this.dialog.find(f.ids.titleBar).mediatitlebar(f);if(this.titleBar){this.addPlayerEvents(this.titleBar);if(f.draggable&&this.dialog.draggable){this.dialog.draggable({handle:f.ids.titleBar,containment:"document"});}if(f.resizable&&this.dialog.resizable){this.dialog.resizable({alsoResize:this.display,containment:"document",resize:function(i){j.onResize();}});}}this.node=this.dialog.find(f.ids.node).medianode(this.server,f);if(this.node){this.node.display.bind("nodeload",function(i,k){j.onNodeLoad(k);});if(this.node.player&&this.node.player.media){this.node.player.media.display.bind("mediaupdate",function(i,k){j.onMediaUpdate(k);});}if(this.node.uservoter){this.node.uservoter.display.bind("voteSet",function(k,i){if(j.activePlaylist){j.activePlaylist.onVoteSet(i);}});}}this.onMediaUpdate=function(i){this.node.player.onMediaUpdate(i);if(f.autoNext&&this.activePlaylist&&(i.type=="complete")){this.activePlaylist.loadNext();}if(this.controller){this.controller.onMediaUpdate(i);}if(this.activeController){this.activeController.onMediaUpdate(i);}if(this.menu&&this.node&&(i.type=="meta")){this.menu.setEmbedCode(this.node.player.media.player.getEmbedCode());this.menu.setMediaLink(this.node.player.media.player.getMediaLink());}if(f.template&&f.template.onMediaUpdate){f.template.onMediaUpdate(i);}};this.onPlaylistLoad=function(i){if(this.node){if(this.node.player&&this.node.player.media){this.node.player.media.hasPlaylist=true;}this.node.loadNode(i);}if(f.template.onPlaylistLoad){f.template.onPlaylistLoad(i);}};this.onNodeLoad=function(i){if(f.template.onNodeLoad){f.template.onNodeLoad(i);}};this.maximize=function(i){if(!this.fullScreen){if(f.template.onMaximize&&(i!=this.maxOn)){this.maxOn=i;f.template.onMaximize(this.maxOn);}}};this.addPlaylist=function(i){if(i){i.display.bind("playlistload",i,function(k,l){j.activePlaylist=k.data;j.onPlaylistLoad(l);});if(!this.activePlaylist&&i.activeTeaser){this.activePlaylist=i;this.onPlaylistLoad(i.activeTeaser.node.nodeInfo);}}return i;};this.playlist=this.addPlaylist(this.dialog.find(f.ids.playlist).mediaplaylist(this.server,f));if(jQuery.media.playlists[f.id]){var g=jQuery.media.playlists[f.id];d=g.length;while(d--){this.addPlaylist(g[d]);}}this.addController=function(k,i){if(k){k.display.bind("controlupdate",k,function(l,m){j.activeController=l.data;if(j.node&&j.node.player){j.node.player.onControlUpdate(m);}});if(i&&!this.activeController){this.activeController=k;}this.addPlayerEvents(k);}return k;};this.controller=this.addController(this.dialog.find(f.ids.control).mediacontrol(f),false);if(this.controller&&this.node){this.node.addVoters(this.controller.display);}if(jQuery.media.controllers[f.id]){var h=jQuery.media.controllers[f.id];d=h.length;while(d--){this.addController(h[d],true);}}this.onResize=function(){if(f.template.onResize){f.template.onResize();}if(this.node){this.node.onResize();}if(this.controller){this.controller.onResize();}};this.showNativeControls=function(i){var k=this.node?this.node.player:null;if(k&&k.hasControls()){k.usePlayerControls=i;if(i){k.busy.hide();k.play.hide();if(k.preview){k.preview.display.hide();}if(this.controller){this.controller.display.hide();}}else{k.showBusy(1,((this.busyFlags&2)==2));k.showPlay(this.playVisible);k.showPreview(this.previewVisible);if(this.controller){this.controller.display.show();}}k.showControls(i);}};this.loadContent=function(){var i=false;if(this.playlist){i=this.playlist.loadPlaylist();}if(!i&&this.node){if(this.node.player&&this.node.player.media){this.node.player.media.settings.repeat=(f.loop||f.repeat);}this.node.loadNode();}};this.initializeTemplate=function(){if(f.template.initialize){f.template.initialize(f);}jQuery.media.utils.resetVisibility(c);};this.load=function(){this.initializeTemplate();this.dialog.css("position","relative");this.dialog.css("marginLeft",0);this.dialog.css("overflow","visible");this.loaded=true;this.display.trigger("playerLoaded",this);if(jQuery.media.loadCallbacks[f.id]){var l=jQuery.media.loadCallbacks[f.id];var k=l.length;while(k--){l[k](this);}}this.server.connect(function(i){j.loadContent();});};this.load();})(this,b);};})(jQuery);