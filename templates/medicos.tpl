{% extends "base.tpl" %}
{% block title %}....::Médicos::....{% endblock %}

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
			<th>Nome</th>
			<th>Especialidade</th>
		</thead>
		<tbody>
			{% for dado in dadostpl %}
			<tr>
				<td>{{ dado.id }}</td>
				<td>{{ dado.nome }}</td>
				<td>{{ dado.especialidade }}</td>
				<td>
                    {% if current_user.is_authenticated %}
                        <a class="btn btn-warning" href="/medicosedit/{{ dado.id }}">Editar</a>
                    {% endif %}
                        <a class="btn btn-info" href="/medicosview/{{ dado.id }}">Visualizar</a>
                    {% if current_user.is_authenticated %}
                        <a class="btn btn-danger" href="/medicosdel/{{ dado.id }}">Deletar</a>
                    {% endif %}

                </td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
	<p><a href="/medicosadd" class="btn btn-info">Cadastra Médico</a></p>
{% endblock %}
