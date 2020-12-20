create table colores(
    id_color int primary key,
    color varchar(220)
);

create table paises(
    id_pais int primary key,
    paises varchar(220)
);

create table proveedores(
    id_proveedor int primary key,
    nombre varchar(220),
    telefono varchar(50),
    nombre_compania varchar(220),
    id_pais_fk int,
    foreign key (id_pais_fk) references paises(id_pais)
);

create table tipo_almacen(
    id_tipo int primary key,
    tipo varchar(220)
);



create table puestos(
    id_puesto int primary key,
    nombre_puesto varchar(220),
    salario decimal,
    descripcion text
);

create table empleados(
    id_empleado int primary key,
    nombre varchar(220),
    direccion varchar(220),
    telefono varchar(50),
    correo varchar(220),
    id_puesto_fk int,
    foreign key (id_puesto_fk) references puestos(id_puesto)
);

create table bodegas(
    id_bodega int primary key,
    direccion varchar(220),
    id_encargado int,
    id_tipo_fk int,
    foreign key (id_encargado) references empleados(id_empleado),
    foreign key (id_tipo_fk) references tipo_almacen(id_tipo)
);

create table partes(
    id_parte int primary key,
    nombre varchar(220),
    id_color_fk int,
    parent int null,
    foreign key (id_color_fk) references colores(id_color)
);

alter table partes add foreign key (parent) references partes(id_parte);

create table partes_bodega(
    id_bodega_fk int,
    id_parte_fk int,
    cantidad int,
    foreign key (id_bodega_fk) references bodegas(id_bodega),
    foreign key (id_parte_fk) references partes(id_parte)
);

create table tipo_producto(
    id_tipo int primary key,
    tipo varchar(220)
);

create table lineas(
    id_linea int primary key,
    nombre_linea int,
    id_tipo_fk int,
    foreign key (id_tipo_fk) references tipo_producto(id_tipo)
);

create table roles(
    id_rol int primary key,
    nombre_rol varchar(220),
    descripcion text
);

create table empleados_lineas(
    id_linea_fk int,
    id_empleado_fk int,
    id_rol_fk int,
    foreign key (id_rol_fk) references roles(id_rol),
    foreign key (id_linea_fk) references lineas(id_linea),
    foreign key (id_empleado_fk) references empleados(id_empleado)
);

create table asistencia_empleados(
    id_asistencia int primary key,
    hora_entrada datetime,
    hora_salida datetime,
    id_linea_fk int,
    id_empleado_fk int,
    foreign key (id_linea_fk) references lineas(id_linea),
    foreign key (id_empleado_fk) references empleados(id_empleado)
);


create table empleado_puesto(
    id_empleado_fk int,
    id_puesto_fk int,
    foreign key (id_empleado_fk) references empleados(id_empleado),
    foreign key (id_puesto_fk) references puestos(id_puesto)
);

create table etapas(
    id_etapa int primary key,
    nombre_etapa varchar(220),
    costo decimal,
    descripcion text
);

create table productos(
    id_producto int primary key,
    nombre varchar(220),
    marca varchar(220),
    detalles text
);

create table producto_partes(
    id_producto_fk int,
    id_parte_fk int,
    foreign key (id_producto_fk) references productos(id_producto),
    foreign key (id_parte_fk) references partes(id_parte)
);




create table produccion(
    codigo_prod int primary key,
    us_ultimo_fk int,
    fecha_terminado datetime null,
    id_bodega_fk int null,
    id_pructo_fk int,
    foreign key (id_pructo_fk) references productos(id_producto),
    foreign key (id_bodega_fk) references bodegas(id_bodega),
    foreign key (us_ultimo_fk) references empleados(id_empleado)
);

create table fases(
    id_fase int primary key,
    estado_nombre varchar(220)
);

create table produccion_etapa(
    cod_prod_fk int,
    id_etapa_fk int,
    id_fase_fk int,
    foreign key (id_fase_fk) references fases(id_fase),
    foreign key (cod_prod_fk) references produccion(codigo_prod),
    foreign key (id_etapa_fk) references etapas(id_etapa)
);

create table partes_etapa(
    id_etapa_fk int,
    id_parte_fk int,
    foreign key (id_etapa_fk) references etapas(id_etapa),
    foreign key (id_parte_fk) references partes(id_parte)
);

create table compras(
    id_compra int primary key,
    fecha date,
    factura blob,
    monto decimal
);

create table partes_compra(
    id_parte_fk int,
    id_compra_fk int,
    foreign key (id_parte_fk) references partes(id_parte),
    foreign key (id_compra_fk) references compras(id_compra)
);

create table devoluciones_compra(
    id_devoluciones int primary key,
    razon varchar(220),
    detalle text,
    id_compra_fk int,
    foreign key (id_compra_fk) references compras(id_compra)
);

create table clientes(
    id_cliente int primary key,
    nombre varchar(220),
    direccion varchar(220),
    id_pais_fk int,
    foreign key (id_pais_fk) references paises(id_pais)
);

create table pedidos(
    id_pedido int primary key,
    fecha date,
    detalles varchar(220),
    id_cliente_fk int,
    adelanto decimal,
    foreign key (id_cliente_fk) references clientes(id_cliente)
);

create table pedido_producto(
    id_pedido_fk int,
    id_producto_fk int,
    cantidad int,
    foreign key (id_pedido_fk) references pedidos(id_pedido),
    foreign key (id_producto_fk) references productos(id_producto)
);

create table devoluciones_cliente(
    id_devolucion int primary key,
    cod_prod_fk int,
    id_cliente_fk int,
    hora time,
    fecha date,
    detalles text,
    monto_reembolso decimal,
    foreign key (cod_prod_fk) references produccion(codigo_prod),
    foreign key (id_cliente_fk) references clientes(id_cliente)
);