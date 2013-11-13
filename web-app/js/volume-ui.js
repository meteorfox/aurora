var finalStatus = ['available','in-use', undefined, '', 'error'];

var refreshVolumeTable = function () {
    var url = rootContextPath + '/volume/_volumes';
    var cellsToUpdate = ["volume_status", "volume_attached"];
    var findIdName = "selectedVolumes";
    var rowToUpdate = "volume_row";
    jQuery.refreshTable(url, rowToUpdate, cellsToUpdate, findIdName);
};


function statusUpdate(cell, timeout) {
    var showLink = cell.parent().find('.volume_show_link a').attr('href');
    var jsonPath = String('volume.status');
    cellUpdater(cell, timeout, showLink, jsonPath, refreshVolumeTable, finalStatus);
}

function showPageUpdater() {
    var link = document.location.pathname;
    var status = 1;
    var interval = setInterval(function () {
        if(link) {
            jQuery.ajax({
                url: link + '.json',
                dataType: 'json',
                success: function (data) {
                    if (data.volume) {
                        status = data.volume.status;
                    } else {
                        status = undefined;
                    }
                    if (status && !in_array(status, finalStatus)) {
                        jQuery('#volume_status_value').html(status + HeaderUtils.getSpinner());
                    } else {
                        clearInterval(interval);
                        document.location = rootContextPath + '/volume/list';
                    }
                },
                error: function (textStatus, errorThrown) {
                    clearInterval(interval);
                    document.location = rootContextPath + '/volume/list';
                }
            });
        }

        if (in_array(status, finalStatus)) {
            clearInterval(interval);
            document.location = document.URL;
        }
    }, 3000);
}

jQuery(function () {
    
    // autorefresh task status on list-page
    jQuery.each(jQuery('.volume_status'), function () {
        if (!in_array(jQuery.trim(jQuery(this).html()), finalStatus)) {
            jQuery(this).html(jQuery(this).html() + HeaderUtils.getSpinner());
            statusUpdate(jQuery(this), 3000);
        }
    });

    jQuery('#volumes_info_box').html('Attachments are loading '+ HeaderUtils.getSpinner());
    statusUpdate(jQuery(this), 500);

    //autorefresh task status on show-page
    var volumeStatusValue = jQuery('#volume_status_value');
    if (volumeStatusValue.length && !in_array(volumeStatusValue[0].innerText, finalStatus)) {
        volumeStatusValue.html(volumeStatusValue.html() + HeaderUtils.getSpinner());
        showPageUpdater();
    }
    
});




