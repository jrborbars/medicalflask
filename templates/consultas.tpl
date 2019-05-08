{% extends "base.tpl" %}
{% block title %}....::Consultas::....{% endblock %}

{% block content %}
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
			<th>Data</th>
			<th>Paciente</th>
			<th>Medico</th>
			<th>Horario</th>
		</thead>
		<tbody>
			{% for dado in dadostpl %}
			<tr>
				<td>{{ dado.id }}</td>
				<td>{{ dado.data }}</td>
				<td>{{ dado.paciente }}</td>
				<td>{{ dado.medico }}</td>
				<td>{{ dado.horario }}</td>
				<td>
                    {% if current_user.is_authenticated %}
                        <a class="btn btn-warning" href="/consultasedit/{{ dado.id }}">Editar</a>
                    {% endif %}
                        <a class="btn btn-info" href="/consultasview/{{ dado.id }}">Visualizar</a>
                    {% if current_user.is_authenticated %}
                        <a class="btn btn-danger" href="/consultasdel/{{ dado.id }}">Deletar</a>
                    {% endif %}

                </td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
	<p><a href="/consultaadd" class="btn btn-info">Agendar Consulta</a></p>
{% endblock %}