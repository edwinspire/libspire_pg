/* libspire_pg.h generated by valac 0.16.1, the Vala compiler, do not modify */


#ifndef ___HOME_EDWINSPIRE_PROGRAMACION_PROYECTOSSOFTWARE_SOFTWARE_VALA_PROYECTOSVALA_PROYECTS_LIBSPIRE_PG_BIN_LNX_LIBSPIRE_PG_H__
#define ___HOME_EDWINSPIRE_PROGRAMACION_PROYECTOSSOFTWARE_SOFTWARE_VALA_PROYECTOSVALA_PROYECTS_LIBSPIRE_PG_BIN_LNX_LIBSPIRE_PG_H__

#include <glib.h>
#include <stdlib.h>
#include <string.h>
#include <glib-object.h>
#include <float.h>
#include <math.h>
#include <postgresql/libpq-fe.h>
#include <gee.h>

G_BEGIN_DECLS


#define EDWINSPIRE_PG_SQL_TYPE_CONNECTION_PARAMETERS (edwinspire_pg_sql_connection_parameters_get_type ())
typedef struct _edwinspirepgSQLConnectionParameters edwinspirepgSQLConnectionParameters;

#define EDWINSPIRE_PG_SQL_TYPE_PG_FIELD (edwinspire_pg_sql_pg_field_get_type ())
#define EDWINSPIRE_PG_SQL_PG_FIELD(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_PG_SQL_TYPE_PG_FIELD, edwinspirepgSQLPgField))
#define EDWINSPIRE_PG_SQL_PG_FIELD_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_PG_SQL_TYPE_PG_FIELD, edwinspirepgSQLPgFieldClass))
#define EDWINSPIRE_PG_SQL_IS_PG_FIELD(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_PG_SQL_TYPE_PG_FIELD))
#define EDWINSPIRE_PG_SQL_IS_PG_FIELD_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_PG_SQL_TYPE_PG_FIELD))
#define EDWINSPIRE_PG_SQL_PG_FIELD_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_PG_SQL_TYPE_PG_FIELD, edwinspirepgSQLPgFieldClass))

typedef struct _edwinspirepgSQLPgField edwinspirepgSQLPgField;
typedef struct _edwinspirepgSQLPgFieldClass edwinspirepgSQLPgFieldClass;
typedef struct _edwinspirepgSQLPgFieldPrivate edwinspirepgSQLPgFieldPrivate;

#define EDWINSPIRE_PG_SQL_TYPE_POSTGRE_SQLDB (edwinspire_pg_sql_postgre_sqldb_get_type ())
#define EDWINSPIRE_PG_SQL_POSTGRE_SQLDB(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), EDWINSPIRE_PG_SQL_TYPE_POSTGRE_SQLDB, edwinspirepgSQLPostgreSqldb))
#define EDWINSPIRE_PG_SQL_POSTGRE_SQLDB_CLASS(klass) (G_TYPE_CHECK_CLASS_CAST ((klass), EDWINSPIRE_PG_SQL_TYPE_POSTGRE_SQLDB, edwinspirepgSQLPostgreSqldbClass))
#define EDWINSPIRE_PG_SQL_IS_POSTGRE_SQLDB(obj) (G_TYPE_CHECK_INSTANCE_TYPE ((obj), EDWINSPIRE_PG_SQL_TYPE_POSTGRE_SQLDB))
#define EDWINSPIRE_PG_SQL_IS_POSTGRE_SQLDB_CLASS(klass) (G_TYPE_CHECK_CLASS_TYPE ((klass), EDWINSPIRE_PG_SQL_TYPE_POSTGRE_SQLDB))
#define EDWINSPIRE_PG_SQL_POSTGRE_SQLDB_GET_CLASS(obj) (G_TYPE_INSTANCE_GET_CLASS ((obj), EDWINSPIRE_PG_SQL_TYPE_POSTGRE_SQLDB, edwinspirepgSQLPostgreSqldbClass))

typedef struct _edwinspirepgSQLPostgreSqldb edwinspirepgSQLPostgreSqldb;
typedef struct _edwinspirepgSQLPostgreSqldbClass edwinspirepgSQLPostgreSqldbClass;
typedef struct _edwinspirepgSQLPostgreSqldbPrivate edwinspirepgSQLPostgreSqldbPrivate;

struct _edwinspirepgSQLConnectionParameters {
	gchar* Host;
	guint Port;
	gchar* db;
	gchar* User;
	gchar* Pwd;
	gboolean SSL;
	guint TimeOut;
};

struct _edwinspirepgSQLPgField {
	GObject parent_instance;
	edwinspirepgSQLPgFieldPrivate * priv;
	gchar* Value;
};

struct _edwinspirepgSQLPgFieldClass {
	GObjectClass parent_class;
};

struct _edwinspirepgSQLPostgreSqldb {
	GObject parent_instance;
	edwinspirepgSQLPostgreSqldbPrivate * priv;
	edwinspirepgSQLConnectionParameters ParamCnx;
};

struct _edwinspirepgSQLPostgreSqldbClass {
	GObjectClass parent_class;
};


GType edwinspire_pg_sql_connection_parameters_get_type (void) G_GNUC_CONST;
edwinspirepgSQLConnectionParameters* edwinspire_pg_sql_connection_parameters_dup (const edwinspirepgSQLConnectionParameters* self);
void edwinspire_pg_sql_connection_parameters_free (edwinspirepgSQLConnectionParameters* self);
void edwinspire_pg_sql_connection_parameters_copy (const edwinspirepgSQLConnectionParameters* self, edwinspirepgSQLConnectionParameters* dest);
void edwinspire_pg_sql_connection_parameters_destroy (edwinspirepgSQLConnectionParameters* self);
void edwinspire_pg_sql_connection_parameters_init (edwinspirepgSQLConnectionParameters *self);
GType edwinspire_pg_sql_pg_field_get_type (void) G_GNUC_CONST;
edwinspirepgSQLPgField* edwinspire_pg_sql_pg_field_new (const gchar* v);
edwinspirepgSQLPgField* edwinspire_pg_sql_pg_field_construct (GType object_type, const gchar* v);
gint edwinspire_pg_sql_pg_field_as_int (edwinspirepgSQLPgField* self);
guint edwinspire_pg_sql_pg_field_as_uint (edwinspirepgSQLPgField* self);
glong edwinspire_pg_sql_pg_field_as_long (edwinspirepgSQLPgField* self);
gulong edwinspire_pg_sql_pg_field_as_ulong (edwinspirepgSQLPgField* self);
gdouble edwinspire_pg_sql_pg_field_as_double (edwinspirepgSQLPgField* self);
gint64 edwinspire_pg_sql_pg_field_as_int64 (edwinspirepgSQLPgField* self);
guint64 edwinspire_pg_sql_pg_field_as_uint64 (edwinspirepgSQLPgField* self);
gboolean edwinspire_pg_sql_pg_field_as_bool (edwinspirepgSQLPgField* self);
GType edwinspire_pg_sql_postgre_sqldb_get_type (void) G_GNUC_CONST;
edwinspirepgSQLPostgreSqldb* edwinspire_pg_sql_postgre_sqldb_new (void);
edwinspirepgSQLPostgreSqldb* edwinspire_pg_sql_postgre_sqldb_construct (GType object_type);
edwinspirepgSQLPostgreSqldb* edwinspire_pg_sql_postgre_sqldb_new_with_args (const gchar* user, const gchar* pwd, const gchar* host, const gchar* dataBase, guint port, gboolean ssl, guint timeOut);
edwinspirepgSQLPostgreSqldb* edwinspire_pg_sql_postgre_sqldb_construct_with_args (GType object_type, const gchar* user, const gchar* pwd, const gchar* host, const gchar* dataBase, guint port, gboolean ssl, guint timeOut);
gboolean edwinspire_pg_sql_postgre_sqldb_TestConnection (edwinspirepgSQLPostgreSqldb* self);
gchar* edwinspire_pg_sql_postgre_sqldb_ConnString (edwinspirepgSQLPostgreSqldb* self);
gboolean edwinspire_pg_sql_postgre_sqldb_TryConnect (const gchar* Connection);
GeeHashMap** edwinspire_pg_sql_postgre_sqldb_Result_FieldNum (PGresult** ResultPostgres, int* result_length1);
GeeHashMap** edwinspire_pg_sql_postgre_sqldb_Result_FieldName (PGresult** ResultPostgres, int* result_length1);


G_END_DECLS

#endif
