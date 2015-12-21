$(document).ready(function() {

    /* This is basic - uses default settings */

    $(".fancy_photo").fancybox();

    /* Apply fancybox to multiple items */

    $("a.group").fancybox({
        'transitionIn'	:	'elastic',
        'transitionOut'	:	'elastic',
        'speedIn'		:	600,
        'speedOut'		:	200,
        'overlayShow'	:	false
    });

});