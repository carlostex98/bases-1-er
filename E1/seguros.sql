create table areas(
    id_area int primary key ,
    nombre_area varchar(220)
);

create table departamentos(
    id_departamento int primary key,
    nombre_departamento varchar(220),
    id_area_fk int,
    foreign key (id_area_fk) references areas(id_area)
);

create table funciones (
  id_funcion int primary key,
  nombre_funcion varchar(220),
  id_depertamento_fk int unique,
  foreign key (id_depertamento_fk) references departamentos(id_departamento)
);

create table puestos(
    id_puesto int primary key,
    nombre_puesto varchar(220)
);

create table personal(
	cui int primary key,
    nombre varchar(220),
    apellidos varchar(220),
    fecha_nacimiento date,
    inicio_labores date,
    telefono varchar(20),
    direccion_domicilio varchar(220),
    id_puesto_fk int,
    id_departamento int,
    foreign key (id_puesto_fk) references puestos(id_puesto),
    foreign key (id_departamento) references departamentos(id_departamento)
);

create table seguros(
    id_seguro int primary key,
    nombre_seguro varchar(220),
    data_seguro text
);

create table papeleria_seguro(
    id_elemento int primary key,
    nombre_elemento varchar(220),
    id_seguro_fk int,
    foreign key (id_seguro_fk) references seguros(id_seguro)
);

create table clientes(
    cui int primary key,
    nombre varchar(220),
    apellido varchar(220),
    fecha_nacimineto date,
    telefono varchar(20),
    direccion_domicilio varchar(220),
    correo varchar(220)
);

create table polizas(
    id_poliza int primary key auto_increment,
    fecha_inicio date,
    fecha_final date,
    cui_empleado_fk int,
    cui_cliente_fk int,
    foreign key (cui_empleado_fk) references personal(cui),
    foreign key (cui_cliente_fk) references clientes(cui)
);


create table pago_medios(
    id_medio int primary key,
    descripcion varchar(220)
);

create table pagos(
    id_pago int primary key,
    tarifa int,
    mora decimal,
    monto decimal,
    fecha_pago date,
    cui_empleado_fk int,
    cui_cliente_fk int,
    id_poliza_fk int,
    id_medio_fk int,
    foreign key (cui_empleado_fk) references personal(cui),
    foreign key (cui_cliente_fk) references clientes(cui),
    foreign key (id_poliza_fk) references polizas(id_poliza),
    foreign key (id_medio_fk) references pago_medios(id_medio)
);


create table llamadas_atencion(
    id_llamada int primary key,
    nombre_cliente varchar(220),
    numero_cliente varchar(10),
    fecha_llamada datetime,
    duracion time,
    cui_empleado_fk int,
    id_seguro_fk int,
    foreign key (cui_empleado_fk) references personal(cui),
    foreign key (id_seguro_fk) references seguros(id_seguro)
);

alter table polizas auto_increment = 1000;