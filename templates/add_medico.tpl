{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Adiciona Médicos{% endblock %}

{% block content %}
        <h2>Médico</h2>
                {{ wtf.quick_form( form=formtpl) }}

        
{% endblock %}
