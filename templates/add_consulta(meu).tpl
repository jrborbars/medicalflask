{% extends "base.tpl" %}
{% block title %}Lista Pacientes{% endblock %}
 
{% block content %}
        {% if current_user.is_authenticated %}
        {% endif %}
        {% with messages = get_flashed_messages(with_categories=true) %}
          {% if messages %}
            <ul class="flashes">
            {% for category, message in messages %}
              <li class="alert alert-{{ category }}"  role="alert" >{{ message }}</li>
            {% endfor %}
            </ul>
          {% endif %}
        {% endwith %}
        <table class="table table-stripped">
            <thead>
                <th>#</th>
                <th>Medico</th>
                <th>Paciente</th>
                <th>Horario</th>
                <th>Data</th>
            </thead>
            <tbody>
                {% for dado in dadostpl %}
                <tr>
                    <td>{{ dado[0] }}</td>
                    <td>{{ dado[2] }}</td>
                    <td>{{ dado[1] }}</td>
                    <td>{{ dado[3] }}</td>
                    <td>{{ dado[4] }}</td>
                    <td>
                    {% if dado[7] == 0 %}
                        <a class="btn btn-success" href="//agendapaciente/{{ dado[0] }}">Agendar</a>
                        <a class="btn btn-light" href="">Cancelar Consulta</a>
                    {% else %}
                        <a class="btn btn-light" href="">Agendar</a>
                        <a class="btn btn-success" href="/devolveemprestimo/{{ dado.eid }}">Cancelar Consulta</a>
                    {% endif %}
                    </td>
                </tr>
                {% endfor %}
            </tbody>
        </table>
{% endblock %}
