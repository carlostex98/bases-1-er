
create table departamentos(
    id_depto int primary key,
    nomb_depto varchar(220)
);

create table proveedores(
    id_pro int primary key,
    nombre_p varchar(220),
    empresa varchar(220),
    correo varchar(220),
    telefono varchar(220),
    direccion varchar(220)
);

create table municipio(
    id_mun int primary key,
    nomb_mun varchar(220),
    id_depto_fk int,
    foreign key (id_depto_fk) references departamentos(id_depto)
);

create table marcas(
    id_marca int primary key,
    nombre_marca varchar(220)
);

create table modelo(
    id_modelo int primary key,
    nombre_modelo varchar(220),
    id_marca_fk int,
    foreign key (id_marca_fk) references marcas(id_marca)
);

create table transmisiones(
    id_tns int primary key,
    tipo_tns varchar(220)
);

create table condiciones(
    id_cond int primary key,
    condicion varchar(220)
);

create table vehiculos(
    id_vehiculo int primary key,
    placa varchar(10) unique,
    kilometraje int,
    vendido tinyint(1),
    anio int,
    puertas int,
    id_modelo_fk int,
    id_tns_fk int,
    id_cond_fk int,
    foreign key (id_cond_fk) references condiciones(id_cond),
    foreign key (id_tns_fk) references transmisiones(id_tns),
    foreign key (id_modelo_fk) references modelo(id_modelo)
);

create table sucursales(
    id_sucursal int primary key,
    nombre varchar(220),
    direccion varchar(220),
    telefono varchar(20),
    sitio_web varchar(220),
    id_mun_fk int,
    foreign key (id_mun_fk) references municipio(id_mun)
);

create table vehiculos_sucursales(
    id_sucursal_fk int,
    id_vehiculos_fk int,
    foreign key (id_sucursal_fk) references sucursales(id_sucursal),
    foreign key (id_vehiculos_fk) references vehiculos(id_vehiculo)
);

create table empleados(
    cui int primary key,
    nombre varchar(220),
    nit varchar(220),
    telefono varchar(220),
    salario int default 2300
);

create table empleado_sucursal(
    id_sucursal_fk int,
    cui_empleado_fk int,
    foreign key (id_sucursal_fk) references sucursales(id_sucursal),
    foreign key (cui_empleado_fk) references empleados(cui)
);

create table labor_empleado_sucursal(
    cui_empleado_fk int,
    id_sucursal_fk int,
    fecha_entrada datetime,
    fecha_salida datetime,
    foreign key (id_sucursal_fk) references sucursales(id_sucursal),
    foreign key (cui_empleado_fk) references empleados(cui)
);

create table medios_pago(
    id_medio int primary key,
    medio varchar(220)
);

create table bancos(
    id_banco int primary key,
    nombre_banco varchar(220)
);


create table compras(
    id_compra int primary key,
    monto decimal,
    fecha date,
    id_proveedor_fk int,
    id_vehiculo_fk int,
    id_sucursal_fk int,
    foreign key (id_sucursal_fk) references sucursales(id_sucursal),
    foreign key (id_proveedor_fk) references proveedores(id_pro),
    foreign key (id_vehiculo_fk) references vehiculos(id_vehiculo)
);

create table transferencias(
    id_pago int primary key,
    monto decimal,
    tarj_credito varchar(20) null,
    fecha_tns datetime,
    id_banco_fk int,
    foreign key (id_banco_fk) references bancos(id_banco)
);

create table pagos_compras(
    id_compra_fk int,
    id_pago_fk int,
    foreign key (id_compra_fk) references compras(id_compra),
    foreign key (id_pago_fk) references transferencias(id_pago)
);

create table clientes(
    cui int primary key,
    nit varchar(20),
    nombre varchar(220),
    direccion varchar(220),
    telefono varchar(20),
    tel_casa varchar(20),
    correo varchar(100)
);

create table tarjetas_cliente(
    id_tarjeta int primary key,
    codigo varchar(20),
    creado datetime,
    cui_cliente int,
    foreign key (cui_cliente) references clientes(cui)
);


create table ventas(
    id_venta int primary key,
    monto decimal,
    fecha date,
    id_vehiculo_fk int,
    id_sucursal_fk int,
    cui_cliente int,
    cui_empleado int,
    foreign key (cui_cliente) references clientes(cui),
    foreign key (cui_empleado) references empleados(cui),
    foreign key (id_sucursal_fk) references sucursales(id_sucursal),
    foreign key (id_vehiculo_fk) references vehiculos(id_vehiculo)
);

create table pagos_ventas(
    id_venta_fk int,
    id_pago_fk int,
    foreign key (id_venta_fk) references ventas(id_venta),
    foreign key (id_pago_fk) references transferencias(id_pago)
);