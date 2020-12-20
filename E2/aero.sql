create table avion(
    numero_vuelo int primary key,
    modelo varchar(220),
    matricula varchar(100),
    asientos_clase_1 int,
    asientos_clase_ec int,
    asientos_clase_ej int,
    ultimo_mantenimiento date,
    prox_mantenimiento date,
    departure_date datetime,
    arrive_date datetime,
    galones_combustible decimal,
    max_distancia decimal,
    alt_max decimal
);

create table jornadas_trabajo(
    id_jornada int primary key,
    tipo varchar(220)
);

create table puestos(
    id_puesto int primary key,
    nombre_puesto varchar(220)
);

create table empleados(
    cui int primary key,
    nombre varchar(220),
    apellido varchar(220),
    direccion_domicilio varchar(220),
    fecha_contrato date,
    fecha_nacimiento date,
    correo varchar(220),
    telefono varchar(20),
    hora_inicio time,
    hora_fin time,
    id_puesto_fk int,
    id_jornda_fk int,
    foreign key (id_puesto_fk) references puestos(id_puesto),
    foreign key (id_jornda_fk) references jornadas_trabajo(id_jornada)
);

create table despidos(
    id_despido int primary key,
    nombre_empleado varchar(220),
    fecha_salida date,
    razon varchar(220),
    data_empleado text
);
create table asistencias(
    id_asistencia int primary key,
    fecha date,
    ingreso time,
    egreso time,
    cui_empleado_fk int,
    foreign key (cui_empleado_fk) references empleados(cui)
);

create table ausencias(
    id_asistencia int primary key,
    fecha date,
    motivo varchar(220),
    cui_empleado_fk int,
    foreign key (cui_empleado_fk) references empleados(cui)
);

create table mantenimientos(
    id_mant int  primary key,
    fecha_mantenimiento datetime,
    programado tinyint(1),
    observasiones text,
    numero_vuelo_fk int,
    foreign key (numero_vuelo_fk) references avion(numero_vuelo)
);

create table mecanicos_mentenimiento(
    id_mant_fk int,
    cui_empleado_fk int,
    foreign key (id_mant_fk) references mantenimientos(id_mant),
    foreign key (cui_empleado_fk) references empleados(cui)
);

create table cod_postales(
    id_cod_p int primary key,
    cod_p varchar(20)
);

create table clientes(
    cui int primary key,
    nombre varchar(220),
    appellido varchar(220),
    fecha_nacimineto date,
    correo varchar(220),
    direccion_domicilio varchar(220),
    num_pasaporte varchar(50) unique,
    id_cod_p_fk int,
    foreign key (id_cod_p_fk) references cod_postales(id_cod_p)
);

create table pais(
    id_pais int primary key,
    nombre_pais varchar(220)
);

create table ciudades(
    id_ciudad int primary key,
    nombre_ciudad varchar(220),
    id_pais_fk int,
    foreign key (id_pais_fk) references pais(id_pais)
);

create table vuelos(
    id_vuelo int primary key,
    id_ciudad_origen int,
    id_ciudad_destino int,
    despegue datetime,
    aterrizaje datetime,
    foreign key (id_ciudad_origen) references ciudades(id_ciudad),
    foreign key (id_ciudad_destino) references ciudades(id_ciudad)
);

create table tripulacion_vuelo(
    id_vuelo_fk int,
    cui_empleado_fk int,
    foreign key (id_vuelo_fk) references vuelos(id_vuelo),
    foreign key (cui_empleado_fk) references empleados(cui)
);

create table medios_pago(
    id_medio int primary key,
    medio varchar(220)
);

create table pagos(
    id_pago int primary key,
    numero_tarjeta varchar(20) null,
    tipo_tarjeta varchar(10)null,
    aporte decimal,
    id_medio_fk int,
    foreign key (id_medio_fk) references medios_pago(id_medio)
);

create table boletos(
    id_boleto int primary key,
    fecha_compra datetime,
    cui_cliente_fk int,
    id_vuelo_fk int,
    precio decimal,
    escala tinyint(1),
    peso_equipaje int default 50,
    data_extra text,
    foreign key (cui_cliente_fk) references clientes(cui),
    foreign key (id_vuelo_fk) references vuelos(id_vuelo)
);

create table pagos_boleto(
    id_boleto_fk int,
    id_pago_fk int,
    foreign key (id_boleto_fk) references boletos(id_boleto),
    foreign key (id_pago_fk) references pagos(id_pago)
);

create table tiempo_tripulacion(
    id_tiempo int primary key,
    horas decimal,
    cui_empleado_fk int,
    foreign key (cui_empleado_fk) references empleados(cui)
);