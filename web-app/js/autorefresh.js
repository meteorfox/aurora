var finalStatusesMap = {instance_taskStatus : ['', null], instance_status:['Active','Error','Shutoff',null]};
var finalStatus = ['COMPLETED', 'FAILED'];

jQuery.refreshTable = function(url, rowToUpdate, cellsToUpdate, findIdName) {
    var updatedContent = {};
    jQuery.ajax({
        url: url,
        dataType: 'html',
        success: function (data) {
            jQuery.each(jQuery(data).find("tr"), function( index, value ) {
                if (index > 0) {
                    var rowInfo = jQuery(this);
                    var itemId = rowInfo.find("[name='"+findIdName+"']").attr('value');
                    updatedContent[itemId] = [];
                    jQuery.each(cellsToUpdate, function(i, value) {
                        if (rowInfo.find("."+value).length > 0)
                            updatedContent[itemId][i] = rowInfo.find("."+value).html();
                    });
                }
            });
            jQuery.each(jQuery('.' + rowToUpdate), function () {
                var row = jQuery(this);
                var itemId = row.find("[name='"+findIdName+"']").attr('value');
                if (updatedContent[itemId]) {
                    jQuery.each(cellsToUpdate, function(i, value) {
                        if (row.find("."+value).length > 0)  {
                            row.find("."+value).html(updatedContent[itemId][i]);
                        }
                    });
                }
                else row.remove();
            });
            if (jQuery('#volumes_info_box').length > 0) jQuery('#volumes_info_box').hide('slow');
        },
        error: function (data, event) {
            if (jQuery('#volumes_info_box').length > 0) jQuery('#volumes_info_box').html('Attachments loading error');
        }
    });

    return null;
}

function cellUpdater(cell, timeout, checkLink, jsonPath, refreshFunc, finalStatus) {
    var status = cell.html();
    var path = (String(jsonPath)).split(".");

    var interval = setInterval(function () {
        if (checkLink) {
            jQuery.ajax({
                url: checkLink + '.json',
                dataType: 'json',
                success: function (data){
                    status = data;
                    for (var i = 0;i<path.length;i++){
                        status = status[path[i]];
                    }
                    cell.html(!in_array(status, finalStatus) ? status + ' ' + HeaderUtils.getSpinner() : status);
                },
                error: function () {
                    status = null;
                }

            });
        }
        if (in_array(status, finalStatus)) {
            clearInterval(interval);
            if (refreshFunc) refreshFunc();
        }
    }, timeout);
}

function rowUpdater(row, timeout, checkLink, refreshFunc, finalStatusesMap) {
    var continueRefresh = true;
    var interval = setInterval(function(){
        if (checkLink) {
            jQuery.ajax({
                url: checkLink,
                dataType: 'html',
                success: function(data){
                    continueRefresh = false;
                    row.find(".instance_status").html((jQuery(data).find(".instance_status").html()));
                    row.find(".instance_taskStatus").html((jQuery(data).find(".instance_taskStatus").html()));
                    //row.find(".instance_help").html('');
                    for(var key in finalStatusesMap){
                        var statusCell = jQuery("."+key, row);
                        if (!in_array(statusCell.text().trim(),finalStatusesMap[key])){
                            continueRefresh = true;
                            statusCell.html(statusCell.text() + ' ' +HeaderUtils.getSpinner());
                        }
                    }
                },
                error: function(){
                    clearInterval(interval);
                    if (refreshFunc) refreshFunc();
                }
            });
        }
        if (!continueRefresh){
            clearInterval(interval);
            if (refreshFunc) refreshFunc();
        }
    },timeout)

}

function in_array(value, array)
{
    for(var i = 0; i < array.length; i++)
    {
        if(array[i] == value) return true;
    }
    return false;
}
