{% import "bootstrap/wtf.html" as wtf %}
<!DOCTYPE html>
<html lang="en">

<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>..:: Login ::..</title>

  <!-- Bootstrap core CSS -->
  <link href="{{ url_for('static', filename='vendor/bootstrap/css/bootstrap.min.css') }}" rel="stylesheet">

  <!-- Custom fonts for this template -->
  <link href="{{ url_for('static', filename='vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic" rel="stylesheet" type="text/css">

  <!-- Plugin CSS -->
  <link href="{{ url_for('static', filename='vendor/fontawesome-free/css/all.min.css') }}" rel="stylesheet" type="text/css">

  <!-- Custom styles for this template -->
  <link href="{{ url_for('static', filename='css/freelancer.min.css') }}" rel="stylesheet">

</head>

<body id="page-top">

<div class="container login-container">
            <div class="row" >
                {% with messages = get_flashed_messages(with_categories=true) %}
                  {% if messages %}
                    <ul class="flashes">
                    {% for category, message in messages %}
                      <li class="alert alert-{{ category }}">{{ message }}</li>
                    {% endfor %}
                    </ul>
                  {% endif %}
                {% endwith %}
                <div class="col-md-6 login-form-1">
                    <h3>Login </h3>
                    {{ wtf.quick_form( form = formtpl , action = url_for('login_post')) }}
                </div>
            </div>
        </div>


  <script src="{{ url_for('static', filename='vendor/jquery/jquery.min.js') }}"></script>
  <script src="{{ url_for('static', filename='vendor/bootstrap/js/bootstrap.bundle.min.js') }}"></script>
</body>

</html>

