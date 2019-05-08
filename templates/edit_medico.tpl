{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Edita Médico{% endblock %}

{% block content %}
        <h2>Usuário</h2>
                {{ wtf.quick_form( form=formtpl, action=url_for('edit_medico_post', _id = _id) )}}
{% endblock %}