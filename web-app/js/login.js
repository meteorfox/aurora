// enable loading indicator and disable "sign in" button during ajax request
jQuery.loginLoadingStart = function () {
    jQuery("#submit").prop("disabled", true).addClass("ui-state-disabled");
    jQuery("#submit i").addClass("icon-spinner").addClass("icon-spin").removeClass("icon-signin");
}
// disable loading indicator and enable "sign in" button after ajax request
jQuery.loginLoadingEnd = function (){
    jQuery("#submit").prop("disabled", false).removeClass("ui-state-disabled");
    jQuery("#submit i").removeClass("icon-spinner").removeClass("icon-spin").addClass("icon-signin");
}
jQuery.hideLoginButton = function (){
    jQuery("#submit").hide();
}
jQuery.showLoginButton = function (){
    jQuery("#submit").show();
}
jQuery.setLoginHint = function(selectEnv) {
    var loginHint = jQuery('.loginHint');
    if (loginHints[selectEnv]) {
        loginHint.html(loginHints[selectEnv]);
        loginHint.show();
    } else {
        loginHint.hide();
    }
}
jQuery.buildLoginErrorMessagesString = function(errors) {
    if(errors==null) {
        return null;        
    }
    var count = 0;
    var msg = '';
    for(var key in errors) {
        msg = msg + '<tr><td>' + key.toUpperCase() + '</td><td>' + errors[key] + '</td></tr>';
        count++;
    }
    if(count==0) {
        return null;
    }
    return msg;
}

jQuery.resetLoginMessages = function() {
    jQuery("#failedLoginConfirmation").hide();
}
jQuery(function() {
    // Adding login hint
    var selectedEnv = jQuery('#vpc').val();
    jQuery.setLoginHint(selectedEnv);

    // Sign in handler
    jQuery("#submit").click(function() {
        jQuery.resetLoginMessages();
        var highlightColor = '#51A2CA';

        if ((!jQuery("#username").val() || !jQuery("#password").val()) && jQuery(".c3specific").is(":visible")) {
            jQuery(".loginToolTip").show().delay(1800).fadeOut();
            if (!jQuery("#username").val())
                jQuery( "#username" ).effect( 'highlight', {color:highlightColor}, 1200 );
            if (!jQuery("#password").val())
                jQuery( "#password" ).effect( 'highlight', {color:highlightColor}, 1200 );
            return false;
        }  else {
            jQuery.loginLoadingStart();
            jQuery.ajax({
                url : signInUrl,
                type : 'POST',
                data : {
                    password : jQuery("#password").val(),
                    username : jQuery("#username").val(),
                    vpc : jQuery("#vpc").val()
                },
                dataType: 'json',
                success : function (data){
                    if (data.redirectUrl) {
                        window.location.replace(data.redirectUrl)
                        return;
                    }
                    var msg = jQuery.buildLoginErrorMessagesString(data.errors);
                    window.location.replace(rootContextPath+"/");
           /*
                    if (!msg) {
                        // if everything ok - just load main page
                        window.location.replace(rootContextPath+"/");
                    } else {
                        jQuery("#partialLoginConfirmation .message-area").html(msg);
                        jQuery("#partialLoginConfirmation").show();
                        jQuery.hideLoginButton();
                    }*/
                },
                error : function(xhr){
                    var data = jQuery.parseJSON(xhr.responseText);
                    jQuery.loginLoadingEnd();
                    var msg = jQuery.buildLoginErrorMessagesString(data.errors);
                    jQuery("#failedLoginConfirmation .message-area").html(msg);
                    jQuery("#failedLoginConfirmation").show();
                    
                }
            })
            return false;
        }
    });

    jQuery('#vpc').change(function() {
        var selectVal = jQuery(this).val();

        if (awsEnvironments.indexOf(selectVal) >= 0) {
            jQuery('.c3specific').hide();
        } else { jQuery('.c3specific').show();
        }
        jQuery.setLoginHint(selectVal);
    });


});
