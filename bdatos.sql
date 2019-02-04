 connect system/oracle1;

drop user damian cascade;


drop tablespace dg_Oracle_tbls_comi
including contents and datafiles;


create tablespace dg_Oracle_tbls_comi
datafile 'dg_Oracle_dbfcom.dbf'
size 30M autoextend on;


create user damian 
identified by 123456
default tablespace dg_Oracle_tbls_comi;



grant connect, resource to damian ;

 connect damian/123456;
 
 create table clientes(
 idcliente number primary key not null,
 nombres varchar(20) not null,
 apellidos varchar(20) not null,
 region varchar(10) not null,
 fecha_nacimiento date not null,
 sexo char not null,
 telefono varchar(10) not null,
 email varchar(35) not null ,
 ciudad varchar(30) not null
);

-------- crear tablas 


---- categorias
create table categorias(
 idcategoria number not null primary key,
 nombre varchar(30) not null
);

----------------------------------------------------

insert into Categorias values (1,'Carnes y Embutidos');
insert into Categorias values (2,'Huevos, Lacteos y Cafe');
insert into Categorias values (3,'Frutas');
insert into Categorias values (4,'Verduras');
insert into Categorias values (5,'Zumos y Bebidas');
insert into Categorias values (6,'Panaderia y Dulces');
insert into Categorias values (7,'Aceites y Pastas');
insert into Categorias values (8,'Conservas y Comida Preparada');
insert into Categorias values (9,'Cocteles');
insert into Categorias values (10,'Algas, Tofu y preparados');

----------------------------------------------------

create table proveedor(
 idproveedor number not null primary key,
 razonsocial varchar(30) not null,
 ruc varchar(13) not null unique,
 telefono varchar(10) null
);

---- articulos
create table articulos(
 idarticulos number primary key not null,
 idcategoria number not null,
 descripcion varchar(50) not null,
 precioUnidad float not null,
 existencias number not null,
 estado varchar(15) not null,
 constraint cf_art_cat foreign key(idcategoria)
 references categorias (idcategoria)
);
------------------------------------------------------
insert into Articulos values(1,1, 'Costillas', 2.00, 50, 'Activo');

insert into Articulos values(2,2,'Mantequilla',3,80,'Activo');

insert into Articulos values(3,3,'Coco',3.00,15,'Activo');

insert into Articulos values (4,4,'Nabos',0.25,450,'Activo');

insert into Articulos values(5,5,'Vino Tinto',14.00,40,'Activo');

insert into Articulos values(6,6,'Volteado de Piña',15.00,40,'Activo');

insert into Articulos values(7,7,'Tallarines doña Petrona',0.70,40,'Activo');

insert into Articulos values(8,8,'Conserva de Pechiche',4.00,40,'Activo');

insert into Articulos values(9,9,'Mojito',5.00,40,'Inactivo');

insert into Articulos values(10,10,'Algas de Nori',14.00,40,'Activo');



insert into Articulos values(11,1, 'Jamon', 2.00, 50, 'Activo');

insert into Articulos values(12,2,'Huevos',3,80,'Activo');

insert into Articulos values(13,3,'Mango',3.00,15,'Activo');

insert into Articulos values (14,4,'Brocoli',0.25,450,'Activo');

insert into Articulos values(15,5,'Vino Blanco',14.00,40,'Activo');

insert into Articulos values(16,6,'Torta de Chocolate',15.00,40,'Activo');

insert into Articulos values(17,7,'Tallarines don Vitorio',0.70,40,'Activo');

insert into Articulos values(18,8,'Dulce de Guayaba',4.00,40,'Activo');

insert into Articulos values(19,9,'Pantera Rosa',5.00,40,'Inactivo');

insert into Articulos values(20,10,'Tofu',14.00,40,'Activo');

------------------------------------------------------
----- provedor_articulo

create table proveedores(
 idproveedores number not null primary key,
 idarticulos number not null,
 idproveedor number not null,
 constraint cf_pro_art foreign key(idarticulos)
 references articulos(idarticulos),
 constraint cf_pr_art foreign key(idproveedor)
 references proveedor(idproveedor)
);

------------


----- ventas

create table ventas (
 idventa number not null primary key,
 idcliente number not null,
 forma_de_pago varchar(30) not null,
 fecha date not null,
 total float not null,
 constraint cf_ve_cl foreign key(idcliente)
 references clientes(idcliente)
);


------ detalle_ventas

create table detalle_ventas(
 idventa number not null,
 idarticulos number not null,
 precioUnidad float not null,
 cantidad number not null,
 descuento float not null,
 constraint cf_dt_ve foreign key(idventa)
 references ventas(idventa),
 constraint cf_dt_art foreign key(idarticulos)
 references articulos(idarticulos)
);

--------------------------


----- creacion de la tabla auditoría
create sequence sig_A;
create table auditoria (
 idauditoria number not null primary key,
 nombreusuario varchar(50) not null ,
 idcliente number not null,
 fecha_hora timestamp default sysdate,
 email_nuevo varchar(35) not null,
 email_antiguo varchar(35) not null,
 constraint cf_auditoria_cl foreign key(idcliente)
 references clientes(idcliente)
);

create sequence sig_cliente;
SET SERVEROUTPUT ON
 create or replace procedure dg_Oracle_Insertar_Cliente(
 dg_Oracle_Nombre varchar,
 dg_Oracle_Apellidos varchar,
 dg_Oracle_Region varchar,
 dg_Oracle_FechaNacimiento date,
 dg_Oracle_Sexo char,
 dg_Oracle_Telefono varchar,
 dg_Oracle_correo varchar,
 dg_Oracle_Ciudad varchar) 
 is 
 begin
  insert into Clientes 
values(sig_cliente.nextval,dg_Oracle_Nombre,dg_Oracle_Apellidos,dg_Oracle_Region,
dg_Oracle_FechaNacimiento,dg_Oracle_Sexo,dg_Oracle_Telefono,dg_Oracle_correo,
dg_Oracle_Ciudad);
 end;
 /
 
 show errors procedure dg_Oracle_Insertar_Cliente;
 

 create or replace procedure dg_Oracle_detalle_categoria(dg_Oracle_idcategoria in number, dg_Oracle_cursor out sys_refcursor)
 is 
 begin
   open dg_Oracle_cursor for select a.idarticulos, a.descripcion, c.nombre from articulos a
   inner join categorias c on a.idcategoria=c.idcategoria
   where c.idcategoria=dg_Oracle_idcategoria;
 end;
 /
 show errors procedure dg_Oracle_detalle_categoria;

 -------------------------------------------
 create or replace trigger actualizarCorreo
 before update on clientes  FOR each row
 declare
 begin
  if :NEW.email<>:OLD.email then
   insert into auditoria(idauditoria, nombreusuario ,idcliente,email_nuevo,email_antiguo) 
  values (sig_A.nextval,user,:OLD.idcliente,:NEW.email,:OLD.email);
  end if;  
 end;
 /
 show error trigger actualizarCorreo;
 
 
 -------------------------------------------
create or replace procedure ver_auditoria(dc_oracle_cursor out sys_refcursor)
is
begin
  open dc_oracle_cursor for select idauditoria, (nombres ||' ' || apellidos), nombreusuario, to_char(fecha_hora,'dd/MM/yyyy'),to_char(fecha_hora,'hh:mm:ss'), email_antiguo,email_nuevo
  from auditoria a 
  inner join clientes c on a.idcliente=c.idcliente
  order by fecha_hora asc;
end;
/
show errors procedure ver_auditoria;
 
 
 -------------------------------------------
 
 
