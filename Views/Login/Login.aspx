<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="PROYECTO_UX.Views.Login.Login" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel="stylesheet" href="../../Recursos/Css/StyleLogin.css" />
    <link rel="stylesheet" href="../../Recursos/Css/StyleModalLogin.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <title>Login</title>
    <style>
        .custom-cursor {
            cursor: pointer; /* Cambia el cursor a una mano */
        }
        
    </style>
</head>
<body>
    <form runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager1"></asp:ScriptManager>
        <section id="login-section">
            <img src="../../Recursos/Imagenes/ImgLogin/FondoLogin.jpeg" class="fondo" />
            <div class="centered-container">
                <div class="centered-div">
                    <div class="login">
                        <h2>Cursos De Ingles UG</h2>
                        <h2>Login</h2>
                        <div class="input-box">
                            <asp:TextBox ID="txtUsuario" runat="server" placeholder="Usuario" CssClass="form-control" required="true"/>
                        </div>
                        <div class="input-box">
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" placeholder="Contraseña" CssClass="form-control" required="true"/>
                        </div>
                        <div class="show-password">
                            <asp:CheckBox ID="chkMostrarPassword" runat="server" Text="Mostrar contraseña" />
                        </div>
                        <div class="input-box">
                            <asp:Button ID="btnIniciarSesion" runat="server" Text="Iniciar Sesión" CssClass="btn btn-primary custom-cursor" OnClick="btnIniciarSesion_Click" />
                        </div>
                        <div class="grupo">
                            <a href="#">Olvidaste tu contraseña?</a>
                            <a href="#">Registrarse</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <asp:Literal ID="ltScript" runat="server"></asp:Literal>
    </form>

    <script>
        document.getElementById('<%= chkMostrarPassword.ClientID %>').addEventListener('change', function () {
            var passwordInput = document.getElementById('<%= txtPassword.ClientID %>');
            if (this.checked) {
                passwordInput.type = 'text';
            } else {
                passwordInput.type = 'password';
            }
        });
    </script>
</body>
</html>
