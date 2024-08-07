using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using PROYECTO_UX.Views.Registros.RegistroProfesor;

namespace PROYECTO_UX.Views.Registros.RegistroProfesor
{
    public partial class CRUD_Profesor : System.Web.UI.Page
    {
        readonly SqlConnection cone = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        public static string sIDp = "-1";
        public static string sOpcp = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            //Obtener el id
            if (!Page.IsPostBack)
            {
                
                if (Request.QueryString["idp"] != null)
                {
                    sIDp = Request.QueryString["idp"].ToString();
                    CargarDatosProfesor();
                    


                }

                if (Request.QueryString["opp"] != null)
                {
                    sOpcp = Request.QueryString["opp"].ToString();
                    

                    switch (sOpcp)
                    {
                        case "CR":
                            this.lbltituloProfesor.Text = "Ingresar el Nuevo Profesor";
                            this.btnCrear.Visible = true;
                            LlenarDropDownList();
                            break;
                        case "V":
                            this.lbltituloProfesor.Text = "Consulta de Profesor";
                            LlenarDropDownList();
                            tbCedula.Enabled = false;
                            tbapellidos.Enabled = false;
                            tbnombres.Enabled = false;
                            tbprofesion.Enabled = false;
                            ddlEstadoProfesor.Enabled = false;
                            ddlCursos.Enabled = false;
                            break;
                        case "A":
                            this.lbltituloProfesor.Text = "Modificar Profesor";
                            this.btnActualizar.Visible = true;
                            LlenarDropDownList();
                            break;
                        case "E":
                            this.lbltituloProfesor.Text = "Eliminar Profesor";
                            this.btnEliminar.Visible = true;
                            LlenarDropDownList();
                            tbCedula.Enabled = false;
                            tbapellidos.Enabled = false;
                            tbnombres.Enabled = false;
                            tbprofesion.Enabled = false;
                            ddlEstadoProfesor.Enabled = false;
                            ddlCursos.Enabled = false;
                            break;
                    }
                }
            }
        }

        private void LlenarDropDownList()
        {
            
                string query = "SELECT Id_curso, Nombre_curso FROM CURSOS";
                SqlCommand cmd = new SqlCommand(query, cone);

                try
                {
                    cone.Open();
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

        void CargarDatosProfesor()
        {
            cone.Open();
            SqlDataAdapter da = new SqlDataAdapter("SP_Read_profesor", cone);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.Add("@Id", SqlDbType.Int).Value = sIDp;
            DataSet ds = new DataSet();
            ds.Clear();
            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            DataRow row = dt.Rows[0];
            tbCedula.Text = row[1].ToString();
            tbapellidos.Text = row[4].ToString();
            tbnombres.Text = row[5].ToString();
            tbprofesion.Text = row[3].ToString();
            ddlEstadoProfesor.SelectedValue = row[6].ToString();
            ddlCursos.SelectedValue = row[7].ToString();
            cone.Close();



        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Crear_profesor", cone);
            cone.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Cedula", SqlDbType.VarChar).Value = tbCedula.Text;
            cmd.Parameters.Add("@Apellidos_profesor", SqlDbType.VarChar).Value = tbapellidos.Text;
            cmd.Parameters.Add("@Nombre_profesor", SqlDbType.VarChar).Value = tbnombres.Text;
            cmd.Parameters.Add("@Profesion", SqlDbType.VarChar).Value = tbprofesion.Text;
            cmd.Parameters.Add("@Estado", SqlDbType.VarChar).Value = ddlEstadoProfesor.SelectedValue;
            cmd.Parameters.Add("@IdCurso", SqlDbType.Int).Value = ddlCursos.SelectedValue;
            cmd.ExecuteNonQuery();
            cone.Close();
            Response.Redirect("~/Views/Registros/RegistroProfesor/RegistroProfesor.aspx");

        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Actualizar_profesor", cone);
            cone.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sIDp;
            cmd.Parameters.Add("@Cedula", SqlDbType.VarChar).Value = tbCedula.Text;
            cmd.Parameters.Add("@Apellidos_profesor", SqlDbType.VarChar).Value = tbapellidos.Text;
            cmd.Parameters.Add("@Nombre_profesor", SqlDbType.VarChar).Value = tbnombres.Text;
            cmd.Parameters.Add("@Profesion", SqlDbType.VarChar).Value = tbprofesion.Text;
            cmd.Parameters.Add("@Estado", SqlDbType.VarChar).Value = ddlEstadoProfesor.SelectedValue;
            cmd.Parameters.Add("@IdCurso", SqlDbType.Int).Value = ddlCursos.SelectedValue;
            cmd.ExecuteNonQuery();
            cone.Close();
            Response.Redirect("~/Views/Registros/RegistroProfesor/RegistroProfesor.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Eliminar_profesor", cone);
            cone.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sIDp;
            cmd.ExecuteNonQuery();
            cone.Close();
            Response.Redirect("~/Views/Registros/RegistroProfesor/RegistroProfesor.aspx");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroProfesor/RegistroProfesor.aspx");
        }


        protected void ddlEstadoProfesor_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlEstadoProfesor.SelectedValue;
            string selectedText = ddlEstadoProfesor.SelectedItem.Text;

            // Aquí puedes agregar la lógica que deseas ejecutar cuando se selecciona un ítem
            Response.Write("Seleccionaste: " + selectedText);
        }


    }
}