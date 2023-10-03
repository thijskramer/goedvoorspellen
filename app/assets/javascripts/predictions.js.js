var submitForm = function(form) {
    if(form.find('input.has-error').length === 0) {
        form.trigger('submit');
    }
}

var showSpinner = function(form, spinner) {
    var opts = {
      lines: 11, // The number of lines to draw
      length: 10, // The length of each line
      width: 6, // The line thickness
      radius: 9, // The radius of the inner circle
      corners: 1, // Corner roundness (0..1)
      rotate: 8, // The rotation offset
      direction: 1, // 1: clockwise, -1: counterclockwise
      color: '#000', // #rgb or #rrggbb or array of colors
      speed: 1.1, // Rounds per second
      trail: 58, // Afterglow percentage
      shadow: true, // Whether to render a shadow
      hwaccel: true, // Whether to use hardware acceleration
      className: 'spinner', // The CSS class to assign to the spinner
      zIndex: 2e9, // The z-index (defaults to 2000000000)
      top: 'auto', // Top position relative to parent in px
      left: 'auto' // Left position relative to parent in px
    };
    var target = form.find('.icon')[0];
    spinner = new Spinner(opts).spin(target);
    return spinner;
}

var validateField = function(input) {
    var reg = /^\d+$/;
    var val = $(input).val();
    if(val.length > 0 && !reg.test(val)) {
        if(!input.hasClass('has-error')) {
            input.addClass('has-error');
        }
    }
    else {
        input.removeClass('has-error');
    }
}

var handleForm = function(f) {
    var homescoreChanged = false,
        form = $(f),
        timer,
        spinner,
        spinnertimer,
        checkTimer;

    form.on('focus', 'input', function() {
        $(this).data('origval', $(this).val());
        clearTimeout(timer);
        formIsSubmitted = false;
    });

    form.on('blur', 'input[name*="home_score"]', function() {
        clearTimeout(timer);
        if(!formIsSubmitted) {
            if($(this).data('origval') != $(this).val()) {
                homescoreChanged = true;
                // if($(this).data('origval').length > 0) {
                    submitForm(form);
                // }
            }
        }
        validateField($(this));
    });

    form.on('blur', 'input[name*="away_score"]', function() {
        clearTimeout(timer);
        if(!formIsSubmitted) {
            var val = $(this).val();
            if(val !== $(this).data('origval')) {
                submitForm(form);
            }
            else {
                if(homescoreChanged) {
                    homescoreChanged = false;
                    submitForm(form);
                }
            }
        }
        validateField($(this));
    });
    form.on('keyup', 'input', function(e) {
        // set timer.
        clearTimeout(timer);
        if(e.which >= 48 && e.which <= 57) {
            timer = setTimeout(function() {
                submitForm(form);
                formIsSubmitted = true;
            }, 1000);
        }
        validateField($(this));
    });

    form.on('submit', function() {
        clearTimeout(checkTimer);
        spinnerTimer = setTimeout(function() {
            spinner = showSpinner(form, spinner);
        }, 500);
    })

    form.on("ajax:success", function(e) {
        clearTimeout(spinnerTimer);
        $('.icon .spinner', form).remove();
        $('.icon .check', form).css({'opacity':1});
        checkTimer = setTimeout(function() {
            $('.icon .check', form).css({'opacity':0});
        }, 3000);
    }).on("ajax:error", function(e) {
        clearTimeout(spinnerTimer);
        $('.icon .spinner', form).remove();
    });
}

$(document).on("page:change", function() {
    $('form.edit_prediction').each(function(i, form) {
        handleForm(form);
    });

    $('.prediction.now-playing').each(function() {
        var me = $(this);
        var startdate = $('.match-timer', me).data('date');
        if(startdate.length > 0) {
            startdateobj = startdate.split('-');
            var now = new Date().getTime();
            var then = new Date(
                parseInt(startdateobj[0], 10), 
                (parseInt(startdateobj[1], 10)-1), 
                parseInt(startdateobj[2], 10), 
                parseInt(startdateobj[3], 10), 
                parseInt(startdateobj[4], 10), 
                0).getTime();
            var diff = now - then;
            var minutes = Math.ceil(diff / (60 * 1000));
            if(minutes > 45 && minutes <= 61) {
                minutes = 45;
            }
            if(minutes > 61) {
                minutes = minutes - 16;
            }
            if(minutes > 90) {
                minutes = 90;
            }
            $('.match-timer', me).find('.minute > span').text(minutes);
        }
    });

    $('.matchdetails .predictions .progress-bar').each(function() {
        var width = $(this).data('width');
        $(this).width(width);
    });
});