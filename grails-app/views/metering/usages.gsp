<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Usages</title>
    <script type="text/javascript" src="${resource(dir: 'js/d3', file: 'd3.v3.min.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js/nvd3', file: 'nv.d3.js')}"></script>
    <script type="text/javascript" src="${resource(dir: 'js', file: 'metrics-ui.js')}"></script>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'nv.d3.css')}"/>
    <style>
        #multiMetricsChart svg {
            height: 400px;
            width: 600px;
        }
        #cpuMetricsChart svg {
            height: 400px;
            width: 600px;
        }
        #vcpuMetricsChart svg {
            height: 400px;
            width: 600px;
        }
        #memoryMetricsChart svg {
            height: 400px;
            width: 600px;
        }
        #diskMetricsChart svg {
            height: 400px;
            width: 600px;
        }
    </style>
    <script>
        var cpuMetricsUrl = rootContextPath + '/metering/getSamples.json?type=cpu_util&showCurrentTenant=true';
        var vcpuMetricsUrl = rootContextPath + '/metering/getSamples.json?type=vcpus&showCurrentTenant=true';
        var diskMetricsUrl = rootContextPath + '/metering/getSamples.json?type=disk.root.size&showCurrentTenant=true';
        var diskEphemeralUrl = rootContextPath + '/metering/getSamples.json?type=disk.ephemeral.size&showCurrentTenant=true';
        var memoryMetricsUrl = rootContextPath + '/metering/getSamples.json?type=memory&showCurrentTenant=true';
    </script>
</head>
<body>
<div class="body">
    <g:if test="${flash.message}">
        <div id="message" class="message">${flash.message}</div>
    </g:if>
    <g:hasErrors bean="${cmd}">
        <div id="error_message" class="error">
            <g:renderErrors bean="${cmd}" as="list"/>
        </div>
    </g:hasErrors>
    <!--
    <div id="multiMetricsChart" style="float: left;">
        <h2>VCPU/Memory Usage</h2>
        <svg></svg>
    </div>
    -->
    <div id="cpuMetricsChart" style="float: left;">
        <h2>CPU Usage</h2>
        <svg></svg>
    </div>
    <div id="memoryMetricsChart" style="float: left;">
        <h2>Memory Usage</h2>
        <svg></svg>
    </div>
    <div id="vcpuMetricsChart" style="float: left;">
        <h2>VCPU Usage</h2>
        <svg></svg>
    </div>
    <div id="diskMetricsChart" style="float: left;">
        <h2>Disk Usage</h2>
        <svg></svg>
    </div>
</div>
</body>
</html>