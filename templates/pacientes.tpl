{% extends "base.tpl" %}
{% block title %}....::Médicos::....{% endblock %}

{% block content %}
	<table class="table table-stripped">
		<thead>
			<th>#</th>
			<th>Nome</th>
			<th>Telefone</th>
			<th>CPF</th>
		</thead>
		<tbody>
			{% for dado in dadostpl %}
			<tr>
				<td>{{ dado.id }}</td>
				<td>{{ dado.nome }}</td>
				<td>{{ dado.telefone }}</td>
				<td>{{ dado.cpf }}</td>
				<td>
                    {% if current_user.is_authenticated %}
                        <a class="btn btn-warning" href="/pacientesedit/{{ dado.id }}">Editar</a>
                    {% endif %}
                        <a class="btn btn-info" href="/pacientesview/{{ dado.id }}">Visualizar</a>
                    {% if current_user.is_authenticated %}
                        <a class="btn btn-danger" href="/pacientesdel/{{ dado.id }}">Deletar</a>
                    {% endif %}

                </td>
			</tr>
			{% endfor %}
		</tbody>
	</table>
	<p><a href="/pacientesadd" class="btn btn-info">Cadastra Paciente</a></p>
{% endblock %}