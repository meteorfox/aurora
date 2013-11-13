var LbAddServices = $([]);

LbAddServices.updateServicesName = function() {
    //alert('updateservice name');
    jQuery('#table_lbaasNewServices tbody tr').each(function(index, value) {

        var checkBox = jQuery(this).find("input[type=checkbox]");

        var instanceId = checkBox.val();

        var ip = instanceIdsToInterfacesMap[instanceId][jQuery('#netInterface').val()];
        if (ip) {
            jQuery(this).find('td.serviceName').html(ip + ':' + jQuery('#port').val());
            checkBox.attr("disabled", false);
        } else {
            jQuery(this).find('td.serviceName').html("");
            checkBox.attr("disabled", true);
            checkBox.attr('checked', false);
        }
    });
};
LbAddServices.validateServicesBeforeSave = function() {
    var instanceIds = LbAddServices.getSelectedInstanceIds();
    if(instanceIds.length==0) {
        HeaderUtils.showPopup({text:"No services selected. Please select service(s) to add to pool."});
        return;
    }
    HeaderUtils.showLoadingModal('Validating the services to be added. Please wait...');
    var submitData = {
        instanceId: LbAddServices.getSelectedInstanceIds().join(", "),
        port: jQuery("#port").val(),
        weight: jQuery("#weight").val(),
        netInterface: jQuery("#netInterface").val(),
        enabled: jQuery("#enabled").val()
    };
    jQuery.ajax({
        url : '/lbaas/saveServiceValidation.json',
        type : 'POST',
        data : submitData,
        dataType: 'json',
        async : false,
        success : function(data) {
            if(data.errors) {
                var msg = 'Validation Errors:<br/>';
                for(var i = 0; i <data.errors.errors.length; i++) {
                    msg = msg+'<i class="icon-remove text-danger"></i> &nbsp;'+data.errors.errors[i].message+'</br>';
                }
                HeaderUtils.hideLoadingModal();
                HeaderUtils.showPopup({title:'Validation errors', text:msg});
            } else {
                var msg = '<i class="icon-ok text-success"></i> Services validated.<br/>';
                msg = msg+'Adding them to pool. Please wait...';
                HeaderUtils.changeLoadingModalMessage(msg);
                jQuery('#addServiceForm').submit();     
                //HeaderUtils.hideLoadingModal();
            }
        },
        error : function(xhr) {
            alert(xhr.responseText);
        }
    });

};
LbAddServices.getSelectedInstanceIds = function() {
    var selectedInstances = jQuery("[name='instanceId']:checked");
    var instanceIds = [];
    for (var i = 0; i < selectedInstances.length; i++) {
        instanceIds.push(selectedInstances.val());
    }
    return instanceIds;
};


jQuery(function() {
    LbAddServices.updateServicesName();

    // "Network interface" select change handler
    jQuery('#netInterface').change(function() {
        LbAddServices.updateServicesName();
    });
    // "Port" text input change handler
    jQuery('#port').change(function() {
        LbAddServices.updateServicesName();
    });
    jQuery("#submitButton").click(function() {
        LbAddServices.validateServicesBeforeSave();
    });
});
