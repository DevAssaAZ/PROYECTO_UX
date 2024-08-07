using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

namespace PROYECTO_UX.Views.Registros.RegistroCursos
{
    public partial class CRUD : System.Web.UI.Page
    {
        readonly SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        public static string sID = "-1";
        public static string sOpc = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Request.QueryString["id"] != null)
                {
                    sID = Request.QueryString["id"].ToString();
                    CargarDatos();
                    tbdateInicio.TextMode = TextBoxMode.DateTime;
                    tbdateFin.TextMode = TextBoxMode.DateTime;
                }

                if (Request.QueryString["op"] != null)
                {
                    sOpc = Request.QueryString["op"].ToString();

                    switch (sOpc)
                    {
                        case "C":
                            this.lbltitulo.Text = "Ingresar el Nuevo Curso";
                            this.btnCrear.Visible = true;
                            break;
                        case "V":
                            this.lbltitulo.Text = "Consulta de Curso";
                            tbNombreCurso.Enabled = false;
                            tbdateInicio.Enabled = false;
                            tbdateFin.Enabled = false;
                            tbDuracion.Enabled = false;
                            ddlNivel.Enabled = false;
                            ddlEstado.Enabled = false;
                            break;
                        case "A":
                            this.lbltitulo.Text = "Modificar Curso";
                            this.btnActualizar.Visible = true;
                            break;
                        case "E":
                            this.lbltitulo.Text = "Eliminar Curso";
                            this.btnEliminar.Visible = true;
                            tbNombreCurso.Enabled = false;
                            tbdateInicio.Enabled = false;
                            tbdateFin.Enabled = false;
                            tbDuracion.Enabled = false;
                            ddlNivel.Enabled = false;
                            ddlEstado.Enabled = false;
                            break;
                    }
                }
            }
        }

        void CargarDatos()
        {
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter("SP_Read", con);
            da.SelectCommand.CommandType = CommandType.StoredProcedure;
            da.SelectCommand.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            DataSet ds = new DataSet();
            ds.Clear();
            da.Fill(ds);
            DataTable dt = ds.Tables[0];
            DataRow row = dt.Rows[0];
            tbNombreCurso.Text = row[1].ToString();
            DateTime dI = (DateTime)row[2];
            tbdateInicio.Text = dI.ToString("dd/MM/yyyy");
            DateTime dF = (DateTime)row[3];
            tbdateFin.Text = dF.ToString("dd/MM/yyyy");
            tbDuracion.Text = row[4].ToString();
            ddlNivel.SelectedValue = row[5].ToString();
            ddlEstado.SelectedValue = row[6].ToString();
            con.Close();
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Crear", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Nombre_curso", SqlDbType.VarChar).Value = tbNombreCurso.Text;
            cmd.Parameters.Add("@Fecha_inicio", SqlDbType.Date).Value = tbdateInicio.Text;
            cmd.Parameters.Add("@Fecha_fin", SqlDbType.Date).Value = tbdateFin.Text;
            cmd.Parameters.Add("@Duracion", SqlDbType.Int).Value = tbDuracion.Text;
            cmd.Parameters.Add("@Nivel", SqlDbType.Int).Value = ddlNivel.SelectedValue;
            cmd.Parameters.Add("@Estado", SqlDbType.VarChar).Value = ddlEstado.SelectedValue;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroCursos/RegistroCursos.aspx");
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Actualizar", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            cmd.Parameters.Add("@Nombre_curso", SqlDbType.VarChar).Value = tbNombreCurso.Text;
            cmd.Parameters.Add("@Fecha_inicio", SqlDbType.Date).Value = tbdateInicio.Text;
            cmd.Parameters.Add("@Fecha_fin", SqlDbType.Date).Value = tbdateFin.Text;
            cmd.Parameters.Add("@Duracion", SqlDbType.Int).Value = tbDuracion.Text;
            cmd.Parameters.Add("@Nivel", SqlDbType.Int).Value = ddlNivel.SelectedValue;
            cmd.Parameters.Add("@Estado", SqlDbType.VarChar).Value = ddlEstado.SelectedValue;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroCursos/RegistroCursos.aspx");
        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            SqlCommand cmd = new SqlCommand("SP_Eliminar", con);
            con.Open();
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.Add("@Id", SqlDbType.Int).Value = sID;
            cmd.ExecuteNonQuery();
            con.Close();
            Response.Redirect("~/Views/Registros/RegistroCursos/RegistroCursos.aspx");
        }

        protected void btnVolver_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroCursos/RegistroCursos.aspx");
        }

        protected void ddlNivel_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlNivel.SelectedValue;
            string selectedText = ddlNivel.SelectedItem.Text;
            Response.Write("Seleccionaste: " + selectedText);
        }

        protected void ddlEstado_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedValue = ddlEstado.SelectedValue;
            string selectedText = ddlEstado.SelectedItem.Text;
            Response.Write("Seleccionaste: " + selectedText);
        }

    }
}
