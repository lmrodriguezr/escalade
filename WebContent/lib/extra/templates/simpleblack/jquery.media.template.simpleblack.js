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
 *
 *  This file serves as a starting point for new template designs.  Below you will
 *  see a listing of all media player "hooks" that can be implemented by the
 *  template to customize the functionality of this template.
 */
(function($) {
  jQuery.media = jQuery.media ? jQuery.media : {};
  jQuery.media.templates = jQuery.extend( {}, {
    "simpleblack" : function( mediaplayer, settings ) {
      return new (function( mediaplayer, settings ) {
        
        settings = jQuery.media.utils.getSettings(settings);
        var _this = this;

        this.mediaDisplay = null;
        this.controlBar = null;
        this.player = null;
        this.logo = null;
        this.fullScreenButton = null;

        /**
         * Called just before the mediaplayer is ready to show this template to the user.
         * This function is used to initialize the template given the current state of
         * settings passed to the player.  You can use this function to initialize variables,
         * change width's and height's of elements based on certain parameters passed to the
         * media player.
         *
         * @param - The settings object.
         */
        this.initialize = function( settings ) {
               
          // Get the player elements.
          this.mediaDisplay = mediaplayer.node.player.media;
          this.controlBar = mediaplayer.controller;
          this.player = mediaplayer.node.player;
          this.logo = this.player.logo;
          this.fullScreenButton = this.controlBar.display.find("#mediafront_resizeScreen");

          // Hide the volume bar by default.
          this.controlBar.volumeBar.display.hide();
          this.fullScreenButton.find(".off").hide();

          // Show the control bar, and then hide it after 5 seconds of inactivity.
          jQuery.media.utils.showThenHide( this.controlBar.display, "display", null, "slow" );
          jQuery.media.utils.showThenHide( this.logo.display, "logo", null, "slow" );

          // Make sure that we show the volume bar when they hover over the mute button.
          // Add a timer to the mouse move of the display to show the control bar and logo on mouse move.
          mediaplayer.display.bind("mousemove", function() {
            jQuery.media.utils.showThenHide( _this.controlBar.display, "display", "fast", "slow" );
            jQuery.media.utils.showThenHide( _this.logo.display, "logo", "fast", "slow" );
          });

          // Show the volume bar when they hover over the mute button.
          this.controlBar.mute.display.bind("mousemove", function() {
            jQuery.media.utils.showThenHide( _this.controlBar.volumeBar.display, "volumeBar", "fast", "fast" );
          });

          // Stop the hide on both the control bar and the volumeBar.
          jQuery.media.utils.stopHideOnOver( this.controlBar.display, "display" );
          jQuery.media.utils.stopHideOnOver( this.controlBar.volumeBar.display, "volumeBar" );
        };

        /**
         * Returns our template settings overrides.  This is used to force a particular
         * setting to be a certain value if the user does not provide that parameter.
         *
         * @return - An associative array of our settings.  We can use this to override any
         *           default settings for the player as well as default ids.
         */
        this.getSettings = function() {
          return {
            volumeVertical:true
          };
        };

        /**
         * Called when the user presses the menu button.
         *
         * @param - If the menu should be on (true) or off (false).
         */
        this.onMenu = function( on ) {
          if( mediaplayer.menu ) {
            if( on ) {
              mediaplayer.menu.display.show( "normal" );
            }
            else {
              mediaplayer.menu.display.hide( "normal" );
            }
          }
        };

        /**
         * Called when the user presses the fullscreen button.
         *
         * @param - If the player is in fullscreen (true) or normal mode (false).
         */
        this.onFullScreen = function( on ) {
          if( on ) {
            this.fullScreenButton.find(".on").hide();
            this.fullScreenButton.find(".off").show();
            this.player.display.addClass("fullscreen");
            mediaplayer.menu.display.addClass("fullscreen");
            
            // Hide the players controls, and show the HTML controls.
            if( this.player ) {
              this.player.showControls(true);
            }
          }
          else {
            this.fullScreenButton.find(".on").show();
            this.fullScreenButton.find(".off").hide();
            this.player.display.removeClass("fullscreen");
            mediaplayer.menu.display.removeClass("fullscreen");
            
            // Hide the players controls, and show the HTML controls.
            if( this.player ) {
              this.player.showControls(false);
            }
          }
        };

        /**
         * Selects or Deselects a menu item.
         *
         * @param - The link jQuery object
         */
        this.onMenuSelect = function( link, contents, selected ) {
          if( selected ) {
            contents.show("normal");
            link.addClass('active');
          }
          else {
            contents.hide("normal");
            link.removeClass('active');
          }
        };

        /**
         * This function is currently stubbed out.
         * You can implement it and hook into the time display by
         * reassigning this as follows...
         *
         *  this.formatTime = function( time ) {
         *  }
         *
         *  You can see the default implementation of this function
         *  by opening js/source/jquery.media.control.js on the line
         *  after it says this.formatTime = ...
         */
        this.formatTime = false;
      })( mediaplayer, settings );
    }
  }, jQuery.media.templates );
})(jQuery);
