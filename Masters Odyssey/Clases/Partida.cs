using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Masters_Odyssey.Clases
{
    public class Partida
    {
        private int id;
        private string nombre;
        private string resumen;
        private string notas;
        private int id_cam;
        private int estado;

        public Partida(int id, string nombre, string resumen, string notas, int id_cam, int estado)
        {
            this.Id = id;
            this.Nombre = nombre;
            this.Resumen = resumen;
            this.Notas = notas;
            this.Id_cam = id_cam;
            this.Estado = estado;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Resumen { get => resumen; set => resumen = value; }
        public string Notas { get => notas; set => notas = value; }
        public int Id_cam { get => id_cam; set => id_cam = value; }
        public int Estado { get => estado; set => estado = value; }
    }
}