create table complexiones(
    id_complexion int primary key,
    complex varchar(220)
);

create table etnias(
    id_etnia int primary key,
    etnia varchar(220)
);

create table departamentos(
    id_departamento int primary key,
    nombre_depto varchar(220)
);

create table municipio(
    id_municipio int primary key,
    nombre_municipio varchar(220),
    id_depto_fk int,
    foreign key (id_depto_fk) references departamentos(id_departamento)
);

create table victimas(
    id_victima int primary key,
    nombre varchar(220),
    apellido varchar(220),
    fecha_nacimiento date,
    residencia varchar(220),
    telefono varchar(20),
    id_municipio_fk int,
    id_etnia_fk int,
    foreign key (id_municipio_fk) references municipio(id_municipio),
    foreign key (id_etnia_fk) references etnias(id_etnia)
);

create table denuncias(
    id_denuncia int primary key,
    nombre_denunciante varchar(220),
    fecha_den date,
    fecha_desaparicion date,
    adn_denuciante blob,
    nombre_desaparecido varchar(220),
    profesion_des varchar(220),
    edad_des int,
    altura_des decimal,
    id_etnia_fk int,
    foreign key (id_etnia_fk) references etnias(id_etnia)
);

create table victimas_no_reconocidas(
    id_victima int primary key,
    hallazago varchar(220),
    adn blob,
    altura decimal,
    edad int,
    objetos text,
    datos_extra text
);

create table complex_valor_denuncia(
    id_complex_fk int,
    id_denuncia_fk int,
    valor varchar(220),
    foreign key (id_complex_fk) references complexiones(id_complexion),
    foreign key (id_denuncia_fk) references denuncias(id_denuncia)
);

create table complex_valor_victima(
    id_complex_fk int,
    id_denuncia_fk int,
    valor varchar(220),
    foreign key (id_complex_fk) references complexiones(id_complexion),
    foreign key (id_denuncia_fk) references denuncias(id_denuncia)
);