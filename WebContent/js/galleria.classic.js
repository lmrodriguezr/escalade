
(function($) {

Galleria.addTheme({
    name: 'classic',
    author: 'Galleria',
    version: '1.5',
    css: '../css/galleria.classic.css',
    defaults: {
        transition: 'slide',
        thumb_crop: 'height',

        _toggle_info: true
    },
    init: function(options) {
        
        this.addElement('info-link','info-close');
        this.append({
            'info' : ['info-link','info-close']
        });

        var toggle   = this.$('image-nav-left,image-nav-right,counter'),
            info     = this.$('info-link,info-close,info-text'),
            click    = Galleria.TOUCH ? 'touchstart' : 'click';
        
        this.$('loader,counter').show().css('opacity',.4)

        if (! Galleria.TOUCH ) {

            this.$('thumbnails').children().hover(function() {
                $(this).not('.active').children().stop().fadeTo(100, 1);
            }, function() {
                $(this).not('.active').children().stop().fadeTo(400, .6);
            });
            
            this.addIdleState( this.get('image-nav-left'), { left:-50 });
            this.addIdleState( this.get('image-nav-right'), { right:-50 });
            this.addIdleState( this.get('counter'), { opacity:0 });
        }
        
        if ( options._toggle_info ) {
            info.bind( click, function() {
                info.toggle();
            });
        }
        
        this.bind(Galleria.THUMBNAIL, function(e) {
            $(e.thumbTarget).parent(':not(.active)').children().css('opacity',.6)
        });
        
        this.bind(Galleria.LOADSTART, function(e) {
            if (!e.cached) {
                this.$('loader').show().fadeTo(200, .4);
            }
            
            this.$('info').toggle( this.hasInfo() );
            
            $(e.thumbTarget).css('opacity',1).parent().siblings().children().css('opacity',.6);
        });
        
        this.bind(Galleria.LOADFINISH, function(e) {
            this.$('loader').fadeOut(200);
        });
    }
});

})(jQuery);
