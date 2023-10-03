// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

// Include all twitter's javascripts
//= require twitter/bootstrap

//= require predictions

(function($) {
    var updateCountdown = function() {
        var c = $('.countdown');
        if(!(c.length > 0 && c.data('date').length > 0)) {
            return;
        }
        var utc = c.data('date').split('-');
        var then = new Date(utc[0], (utc[1]-1), utc[2], utc[3], utc[4], 0).getTime();
        var now = new Date().getTime();
        var diff = (then - now) / 1000;
        if(diff < 0) {
            window.location.reload();
        }
        var days = Math.floor(diff / (60*60*24));
        var diffMinDays = diff - (days*60*60*24);
        var hours = Math.floor(diffMinDays / (60*60));
        var diffMinHours = diffMinDays - (hours * 60*60);
        var minutes = Math.floor(diffMinHours / (60));
        var seconds = Math.round(diffMinHours - (minutes * 60));
        c.find('.days .val').text(days);
        c.find('.days .lbl').text(days == 1 ? "dag" : "dagen");
        c.find('.hours .val').text(hours < 10 ? "0" + hours : hours);
        c.find('.minutes .val').text(minutes < 10 ? "0" + minutes : minutes);
        c.find('.minutes .lbl').text(minutes == 1 ? "minuut" : "minuten");
        c.find('.seconds .val').text(seconds < 10 ? "0" + seconds : seconds);
        c.find('.seconds .lbl').text(seconds == 1 ? "seconde" : "seconden");
    };
    updateCountdown();
    var s = setInterval(updateCountdown, 1000);
})(jQuery);

$(function() {
    $(document).on('click', '.navbar-toggle.mainnav', function() {
        $('html').toggleClass('nav-open');
    });
    $(document).on('click', '.nav-open', function() {
        $('html').removeClass('nav-open');
    });

    $(document).on('click', 'table.clubrankingtable tr', function (e) {
        var href = $(this).find('a').attr('href');
        $(this).closest('table').find('tr').removeClass('active');
        $(this).addClass('active');
        $.get(href, function(response) {
            $('.playerslist').html(response);
        });
        e.preventDefault();
    });
});

