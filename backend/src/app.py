from flask import Flask
from flask_cors import CORS
from dotenv import load_dotenv
import os

load_dotenv()

def create_app():
    app = Flask(__name__)
    
    #Configuración básica de la aplicación
    app.config["SECRET_KEY"] = os.getenv("SECRET_KEY")

    #Habilitar CORS para permitir solicitudes desde el frontend
    CORS(app)

    #Importar y registrar los blueprints de las rutas
    from routes.routes import main_routes
    app.register_blueprint(main_routes, url_prefix="/api")

    return app

app = create_app()
if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)