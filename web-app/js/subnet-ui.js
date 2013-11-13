jQuery(function() {
    jQuery( "#dialog" ).dialog({
        resizable: false,
        autoOpen: false,
        height:400,
        width: 400,
        modal: true
    });
    // for subnet create
    //jQuery('#subnetTabs').tabs();

    var position = { position: { my: "left+15 center", at: "right center" }}
    jQuery("#allocationPools").tooltip(position);
    jQuery("#dnsName").tooltip(position);
    jQuery("#hostRoutes").tooltip(position);
    jQuery("#name").tooltip(position);
    jQuery("#networkAddress").tooltip(position);
    jQuery("#gatewayIp").tooltip(position);
});
