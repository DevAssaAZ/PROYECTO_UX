<%@ Page Title="" Language="C#" MasterPageFile="~/MP.Master" AutoEventWireup="true" CodeBehind="Calificaciones.aspx.cs" Inherits="PROYECTO_UX.Views.Registros.RegistroCalificaciones.Calificaciones" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Calificaciones
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
    <style>
        .form-container {
            width: 400px;
            margin: 50px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
            text-align: center;
        }

        .form-group {
            margin-bottom: 15px;
        }

            .form-group label {
                display: block;
                margin-bottom: 5px;
            }

            .form-group input,
            .form-group select {
                width: 100%;
                padding: 8px;
                box-sizing: border-box;
            }

            .form-group img {
                display: block;
                margin: 0 auto 10px;
            }

            .form-group input[type="submit"] {
                width: auto;
                background-color: #4CAF50;
                color: white;
                border: none;
                padding: 10px 20px;
                cursor: pointer;
            }
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    <form runat="server">
        <div class="form-container">
            <div class="row justify-content-center">
                <div class="col-auto">
                    <asp:Label runat="server" CssClass="h2 text-center" ID="lbltitulo"></asp:Label>
                </div>
            </div>
            <div class="form-group">
                <label for="ddlEstudiante">Estudiante</label>
                <asp:DropDownList ID="ddlEstudiantes" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlEstudiantes_SelectedIndexChanged" AppendDataBoundItems="true">
                </asp:DropDownList>
            </div>
            <div class="form-group">
                <label for="txtCurso">Curso</label>
                <asp:TextBox ID="txtCurso" runat="server" CssClass="form-control" ReadOnly="true" />
            </div>
            <div class="form-group">
                <label for="txtParcial1">Parcial 1</label>
                <asp:TextBox ID="txtParcial1" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="txtParcial2">Parcial 2</label>
                <asp:TextBox ID="txtParcial2" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <label for="txtExamen">Examen</label>
                <asp:TextBox ID="txtExamen" runat="server" CssClass="form-control" />
            </div>
            <div class="form-group">
                <asp:Button runat="server" CssClass="btn btn-primary" ID="btnRegistrar" Text="Registrar" Visible="false" OnClick="btnRegistrar_Click" OnClientClick="showCreateUpdateConfirm('registrar'); return false;" />
                <asp:Button runat="server" CssClass="btn btn-primary" ID="btnActualizar" Text="Actualizar" Visible="false" OnClick="btnActualizar_Click" OnClientClick="showCreateUpdateConfirm('actualizar'); return false;" />
                <asp:Button runat="server" CssClass="btn btn-primary" ID="btnEliminar" Text="Eliminar" Visible="false" OnClick="btnEliminar_Click" OnClientClick="showDeleteConfirm(); return false;" />
                <asp:Button runat="server" CssClass="btn btn-primary btn-dark" ID="btnVolver" Text="Volver" Visible="true" OnClick="btnVolver_Click" />
            </div>
        </div>


    </form>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function showCreateUpdateConfirm(action) {
            let titleText = "";

            if (action === 'registrar') {
                titleText = "¿Quieres Registrar la calificacion?";
            } else if (action === 'actualizar') {
                titleText = "¿Quieres actualizar la calificacion?";
            }

            Swal.fire({
                title: titleText,
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: "Guardar",
                denyButtonText: "No guardar"
            }).then((result) => {
                if (result.isConfirmed) {
                    if (action === 'registrar') {
                        __doPostBack('<%= btnRegistrar.UniqueID %>', '');
                    } else if (action === 'actualizar') {
                        __doPostBack('<%= btnActualizar.UniqueID %>', '');
                    }
                    Swal.fire("¡Guardado!", "", "success");
                } else if (result.isDenied) {
                    Swal.fire("Los cambios no se guardaron", "", "info");
                }
            });
        }

        function showDeleteConfirm() {
            const swalWithBootstrapButtons = Swal.mixin({
                customClass: {
                    confirmButton: "btn btn-success",
                    cancelButton: "btn btn-danger"
                },
                buttonsStyling: false
            });
            swalWithBootstrapButtons.fire({
                title: "¿Estás seguro?",
                text: "¡No podrás revertir esto!",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Sí, eliminarlo!",
                cancelButtonText: "No, cancelar!",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    __doPostBack('<%= btnEliminar.UniqueID %>', '');
                    swalWithBootstrapButtons.fire("¡Eliminado!", "Tu registro ha sido eliminado.", "success");
                } else if (result.dismiss === Swal.DismissReason.cancel) {
                    swalWithBootstrapButtons.fire("Cancelado", "Tu registro está seguro :)", "error");
                }
            });
        }
    </script>
</asp:Content>
