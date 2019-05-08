{% extends "base.tpl" %}

{% block title %}....:: Hospital ::....{% endblock %}

{% block body_attribs %}
    id="page-top"
{% endblock %}



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

  <!-- Navigation -->
  <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top" id="mainNav">
    <div class="container">
      <a class="navbar-brand js-scroll-trigger" href="#">Sistema de consultas médicas</a>
      <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
      </button>
      <div class="collapse navbar-collapse" id="navbarResponsive">
        <ul class="navbar-nav ml-auto">
          <li class="nav-item">
            {% if current_user.is_anonymous %}
            <a class="nav-link js-scroll-trigger" href="/login">Login</a>
            {% endif %}
          </li>
          
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/medicos">Médicos</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/pacientes">Pacientes</a>
          </li>
          <li class="nav-item">
            <a class="nav-link js-scroll-trigger" href="/consultas">Consultas</a>
          </li>
          <li class="nav-item">
            {% if current_user.is_authenticated %}
            <a class="nav-link js-scroll-trigger" href="/logout">Logout</a>
            {% endif %}
          </li>
        </ul>
      </div>
    </div>
  </nav>

  <header class="bg-primary text-white">
    <div class="container text-center">
      <h1>Bem-vindo ao sistema de consultas médicas.</h1>
      <p class="lead">Exercicio da matéria inf9, para fixação antes da prova.</p>
    </div>
  </header>


  <section id="contact">
    <div class="container">
      <div class="row">
        <div class="col-lg-8 mx-auto">
          <h2>Sobre nós</h2>
          <p class="lead">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vero odio fugiat voluptatem dolor, provident officiis, id iusto! Obcaecati incidunt, qui nihil beatae magnam et repudiandae ipsa exercitationem, in, quo totam.</p>
        </div>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="py-5 bg-dark">
    <div class="container">
      <p class="m-0 text-center text-white">Copyright &copy; Meu Website 2019</p>
    </div>
    <!-- /.container -->
  </footer>
{% endblock %}
