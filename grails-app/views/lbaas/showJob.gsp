<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="lbaas"/>
    <meta name="menu-level-2" content="jobs"/> 
    <meta name="menu-level-3" content="Job Detail"/> 
    <title>Job Detail</title>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'lbaasJobs-ui.js')}"></script>
  </head>
  <body>

    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>          
          </div>
        </div>
        <g:form method="post">
          <div class="box">
            <div class="box-header">
              <span class="title">Job Detail ${job.jobId}</span>
            </div>
            <div class="box-content">
              <table id="table_lbassJob" class="table table-normal">
                <tbody>
                  <tr>
                    <td>ID</td>
                    <td class="prop">${job.jobId}</td>
                  </tr>
                  <tr>
                    <td>Creation date</td>
                    <td class="prop" id="job_creationDate">${job.creationDate}</td>
                  </tr>
                  <tr>
                    <td>Completion date</td>
                    <td class="prop" id="job_completionDate">${job.completionDate}</td>
                  </tr>
                  <tr>
                    <td>Task type</td>
                    <td class="prop" id="job_taskType">${job.taskType}</td>
                  </tr>
                  <tr>
                    <td>Status</td>
                    <td class="prop" id="job_status">${job.status}</td>
                  </tr>
                  <tr>
                    <td>Comments</td>
                    <td class="prop" id="job_comments">${job.comments}</td>
                  </tr>
                  <tr>
                    <td>Payload</td>
                    <td class="prop">${job.requestBody}</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </g:form>
      </div>
    </div>
  </body>
</html>