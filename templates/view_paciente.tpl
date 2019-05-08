{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Visualizar Médicos{% endblock %}

{% block content %}
        <h2>Médico</h2>
                    <p>Nome: {{ d.nome }}</p>
                    <p>Telefone: {{ d.telefone }}</p>
                    <p>CPF: {{ d.cpf }}</p>
         
                <a class="btn btn-info" href="{{ url_for('lista_medicos') }}" >Voltar</a>
{% endblock %}
