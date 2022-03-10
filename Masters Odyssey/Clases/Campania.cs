using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Masters_Odyssey.Clases
{
    public class Campania
    {
        private int id;
        private string nombre;
        private string reglas;
        private string nom_usu;

        public Campania(int id, string nombre, string reglas, string nom_usu)
        {
            this.Id = id;
            this.Nombre = nombre;
            this.Reglas = reglas;
            this.Nom_usu = nom_usu;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Reglas { get => reglas; set => reglas = value; }
        public string Nom_usu { get => nom_usu; set => nom_usu = value; }
    }
}