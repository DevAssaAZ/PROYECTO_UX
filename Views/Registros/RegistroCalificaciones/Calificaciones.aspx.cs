using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROYECTO_UX.Views.Registros.RegistroCalificaciones
{
    public partial class Calificaciones : System.Web.UI.Page
    {
        readonly SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        public static string sID = "-1";
        public static string sOpc = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Obtener el id
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    sID = Request.QueryString["id"].ToString();
                    
                    CargarDatos();
                }
                if (Session["Id_Curso"] != null)
                {
                    int idCurso = (int)Session["Id_Curso"];
                    LlenarDropDownList(idCurso);
                }
                else
                {
                    // Redirigir a la página de inicio de sesión si no hay un Id_Curso en la sesión
                    //Response.Redirect("~/Login.aspx");
                }

                if (Request.QueryString["op"] != null)
                {
                    sOpc = Request.QueryString["op"].ToString();
                    int idCurso = (int)Session["Id_Curso"];

                    switch (sOpc)
                    {
                        
                        case "C":
                            this.lbltitulo.Text = "Registrar Calificacion";
                            this.btnRegistrar.Visible = true;
                            break;
                        case "V":
                            this.lbltitulo.Text = "Consulta de Calificacion";
                            txtCurso.Enabled = false;
                            ddlEstudiantes.Enabled = false;
                            txtParcial1.Enabled = false;
                            txtParcial2.Enabled = false;
                            txtExamen.Enabled = false;
                            break;
                        case "A":
                            this.lbltitulo.Text = "Modificar Estudiante";
                            this.btnActualizar.Visible = true;
                            break;
                        case "E":
                            this.lbltitulo.Text = "Eliminar Estudiante";
                            this.btnEliminar.Visible = true;
                            txtCurso.Enabled = false;
                            ddlEstudiantes.Enabled = false;
                            txtParcial1.Enabled = false;
                            txtParcial2.Enabled = false;
                            txtExamen.Enabled = false;
                            break;
                    }
                }
            }
        }
        private void LlenarDropDownList(int idCurso)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = "SELECT Id_estudiante, Estudiante FROM ESTUDIANTES WHERE Id_Curso = @Id_Curso";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@Id_Curso", idCurso);

                try
                {
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlEstudiantes.DataSource = reader;
                    ddlEstudiantes.DataTextField = "Estudiante";
                    ddlEstudiantes.DataValueField = "Id_estudiante";
                    ddlEstudiantes.DataBind();

                    // Añadir el ítem "SELECCIONAR" al principio
                    ddlEstudiantes.Items.Insert(0, new ListItem("SELECCIONAR", "0"));

                    reader.Close();
                }
                catch (Exception ex)
                {
                    // Manejar errores
                    throw ex;
                }
            }
        }

        protected void ddlEstudiantes_SelectedIndexChanged(object sender, EventArgs e)
        {// Verificar si el ítem seleccionado es "SELECCIONAR"
            if (ddlEstudiantes.SelectedValue == "0")
            {
                txtCurso.Text = "";
            }
            else
            {
                int idEstudiante = int.Parse(ddlEstudiantes.SelectedValue);
                ObtenerCursoEstudiante(idEstudiante);
            }


        }

        private void ObtenerCursoEstudiante(int idEstudiante)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["conexion"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                string query = @"SELECT c.Nombre_curso 
                         FROM ESTUDIANTES e
                         JOIN CURSOS c ON e.Id_curso = c.Id_curso
                         WHERE e.Id_estudiante = @Id_estudiante";
                SqlCommand cmd = new SqlCommand(query, connection);
                cmd.Parameters.AddWithValue("@Id_estudiante", idEstudiante);

                try
                {
                    connection.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read())
                    {
                        txtCurso.Text = reader["Nombre_curso"].ToString();
                    }
                    reader.Close();
                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
        }

        void CargarDatos()
        {
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter("SP_Read_calificaciones", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            DataSet ds = new DataSet();
            ds.Clear();
            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            DataRow row = dt.Rows[0];
            txtCurso.Text = row[1].ToString();
            ddlEstudiantes.SelectedValue = row[3].ToString();
            txtParcial1.Text = row[4].ToString();
            txtParcial2.Text = row[5].ToString();
            txtExamen.Text = row[6].ToString();
            con.Close();



        }

        protected void btnRegistrar_Click(object sender, EventArgs e)
        {
            int idCurso = (int)Session["Id_Curso"];

            SqlCommand cmd = new SqlCommand("SP_Crear_calificaciones", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Curso", SqlDbType.VarChar).Value = txtCurso.Text;
            cmd.Parameters.Add("@Id_curso", SqlDbType.Int).Value = idCurso;
            cmd.Parameters.Add("@Estudiante", SqlDbType.VarChar).Value = ddlEstudiantes.SelectedValue;
            cmd.Parameters.Add("@Parcial_1", SqlDbType.Decimal).Value = txtParcial1.Text;
            cmd.Parameters.Add("@Parcial_2", SqlDbType.Decimal).Value = txtParcial2.Text;
            cmd.Parameters.Add("@Examen", SqlDbType.Decimal).Value = txtExamen.Text;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/RegistroCalificaciones.aspx");
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            int idCurso = (int)Session["Id_Curso"];
            SqlCommand cmd = new SqlCommand("SP_Actualizar_calificaciones", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            cmd.Parameters.Add("@Curso", SqlDbType.VarChar).Value = txtCurso.Text;
            cmd.Parameters.Add("@Id_curso", SqlDbType.Int).Value = idCurso;
            cmd.Parameters.Add("@Estudiante", SqlDbType.VarChar).Value = ddlEstudiantes.SelectedValue;
            cmd.Parameters.Add("@Parcial_1", SqlDbType.Decimal).Value = txtParcial1.Text;
            cmd.Parameters.Add("@Parcial_2", SqlDbType.Decimal).Value = txtParcial2.Text;
            cmd.Parameters.Add("@Examen", SqlDbType.Decimal).Value = txtExamen.Text;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/RegistroCalificaciones.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Eliminar_calificaciones", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/RegistroCalificaciones.aspx");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/RegistroCalificaciones.aspx");
        }
    }
}