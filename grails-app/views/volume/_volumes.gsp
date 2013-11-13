<table id="table_volumeList" class="table table-normal sortable filtered">
    <thead>
    <tr>
        <td class="checkboxTd">&thinsp;x</td>
        <td>Name</td>
        <td>Status</td>
        <td>Type</td>
        <td>Attached To</td>
        <td>Size (GB)</td>
    </tr>
    </thead>
    <tbody>
    <g:each var="volume" in="${volumes}" status="i">
        <tr class="volume_row">
            <td><g:checkBox id="checkBox_${volume.id}" name="selectedVolumes" value="${volume.id}"
                            checked="0"/></td>
            <td class="volume_show_link"><g:linkObject type="volume" displayName="${volume.displayName}" id="${volume.id}"/></td>
            <td class='volume_status'>
                ${volume.status}
            </td>
            <td>${volume.volumeType}</td>
            <td class="volume_attached">
                <g:if test="${volume.instanceName}">
                    Attached to <g:linkObject type="instance" displayName="${volume.instanceName}"
                                              id="${volume.instanceId}"/> on
                    ${volume.device}
                </g:if>
            </td>
            <td>${volume.size}</td>
        </tr>
    </g:each>
    </tbody>
</table>