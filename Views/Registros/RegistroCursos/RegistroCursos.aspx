<%@ Page Title="" Language="C#" MasterPageFile="~/MP.Master" AutoEventWireup="true" CodeBehind="RegistroCursos.aspx.cs" Inherits="PROYECTO_UX.Views.Registros.RegistroCursos.RegistroCursos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Registro-Cursos
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
    <form runat="server">
        <br />
        <br />
        <br />
        <div class="mx-auto" style="width: 300px; text-align: center;">
            <h2>Listado de Cursos</h2>
        </div>
        <br />
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-auto">
                    <asp:Button runat="server" ID="btnCrear" CssClass="btn btn-success form-control-sm" Text="Crear" OnClick="btnCrear_Click"/>
                </div>
            </div>
        </div>
        <br />
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-auto">
                    <div class="table-responsive">
                        <asp:GridView runat="server" ID="gvCursos" CssClass="table table-bordered table-hover">
                            <Columns>
                                <asp:TemplateField HeaderText="Opciones del administrador">
                                    <ItemTemplate>
                                        <asp:Button  runat="server" Text="Ver" CssClass="btn form-control-sm btn-info" ID="btnVer" OnClick="btnVer_Click"/>
                                        <asp:Button  runat="server" Text="Actualizar" CssClass="btn form-control-sm btn-warning" ID="btnActualizar" OnClick="btnActualizar_Click"/>
                                        <asp:Button  runat="server" Text="Eliminar" CssClass="btn form-control-sm btn-danger" ID="btnEliminar" OnClick="btnEliminar_Click"/>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
</asp:Content>

