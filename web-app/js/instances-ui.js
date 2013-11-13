var Instances = {};
Instances.IdsForInstancesWithAjaxCallRunning = [];
Instances.IdsToIntervals = {};
Instances.isAjaxCallForInstanceCurrentlyRunning = function(instanceId) {
    return (isInArray(instanceId, Instances.IdsForInstancesWithAjaxCallRunning));
};
Instances.handleInstanceJsonDataSuccess = function(instanceId, instanceJson, row) {
    getStatusCell(row).html(instanceJson.status);
    
    if(!instanceJson.taskStatus) {
        getTaskStatusCell(row).html('');
    } else {
       getTaskStatusCell(row).html(instanceJson.taskStatus);
    }
    getPowerStateCell(row).html(instanceJson.powerStatus);

    if(checkIfRowRequiresRefresh(row)) {
        showSpinnerForRow(row);
    } else {
        clearInterval(Instances.IdsToIntervals[instanceId]);
        Instances.reloadInstanceRowHtml(instanceId, row);
    }
};

Instances.handleInstanceDeleted =  function(instanceId, row) {
    clearInterval(Instances.IdsToIntervals[instanceId]);
    jQuery(".instance_ip", row).html('');   
    jQuery(".instance_select", row).html('');   
    getInstanceLinkCell(row).html(getInstanceName(row));    
    getStatusCell(row).html('Deleted&nbsp;&nbsp;&nbsp;<i class="icon-ok"></i>');
    getTaskStatusCell(row).html('');
    getPowerStateCell(row).html('');
    getLoginHelpCell(row).html('');
    jQuery(".instance_host", row).html(''); 
};

var ROW_REFRESH_DELAY = 5000;

var finalStatusArray = ['Active','Error','Shutoff','Paused'];

function isFinalStatus(instanceStatus) {
    if(isInArray(instanceStatus.trim(), finalStatusArray)) {
        return true;
    }
    return false;
}
function isFinalTaskStatus(instanceTaskStatus) {
    if(instanceTaskStatus==null || 
        instanceTaskStatus.trim().length==0) {
        return true;
        }
    return false;
}
function getTaskStatusCell(rowObject) {
    return jQuery(".instance_taskStatus", rowObject);   
}
function getStatusCell(rowObject) {
    return jQuery(".instance_status", rowObject);
}
function getPowerStateCell(rowObject) {
    return jQuery(".instance_powerStatus", rowObject);
}
function getInstanceName(rowObject) {
    return jQuery(".instance_name", rowObject).html();
}
function getInstanceLinkCell(rowObject) {
    return jQuery(".instance_show_link", rowObject);
}
function getLoginHelpCell(rowObject) {
    return jQuery(".instance_help", rowObject);
}

function loadFloatingIPs () {
    showSpinnersForRowsWithNonFinalStatuses();
    showSpinnersForEmptyFloatingIpCells(jQuery('#table_container'));
    updateFloatingIps();
    checkAndQueueInstanceRowAutoRefresh();
}
function showSpinnersForEmptyFloatingIpCells(container) {
    jQuery(container).find('.instance_ip').each(function () {
        if(jQuery(this).html().trim()=='') {
            jQuery(this).html(HeaderUtils.getSpinner());
        }        
    });
}

function showSpinnersForRowsWithNonFinalStatuses() {
    jQuery('#table_container').find('.instance_row').each(function () {
        if(checkIfRowRequiresRefresh(jQuery(this))) {
            showSpinnerForRow(this);
        }        
    });
}
function showSpinnerForRow(rowObject) {
    var rowTaskStatusCell = getTaskStatusCell(rowObject);
    
    if(!isFinalTaskStatus(rowTaskStatusCell.text())) {
        rowTaskStatusCell.html(rowTaskStatusCell.text()+' '+HeaderUtils.getSpinner());
    }
    var rowStatusCell = getStatusCell(rowObject);
    if(!isFinalStatus(rowStatusCell.text())) {
        rowStatusCell.html(rowStatusCell.text()+' '+HeaderUtils.getSpinner());
    }
}
Instances.reloadInstanceRowHtml = function(instanceId, row) {
    var url = rootContextPath + "/instance/_instanceRow/"+instanceId+'.html';

    jQuery.ajax({
        url: url,
        dataType: 'html',
        success: function(newRowHtml) {
            row.replaceWith(newRowHtml);
            showSpinnersForEmptyFloatingIpCells(row);
            updateFloatingIps();
        },
        error: function(xhr, status, thrownError) {
            if (xhr.readyState < 4) {
                   xhr.abort();
            } else {
                //do something here. For now ignore the error. Data will just not get refreshed.
            }
        }
    });
};
var updateFloatingIps = function () {
    var container = jQuery('#table_container');

    jQuery.ajax({
        url: rootContextPath + '/instance/_instances',
        dataType: 'html',
        success: function (data) {
            var updatedContent = [];
            // update ONLY table cells with IP, not the whole table, because whole tables update broke filtering and sorting
            jQuery('#temp_table_holder').html(data);  
            try {
            jQuery('#temp_table_holder').find("tbody tr").each(function( index, value ) {
                
                updatedContent[index] = [];
                updatedContent[index]['instance_ip'] =  jQuery(this).find(".instance_ip").html();
                if (jQuery(this).find(".instance_help").length > 0)
                    updatedContent[index]['instance_help'] =  jQuery(this).find(".instance_help").html();
            });
            jQuery.each(container.find("tbody tr"), function( index, value ) {
                
                     jQuery(this).find(".instance_ip").html(updatedContent[index]['instance_ip']);
                     if (jQuery(this).find(".instance_help").length > 0) {
                        jQuery(this).find(".instance_help").html(updatedContent[index]['instance_help']);
                        
                     }
            });
            } catch(e) {
                //alert(e);
            }
            jQuery('#temp_table_holder').html('');

        },
        error: function(xhr, textStatus, errorThrown) {
            if (xhr.readyState < 4) {
                   xhr.abort();
            } else {
                //Do nothing for now.
            }
        }
    });
};

function showLoginHelp(ipaddress) {
    HeaderUtils.showPopup({title:'Loading Login Hints', text:HeaderUtils.getSpinnerForLoadingDialog()});
    //Attempt to load fqdn. If that does not work, show help with ip.
    HeaderUtils.doAjaxJson({
        method:'POST',
        url:rootContextPath + '/instance/getFQDN.json?ip=' + ipaddress,
        success: function (data) {
            if (data.address) {
                subsituteAddressInLoginHelp(data.address);
            } else {
                subsituteAddressInLoginHelp(ipaddress);
            }
        },
        error: function () {
            subsituteAddressInLoginHelp(ipaddress);
        }
    });
}
function subsituteAddressInLoginHelp(address) {
    jQuery("#corp_credentials").text("ssh " + userName + "@" + address);
    jQuery("#root_credentials").html("ssh root@"+address);
    HeaderUtils.showPopup({title:'Login Help', text:jQuery('#credentialsArea').html()});
}

var refreshInstanceTable = function () {

    var container = jQuery('#table_container');
    var url = rootContextPath + '/instance/_instances';
    var cellsToUpdate = ["instance_ip", "instance_status", "instance_host", "instance_taskStatus", "instance_help"];
    var findIdName = "selectedInstances";
    var rowToUpdate = "instance_row";
    jQuery.refreshTable(container, url, rowToUpdate, cellsToUpdate, findIdName);

};

function loadFloatingIPsForShow() {
    var link = rootContextPath + '/instance/_instanceFloatingIps/' + instanceId;

    jQuery("tr#instanceFloatingIps").html('<td colspan="2">Floating IPs are loading '+HeaderUtils.getSpinner()+'</td>');
    jQuery.ajax({
        url: link,
        dataType: 'html',
        success: function (data) {
            jQuery("tr#instanceFloatingIps").replaceWith(data);
            //autorefreshStatus();
            //Any new buttons added e.g. the dissociate floating ip. then initialize confirmation on button click.
        },
        error: function() {
            jQuery("tr#instanceFloatingIps").addClass('danger');
            jQuery("tr#instanceFloatingIps").html('<td colspan="2">Floating IPs are unavailable</td>');
            //autorefreshStatus();
        }
    });
}


function setupRowRefresh(row) {
    var instanceId = row.find("[name='selectedInstances']").attr('value');
    var url = rootContextPath + "/instance/_instanceRow/"+instanceId+'.json';

    var interval = setInterval(function() {
        if(Instances.isAjaxCallForInstanceCurrentlyRunning(instanceId)) {
            return;
        }
        addToArray(instanceId, Instances.IdsForInstancesWithAjaxCallRunning);
        
        jQuery.ajax({
            url: url,
            dataType: 'json',
            success: function(data) {
                Instances.IdsForInstancesWithAjaxCallRunning = removeFromArray(instanceId, Instances.IdsForInstancesWithAjaxCallRunning);

                if(data.errors || data.errorCode) {
                    if(data.errorCode=='404') {
                        Instances.handleInstanceDeleted(instanceId,row);
                    } else {
                        //Do nothing. The refresh should try again.
                    }
                } else {
                    Instances.handleInstanceJsonDataSuccess(instanceId, data.instance, row);
                }
            },
            error: function(jqXHR, status, thrownError) {
                Instances.IdsForInstancesWithAjaxCallRunning = removeFromArray(instanceId, Instances.IdsForInstancesWithAjaxCallRunning);
                if(jqXHR.status==404) {
                    Instances.handleInstanceDeleted(instanceId,row);
                }
                //Stop refreshes. //Show error.
                //var responseText = jQuery.parseJSON(jqXHR.responseText);
                //alert(jqXHR.responseText);
                
            }
        });
        
    }, ROW_REFRESH_DELAY);
    Instances.IdsToIntervals[instanceId]=interval;
}
function showPageUpdater(){
    var link = document.location.pathname;
    var taskStatus = 1;
    var interval = setInterval(function () {
        if (link) {
            jQuery.ajax({
                url: link + '.json',
                dataType: 'json',
                success: function (data) {
                    if(data.instance) {
                        taskStatus = data.instance.taskStatus;
                        if (taskStatus){
                            jQuery('#instance_show_buttons_area').html('<b>'+taskStatus+'</b><img src="' + rootContextPath + '/images/spinner.gif"/>');
                            if (taskStatus == 'Deleted'){
                                clearInterval(interval);
                                document.location = rootContextPath + '/instance/list';
                            }
                        }
                    } else {
                        clearInterval(interval);
                        document.location = rootContextPath + '/instance/list';
                    }
                },
                error: function (textStatus, errorThrown) {
                    clearInterval(interval);
                    document.location = rootContextPath + '/instance/list';
                }
            });
        }
        if (!taskStatus) {
            clearInterval(interval);
            document.location = document.URL;
        }
    }, PAGE_REFRESH_DELAY);
}

function checkIfRowRequiresRefresh(rowObject) {
    var rowTaskStatus = getTaskStatusCell(rowObject).text().trim();
    var rowStatus = getStatusCell(rowObject).text().trim();
    if(isFinalTaskStatus(rowTaskStatus) && isFinalStatus(rowStatus)) {
        return false;
    }
    return true;
}
/*
function autorefreshStatus() {
    // autorefresh status and task status on list-page
    jQuery.each(jQuery('.instance_row'), function () {
        var needRefresh = checkIfRowRequiresRefresh(jQuery(this));
        if(needRefresh){
            statusUpdate(jQuery(this));
        }
    });

    //autorefresh task status on show-page
    var buttonsAreas = jQuery('#instance_show_buttons_area');
    if(buttonsAreas.length && jQuery('#taskStatus',buttonsAreas[0]).length){
        showPageUpdater();
    }
}
*/
function checkAndQueueInstanceRowAutoRefresh() {
    // autorefresh status and task status on list-page
    jQuery('.instance_row').each(function () {
        var needRefresh = checkIfRowRequiresRefresh(jQuery(this));
        if(needRefresh){
            setupRowRefresh(jQuery(this));
        }
    });
}
function initCreatePage() {
    jQuery('#snapshotSources').hide();

    jQuery('#cb_instance_source').change(function () {
        var selectVal = jQuery(this).val();
        if (selectVal == imageString) {
            jQuery('#snapshotSources').hide();
            jQuery('#imageSources').show();
        } else if (selectVal == snapshotString) {
            jQuery('#snapshotSources').show();
            jQuery('#imageSources').hide();
        }
    });

    jQuery('#cb_instance_source').change();
        jQuery('#cb_options').change(function () {
        var selectVal = jQuery(this).val();
        if (selectVal == notBootString) {
            jQuery('#volumes').hide();
            jQuery('#volumeSnapshots').hide();
            jQuery('#deviceName').hide();
            jQuery('#deleteOnTerminate').hide();
        } else if (selectVal == bootFromVolumeString) {
            jQuery('#volumes').show();
            jQuery('#volumeSnapshots').hide();
            jQuery('#deviceName').show();
            jQuery('#deleteOnTerminate').show();
        } else if (selectVal == bootFromSnapshotString) {
            jQuery('#volumes').hide();
            jQuery('#volumeSnapshots').show();
            jQuery('#deviceName').show();
            jQuery('#deleteOnTerminate').show();
        }
    });

    jQuery('#cb_options').change();
    
}
jQuery(function () {
    jQuery("#root_credentials, #corp_credentials").click(function() {
        jQuery(this).select();
    });

});



