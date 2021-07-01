
function fnInitPage() {
    requirejs(['/mobile/lib/jquery.iosslider.min.js'],
        function() {
            $('.iosSlider').iosSlider({
                snapToChildren: true,
                desktopClickDrag: true,
			    infiniteSlider: true,
                navNextSelector: $('.nextButton'),
                navPrevSelector: $('.prevButton'),
                navSlideSelector: $('.selectors .item'),
                autoSlide: true,
                autoSlideTimer: 3000,
                onSlideChange: slideChange
            });
        }
    );
}

function slideChange(args) {

    $('.selectors .item').removeClass('selected');
    $('.selectors .item:eq(' + (args.currentSlideNumber - 1) + ')').addClass('selected');

}