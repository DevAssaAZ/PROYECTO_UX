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
    public partial class RegistroCalificaciones : System.Web.UI.Page
    {
        readonly SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarTabla();
        }

        void CargarTabla()
        {
            SqlCommand cmd = new SqlCommand("SP_Load_calificaciones", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvCalificaciones.DataSource = dt;
            gvCalificaciones.DataBind();
            con.Close();

        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/Calificaciones.aspx?op=C");
        }

        protected void btnVer_Click(object sender, EventArgs e)
        {
            string id;
            Button btnConsultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultar.NamingContainer;
            id = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/Calificaciones.aspx?id=" + id + "&op=V");
        }

        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string id;
            Button btnConsultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultar.NamingContainer;
            id = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/Calificaciones.aspx?id=" + id + "&op=A");

        }

        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string id;
            Button btnConsultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultar.NamingContainer;
            id = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroCalificaciones/Calificaciones.aspx?id=" + id + "&op=E");
        }

        protected void btnVer_Click1(object sender, EventArgs e)
        {

        }
    }
}