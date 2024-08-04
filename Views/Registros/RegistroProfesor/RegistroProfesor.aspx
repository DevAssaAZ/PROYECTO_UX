<%@ Page Title="" Language="C#" MasterPageFile="~/MP.Master" AutoEventWireup="true" CodeBehind="RegistroProfesor.aspx.cs" Inherits="PROYECTO_UX.Views.Registros.RegistroProfesor.RegistroProfesor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="title" runat="server">
    Registro-Profesor
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="body" runat="server">
     <form runat="server">
     <br />
     <br />
     <br />
     <div class="mx-auto" style="width: 300px; text-align: center;">
         <h2>Listado de Profesores</h2>
     </div>
     <br />
     <div class="container">
         <div class="row justify-content-center">
             <div class="col-auto">
                 <asp:Button runat="server" ID="btnCrearProfesor" CssClass="btn btn-success form-control-sm" Text="Crear" OnClick="btnCrearProfesor_Click"/>
             </div>
         </div>
     </div>
     <br />
     <div class="container">
         <div class="row justify-content-center">
             <div class="col-auto">
                 <div class="table-responsive">
                     <asp:GridView runat="server" ID="gvProfesor" CssClass="table table-bordered table-hover">
                         <Columns>
                             <asp:TemplateField HeaderText="Opciones del administrador">
                                 <ItemTemplate>
                                     <asp:Button  runat="server" Text="Ver" CssClass="btn form-control-sm btn-info" ID="btnVerProfesor" OnClick="btnVerProfesor_Click"/>
                                     <asp:Button  runat="server" Text="Actualizar" CssClass="btn form-control-sm btn-warning" ID="btnActualizarProfesor" OnClick="btnActualizarProfesor_Click"/>
                                     <asp:Button  runat="server" Text="Eliminar" CssClass="btn form-control-sm btn-danger" ID="btnEliminarProfesor" OnClick="btnEliminarProfesor_Click"/>
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
