<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>Hospital</title>

  <!-- Bootstrap core CSS -->
  <link href="static/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="static/css/scrolling-nav.css" rel="stylesheet">

</head>

<body id="page-top">

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

  <!-- Bootstrap core JavaScript -->
  <script src="static/vendor/jquery/jquery.min.js"></script>
  <script src="static/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Plugin JavaScript -->
  <script src="static/vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Custom JavaScript for this theme -->
  <script src="static/js/scrolling-nav.js"></script>

</body>

</html>
