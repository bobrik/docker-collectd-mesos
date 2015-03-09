Hostname "{{ MESOS_HOST }}"

FQDNLookup false
Interval 10
Timeout 2
ReadThreads 5

LoadPlugin write_graphite
<Plugin "write_graphite">
    <Carbon>
        Host "{{ GRAPHITE_HOST }}"
        Port "{{ GRAPHITE_PORT | default("2003") }}"
        Protocol "tcp"
        Prefix "{{ GRAPHITE_PREFIX | default("collectd.") }}"
        StoreRates true
        AlwaysAppendDS false
        SeparateInstances true
    </Carbon>
</Plugin>

<LoadPlugin "python">
    Globals true
</LoadPlugin>

<Plugin "python">
    ModulePath "/usr/share/collectd/plugins/mesos"

    Import "mesos-{{ MESOS_MODE }}"
    <Module "mesos-{{ MESOS_MODE }}">
        Host "{{ MESOS_HOST }}"
        Port {{ MESOS_PORT }}
        Verbose false
        Version "{{ MESOS_VERSION }}"
    </Module>
</Plugin>
