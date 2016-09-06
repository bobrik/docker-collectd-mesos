Hostname "{{ COLLECTD_HOST | default(MESOS_HOST) }}"

FQDNLookup false
Interval {{ COLLECTD_INTERVAL | default("10") }}
Timeout 2
ReadThreads 5

{% if GRAPHITE_HOST is defined %}
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
{% endif %}

{% if INFLUXDB_HOST is defined %}
LoadPlugin network
<Plugin "network">
    Server "{{ INFLUXDB_HOST }}" "{{ INFLUXDB_PORT | default("25826") }}"
</Plugin>
{% endif %}

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
