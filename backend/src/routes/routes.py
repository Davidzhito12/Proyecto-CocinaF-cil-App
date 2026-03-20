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