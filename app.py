from flask import Flask, render_template, request, flash, redirect, url_for
from flask_sqlalchemy import SQLAlchemy
from flask_migrate import Migrate
from sqlalchemy import text, update, func
from flask_wtf import FlaskForm
from werkzeug.security import generate_password_hash, check_password_hash
from wtforms import StringField, PasswordField, SubmitField, IntegerField, SelectField
from wtforms.validators import InputRequired, Email, Length,  ValidationError, EqualTo
from flask_bootstrap import Bootstrap
from flask_login import UserMixin, LoginManager, login_user, logout_user, login_required
from datetime import timedelta, datetime
from wtforms.fields.html5 import DateField

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///meudb.db'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = '5fbc1554-8b78-4080-98b4-5035b8469fee-042c5b51-5024-4bd5-af69-d2ab00debd6b'
db = SQLAlchemy(app)
mg = Migrate(app,db)
bootstrap = Bootstrap(app)

HORARIOS =  [(1,"10:00"),(2,"11:00"),(3,"12:00"),(4,"13:00"),(5,"14:00"),(6,"15:00")]
#=================================================#
#           CRIAÇÃO DO LOGIN                      #
#=================================================#
login_manager = LoginManager(app)
login_manager.login_view = 'login_get'

@login_manager.user_loader
def load_user(user_id):
    return Paciente.query.filter_by(id=user_id).first()

class LoginForm(FlaskForm):
    nome   = StringField('Nome',validators=[InputRequired()],render_kw={"placeholder":"Digite seu nome..."})
    senha   = PasswordField('Senha',validators=[InputRequired()],render_kw={"placeholder":"Digite sua senha..."})
    confirm = SubmitField('Login', render_kw={"_class":"btn btn-info"})
#=================================================#
#           CRIAÇÃO DO BANCO DE DADOS             #
#=================================================#

class Medico(db.Model):
    __tablename__ = 'medicos'
    id   = db.Column(db.Integer, primary_key=True)
    nome = db.Column(db.String(250))
    especialidade = db.Column(db.String(250))


    def __repr__(self):
        return '<Medico: {} /{}>'.format(self.nome, self.especialidade)

    def __init__(self, nome, especialidade):
        self.nome = nome
        self.especialidade = especialidade

class Paciente(db.Model, UserMixin):
    __tablename__ = 'pacientes'
    id       = db.Column(db.Integer, primary_key=True)
    nome     = db.Column(db.String(250))
    telefone = db.Column(db.String(50))
    cpf      = db.Column(db.String(20))
    password_hash = db.Column(db.String(250))
    
    def __repr__(self):
        return '<Paciente: {}>'.format(self.nome)

    def __init__(self, nome,telefone,cpf,password):
        self.nome     = nome
        self.telefone = telefone
        self.cpf      = cpf
        self.password_hash = generate_password_hash(password)

class Consulta(db.Model, UserMixin):
    __tablename__ = 'consultas'
    id       = db.Column(db.Integer,primary_key=True) 
    medico   = db.Column(db.String(250))
    paciente = db.Column(db.String(250))
    horario  = db.Column(db.Integer)
    data     = db.Column(db.Date())

    def __repr__(self):
        return '<Consulta: {}>'.format(self.nome)
#=================================================#
#           CRIAÇÃO DO FORMULÁRIO                 #
#=================================================#
class InsereMedicoForm(FlaskForm):
    nome   = StringField('Nome', validators=[InputRequired(), Length(min=3)])
    especialidade = StringField('Especialidade',validators=[InputRequired(),Length(min=4)])
    enviar = SubmitField('Enviar')
class InserePacienteForm(FlaskForm):
    nome     = StringField('Nome', validators=[InputRequired(), Length(min=3)])
    telefone = StringField('Telefone',validators=[InputRequired(),Length(min=6)])
    cpf      = StringField('CPF',validators=[InputRequired(),Length(min=11,max=11)])
    senha    = PasswordField('Senha',validators=[InputRequired(),Length(min=6)])
    enviar   = SubmitField('Enviar')

class InsereConsultaForm(FlaskForm):
    medico = SelectField('Medico',validators = [InputRequired()],coerce=int,choices="",render_kw={"placeholder":"Selecione o medico"})
    paciente = SelectField('Paciente', validators = [InputRequired()],coerce=int,choices="",render_kw={"placeholder":"Selecione o paciente"})
    horario = SelectField('Horario',validators = [InputRequired()],coerce=int,choices="",render_kw={"placeholder":"Selecione o horario"})
    data = DateField('Data',validators = [InputRequired()],render_kw={"placeholder":"Entre com a data"})
    enviar = SubmitField('Agendar', render_kw={"_class":"btn btn-info"})

    def __init__(self,*args, **kwargs):
        super(InsereConsultaForm, self).__init__(*args, **kwargs)
        self.medicos = Medico.query.all()
        print(self.medicos)
        self.medico.choices = [(m.id, m.nome) for m in self.medicos]
        self.pacientes = Paciente.query.all()
        print(self.pacientes)
        self.paciente.choices = [(p.id, p.nome) for p in self.pacientes]
        self.horario.choices = HORARIOS

#=================================================#
#           CRIAÇÃO DAS ROTAS WEB                 #
#=================================================#
@app.errorhandler(404)
def page_not_found(error):
    return render_template('404.tpl'), 404

@app.route('/')
def index():
    return render_template('index.tpl')
########## ROTAS MEDICOS ##################
@app.route('/medicos',methods=['GET'])
def lista_medicos():
    dados = Medico.query.all()
    return render_template('medicos.tpl', dadostpl = dados)

@app.route('/medicosadd',methods=['GET'])
def add_medico_get():
    form = InsereMedicoForm()
    return render_template('add_medico.tpl', formtpl = form)

@app.route('/medicosadd',methods=['POST'])
def add_medico_post():
    form = InsereMedicoForm(request.form)
    if form.validate_on_submit():
        novo_medico = Medico(nome=form.nome.data,especialidade=form.especialidade.data)
        db.session.add(novo_medico)
        db.session.commit()
        flash('Medico cadastrado com sucesso','success')
    else:
        flash('Erro nos dados.'+str(form.errors),'danger')
    return redirect('/medicos')
    
@app.route('/medicosedit/<_id>',methods=['GET'])
def edit_medico_get(_id):
    m = Medico.query.filter_by(id=_id).first()
    form = InsereMedicoForm(obj=m)
    return render_template('edit_medico.tpl', formtpl = form, _id=_id)

@app.route('/medicosedit/<_id>',methods=['POST'])
def edit_medico_post(_id):
    form = InsereMedicoForm(request.form)
    m = Medico.query.filter_by(id=_id).first()
    if form.validate_on_submit():
        form.populate_obj(m)
        db.session.commit()
        flash('Medico alterado com sucesso.','success')
    else:
        flash('Nao alterado, revise os dados.'+str(form.errors),'danger')
    return redirect('/medicos')


@app.route('/medicosview/<_id>',methods=['GET'])

def view_medico_get(_id):
    m = Medico.query.filter_by(id=_id).first()
    return render_template('view_medico.tpl', d = m)

@app.route('/medicosdel/<_id>',methods=['GET'])

def del_medico_get(_id):
    m = Medico.query.filter_by(id=_id).first()
    return render_template('del_medico.tpl', d = m)

@app.route('/medicosdel/<_id>',methods=['POST'])

def del_medico_post(_id):
    m = Medico.query.filter_by(id=_id).first()
    db.session.delete(m)
    db.session.commit()
    flash('Médico excluído com sucesso.','success')
    return redirect('/medicos')
####################################################

######### ROTAS PACIENTES ##########################

@app.route('/pacientes',methods=['GET'])
def lista_pacientes():
    dados = Paciente.query.all()
    return render_template('pacientes.tpl', dadostpl = dados)

@app.route('/pacientesadd',methods=['GET'])
def add_paciente_get():
    form = InserePacienteForm()
    return render_template('add_paciente.tpl', formtpl = form)

@app.route('/pacientesadd',methods=['POST'])
def add_paciente_post():
    form = InserePacienteForm(request.form)
    if form.validate_on_submit():
        novo_paciente = Paciente(nome=form.nome.data,
            telefone=form.telefone.data,
            cpf=form.cpf.data,
            password = form.senha.data)
        db.session.add(novo_paciente)
        db.session.commit()
        flash('Paciente cadastrado com sucesso','success')
    else:
        flash('Erro nos dados.'+str(form.errors),'danger')
    return redirect('/pacientes')
    
@app.route('/pacientesedit/<_id>',methods=['GET'])
def edit_paciente_get(_id):
    p = Paciente.query.filter_by(id=_id).first()
    form = InserePacienteForm(obj=p)
    return render_template('edit_paciente.tpl', formtpl = form, _id=_id)

@app.route('/pacientesedit/<_id>',methods=['POST'])
def edit_paciente_post(_id):
    form = InserePacienteForm(request.form)
    p = Paciente.query.filter_by(id=_id).first()
    if form.validate_on_submit():
        form.populate_obj(p)
        db.session.commit()
        flash('Paciente alterado com sucesso.','success')
    else:
        flash('Nao alterado, revise os dados.'+str(form.errors),'danger')
    return redirect('/pacientes')


@app.route('/pacientesview/<_id>',methods=['GET'])

def view_paciente_get(_id):
    p = Paciente.query.filter_by(id=_id).first()
    return render_template('view_paciente.tpl', d = p)

@app.route('/pacientesdel/<_id>',methods=['GET'])

def del_paciente_get(_id):
    p = Paciente.query.filter_by(id=_id).first()
    return render_template('del_paciente.tpl', d = p)

@app.route('/pacientesdel/<_id>',methods=['POST'])

def del_paciente_post(_id):
    p = Paciente.query.filter_by(id=_id).first()
    db.session.delete(p)
    db.session.commit()
    flash('Paciente excluído com sucesso.','success')
    return redirect('/pacientes')

####################################################

##########AGENDAMENTO DA CONSULTA###################
@app.route('/consultas', methods=['GET'])
def mostra_consultas():
    dados = Consulta.query.all()

    return render_template('consultas.tpl', dadostpl = dados)

@app.route('/consultaadd',methods=['GET'])
def add_consulta_get():
    form = InsereConsultaForm()
    return render_template('add_consulta.tpl', formtpl = form)

@app.route('/consultaadd',methods=['POST'])
def add_consulta_post():
    form = InsereConsultaForm(request.form)
    print(request.form)
    if form.validate_on_submit():
        try:

            #dataDate = datetime.strptime(form.data.data, '%Y-%m-%d')
            nova_consulta = Consulta(medico    = form.medico.data,
                                     paciente  = form.paciente.data,
                                     horario   = form.horario.data,
                                     data      = form.data.data)

            db.session.add(nova_consulta)
            db.session.commit()
            flash('Consulta inserida com sucesso.','success')

        except Exception as e:
            flash('Nao inserido'+str(e),'danger')
    else :
        flash('Não inserido. Problemas nos dados.'+str(form.errors),'danger')
    return redirect('/consultas')

@app.route('/consultasedit/<_id>',methods=['GET'])
def edit_consulta_get(_id):
    c = Consulta.query.filter_by(id=_id).first()
    form = InsereConsultaForm(obj=c)
    return render_template('edit_consulta.tpl', formtpl = form, _id=_id)

@app.route('/consultasedit/<_id>',methods=['POST'])
def edit_consulta_post(_id):
    form = InsereConsultaForm(request.form)
    c = Consulta.query.filter_by(id=_id).first()
    if form.validate_on_submit():
        form.populate_obj(c)
        db.session.commit()
        flash('Consulta alterada com sucesso.','success')
    else:
        flash('Nao alterado, revise os dados.'+str(form.errors),'danger')
    return redirect('/consultas')

@app.route('/consultasview/<_id>',methods=['GET'])

def view_consulta_get(_id):
    c = Consulta.query.filter_by(id=_id).first()
    return render_template('view_consulta.tpl', d = c)

@app.route('/consultasdel/<_id>',methods=['GET'])
def del_consulta_get(_id):
    c = Consulta.query.filter_by(id=_id).first()
    return render_template('del_consulta.tpl', d = c)

@app.route('/consultasdel/<_id>',methods=['POST'])

def del_consulta_post(_id):
    c = Consulta.query.filter_by(id=_id).first()
    db.session.delete(c)
    db.session.commit()
    flash('Consulta excluída com sucesso.','success')
    return redirect('/consultas')
####################################################

####LOGIN AND LOGOUT #####
@app.route('/login',methods=['GET'])
def login_get():
    form = LoginForm()
    return render_template('login.tpl', formtpl = form)
@app.route('/login',methods=['POST'])
def login_post():
    form = LoginForm(request.form)
    if form.validate_on_submit():
        paciente = Paciente.query.filter_by(nome=form.nome.data).first()
        if paciente is not None:
            if check_password_hash(paciente.password_hash,form.senha.data):
                login_user(paciente)
                return redirect(url_for('index'))
                print('Login sucesso')
            else:
                flash('Usuário ou senha incorreto','danger')
                print('Login não ok1')
        else:
            flash('Usuário ou senha incorreto','danger')
            print('Login não ok2')
    else:
        msg = 'Dados incorretos'+str(form.errors)
        flash(msg,'danger')
        print('Login não ok3')
    return redirect(url_for('login_get'))

@app.route('/logout',methods=['GET'])
def logout():
    logout_user()
    return redirect( url_for('login_get'))
##########################

if __name__ == '__main__':
    app.run(host='localhost', port=7000, debug=True)