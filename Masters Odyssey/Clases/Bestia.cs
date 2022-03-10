using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Masters_Odyssey.Clases
{
    public class Bestia
    {
        private int id;
        private string nombre;
        private string estado1;
        private string estado2;
        private string estado3;
        private string estado4;
        private string estado5;
        private string estado6;
        private string estado7;
        private string estado8;
        private string caracter;
        private int id_cam;

        public Bestia(int id, string nombre, string estado1, string estado2, string estado3, string estado4, string estado5, string estado6, string estado7, string estado8, string caracter, int id_cam)
        {
            this.Id = id;
            this.Nombre = nombre;
            this.Estado1 = estado1;
            this.Estado2 = estado2;
            this.Estado3 = estado3;
            this.Estado4 = estado4;
            this.Estado5 = estado5;
            this.Estado6 = estado6;
            this.Estado7 = estado7;
            this.Estado8 = estado8;
            this.Caracter = caracter;
            this.Id_cam = id_cam;
        }

        public int Id { get => id; set => id = value; }
        public string Nombre { get => nombre; set => nombre = value; }
        public string Estado1 { get => estado1; set => estado1 = value; }
        public string Estado2 { get => estado2; set => estado2 = value; }
        public string Estado3 { get => estado3; set => estado3 = value; }
        public string Estado4 { get => estado4; set => estado4 = value; }
        public string Estado5 { get => estado5; set => estado5 = value; }
        public string Estado6 { get => estado6; set => estado6 = value; }
        public string Estado7 { get => estado7; set => estado7 = value; }
        public string Estado8 { get => estado8; set => estado8 = value; }
        public string Caracter { get => caracter; set => caracter = value; }
        public int Id_cam { get => id_cam; set => id_cam = value; }
    }
}