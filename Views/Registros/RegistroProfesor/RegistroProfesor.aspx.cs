using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROYECTO_UX.Views.Registros.RegistroProfesor
{
    public partial class RegistroProfesor : System.Web.UI.Page
    {
        readonly SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarTablaProfesor();
        }
        void CargarTablaProfesor()
        {
            SqlCommand cmd = new SqlCommand("SP_Load_profesor", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvProfesor.DataSource = dt;
            gvProfesor.DataBind();
            con.Close();

        }
        protected void btnVerProfesor_Click(object sender, EventArgs e)
        {
            string idp;
            Button btnConsultarProfesor = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultarProfesor.NamingContainer;
            idp = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroProfesor/CRUD_Profesor.aspx?idp=" + idp + "&opp=V");
        }

        protected void btnActualizarProfesor_Click(object sender, EventArgs e)
        {
            string idp;
            Button btnConsultarProfesor = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultarProfesor.NamingContainer;
            idp = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroProfesor/CRUD_Profesor.aspx?idp=" + idp + "&opp=A");
        }

        protected void btnEliminarProfesor_Click(object sender, EventArgs e)
        {
            string idp;
            Button btnConsultarProfesor = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultarProfesor.NamingContainer;
            idp = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroProfesor/CRUD_Profesor.aspx?idp=" + idp + "&opp=E");
        }

        protected void btnCrearProfesor_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroProfesor/CRUD_Profesor.aspx?opp=CR");
        }
    }
}