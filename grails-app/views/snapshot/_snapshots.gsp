<table id="table_snapshotList" class="table table-normal sortable filtered">
    <thead>
    <tr>
        <td class="checkboxTd">&thinsp;x</td>
        <td>Name</td>
        <td>Description</td>
        <td>Size</td>
        <td>Status</td>
        <td>Volume ID</td>
    </tr>
    </thead>
    <tbody>
    <g:each var="s" in="${snapshots}" status="i">
        <tr class="snapshot_row">
            <td><g:checkBox id="checkBox_${s.id}" name="selectedSnapshots" value="${s.id}"
                            checked="0"/></td>
            <td class="snapshot_show_link"><g:linkObject type="snapshot" displayName="${s.name}" id="${s.id}"/></td>
            <td>${s.description}</td>
            <td>${s.size}</td>
            <td class="snapshot_status">${s.status}</td>
            <td>${s.volumeId}</td>
        </tr>
    </g:each>
    </tbody>
</table>