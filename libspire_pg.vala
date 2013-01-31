//
//  spire_postgresql.vala
//  
//  Author:
//       Edwin De La Cruz <edwinspire@gmail.com>
//  
//  Copyright (c) 2011 edwinspire
// 
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU Lesser General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
// 
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU Lesser General Public License for more details.
// 
//  You should have received a copy of the GNU Lesser General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
using GLib;
using Gee;
using Postgres;

namespace edwinspire{

namespace pgSQL{

public struct ConnectionParameters{

public string Host;
public uint Port;
public string db;
public string User;
public string Pwd;
public bool SSL;
public uint TimeOut;

public ConnectionParameters(){
this.Host = "localhost";
this.Port = 0;
this.db = "";
this.User = "";
this.Pwd = "";
this.SSL = false;
this.TimeOut = 0;
}

}

public class PgField:GLib.Object{
public string Value = "";

public PgField(string v){
this.Value = v;
}

public int as_int(){
return int.parse(this.Value);
}

public uint as_uint(){
return (uint)int.parse(this.Value);
}

public long as_long(){
return long.parse(this.Value);
}
public ulong as_ulong(){
return (ulong)long.parse(this.Value);
}

public double as_double(){
return double.parse(this.Value);
}

public int64 as_int64(){
return int64.parse(this.Value);
}
public uint64 as_uint64(){
return uint64.parse(this.Value);
}



public bool as_bool(){
bool Retorno = false;
if(this.Value == "t"){
Retorno = true;
}
return Retorno;
}

}

[Description(nick = "PostgreSqldb", blurb = "Clase de acceso a Postgres")]
public class PostgreSqldb :GLib.Object {

public ConnectionParameters ParamCnx = ConnectionParameters();

public PostgreSqldb(){

}

[Description(nick = "Funcion exec_params con el minimo de parametros", blurb = "")]
public static Result exec_params_minimal(ref Database db, string command, string[] paramValues){
return db.exec_params (command,  paramValues.length, null, paramValues, null, null, 0);
}

[Description(nick = "Construtor con argumentos", blurb = "")]
public PostgreSqldb.with_args(string user, string pwd, string host, string dataBase, uint port = 0, bool ssl = false, uint timeOut = 0){
ParamCnx.Host = host;
ParamCnx.Port = port;
ParamCnx.db = dataBase;
ParamCnx.User = user;
ParamCnx.Pwd = pwd;
ParamCnx.SSL = ssl;
ParamCnx.TimeOut = timeOut;
}

public bool TestConnection(){
return TryConnect(ConnString());
}

[Description(nick = "ConnString", blurb = "String para la Conexion con la base de datos")]
public string ConnString(){

StringBuilder Cadena = new StringBuilder();
if(ParamCnx.Host.length>0){
	Cadena.append(" host = ");
	Cadena.append(ParamCnx.Host);
//Cadena.append_printf("", );
}
if(ParamCnx.Port>0){
	Cadena.append(" port = ");
	Cadena.append(ParamCnx.Port.to_string());
//Cadena.append_printf("", );
}
if(ParamCnx.db.length>0){
	Cadena.append(" dbname = ");
	Cadena.append(ParamCnx.db);
//Cadena.append_printf("", );
}
if(ParamCnx.User.length>0){
	Cadena.append(" user = ");
	Cadena.append(ParamCnx.User);
//Cadena.append_printf("", );
}
if(ParamCnx.Pwd.length>0){
	Cadena.append(" password = ");
	Cadena.append(ParamCnx.Pwd);
//Cadena.append_printf("", );
}
if(ParamCnx.SSL){
	Cadena.append(" ssl = 1");
	//Cadena.append(1);
//Cadena.append_printf("", );
}
if(ParamCnx.TimeOut>0){
	Cadena.append(" timeout = ");
	//Cadena.append(1);
Cadena.append_printf("%i", (int)ParamCnx.TimeOut);
}

//stdout.printf ("Cadena.str = %s\n", Cadena.str);
return Cadena.str;
}

[Description(nick = "TryConnect", blurb = "Intenta conectarse con la base de datos con el string de conexion")]
public static bool TryConnect(string Connection){

bool Retorno = false;
var  Conexiondb = Postgres.connect_db (Connection);

if(Conexiondb.get_status () == ConnectionStatus.OK){
	Retorno = true;
}else{
	stderr.printf ("String Conecion: %s \nConnection to database failed: %s", Connection, Conexiondb.get_error_message ());
}
return Retorno;
}

[Description(nick = "Result FieldNum", blurb = "Devuelve una matriz de Hashmap con los campos en int")]
public static HashMap<int, PgField>[] Result_FieldNum(ref Result ResultPostgres){

//var Retorno = new ArrayList<HashMap<int, string>>();

int row = 0;
int field = 0;
int num_tuples = ResultPostgres.get_n_tuples();
HashMap<int, PgField>[] Retorno = new HashMap<int, PgField>[num_tuples];

while(row<num_tuples){

var Fila = new HashMap<int, PgField>();
field = 0;
while(field<ResultPostgres.get_n_fields ()){
Fila.set(field,  new PgField(ResultPostgres.get_value(row, field)));
field++;
}
Retorno[row] = Fila;

row++;
}

return Retorno;
}

[Description(nick = "Result FieldName", blurb = "Devuelve una matriz de Hashmap con los campos en string")]
public static HashMap<string, PgField>[] Result_FieldName(ref Result ResultPostgres){
//var Retorno = new ArrayList<HashMap<string, string>>();
HashMap<string, PgField>[] Retorno = new HashMap<string, PgField>[ResultPostgres.get_n_tuples()];

int row = 0;

foreach(var Fila in Result_FieldNum(ref ResultPostgres)){

var NuevaFila = new HashMap<string, PgField>();

foreach(var Detalle in Fila.entries){
NuevaFila.set(ResultPostgres.get_field_name (Detalle.key), Detalle.value);
}
Retorno[row] = NuevaFila;
row++;
}

return Retorno;
}




}







/*

// Crea un string con los datos necesarios para hecer la conexion con el servidor de postgresql
public class PgConnBuilder :GLib.Object {

public string Host = "";
//public string HostAddr = "";
public uint Port = 0;
public string DataBase = "";
public string User = "";
public string Password = "";
public bool SSL = false;
public uint TimeOut = 0;
//private unowned string conni = "";

public PgConnBuilder(){

}

public  string ConnInfo(){
return PSQLMisc.ConnInfo(this.Host, Port, DataBase, User, Password, SSL, TimeOut); 
//stdout.printf ("con %s\n", conni);
//return conni;
}

/*
public static unowned string StringConnection(string Host, uint Port = 0, string DBName = "", string User = "", string Password = "", bool SSL = false, uint TimeOut = 30){

StringBuilder Cadena = new StringBuilder();
if(Host.length>0){
	Cadena.append(" host = ");
	Cadena.append(Host);
//Cadena.append_printf("", );
}
if(Port>0){
	Cadena.append(" port = ");
	Cadena.append(Port.to_string());
//Cadena.append_printf("", );
}
if(DBName.length>0){
	Cadena.append(" dbname = ");
	Cadena.append(DBName);
//Cadena.append_printf("", );
}
if(User.length>0){
	Cadena.append(" user = ");
	Cadena.append(User);
//Cadena.append_printf("", );
}
if(Password.length>0){
	Cadena.append(" password = ");
	Cadena.append(Password);
//Cadena.append_printf("", );
}
if(SSL){
	Cadena.append(" ssl = 1");
	//Cadena.append(1);
//Cadena.append_printf("", );
}
if(TimeOut>0){
	Cadena.append(" timeout = ");
	//Cadena.append(1);
Cadena.append_printf("%i", (int)TimeOut);
}

//stdout.printf ("Cadena.str = %s\n", Cadena.str);
return Cadena.str;
}
///



}
*/
/*
public class ResultPg: GLib.Object{

private unowned Result Internalresult;
public int Row{set; get; default = 0;}

public ResultPg(Result ResultPostg_){
//	Row = 0;
Internalresult = ResultPostg_;
}

public int Rows{
	get{
		return Internalresult.get_n_tuples();
	}
}


// devuelve el valor de un campo (valor pùede ser int id del campo o string nombre del campo)
// La fila que deviuelve es la ubicada en la posicion row
public string string(Value field){

string Retorno = "";
int field_num = -1;

if(field.type() == typeof(int)){

field_num = field.get_int();
if(field_num < Internalresult.get_n_fields ()){
 Retorno = Internalresult.get_value(Row, field_num);
}
}else if(field.type() == typeof(string)){

field_num = Internalresult.get_field_number(field.get_string());

if(field_num >=0 && field_num < Internalresult.get_n_fields ()){
 Retorno = Internalresult.get_value(Row, field_num);
}

}

return Retorno;
}

public int Int(Value field){
return int.parse(string(field));
}

public long Long(Value field){
return long.parse(string(field));
}
public ulong Ulong(Value field){
return (ulong)long.parse(string(field));
}

public double Double(Value field){
return double.parse(string(field));
}

public int64 Int64(Value field){
return int64.parse(string(field));
}
public uint64 Uint64(Value field){
return uint64.parse(string(field));
}



public bool bool(Value field){
bool Retorno = false;
if(string(field).has_prefix("t")){
Retorno = true;
}
return Retorno;
}

}
*/
/*
// TODO // Eliminar esta clase en el futuro, solo existe por compaibilidad con la libreria anterior.
public class QueryString:QueryBuilder{

public QueryString(){

}

}
*/

/*
// Clase utilizada para crea un string con el query que se la a enviar  al servidor, permite ingresar diferentes variables que son automaticamente formateadas segun el tipo de campo
// al que pertenecen.
public class QueryBuilder: GLib.Object{

private string QueryInterno = "";

private HashMap<string, string> Vars = new HashMap<string, string>();
private GLib.Value VarTemp;

public QueryBuilder(){
VarTemp = 0;
}

public QueryBuilder.with_query(string Query){
QueryInterno = Query;
}

public string Query{

get{
	return QueryInterno;
}
set{
	QueryInterno = value;
}
}


public void set_variable(string NameVar, Value ValueVar){

StringBuilder Retorno = new StringBuilder();
Value X = ValueVar;
string ValTemp = "";

if(X.type() == typeof(string)){
Retorno.append(FormatString(X.get_string()));
}else if(X.type() == typeof(int)){
Retorno.append_printf("%i", X.get_int());
}else if(X.type() == typeof(uint)){
Retorno.append_printf("%u", X.get_uint());
}else if(X.type() == typeof(double)){
Retorno.append_printf("%g", X.get_double());
ValTemp = (Retorno.str).replace(",", ".");
Retorno.truncate(0);
Retorno.append(ValTemp);
}else if(X.type() == typeof(char)){
Retorno.append_printf("%c", X.get_char());
}else if(X.type() == typeof(uchar)){
Retorno.append_printf("%c", X.get_uchar());
}else if(X.type() == typeof(long)){
Retorno.append_printf("%l", X.get_long());
ValTemp = (Retorno.str).replace(",", ".");
Retorno.truncate(0);
Retorno.append(ValTemp);
}else if(X.type() == typeof(ulong)){
Retorno.append_printf("%l", X.get_ulong());
ValTemp = (Retorno.str).replace(",", ".");
Retorno.truncate(0);
Retorno.append(ValTemp);
}else if(X.type() == typeof(DateTime)){
Retorno.append_printf("%s", FormatString(((DateTime)X).format("%F %H:%M:%S")));
}else if(X.type() == typeof(bool)){
Retorno.append_printf("%s", (X.get_boolean()).to_string());
}else if(X.type() == typeof(float)){
Retorno.append_printf("%f", X.get_float());
ValTemp = (Retorno.str).replace(",", ".");
Retorno.truncate(0);
Retorno.append(ValTemp);
}

Vars.set(NameVar, Retorno.str);
}

public string Return(){
	string NuevoQuery = QueryInterno;
foreach(var Variable in Vars.entries){
NuevoQuery = NuevoQuery.replace(Variable.key, Variable.value);
//stdout.printf ("Return %s - %s\n", Variable.key, Variable.value);
}
return NuevoQuery;
}

public void ClearValues(){
Vars.clear();
}




private static string FormatString(string Valor, bool DoubleCommi = false){

StringBuilder Cadena = new StringBuilder();

if(DoubleCommi){
Cadena.append("\"");
Cadena.append(Valor);
Cadena.append("\"");
	}else{
Cadena.append("\'");
Cadena.append(Valor);
Cadena.append("\'");
}

return Cadena.str;
}

}
*/


}


}





