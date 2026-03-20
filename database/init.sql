CREATE TABLE IF NOT EXISTS admins(
    id_admin SERIAL PRIMARY KEY,
    username_admin VARCHAR(255) NOT NULL UNIQUE,
    password_admin VARCHAR(255) NOT NULL
);

INSERT INTO admins (username_admin, password_admin) VALUES
('Ali Gonzalez', 'Administrador1'),
('Angel Mercado', 'Administrador2'),
('David Morales', 'Administrador3');

CREATE TABLE IF NOT EXISTS categorias(
    id_categoria SERIAL PRIMARY KEY,
    nombre_categoria VARCHAR(255) NOT NULL UNIQUE,
    descripcion_categoria TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS recetas(
    id_receta SERIAL PRIMARY KEY,
    id_categoria INT NOT NULL,
    id_autor INT NOT NULL,
    porciones_receta INT NOT NULL,
    nombre_receta VARCHAR(255) NOT NULL,
    descripcion_receta TEXT NOT NULL,
    ingredientes_receta TEXT NOT NULL,
    instrucciones_receta TEXT NOT NULL,
    tiempo_preparacion INT NOT NULL,
    dificultad VARCHAR(50) NOT NULL,
    imagen_receta VARCHAR(255),
    
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    FOREIGN KEY (id_autor) REFERENCES admins(id_admin)
);

CREATE TABLE IF NOT EXISTS usuario(
    id_usuario SERIAL PRIMARY KEY,
    nombre_usuario VARCHAR(255) NOT NULL UNIQUE,
    correo_usuario VARCHAR(255) NOT NULL UNIQUE,
    contraseña_usuario VARCHAR(255) NOT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    foto_usuario VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS favoritos(
    id_favorito SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_receta INT NOT NULL,
    
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_receta) REFERENCES recetas(id_receta),
    UNIQUE (id_usuario, id_receta)
);

CREATE TABLE IF NOT EXISTS valoraciones(
    id_valoracion SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_receta INT NOT NULL,
    valoracion INT NOT NULL CHECK (valoracion >= 1 AND valoracion <= 5),
    comentario TEXT,
    
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_receta) REFERENCES recetas(id_receta),
    UNIQUE (id_usuario, id_receta)
);

CREATE TABLE IF NOT EXISTS comentarios(
    id_comentario SERIAL PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_receta INT NOT NULL,
    comentario TEXT NOT NULL,
    fecha_comentario TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (id_receta) REFERENCES recetas(id_receta)
);