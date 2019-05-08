{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Adiciona Consultas{% endblock %}

{% block content %}
        <h2>Consulta</h2>
                {{ wtf.quick_form( form=formtpl) }}

{% endblock %}
