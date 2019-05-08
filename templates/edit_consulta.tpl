{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Edita Consulta{% endblock %}

{% block content %}
        <h2>Consulta</h2>
                {{ wtf.quick_form( form=formtpl, action=url_for('edit_consulta_post', _id = _id) )}}
{% endblock %}