from flask import Blueprint, jsonify, request
from db import get_connection

main_routes = Blueprint("main", __name__)

@main_routes.route("/", methods=["GET"])
def home():
    return jsonify({
        "message": "¡Hola desde el backend de CocinaFácil App!"
    })

@main_routes.route("/db-test", methods=["GET"])
def db_test():
    conn = get_connection()

    if conn:
        return jsonify({
            "message": "Conexión a la base de datos exitosa"
        })
    else:
        return jsonify({
            "message": "Error al conectar a la base de datos"
        }), 500

    
@main_routes.route("/recetas", methods=["POST"])
def crear_receta():
    try:
        data = request.get_json()
        
        nombre_receta = data.get("nombre_receta")
        descripcion_receta = data.get("descripcion_receta")
        ingredientes_receta = data.get("ingredientes_receta")
        instrucciones_receta = data.get("instrucciones_receta")
        tiempo_preparacion = data.get("tiempo_preparacion")
        dificultad = data.get("dificultad")
        porciones_receta = data.get("porciones_receta")
        id_categoria = data.get("id_categoria")
        id_autor = data.get("id_autor")
        imagen_receta = data.get("imagen_receta")

        conn = get_connection()
        cursor = conn.cursor()

        query = """
        INSERT INTO recetas (
        nombre_receta, descripcion_receta, ingredientes_receta,
        instrucciones_receta, tiempo_preparacion, dificultad,
        porciones_receta, id_categoria, id_autor, imagen_receta
        )
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        RETURNING id_receta
        """
        cursor.execute(query, (
            nombre_receta, descripcion_receta, ingredientes_receta,
            instrucciones_receta, tiempo_preparacion, dificultad,
            porciones_receta, id_categoria, id_autor, imagen_receta
        ))

        id_receta = cursor.fetchone()[0]

        conn.commit()
        cursor.close()
        conn.close()

        return jsonify({
            "message": "Receta creada exitosamente",
            "id_receta": id_receta
        }), 201
    except Exception as e:
        print("Error al crear receta:", e)
        return jsonify({
            "message": "Error al crear la receta"
        }), 500
    
@main_routes.route("/recetas", methods=["GET"])
def obtener_recetas():
    try:
        conn = get_connection()
        cursor = conn.cursor()

        categoria = request.args.get("categoria")
        buscar = request.args.get("buscar")

        query = """
        SELECT 
            r.id_receta,
            r.nombre_receta,
            r.descripcion_receta,
            r.ingredientes_receta,
            r.instrucciones_receta,
            r.tiempo_preparacion,
            r.dificultad,
            r.porciones_receta,
            r.imagen_receta,
            c.nombre_categoria AS categoria,
            a.username_admin AS autor
        FROM recetas r
        JOIN categorias c ON r.id_categoria = c.id_categoria
        JOIN admins a ON r.id_autor = a.id_admin
        WHERE 1=1
        """

        params = []
        if categoria:
            query += " WHERE LOWER(c.nombre_categoria) = LOWER(%s)"
            params.append(f"%{categoria.strip()}%")
        if buscar:
            if "WHERE" in query:
                query += " AND (r.nombre_receta ILIKE %s OR r.descripcion_receta ILIKE %s)"
            else:
                query += " WHERE (r.nombre_receta ILIKE %s OR r.descripcion_receta ILIKE %s)"
            params.extend([f"%{buscar}%", f"%{buscar}%"])

        cursor.execute(query, tuple(params))
        recetas = cursor.fetchall()
        columnas = [desc[0] for desc in cursor.description]

        cursor.close()
        conn.close()

        recetas_list = []
        for receta in recetas:
            recetas_list.append(dict(zip(columnas, receta)))

        return jsonify(recetas_list), 200
    except Exception as e:
        print("Error al obtener recetas:", e)
        return jsonify({
            "message": "Error al obtener las recetas"
        }), 500
    
@main_routes.route("/recetas/<int:id_receta>", methods=["GET"])
def obtener_receta(id_receta):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        query = """
        SELECT 
            r.id_receta,
            r.nombre_receta,
            r.descripcion_receta,
            r.ingredientes_receta,
            r.instrucciones_receta,
            r.tiempo_preparacion,
            r.dificultad,
            r.porciones_receta,
            r.imagen_receta,
            c.nombre_categoria AS categoria
            a.username_admin AS autor
        FROM recetas r
        JOIN categorias c ON r.id_categoria = c.id_categoria
        JOIN admins a ON r.id_autor = a.id_admin
        WHERE r.id_receta = %s;
        """
        cursor.execute(query, (id_receta,))
        receta = cursor.fetchone()
        columnas = [desc[0] for desc in cursor.description]

        cursor.close()
        conn.close()

        if receta:
            return jsonify(dict(zip(columnas, receta))), 200
        else:
            return jsonify({
                "message": "Receta no encontrada"
            }), 404
    except Exception as e:
        print("Error al obtener receta:", e)
        return jsonify({
            "message": "Error al obtener la receta"
        }), 500