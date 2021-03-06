<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-configuration PUBLIC
		"-//Hibernate/Hibernate Configuration DTD 3.0//EN"
		"http://hibernate.sourceforge.net/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
	<session-factory>

		<property name="hibernate.connection.url">jdbc:mysql://__mysql_server:3306/__mysql_database</property>

		<!-- renseigner l'utilisateur et son mot de passe -->
		<property name="hibernate.connection.username">__mysql_user</property>
		<property name="hibernate.connection.password">__mysql_passwd</property>

		<property name="hibernate.connection.driver_class">com.mysql.jdbc.Driver</property>
		<property name="hibernate.dialect">org.hibernate.dialect.MySQLInnoDBDialect</property>
		<property name="hibernate.cache.use_second_level_cache">false</property>
		<property name="hibernate.cache.use_query_cache">false</property>
		<property name="hibernate.format_sql">true</property>
		<property name="hibernate.show_sql">true</property>
		<property name="hibernate.connection.pool_size">2</property>

		<!-- validation automatique des ordres SQL -->
		<property name="hibernate.connection.autocommit">true</property>

		<!-- Génération conditionnelle de la base de données au lancement de l'application -->
		<!-- valeurs possibles: validate,update,create,create-drop -->
		<!-- * validate: validate the schema, makes no changes to the database. -->
		<!-- * update: update the schema. -->
		<!-- * create: creates the schema, destroying previous data. -->
		<!-- * create-drop: drop the schema at the end of the session. -->
		<!-- <property name="hibernate.hbm2ddl.auto">create-drop</property> -->
		<property name="hibernate.hbm2ddl.auto">update</property>

		<!-- mappings -->
		<mapping class="me.thebio.escalade.Grimpeur" />
		<mapping class="me.thebio.escalade.Administrateur" />
		<mapping class="me.thebio.escalade.Falaise" />
		<mapping class="me.thebio.escalade.Pays" />
		<mapping class="me.thebio.escalade.Secteur" />
		<mapping class="me.thebio.escalade.Voie" />
		<mapping class="me.thebio.escalade.Ascension" />
		<mapping class="me.thebio.escalade.Cotation" />
	</session-factory>
</hibernate-configuration>
