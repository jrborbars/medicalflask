{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Edita Paciente{% endblock %}

{% block content %}
        <h2>Paciente</h2>
                {{ wtf.quick_form( form=formtpl, action=url_for('edit_paciente_post', _id = _id) )}}
{% endblock %}