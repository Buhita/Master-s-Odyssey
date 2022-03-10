using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Masters_Odyssey.Clases {
    public class DAO {
        public SqlConnection con = null;//establecer la conexion a bd
        public SqlCommand cmd = null;//Establecer la sentencia sql
        public SqlDataReader dr = null;//contenedor de los datos de la query

        public DAO()
        {
            //Data Source = nombre del servidor BD
            //Initial catalog= nombre de la base de datos a trabajar
            try
            {
                con = new SqlConnection("Data Source=(localdb)\\18636664;Initial Catalog=rol;Integrated Security=True;");
            }
            catch (SqlException e)
            {
                Environment.Exit(0);
            }
        }

        //USUARIO//
        //USUARIO//
        //USUARIO//

        public string BuscarUsuario(Usuario U)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from usuarios where nom_usu='" + U.Nombre + "' and con_usu='" + U.Contra + "'", con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_usu"].ToString();
                    con.Close();
                    return nom;
                }
                else
                {
                    con.Close();
                    return null;
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }// CIERRE

        public string RegistrarUsuario(Usuario U)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from usuarios where nom_usu='" + U.Nombre + "'", con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    return "El nombre de usuario ya está en uso. ";
                }
                else
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("select * from usuarios where cor_usu='" + U.Correo+ "'", con);
                    dr = cmd.ExecuteReader();
                    if (dr.Read())
                    {
                        con.Close();
                        return "El correo de usuario ya está en uso. ";
                    }
                    else
                    {
                        con.Close();
                        con.Open();
                        cmd = new SqlCommand("insert into usuarios values('" + U.Nombre + "','" + U.Contra + "','" + U.Correo + "')", con);
                        cmd.ExecuteReader();
                        con.Close();
                        return "Usuario registrado correctamente";
                    }
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }// CIERRE

        //CAMPAÑA//
        //CAMPAÑA//
        //CAMPAÑA//

        public string CrearCampaña(Campania C)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("insert into campanias values('"+C.Nombre+"','','"+C.Nom_usu+"')", con);
                cmd.ExecuteReader();
                con.Close();
                return "Campaña Creada Correctamente";
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }// CIERRE

        public List<Campania> ListaCampañas()
        {
            List<Campania> lista = new List<Campania>();
            try
            {
                Campania C;
                con.Open();
                cmd = new SqlCommand("select * from campanias", con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    string nom, reg, usu;
                    int id;
                    int.TryParse(dr["id_cam"].ToString(), out id);
                    nom = dr["nom_cam"].ToString();
                    reg = dr["reg_cam"].ToString();
                    usu = dr["nom_usu"].ToString();
                    C = new Campania(id,nom,reg,usu);
                    lista.Add(C);
                }
                con.Close();
                return lista;
            }
            catch (SqlException e)
            {
                lista.Add(new Campania(0,e.ToString(), "", ""));
                return lista;
            }
        }//CIERRE

        public List<Campania> ElegirCampaña(int op)
        {
            List<Campania> lista = new List<Campania>();
            try
            {
                Campania C;
                con.Open();
                cmd = new SqlCommand("select * from campanias where id_cam=" + op, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom, reg, usu;
                    int id;
                    int.TryParse(dr["id_cam"].ToString(), out id);
                    nom = dr["nom_cam"].ToString();
                    reg = dr["reg_cam"].ToString();
                    usu = dr["nom_usu"].ToString();
                    C = new Campania(id, nom, reg, usu);
                    lista.Add(C);
                    con.Close();
                    return lista;
                }
                else
                {
                    con.Close();
                    return lista;
                }
            }
            catch (SqlException e)
            {
                lista.Add(new Campania(0, e.ToString(), "", ""));
                return lista;
            }
        }//CIERRE

        public string BorrarCampaña(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from campanias where id_cam="+id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("delete from campanias where id_cam="+id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Campaña eliminada correctamente";
                }
                else
                {
                    con.Close();
                    return "La campaña no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string EncontrarReglas(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from campanias where id_cam=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string reg;
                    reg = dr["reg_cam"].ToString();
                    con.Close();
                    return reg;
                }
                else
                {
                    con.Close();
                    return "La campaña no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string GuardarReglas(Campania C)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from campanias where id_cam="+C.Id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update campanias set reg_cam='"+C.Reglas+"' where id_cam="+C.Id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Las reglas de la campaña han sido incorporadas correctamente";
                }
                else
                {
                    con.Close();
                    return "La campaña no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        //PERSONAJES//
        //PERSONAJES//
        //PERSONAJES//

        public List<Personaje> ListaPersonajes()
        {
            List<Personaje> lista = new List<Personaje>();
            try
            {
                Personaje P;
                con.Open();
                cmd = new SqlCommand("select * from personajes", con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    int.TryParse(dr["id_per"].ToString(), out int id);
                    string nom = dr["nom_per"].ToString();
                    string raz = dr["raz_per"].ToString();
                    string cla = dr["cla_per"].ToString();
                    string es1 = dr["est1_per"].ToString();
                    string es2 = dr["est2_per"].ToString();
                    string es3 = dr["est3_per"].ToString();
                    string es4 = dr["est4_per"].ToString();
                    string es5 = dr["est5_per"].ToString();
                    string es6 = dr["est6_per"].ToString();
                    string es7 = dr["est7_per"].ToString();
                    string es8 = dr["est8_per"].ToString();
                    string car = dr["car_per"].ToString();
                    int.TryParse(dr["id_cem"].ToString(), out int idcem);
                    int.TryParse(dr["id_cam"].ToString(), out int idcam);
                    P = new Personaje(id,nom,raz,cla,es1,es2,es3,es4,es5,es6,es7,es8,car,idcem,idcam);
                    lista.Add(P);
                }
                con.Close();
                return lista;
            }
            catch (SqlException e)
            {
                lista.Add(new Personaje(0, e.ToString(),"","","","","","","","","","","",0,0));
                return lista;
            }
        }//CIERRE

        public List<Personaje> SacarPersonaje(int idper)
        {
            List<Personaje> lista = new List<Personaje>();
            try
            {
                Personaje P;
                con.Open();
                cmd = new SqlCommand("select * from personajes where id_per="+idper, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    int.TryParse(dr["id_per"].ToString(), out int id);
                    string nom = dr["nom_per"].ToString();
                    string raz = dr["raz_per"].ToString();
                    string cla = dr["cla_per"].ToString();
                    string es1 = dr["est1_per"].ToString();
                    string es2 = dr["est2_per"].ToString();
                    string es3 = dr["est3_per"].ToString();
                    string es4 = dr["est4_per"].ToString();
                    string es5 = dr["est5_per"].ToString();
                    string es6 = dr["est6_per"].ToString();
                    string es7 = dr["est7_per"].ToString();
                    string es8 = dr["est8_per"].ToString();
                    string car = dr["car_per"].ToString();
                    int.TryParse(dr["id_cem"].ToString(), out int idcem);
                    int.TryParse(dr["id_cam"].ToString(), out int idcam);
                    P = new Personaje(id, nom, raz, cla, es1, es2, es3, es4, es5, es6, es7, es8, car, idcem, idcam);
                    lista.Add(P);
                    con.Close();
                    return lista;
                }
                else
                {
                    con.Close();
                    return lista;
                }
                
            }
            catch (SqlException e)
            {
                lista.Add(new Personaje(0, e.ToString(), "", "", "", "", "", "", "", "", "", "", "", 0, 0));
                return lista;
            }
        }//CIERRE

        public string CrearPersonaje(Personaje P)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("insert into personajes values('"+P.Nombre+"','"+P.Raza+"','"+P.Clase+"','"+P.Estado1+ "','" + P.Estado2 + "','" + P.Estado3 + "','" + P.Estado4 + "','" + P.Estado5 + "','" + P.Estado6 + "','" + P.Estado7 + "','" + P.Estado8 + "','"+P.Caracter+"',"+P.Id_cem+","+P.Id_cam+")", con);
                cmd.ExecuteReader();
                con.Close();
                return "El personaje se ha creado sin problemas";            
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string ModificarPersonaje(Personaje P)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from personajes where id_per=" + P.Id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update personajes set nom_per='"+P.Nombre+"', raz_per='"+P.Raza+"', cla_per='"+P.Clase+ "', est1_per='"+P.Estado1+"', est2_per='"+P.Estado2+ "', est3_per='"+P.Estado3+ "', est4_per='" + P.Estado4 + "', est5_per='" + P.Estado5 + "', est6_per='" + P.Estado6 + "', est7_per='" + P.Estado7 + "', est8_per='" + P.Estado8 + "', car_per='"+P.Caracter+"' where id_per=" + P.Id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "El personaje ha sido modificado correctamente";
                }
                else
                {
                    con.Close();
                    return "El personaje no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string BorrarPersonaje(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from personajes where id_per=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_per"].ToString();
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("delete from personajes where id_per=" + id + "", con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Personaje "+nom+" eliminado correctamente";
                }
                else
                {
                    con.Close();
                    return "El personaje no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string NombrePersonaje(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select nom_per from personajes where id_per=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_per"].ToString();
                    con.Close();
                    return nom;
                }
                else
                {
                    con.Close();
                    return "El personaje no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        //BESTIAS
        //BESTIAS
        //BESTIAS

        public List<Bestia> ListaBestias()
        {
            List<Bestia> lista = new List<Bestia>();
            try
            {
                Bestia B;
                con.Open();
                cmd = new SqlCommand("select * from bestias", con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    int.TryParse(dr["id_bes"].ToString(), out int id);
                    string nom = dr["nom_bes"].ToString();
                    string es1 = dr["est1_bes"].ToString();
                    string es2 = dr["est2_bes"].ToString();
                    string es3 = dr["est3_bes"].ToString();
                    string es4 = dr["est4_bes"].ToString();
                    string es5 = dr["est5_bes"].ToString();
                    string es6 = dr["est6_bes"].ToString();
                    string es7 = dr["est7_bes"].ToString();
                    string es8 = dr["est8_bes"].ToString();
                    string car = dr["car_bes"].ToString();
                    int.TryParse(dr["id_cam"].ToString(), out int idcam);
                    B = new Bestia(id, nom, es1, es2, es3, es4, es5, es6, es7, es8, car, idcam);
                    lista.Add(B);
                }
                con.Close();
                return lista;
            }
            catch (SqlException e)
            {
                lista.Add(new Bestia(0, e.ToString(), "", "", "", "", "", "", "", "", "", 0));
                return lista;
            }
        }//CIERRE

        public List<Bestia> SacarBestia(int idbes)
        {
            List<Bestia> lista = new List<Bestia>();
            try
            {
                Bestia B;
                con.Open();
                cmd = new SqlCommand("select * from bestias where id_bes=" + idbes, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    int.TryParse(dr["id_bes"].ToString(), out int id);
                    string nom = dr["nom_bes"].ToString();
                    string es1 = dr["est1_bes"].ToString();
                    string es2 = dr["est2_bes"].ToString();
                    string es3 = dr["est3_bes"].ToString();
                    string es4 = dr["est4_bes"].ToString();
                    string es5 = dr["est5_bes"].ToString();
                    string es6 = dr["est6_bes"].ToString();
                    string es7 = dr["est7_bes"].ToString();
                    string es8 = dr["est8_bes"].ToString();
                    string car = dr["car_bes"].ToString();
                    int.TryParse(dr["id_cam"].ToString(), out int idcam);
                    B = new Bestia(id, nom, es1, es2, es3, es4, es5, es6, es7, es8, car, idcam);
                    lista.Add(B);
                    con.Close();
                    return lista;
                }
                else
                {
                    con.Close();
                    return lista;
                }

            }
            catch (SqlException e)
            {
                lista.Add(new Bestia(0, e.ToString(), "", "", "", "", "", "", "", "", "", 0));
                return lista;
            }
        }//CIERRE

        public string ModificarBestia(Bestia B)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from bestias where id_bes=" + B.Id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update bestias set nom_bes='" + B.Nombre + "', est1_bes='" + B.Estado1 + "', est2_bes='" + B.Estado2 + "', est3_bes='" + B.Estado3 + "', est4_bes='" + B.Estado4 + "', est5_bes='" + B.Estado5 + "', est6_bes='" + B.Estado6 + "', est7_bes='" + B.Estado7 + "', est8_bes='" + B.Estado8 + "', car_bes='" + B.Caracter + "' where id_bes=" + B.Id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "La bestia ha sido modificada correctamente";
                }
                else
                {
                    con.Close();
                    return "La bestia no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string CrearBestia(Bestia B)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("insert into bestias values('" + B.Nombre + "','" + B.Estado1 + "','" + B.Estado2 + "','" + B.Estado3 + "','" + B.Estado4 + "','" + B.Estado5 + "','" + B.Estado6 + "','" + B.Estado7 + "','" + B.Estado8 + "','" + B.Caracter + "'," + B.Id_cam + ")", con);
                cmd.ExecuteReader();
                con.Close();
                return "La bestia se ha creado sin problemas";
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string BorrarBestia(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from bestias where id_bes=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_bes"].ToString();
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("delete from bestias where id_bes=" + id + "", con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Bestia "+nom+" eliminada correctamente";
                }
                else
                {
                    con.Close();
                    return "La bestia no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string NombreBestia(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select nom_bes from bestias where id_bes=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_bes"].ToString();
                    con.Close();
                    return nom;
                }
                else
                {
                    con.Close();
                    return "La bestia no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        //CEMENTERIO
        //CEMENTERIO
        //CEMENTERIO

        public string EnviarCementerio(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from personajes where id_per=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_per"].ToString();
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update personajes set id_cem=0 where id_per="+id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Personaje "+nom+" enviado al cementerio.";
                }
                else
                {
                    con.Close();
                    return "El personaje no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string Revivir(int id) 
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from personajes where id_per=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_per"].ToString();
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update personajes set id_cem=1 where id_per=" + id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Personaje "+ nom +" ha sido revivido.";
                }
                else
                {
                    con.Close();
                    return "El personaje no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }

        }//CIERRE

        //PARTIDAS//
        //PARTIDAS//
        //PARTIDAS//

        public List<Partida> ListaPartidas()
        {
            List<Partida> lista = new List<Partida>();
            try
            {
                Partida P;
                con.Open();
                cmd = new SqlCommand("select * from partidas", con);
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    string nom, not, res;
                    int id, idcam, est;
                    int.TryParse(dr["id_par"].ToString(), out id);
                    nom = dr["nom_par"].ToString();
                    not = dr["not_par"].ToString();
                    res = dr["res_par"].ToString();
                    int.TryParse(dr["id_cam"].ToString(), out idcam);
                    int.TryParse(dr["id_estp"].ToString(), out est);
                    P = new Partida(id, nom, not, res, idcam, est);
                    lista.Add(P);
                }
                con.Close();
                return lista;
            }
            catch (SqlException e)
            {
                lista.Add(new Partida(0, e.ToString(), "", "",0,0));
                return lista;
            }
        }//CIERRE

        public List<Partida> EncontrarPartida(int id)
        {
            List<Partida> lista = new List<Partida>();
            try
            {
                Partida P;
                con.Open();
                cmd = new SqlCommand("select * from partidas where id_par=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom, not, res;
                    int idcam, est;
                    int.TryParse(dr["id_par"].ToString(), out id);
                    nom = dr["nom_par"].ToString();
                    not = dr["not_par"].ToString();
                    res = dr["res_par"].ToString();
                    int.TryParse(dr["id_cam"].ToString(), out idcam);
                    int.TryParse(dr["id_estp"].ToString(), out est);
                    P = new Partida(id, nom, res, not, idcam, est);
                    lista.Add(P);
                    con.Close();
                    return lista;
                }
                else
                {
                    con.Close();
                    return lista;
                }
            }
            catch (SqlException e)
            {
                lista.Add(new Partida(0, e.ToString(), "", "", 0, 0));
                return lista;
            }
        }//CIERRE

        public string EliminarPartidas(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from partidas where id_par=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("delete from partidas where id_par=" + id + "", con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "Partida eliminada correctamente";
                }
                else
                {
                    con.Close();
                    return "La partida no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string MarcarComoRealizada(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from partidas where id_par=" +id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update partidas set id_estp=1 where id_par="+id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "La partida se ha cambiado a partida realizada";
                }
                else
                {
                    con.Close();
                    return "La partida no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string CrearPartidaRealizada(Partida P)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("insert into partidas values('"+P.Nombre+"','"+P.Notas+"','"+P.Resumen+"',"+P.Id_cam+",1)", con);
                cmd.ExecuteReader();
                con.Close();
                return "La partida se ha creado sin problemas";
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string ModificarPartidaRealizada(Partida P)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from partidas where id_par=" + P.Id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update partidas set nom_par='" + P.Nombre + "', not_par='" + P.Notas + "', res_par='" + P.Resumen + "', id_cam=" + P.Id_cam + ", id_estp=" + P.Estado + " where id_par=" + P.Id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "La partida ha sido modificada correctamente";
                }
                else
                {
                    con.Close();
                    return "La partida no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string CrearPartidaPorRealizar(Partida P)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("insert into partidas values('" + P.Nombre + "','" + P.Notas + "','" + P.Resumen + "'," + P.Id_cam + ",0)", con);
                cmd.ExecuteReader();
                con.Close();
                return "La partida se ha creado sin problemas";
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public string ModificarPartidaPorRealizar(Partida P)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select * from partidas where id_par=" + P.Id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    con.Close();
                    con.Open();
                    cmd = new SqlCommand("update partidas set nom_par='" + P.Nombre + "', not_par='" + P.Notas + "', res_par='" + P.Resumen + "', id_cam=" + P.Id_cam + ", id_estp=" + P.Estado + " where id_par=" + P.Id, con);
                    cmd.ExecuteReader();
                    con.Close();
                    return "La partida ha sido modificada correctamente";
                }
                else
                {
                    con.Close();
                    return "La partida no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

        public List<Partida> FiltrarPartidas(int id)
        {
            List<Partida> lista = new List<Partida>();
            try
            {
                Partida P;
                con.Open();
                cmd = new SqlCommand("select * from partidas where id_cam=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom, not, res;
                    int idcam, est;
                    int.TryParse(dr["id_par"].ToString(), out id);
                    nom = dr["nom_par"].ToString();
                    not = dr["not_par"].ToString();
                    res = dr["res_par"].ToString();
                    int.TryParse(dr["id_cam"].ToString(), out idcam);
                    int.TryParse(dr["id_estp"].ToString(), out est);
                    P = new Partida(id, nom, res, not, idcam, est);
                    lista.Add(P);
                    con.Close();
                    return lista;
                }
                else
                {
                    con.Close();
                    return lista;
                }
            }
            catch (SqlException e)
            {
                lista.Add(new Partida(0, e.ToString(), "", "", 0, 0));
                return lista;
            }
        }//CIERRE

        public string NombrePartida(int id)
        {
            try
            {
                con.Open();
                cmd = new SqlCommand("select nom_par from partidas where id_par=" + id, con);
                dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    string nom = dr["nom_par"].ToString();
                    con.Close();
                    return nom;
                }
                else
                {
                    con.Close();
                    return "La partida no se ha encontrado en la BD";
                }
            }
            catch (SqlException e)
            {
                return e.ToString();
            }
        }//CIERRE

    }

}
