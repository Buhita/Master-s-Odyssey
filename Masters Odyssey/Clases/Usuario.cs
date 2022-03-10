using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Masters_Odyssey.Clases
{
    public class Usuario
    {
        private string nombre;
        private string correo;
        private string contra;

        public string Nombre { get => nombre; set => nombre = value; }
        public string Correo { get => correo; set => correo = value; }
        public string Contra { get => contra; set => contra = value; }

        public Usuario(string nombre, string correo, string contra)
        {
            this.Nombre = nombre;
            this.Correo = correo;
            this.Contra = contra;
        }
    }
}