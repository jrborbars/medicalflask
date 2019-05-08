{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Adiciona Paciente{% endblock %}

{% block content %}
        <h2>Paciente</h2>
                {{ wtf.quick_form( form=formtpl) }}

        
{% endblock %}
