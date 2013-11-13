<table id="table_lbassJobs" class="table table-normal sortable filtered">
    <thead>
    <tr>
        <td>ID</td>
        <td>Creation date</td>
        <td>Completion date</td>
        <td>Task type</td>
        <td>Status</td>
        <td>Comments</td>
    </tr>
    </thead>
    <tbody>
    <g:each var="job" in="${jobs}" status="i">
        <tr class="job_row">
            <td class="job_show_link"><div><g:link id="${job.jobId}" controller="lbaas" action="showJob">${job.jobId}</g:link><input type="hidden" name="lbaasJob" value="${job.jobId}" /></div></td>
            <td class="job_creationDate">${job.creationDate}</td>
            <td class="job_completionDate">${job.completionDate}</td>
            <td class="job_taskType">${job.taskType}</td>
            <td class="job_status">${job.status}</td>
            <td class="job_comments">${job.comments}</td>
        </tr>
    </g:each>
    </tbody>
</table>