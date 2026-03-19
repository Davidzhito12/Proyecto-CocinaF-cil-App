from flask import Blueprint, jsonify
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