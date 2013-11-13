<%@ page import="com.paypal.aurora.InstanceController; com.paypal.aurora.OpenStackRESTService; grails.converters.JSON; com.paypal.aurora.Constant" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="mainWithNav"/>
    <meta name="menu-level-1" content="compute"/> 
    <meta name="menu-level-2" content="images"/> 
    <meta name="menu-level-3" content="${bType} Detail"/> 

    <title>${image.id} ${image.name} ${bType}</title>
      <script type="text/javascript" src="${resource(dir: 'js', file: 'autorefresh.js')}"></script>
      <script type="text/javascript" src="${resource(dir: 'js', file: 'image-ui.js')}"></script>

  </head>

  <body>

    <div class="body">
      <div class="container">
        <div class="row">
          <div class="col-md-12">
            <g:if test="${flash.message}">
              <div id="message" class="alert alert-info">${flash.message}</div>
            </g:if>          
            <g:hasErrors bean="${cmd}">
              <div id="error_message" class="alert alert-error">
                <g:renderErrors bean="${cmd}" as="list"/>
              </div>
            </g:hasErrors>
          </div>
        </div>
        <div class="box">
          <div class="box-header">
            <span class="title">${bType} Detail</span>
            <shiro:hasRole name="${Constant.ROLE_ADMIN}">
              <g:form>
                <ul class="box-toolbar">

                  <input type="hidden" id="id" name="id" value="${image.id}"/>
                  <g:if test="${isSnapshot}">
                    <li><g:link elementId="create" class="btn btn-xs btn-green" controller="instance" 
                                action="create" title="Launch instance from this snapshot"
                                params="[selectedInstanceSource: InstanceController.InstanceSources.SNAPSHOT,
                                snapshotId: image.id]">Launch</g:link></li>
                  </g:if>
                  <li><g:link elementId="edit" class="btn btn-xs btn-blue" action="edit" 
                              params="[id: image.id]" 
                              title="Edit ${sType} name and sharing">Edit ${bType} Attributes</g:link></li>
                  <li><g:buttonSubmit id="delete" class="btn btn-xs btn-red delete" action="delete" 
                                      value="Delete ${bType}"
                                      data-warning="Really delete ${sType} '${image.id}' with name '${image.name}'?" 
                                      title="Delete this ${sType}"/></li>

                </ul>
              </g:form>  
            </shiro:hasRole>
          </div>        

          <div class="box-content">
            <table id="table_showImage" class="table table-normal">
              <tbody>
                <tr>
                  <td>ID</td>
                  <td>${image.id}</td>
                </tr>
                <tr>
                  <td>Name</td>
                  <td>${image.name}</td>
                </tr>
                <tr>
                  <td>Status</td>
                  <td id="image_status_value">${image.status}
              <g:if test="${image.status != 'active' && image.status != 'killed'}">
                <img src="${resource(dir: 'images', file: 'spinner.gif')}"/>
              </g:if></td>
              </tr>
              <tr>
                <td>Public</td>
                <td>${image.shared}</td>
              </tr>
              <tr>
                <td>Checksum</td>
                <td>${image.checksum}</td>
              </tr>
              <tr>
                <td>Created</td>
                <td>${image.created}</td>
              </tr>
              <tr>
                <td>Updated</td>
                <td>${image.updated}</td>
              </tr>
              <tr>
                <td>Container format</td>
                <td>${image.containerFormat}</td>
              </tr>
              <tr>
                <td>Disk format</td>
                <td>${image.diskFormat}</td>
              </tr>
 
              <g:if test="${isSnapshot}">
                <tr>
                  <td>RAM disk ID</td>
                  <td>${image.properties.ramdisk_id}</td>
                </tr>
                <tr>
                  <td>Image location</td>
                  <td>${image.properties.image_location}</td>
                </tr>
                <tr>
                  <td>Image state</td>
                  <td>${image.properties.image_state}</td>
                </tr>
                <tr>
                  <td>Kernel ID</td>
                  <td>${image.properties.kernel_id}</td>
                </tr>
                <tr>
                  <td>Owner ID</td>
                  <td>${image.properties.owner_id}</td>
                </tr>
                <tr>
                  <td>User ID</td>
                  <td>${image.properties.user_id}</td>
                </tr>
                <tr>
                  <td>Instance UUID</td>
                  <td>${image.properties.instance_uuid}</td>
                </tr>
                <tr>
                  <td>Base image ref</td>
                  <td>${image.properties.base_image_ref}</td>
                </tr>

              </g:if>
              </tbody>
            </table>

          </div>
        </div>
      </div>
    </div>
  </body>
</html>
