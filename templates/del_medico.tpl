{% extends "base.tpl" %}
{% import 'bootstrap/wtf.html' as wtf %}

{% block title %}Visualizar Médicos{% endblock %}

{% block content %}
        <h2>Médicos</h2>
        <p class="alert alert-danger"> Você tem certeza que deseja deletar o médico?</p>
            <form action="{{ url_for('del_medico_post', _id = d.id) }}" method="POST">
                    <input type="hidden" name="_id" value="{{ d.id }}" />
                    <p>Nome: {{ d.nome }}</p>
                
                    <button class="btn btn-danger" type="submit">Deletar</button>
                    <a class="btn btn-info" href="{{ url_for('lista_medicos') }}" >Voltar</a>
            </form>
{% endblock %}
