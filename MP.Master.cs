using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PROYECTO_UX
{
    public partial class MP : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                // Establecer las URLs en el código detrás
                navCalificaciones.HRef = ResolveUrl("~/Views/Registros/RegistroCalificaciones/RegistroCalificaciones.aspx");
                navCerrarSesion.HRef = ResolveUrl("~/Views/Login/Login.aspx");
                navRegistros.HRef = "#"; // No puedes dejar un dropdown vacío, por lo que lo configuras en "#"


                // Verificar el rol del usuario almacenado en la sesión
                string rol = Session["Rol"] as string;

                if (!string.IsNullOrEmpty(rol))
                {
                    if (rol == "Profesor")
                    {
                        // Deshabilitar el dropdown "Registros" para profesores
                        navRegistros.Attributes["style"] = "display:none;";
                    }
                    else if (rol == "Secretario")
                    {
                        // Deshabilitar el link "Calificaciones" para secretarios
                        navCalificaciones.Attributes["style"] = "display:none;";
                    }
                }
                else
                {
                    // Redirigir a la página de inicio de sesión si no hay un rol en la sesión
                    Response.Redirect("~/Login.aspx");
                }

                // Asignar evento de clic al enlace de Cerrar Sesión
                //navCerrarSesion.ServerClick += new EventHandler(navCerrarSesion_Click);

            }
        }

        //protected void navCerrarSesion_Click(object sender, EventArgs e)
        //{
        //    // Cerrar sesión
        //    Session.Clear();
        //    Response.Redirect("~/Views/Login/Login.aspx");
        //}


    }
}