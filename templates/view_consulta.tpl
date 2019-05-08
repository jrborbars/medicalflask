{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Visualizar Consulta{% endblock %}

{% block content %}
        <h2>Sua consulta</h2>
                    <p>Data: {{ d.data }}</p>
                    <p>Nome do Paciente: {{ d.paciente }}</p>
                    <p>Nome do Médico: {{ d.medico }}</p>
                    <p>Horário da consulta: {{ d.horario }}</p>
                    <p></p>
         			<p></p>
                <a class="btn btn-info" href="{{ url_for('mostra_consultas') }}" >Voltar</a>
{% endblock %}