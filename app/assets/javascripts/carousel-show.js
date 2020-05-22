$(document).on('turbolinks:load', function(){
  $('.slick-show').slick({
    dots: true,
    infinite: true,
    speed: 500,
    fade: true,
    cssEase: 'linear'
  });
});