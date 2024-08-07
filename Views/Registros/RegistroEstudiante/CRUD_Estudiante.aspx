<%@ Page Title="" Language="C#" MasterPageFile="~/MP.Master" AutoEventWireup="true" CodeBehind="CRUD_Estudiante.aspx.cs" Inherits="PROYECTO_UX.Views.Registros.RegistroEstudiante.CRUD_Estudiante" %>

<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    CRUD-Estudiantes
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
    </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    <br />
    <br />
    <br />

    <form runat="server" class="h-100 d-flex align-items-center justify-content-center">
        <div class="form-container">
            <div class="row justify-content-center">
                <div class="col-auto">
                    <asp:Label runat="server" CssClass="h2 text-center" ID="lbltitulo"></asp:Label>
                </div>
            </div>
            <br />
            <br />
            <div class="mb-3">
                <label class="form-label">Cedula</label>
                <asp:TextBox runat="server" CssClass="form-control" ID="tbCedula"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Apellidos</label>
                <asp:TextBox runat="server" CssClass="form-control" ID="tbApellidos"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Nombres</label>
                <asp:TextBox runat="server" CssClass="form-control" ID="tbNombres"></asp:TextBox>
            </div>

            <div class="mb-3">
                <label class="form-label">Fecha De Nacimiento</label>
                <asp:TextBox runat="server" TextMode="Date" CssClass="form-control" ID="tbdateNacimiento"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Telefono</label>
                <asp:TextBox runat="server" CssClass="form-control" ID="tbTelefono"></asp:TextBox>
            </div>
            <div class="mb-3">
                <label class="form-label">Gratuidad</label>
                <asp:DropDownList ID="ddlGratuidad" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="ddlGratuidad_SelectedIndexChanged">
                    <asp:ListItem Text="SELECCIONAR" Value="" />
                    <asp:ListItem Text="Si" Value="Si" />
                    <asp:ListItem Text="No" Value="No" />
                </asp:DropDownList>
            </div>
            <div class="mb-3">
                <label class="form-label">Curso</label>
                <asp:DropDownList ID="ddlCursos" runat="server" CssClass="form-control">
                </asp:DropDownList>
            </div>
            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnCrear" Text="Crear" Visible="false" OnClick="btnCrear_Click" OnClientClick="showCreateUpdateConfirm('crear'); return false;" />
            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnActualizar" Text="Actualizar" Visible="false" OnClick="btnActualizar_Click" OnClientClick="showCreateUpdateConfirm('actualizar'); return false;" />
            <asp:Button runat="server" CssClass="btn btn-primary" ID="btnEliminar" Text="Eliminar" Visible="false" OnClick="btnEliminar_Click" OnClientClick="showDeleteConfirm(); return false;" />
            <asp:Button runat="server" CssClass="btn btn-primary btn-dark" ID="btnVolver" Text="Volver" Visible="true" OnClick="btnVolver_Click" />

        </div>
        <br />
        <br />



    </form>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script type="text/javascript">
        function showCreateUpdateConfirm(action) {
            let titleText = "";

            if (action === 'crear') {
                titleText = "¿Quieres registrar a este estudiante?";
            } else if (action === 'actualizar') {
                titleText = "¿Quieres actualizar los datos de este estudiante?";
            }

            Swal.fire({
                title: titleText,
                showDenyButton: true,
                showCancelButton: true,
                confirmButtonText: "Guardar",
                denyButtonText: "No guardar"
            }).then((result) => {
                if (result.isConfirmed) {
                    if (action === 'crear') {
                        __doPostBack('<%= btnCrear.UniqueID %>', '');
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
