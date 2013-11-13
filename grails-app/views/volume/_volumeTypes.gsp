<table id="table_volumeTypes" class="table table-normal sortable filtered">
  <thead>
    <tr>
      <td class="checkboxTd">&thinsp;x</td>
      <td>Name</td>
    </tr>
  </thead>
  <tbody>
  <g:each var="volumeType" in="${volumeTypes}" status="i">
    <tr>
      <td><g:checkBox id="checkBox_${volumeType.id}" name="selectedVolumeTypes"
                    value="${volumeType.id}" checked="0"/></td>
    <td><g:link elementId="showType-${volumeType.id}" action="showType"
                params="[id: volumeType.id]">${volumeType.name}</g:link></td>
    </tr>
  </g:each>
</tbody>
</table>