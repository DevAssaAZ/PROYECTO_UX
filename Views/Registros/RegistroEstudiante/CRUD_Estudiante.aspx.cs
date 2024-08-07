using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace PROYECTO_UX.Views.Registros.RegistroEstudiante
{
    public partial class CRUD_Estudiante : System.Web.UI.Page
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
                    tbdateNacimiento.TextMode = TextBoxMode.DateTime;
                }

                if (Request.QueryString["op"] != null)
                {
                    sOpc = Request.QueryString["op"].ToString();

                    switch (sOpc)
                    {
                        case "C":
                            this.lbltitulo.Text = "Ingresar el Nuevo Estudiante";
                            this.btnCrear.Visible = true;
                            LlenarDropDownList();
                            break;
                        case "V":
                            this.lbltitulo.Text = "Consulta de Estudiante";
                            LlenarDropDownList();
                            tbCedula.Enabled = false;
                            tbApellidos.Enabled = false;
                            tbNombres.Enabled = false;
                            tbdateNacimiento.Enabled = false;
                            tbTelefono.Enabled = false;
                            ddlGratuidad.Enabled = false;
                            ddlCursos.Enabled = false;
                            break;
                        case "A":
                            this.lbltitulo.Text = "Modificar Estudiante";
                            this.btnActualizar.Visible = true;
                            LlenarDropDownList();
                            break;
                        case "E":
                            this.lbltitulo.Text = "Eliminar Estudiante";
                            this.btnEliminar.Visible = true;
                            LlenarDropDownList();
                            tbCedula.Enabled = false;
                            tbApellidos.Enabled = false;
                            tbNombres.Enabled = false;
                            tbdateNacimiento.Enabled = false;
                            tbTelefono.Enabled = false;
                            ddlGratuidad.Enabled = false;
                            ddlCursos.Enabled = false;
                            break;
                    }
                }
            }
        }

        private void LlenarDropDownList()
        {

            string query = "SELECT Id_curso, Nombre_curso FROM CURSOS";
            SqlCommand cmd = new SqlCommand(query, con);

            try
            {
                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                ddlCursos.DataSource = reader;
                ddlCursos.DataTextField = "Nombre_curso";
                ddlCursos.DataValueField = "Id_curso";
                ddlCursos.DataBind();

                reader.Close();
            }
            catch (Exception ex)
            {
                // Manejar errores
                throw ex;
            }

        }

        void CargarDatos()
        {
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter("SP_Read_estudiante", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            DataSet ds = new DataSet();
            ds.Clear();
            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            DataRow row = dt.Rows[0];
            tbCedula.Text = row[1].ToString();
            // Divide el nombre completo en apellidos y nombres
            string fullName = row[2].ToString();
            string[] nameParts = fullName.Split(' ');
            if (nameParts.Length >= 4)
            {
                tbApellidos.Text = nameParts[0] + " " + nameParts[1]; // Primer y segundo elemento como apellidos
                tbNombres.Text = nameParts[2] + " " + nameParts[3]; // Tercer y cuarto elemento como nombres
            }
            else
            {
                // Manejar el caso donde no hay suficientes partes
                tbApellidos.Text = fullName;
                tbNombres.Text = "";
            }

            DateTime dI = (DateTime)row[3];
            tbdateNacimiento.Text = dI.ToString("dd/MM/yyyy");
            tbTelefono.Text = row[4].ToString();
            ddlGratuidad.SelectedValue = row[5].ToString();
            ddlCursos.SelectedValue = row[7].ToString();
            con.Close();



        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Crear_estudiante", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Cedula", SqlDbType.VarChar).Value = tbCedula.Text;
            cmd.Parameters.Add("@Apellido", SqlDbType.VarChar).Value = tbApellidos.Text;
            cmd.Parameters.Add("@Nombre", SqlDbType.VarChar).Value = tbNombres.Text;
            cmd.Parameters.Add("@Fecha_nacimiento", SqlDbType.Date).Value = tbdateNacimiento.Text;
            cmd.Parameters.Add("@Telefono", SqlDbType.VarChar).Value = tbTelefono.Text;
            cmd.Parameters.Add("@Gratuidad", SqlDbType.VarChar).Value = ddlGratuidad.SelectedValue;
            cmd.Parameters.Add("@IdCurso", SqlDbType.Int).Value = ddlCursos.SelectedValue;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroEstudiante/RegistroEstudiante.aspx");

        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Actualizar_estudiante", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            cmd.Parameters.Add("@Cedula", SqlDbType.VarChar).Value = tbCedula.Text;
            cmd.Parameters.Add("@Apellido", SqlDbType.VarChar).Value = tbApellidos.Text;
            cmd.Parameters.Add("@Nombre", SqlDbType.VarChar).Value = tbNombres.Text;
            cmd.Parameters.Add("@Fecha_nacimiento", SqlDbType.Date).Value = tbdateNacimiento.Text;
            cmd.Parameters.Add("@Telefono", SqlDbType.VarChar).Value = tbTelefono.Text;
            cmd.Parameters.Add("@Gratuidad", SqlDbType.VarChar).Value = ddlGratuidad.SelectedValue;
            cmd.Parameters.Add("@IdCurso", SqlDbType.Int).Value = ddlCursos.SelectedValue;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroEstudiante/RegistroEstudiante.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Eliminar_estudiante", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroEstudiante/RegistroEstudiante.aspx");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroEstudiante/RegistroEstudiante.aspx");
        }


        protected void ddlGratuidad_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlGratuidad.SelectedValue;
            string selectedText = ddlGratuidad.SelectedItem.Text;

            // Aquí puedes agregar la lógica que deseas ejecutar cuando se selecciona un ítem
            Response.Write("Seleccionaste: " + selectedText);
        }
    }
}