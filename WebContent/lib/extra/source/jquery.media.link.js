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
  jQuery.fn.medialink = function( settings, onClick, data ) {
    data = data ? data : {
      noargs:true
    };
    return new (function( link, settings, onClick, data ) {
      var _this = this;
      this.display = link;
          
      this.display.css("cursor", "pointer").bind( "click", data, function( event ) {
        onClick( event, $(this) );
      }).bind("mouseenter", function() {
        if( settings.template.onLinkOver ) {
          settings.template.onLinkOver( $(this) );
        }
      }).bind("mouseleave", function() {
        if( settings.template.onLinkOut ) {
          settings.template.onLinkOut( $(this) );
        }
      });
    })( this, settings, onClick, data );
  };
})(jQuery);
