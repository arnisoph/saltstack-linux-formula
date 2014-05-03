{% from "linux/defaults.yaml" import rawmap with context %}
{% set datamap = salt['grains.filter_by'](rawmap, merge=salt['pillar.get']('linux:lookup')) %}

{% for m in salt['pillar.get']('linux:modules') %}
linux-module-{{ m.name }}-{{ m.ensure|default('present') }}:
  kmod:
    - {{ m.ensure|default('present') }}
    - name: {{ m.name }}
    - persist: {{ m.persist|default(False) }}
  {% if m.comment is defined %}
    - comment: {{ m.comment }}
  {% endif %}
{% endfor %}
