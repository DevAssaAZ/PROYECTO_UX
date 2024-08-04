using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;

namespace PROYECTO_UX.Views.Login
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        private bool VerificarCredenciales(string usuario, string password, out string rol, out int idCurso)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
            rol = "";
            idCurso = -1;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                // Verificar en la tabla de secretarios
                string querySecretarios = "SELECT 'Secretario' as Rol FROM SECRETARIO WHERE Cedula = @Usuario AND Cedula = @Contraseña";
                using (SqlCommand cmd = new SqlCommand(querySecretarios, connection))
                {
                    cmd.Parameters.AddWithValue("@Usuario", usuario);
                    cmd.Parameters.AddWithValue("@Contraseña", password);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        rol = reader["Rol"].ToString();
                        reader.Close();
                        return true;
                    }
                    reader.Close();
                }

                // Verificar en la tabla de profesores
                string queryProfesores = "SELECT 'Profesor' as Rol, Id_curso FROM PROFESORES WHERE Cedula = @Usuario AND Cedula = @Contraseña";
                using (SqlCommand cmd = new SqlCommand(queryProfesores, connection))
                {
                    cmd.Parameters.AddWithValue("@Usuario", usuario);
                    cmd.Parameters.AddWithValue("@Contraseña", password);

                    SqlDataReader reader = cmd.ExecuteReader();
                    if (reader.Read())
                    {
                        rol = reader["Rol"].ToString();
                        idCurso = (int)reader["Id_curso"];
                        reader.Close();
                        return true;
                    }
                    reader.Close();
                }
            }

            return false;
        }

        protected void btnIniciarSesion_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text;
            string contraseña = txtPassword.Text;

            if (VerificarCredenciales(usuario, contraseña, out string rol, out int idCurso))
            {
                // Guardar el rol y el Id_Curso en la sesión
                Session["Rol"] = rol;

                if (rol == "Profesor")
                {
                    Session["Id_Curso"] = idCurso;
                }

                // Redirigir a la página correspondiente según el rol
                if (rol == "Secretario" || rol == "Profesor")
                {
                    Response.Redirect("~/Views/Index.aspx");
                }
            }
            else
            {
                // Mostrar SweetAlert2 en caso de error
                string script = "<script type='text/javascript'>Swal.fire({ icon: 'error', title: 'Error...', text: 'Usuario o Contraseña Incorrectos!!', footer: '<p>Por Favor verifique los Datos Ingresados</p>' });</script>";
                ltScript.Text = script;
            }
        }
    }
}
