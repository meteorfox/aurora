var refreshJobsTable = function () {
    var container = jQuery('#table_container');
    var url = rootContextPath + '/lbaas/_jobs';
    var cellsToUpdate = ["job_creationDate", "job_completionDate", "job_taskType", "job_status", "job_comments"];
    var findIdName = "lbaasJob";
    var rowToUpdate = "job_row";
    jQuery.refreshTable(url, rowToUpdate, cellsToUpdate, findIdName);
};

function jobsCellUpdater(row, timeout, checkLink, jsonPath, finalStatus) {
    var continueRefresh = true;
    var interval = setInterval(function () {
        var status = '';
        if (checkLink) {
            jQuery.ajax({
                url: checkLink + '.json',
                dataType: 'json',
                success: function (data){
                    continueRefresh = false;
                    if (data.job) {
                        status = data.job.status;
                        row.find('.job_creationDate').html(data.job.creationDate);
                        row.find('.job_completionDate').html(data.job.completionDate);
                        row.find('.job_taskType').html(data.job.taskType);
                        row.find('.job_comments').html(data.job.comments);
                    }

                    row.find('.job_status').html(!in_array(status, finalStatus) ? status + ' ' + HeaderUtils.getSpinner() : status);
                    if (!in_array(status, finalStatus)) {continueRefresh = true;}
                },
                error: function () {
                    clearInterval(interval);
                }

            });
        }
        if (!continueRefresh){
            clearInterval(interval);
        }
    }, timeout);
}

function statusUpdate(row) {
    var showLink = row.find('.job_show_link a').attr('href');
    var jsonPath = String('job.status');
    jobsCellUpdater(row,5000,showLink,jsonPath, finalStatus);
}

function showPageUpdater() {
    var link = document.location.pathname;
    var status = '';
    var interval = setInterval(function () {
        if(link) {
            jQuery.ajax({
                url: link + '.json',
                dataType: 'json',
                success: function (data) {
                    if (data.job) {
                        status = data.job.status;
                        jQuery('#job_creationDate').html(data.job.creationDate);
                        jQuery('#job_completionDate').html(data.job.completionDate);
                        jQuery('#job_taskType').html(data.job.taskType);
                        jQuery('#job_comments').html(data.job.comments);
                    }
                    if (status && !in_array(status, finalStatus)) {
                        jQuery('#job_status').html(status + ' ' + HeaderUtils.getSpinner());
                    } else {
                        jQuery('#job_status').html(status);
                        clearInterval(interval);
                        //document.location = '/lbaas/listJobs';
                    }
                },
                error: function (textStatus, errorThrown) {
                    jQuery('#job_status').html("Request Error");
                    clearInterval(interval);
                    //document.location = '/lbaas/listJobs';
                }
            });
        }

        if (in_array(status, finalStatus)) {
            jQuery('#job_status').html(status);
            clearInterval(interval);
            //document.location = document.URL;
        }
    }, 5000);
}

jQuery(function () {
    // autorefresh task status on list-page
    jQuery.each(jQuery('.job_row'), function () {
        var statusCell = jQuery(this).find('.job_status');
        if (!in_array(jQuery.trim(statusCell.html()), finalStatus)) {
            statusCell.html(statusCell.html() + ' ' + HeaderUtils.getSpinner());
            statusUpdate(jQuery(this));
        }
        //statusUpdate(jQuery(this));
    });
    // refresh data for list-page
    if(jQuery('#table_container').length > 0) refreshJobsTable();

    //autorefresh task status on show-page
    var jobStatusValue = jQuery('#job_status');
    if (jobStatusValue.length > 0 && !in_array(jobStatusValue[0].innerText, finalStatus)) {
        jQuery('#job_status').html(jQuery('#job_status').html() + ' ' + HeaderUtils.getSpinner());
        showPageUpdater();
    }
});


