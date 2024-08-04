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
    public partial class RegistroCursos : System.Web.UI.Page
    {
        readonly SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["conexion"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            CargarTabla();
        }

        void CargarTabla()
        {
            SqlCommand cmd = new SqlCommand("SP_Load", con);
            cmd.CommandType = CommandType.StoredProcedure;
            con.Open();
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            DataTable dt = new DataTable();
            da.Fill(dt);
            gvCursos.DataSource = dt;
            gvCursos.DataBind();
            con.Close();
            
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Registros/RegistroCursos/CRUD_Cursos.aspx?op=C");
        }
        protected void btnVer_Click(object sender, EventArgs e)
        {
            string id;
            Button btnConsultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultar.NamingContainer;
            id = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroCursos/CRUD_Cursos.aspx?id="+id+"&op=V");

        }
        protected void btnActualizar_Click(object sender, EventArgs e)
        {
            string id;
            Button btnConsultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultar.NamingContainer;
            id = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroCursos/CRUD_Cursos.aspx?id=" + id + "&op=A");

        }
        protected void btnEliminar_Click(object sender, EventArgs e)
        {
            string id;
            Button btnConsultar = (Button)sender;
            GridViewRow selectedrow = (GridViewRow)btnConsultar.NamingContainer;
            id = selectedrow.Cells[1].Text;
            Response.Redirect("~/Views/Registros/RegistroCursos/CRUD_Cursos.aspx?id=" + id + "&op=E");
        }
    }
}