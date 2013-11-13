var HeaderUtils = $([]);
HeaderUtils.Message = $([]);
HeaderUtils.Message.defaultMessage = 'A system error occurred.<br/>Please try again later or contact the system administrator.';

$(function() {
    HeaderUtils.Message.container = $( "#header-message" );
    /*
    if(HeaderUtils.Message.container.html().trim().length>0) {
        HeaderUtils.showMessage('error', HeaderUtils.Message.container.html());
    }*/
    $('#loading-modal').on('shown', function () {
        $('#loading-modal').addClass('modal-override');
    });
    $('#loading-modal').on('hidden', function () {
        $('#loading-modal').removeClass('modal-override');
    });
    $('#dialog-confirm').on('shown', function () {
        $('#dialog-confirm').addClass('modal-override');
    });
    $('#dialog-confirm').on('hidden', function () {
        $('#dialog-confirm').removeClass('modal-override');
    });    
    $('#popup').on('shown', function () {
        $('#popup').addClass('modal-override');
    });
    $('#popup').on('hidden', function () {
        $('#popup').removeClass('modal-override');
    });
});

HeaderUtils.isAnyModalShowing = function() {
    if($('#loading-modal').hasClass('modal-override')) {
        return true;
    }
    if($('#popup').hasClass('modal-override')) {
        return true;
    }
    if($('#dialog-confirm').hasClass('modal-override')) {
        return true;
    }
    return false;
};
HeaderUtils.showLoadingModal = function(message) {
    if(message) {
        $('#loading-modal-message').html(message);
    } else {
        $('#loading-modal-message').html('Processing your request. Please wait...');
    }
    
    $('#loading-modal').modal({backdrop:'static'});
};
HeaderUtils.hideLoadingModal = function() {
    $('#loading-modal').modal('hide');
};
HeaderUtils.closeLoadingModal = function() {
    $('#loading-modal').modal('hide');
};
HeaderUtils.changeLoadingModalMessage = function(message) {
    $('#loading-modal-message').html(message);
};
HeaderUtils.appendLoadingModalMessage = function(message) {
    var currentMessage = $('#loading-modal-message').html();
    $('#loading-modal-message').html(currentMessage + message);
};
HeaderUtils.reload = function(checkForPopups) {
    if(checkForPopups && HeaderUtils.isAnyModalShowing()) {
        return;
    }
    $('#reloading-msg-layer').removeClass('hide');
    location.reload();
};	
HeaderUtils.showMessage = function(type, message){
    HeaderUtils.showMessageInElement(HeaderUtils.Message.container, type, message);
};

HeaderUtils.hideMessage = function(){
    HeaderUtils.hideMessageInElement(HeaderUtils.Message.container);
};

HeaderUtils.showMessageInElement = function(messageContainer, type, message){
    HeaderUtils.hideMessageInElement(messageContainer);
    if(message) {
        messageContainer.html(message);	
    } else {
        messageContainer.html(HeaderUtils.Message.defaultMessage);
    }
    
    if(type=='info') {
        messageContainer.addClass('alert').addClass('alert-info');        
    }
    if(type=='warning') {
        messageContainer.addClass('alert');
    }
    if(type=='none') {
        //no classes
    }    
    if(type=='error'||type=='systemerror') {
        messageContainer.addClass('alert').addClass('alert-error');   
    }
    messageContainer.removeClass('hide');
};

HeaderUtils.hideMessageInElement = function(messageContainer) {
    messageContainer.html('');
    messageContainer.removeClass('alert');
    messageContainer.removeClass('alert-error');
    messageContainer.removeClass('alert-info');
    messageContainer.removeClass('alert-success');
    messageContainer.addClass('hide');
};

HeaderUtils.showPopup = function(config) {
/*    if(! config.height) {config.height=200};
    if(! config.width) {config.width=600};
    if(! config.position) {config.postion='center'};
*/    if(! config.showLoadingMessage) {config.showLoadingMessage=false};

    //$( "#popup .modal-body" ).css({height:config.height+'px'});
    
    var popupContainer = $( "#popup" );
    var popupTextContainer = $( "#popup .modal-body p" );
    var popupTitleContainer = $( "#popup .modal-title" );
    var popupOkButton = $( "#popup .modal-footer .ok-btn" );
    popupOkButton.unbind('click');
    
    popupOkButton.bind('click', function() {
        if(config.okcallback) {
            config.okcallback();
        } else {
            popupTextContainer.html('');
            popupTitleContainer.html('');
            popupContainer.modal('hide');	
        }
    });
    popupTitleContainer.html(config.title);
    if(config.element) {
        popupTextContainer.html(config.element.html());
    } else if(config.text) {
        popupTextContainer.html(config.text);
    } else if(config.url) {
        HeaderUtils.loadUrlIntoElement({
            url:config.url, 
            data:config.data, 
            element:popupTextContainer, 
            showLoadingMessage:config.showLoadingMessage,
            showLoadingModal:false
        });
    }     
    popupContainer.modal();
};

HeaderUtils.closePopup = function(popupContainer) {
    if(popupContainer) {
        popupContainer.modal( "hide" );
    } else {
        $( "#popup" ).modal( "hide" );
    }
};
HeaderUtils.showConfirmDialog = function(config) {
    
    var dialogContainer = $( "#dialog-confirm" );
    var dialogTextContainer = $( "#dialog-confirm .modal-body p" );
    var dialogTitleContainer = $( "#dialog-confirm .modal-title" );
    var dialogOkButton = $( "#dialog-confirm .modal-footer .ok-btn" );
    var dialogCancelButton = $( "#dialog-confirm .modal-footer .cancel-btn" );
    dialogOkButton.unbind('click');
    dialogCancelButton.unbind('click');
    if (config.okcallback) {
        dialogOkButton.show();
    } else {
        dialogOkButton.hide();
    }
    if(config.oktext) {
        dialogOkButton.html(config.oktext);
    } else {
        dialogOkButton.html('Ok');
    }
    if(config.canceltext) {
        dialogCancelButton.html(config.canceltext);
    } else {
        dialogCancelButton.html('Cancel');
    }    
    dialogOkButton.bind('click', function() {
        if(config.okcallback) {
            config.okcallback();
        } else {
            dialogContainer.modal('hide');	
        }
    });
    dialogCancelButton.click('click', function() {
        if(config.cancelcallback) {
            config.cancelcallback();
        } else {
            dialogContainer.modal('hide');	
        }
    });
    dialogTitleContainer.html(config.title);
    dialogContainer.modal();
    if(config.element) {
        dialogTextContainer.html(config.element.html());
    } else if(config.text) {
        dialogTextContainer.html(config.text);
    } else if(config.url) {
        HeaderUtils.loadUrlIntoElement({url:config.url, data:config.data, element:dialogTextContainer, showLoadingMessage:config.showLoadingMessage, showLoadingModal:false});
    }    
};

HeaderUtils.closeConfirmDialog = function(dialogContainer) {
    if(dialogContainer) {
        dialogContainer.modal( "hide" );
    } else {
        $( "#dialog-confirm" ).modal( "hide" );
    }
};
HeaderUtils.getSpinner = function(size){
    return "<i class='icon-cog icon-spin'></i>";
};
HeaderUtils.getSpinnerForLoadingDialog = function(){
    return "<p><i class='icon-cog icon-spin icon-4x'></i></p>";
};
HeaderUtils.doAjaxHtml= function(config) {
    $.ajax({
        cache:false,
        url:config.url,
        dataType:'html',
        data:config.data,
        success: function(responseHtml) {
            if(responseHtml.indexOf('<body>')>-1) {
                //This happens because the login page was returned due to session timeout.
                HeaderUtils.reload();
            } else {
                config.success(responseHtml);	
            }
        },
        error: function(jqXHR, textStatus, errorThrown) {
            config.error(jqXHR, textStatus, errorThrown);	
        }
    });
};	

HeaderUtils.loadUrlIntoElement= function(config) {

    config.element.html('');
    
    if(config.showLoadingMessage) {
        config.element.html('<p>'+HeaderUtils.getSpinner()+" Loading data. Please wait...</p>");
    } else if(config.showLoadingModal==null || config.showLoadingModal!=false) {
        HeaderUtils.showLoadingModal();        	
    }
    if(config.data==null) {
        config.data={};
    }
    
    HeaderUtils.doAjaxHtml({url:config.url, data:config.data,
        success: function(responseHtml) {
            HeaderUtils.hideLoadingModal();
            config.element.html(responseHtml);
            setupCommonHandlersAfterPartialPageLoad(config.element);
        },
        error: function() {
            HeaderUtils.hideLoadingModal();
            HeaderUtils.showMessageInElement(config.element, 'systemerror');
        }
    });	
};

HeaderUtils.doAjaxJson= function(config) {
    if (config.method == null) {
        config.method='GET';
    }
    if (config.async == null) {
        config.async = true;
    }
    $.ajax({
        async:config.async,
        cache:false,        
        url:config.url,
        type:config.method,
        dataType:'json',
        data:config.data,
        traditional: true,
        success: function(responseJsonObject) {
             config.success(responseJsonObject); 
        },
        error: function(jqXHR, textStatus, errorThrown) {
            if(jqXHR.status==200 && textStatus=='parsererror') {
                //This happens because the login page was returned due to session timeout, and the json parser could not parse it.
                HeaderUtils.reload();
            } else {
                config.error(jqXHR, textStatus, errorThrown);	
            } 	        	
        }
    });
};	

var TableTools = {};
TableTools.setupValidationForDeleteButtons = function(containerElement) {
    if(containerElement) {
        jQuery(containerElement).find('button.delete').bind('click keypress', function() {
            if(!jQuery(this).hasClass('nowarn')) {
                TableTools.validateForDeleteButton(jQuery(this));
                return false;
            }
        });  
    } else {
        jQuery('button.delete').bind('click keypress', function() {
            if(!jQuery(this).hasClass('nowarn')) {
                TableTools.validateForDeleteButton(jQuery(this));
                return false;
            }
        });  
    } 
};
TableTools.validateForDeleteButton = function(deleteBtn) {
    var boxParent = deleteBtn.parents(".box")[0];
    var checkBoxes = $(boxParent).find("input[type=checkbox]");
    if(checkBoxes.length==0) {
        //Delete button w/o 
        var warning = $(this).data('warning') || 'Are you sure you want to delete this object?';
        HeaderUtils.showConfirmDialog({
            title:'Confirm',
            text:warning,
            okcallback: function() {
                var currentForm = deleteBtn.closest("form");
                var currentFormAction = currentForm.attr('action');
                var newFormAction = currentFormAction.replace('index', deleteBtn.attr('name').substr(8));
                currentForm.attr("action", newFormAction);
                currentForm.submit();
            }
        });
    } else {
        var checkedCheckBoxes = $(boxParent).find("input[type=checkbox]:checked");
        if (checkedCheckBoxes.length == 0) {
            // check is there selected checkboxes if not - alert
            HeaderUtils.showPopup({title:'Nothing selected!', text:"You didn't select anything!"});
        }  else {
            var warning = deleteBtn.data('warning') || 'Are you sure you want to delete this object?';
            HeaderUtils.showConfirmDialog({
                title:'Confirm',
                text:warning,
                okcallback: function() {
                    var currentForm = deleteBtn.closest("form");
                    var currentFormAction = currentForm.attr('action');
                    var newFormAction = currentFormAction.replace('index', deleteBtn.attr('name').substr(8));
                    currentForm.attr("action", newFormAction);
                    currentForm.submit();
                }
            });
        }
    }
};
TableTools.setupValidationForDataWarningButtons = function(containerElement) {
    if(containerElement) {
        jQuery(containerElement).find('button[data-warning]').bind('click keypress', function() {
            if(!jQuery(this).hasClass('nowarn')) {
                TableTools.validateForDataWarningButton(jQuery(this));
                return false;
            }
        });
    } else {
        jQuery('button[data-warning]').bind('click keypress', function() {
            if(!jQuery(this).hasClass('nowarn')) {
                TableTools.validateForDataWarningButton(jQuery(this));
                return false;
            }
        });   
    }
};
TableTools.validateForDataWarningButton = function(actionBtn) {
    var boxParent = actionBtn.parents(".box")[0];
    var checkBoxes = $(boxParent).find("input[type=checkbox]");
    if(checkBoxes.length==0) {
        //Action button w/o checkboxes
        var warning = actionBtn.data('warning') || 'Are you sure you want to perform this action?';
        HeaderUtils.showConfirmDialog({
            title:'Confirm',
            text:warning,
            okcallback: function() {
                var currentForm = actionBtn.closest("form");
                var currentFormAction = currentForm.attr('action');
                var newFormAction = currentFormAction.replace('index', actionBtn.attr('name').substr(8));
                currentForm.attr("action", newFormAction);
                currentForm.submit();
            }
        });
    } else {
        var checkedCheckBoxes = $(boxParent).find("input[type=checkbox]:checked");
        if (checkedCheckBoxes.length == 0) {
            // check is there selected checkboxes if not - alert
            HeaderUtils.showPopup({title:'Nothing selected!', text:"You didn't select anything!"});
        }  else {
            var warning = actionBtn.data('warning') || 'Are you sure you want to delete this object?';
            HeaderUtils.showConfirmDialog({
                title:'Confirm',
                text:warning,
                okcallback: function() {
                    var currentForm = actionBtn.closest("form");
                    var currentFormAction = currentForm.attr('action');
                    var newFormAction = currentFormAction.replace('index', actionBtn.attr('name').substr(8));
                    currentForm.attr("action", newFormAction);
                    currentForm.submit();
                }
            });
        }
    }
};
var UserStateUtils = [];
UserStateUtils.currentDataCenter='';
UserStateUtils.setupDataCenterChangeHandler = function() {
    UserStateUtils.currentDataCenter=jQuery("#selectDataCenter").val();
    jQuery("#selectDataCenter").change(function() {
        var selectedValue = jQuery(this).val();
        //check if datacenter is available
        if (selectedValue.indexOf('?')==-1) {
            //if yes, submit
            jQuery(this).closest('form').submit();
            return true;
        } else {
            jQuery("#selectDataCenter").select().select2('val',UserStateUtils.currentDataCenter);
            HeaderUtils.showPopup({title:'Region Unavailable.', text:'Sorry this region is currently unavailable!'});       
            return false;
        }
    });
};

function setupCommonHandlersAfterPartialPageLoad(elementLoaded) {
    TableTools.setupValidationForDeleteButtons(elementLoaded);
    TableTools.setupValidationForDataWarningButtons(elementLoaded);
    jQuery(elementLoaded).find('select').select2({minimumResultsForSearch: 5});
}
$(function() {
    TableTools.setupValidationForDeleteButtons();
    TableTools.setupValidationForDataWarningButtons();
    UserStateUtils.setupDataCenterChangeHandler();
    jQuery('select').select2({minimumResultsForSearch: 5});
});

