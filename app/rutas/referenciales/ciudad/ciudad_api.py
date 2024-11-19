from flask import Blueprint, request, jsonify, current_app as app
from app.dao.referenciales.ciudad.CiudadDao import CiudadDao

ciuapi = Blueprint('ciuapi', __name__)

# Trae todas las ciudades
@ciuapi.route('/ciudades', methods=['GET'])
def getCiudades():
    ciudao = CiudadDao()
    try:
        ciudades = ciudao.getCiudades()
        return jsonify({
            'success': True,
            'data': ciudades,
            'error': None
        }), 200
    except Exception as e:
        app.logger.error(f"Error al obtener todas las ciudades: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Ocurrió un error interno. Consulte con el administrador.'
        }), 500

# Obtiene una ciudad por ID
@ciuapi.route('/ciudades/<int:id_ciudad>', methods=['GET'])
def getCiudad(id_ciudad):
    ciudao = CiudadDao()
    try:
        ciudad = ciudao.getCiudadById(id_ciudad)
        if ciudad:
            return jsonify({
                'success': True,
                'data': ciudad,
                'error': None
            }), 200
        else:
            return jsonify({
                'success': False,
                'error': 'No se encontró la ciudad con el ID proporcionado.'
            }), 404
    except Exception as e:
        app.logger.error(f"Error al obtener ciudad: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Ocurrió un error interno. Consulte con el administrador.'
        }), 500

# Agrega una nueva ciudad
@ciuapi.route('/ciudades', methods=['POST'])
def addCiudad():
    data = request.get_json()
    ciudao = CiudadDao()
    campos_requeridos = ['descripcion']

    # Validación de campos requeridos
    for campo in campos_requeridos:
        if campo not in data or not data[campo].strip():
            return jsonify({
                'success': False,
                'error': f'El campo {campo} es obligatorio y no puede estar vacío.'
            }), 400

    try:
        descripcion = data['descripcion'].strip().upper()
        id_ciudad = ciudao.guardarCiudad(descripcion)
        if id_ciudad:
            return jsonify({
                'success': True,
                'data': {'id_ciudad': id_ciudad, 'descripcion': descripcion},
                'error': None
            }), 201
        else:
            return jsonify({
                'success': False,
                'error': 'No se pudo guardar la ciudad. Consulte con el administrador.'
            }), 500
    except Exception as e:
        app.logger.error(f"Error al agregar ciudad: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Ocurrió un error interno. Consulte con el administrador.'
        }), 500

# Actualiza una ciudad
@ciuapi.route('/ciudades/<int:id_ciudad>', methods=['PUT'])
def updateCiudad(id_ciudad):
    data = request.get_json()
    ciudao = CiudadDao()
    campos_requeridos = ['descripcion']

    # Validación de campos requeridos
    for campo in campos_requeridos:
        if campo not in data or not data[campo].strip():
            return jsonify({
                'success': False,
                'error': f'El campo {campo} es obligatorio y no puede estar vacío.'
            }), 400

    try:
        descripcion = data['descripcion'].strip().upper()
        if ciudao.updateCiudad(id_ciudad, descripcion):
            return jsonify({
                'success': True,
                'data': {'id_ciudad': id_ciudad, 'descripcion': descripcion},
                'error': None
            }), 200
        else:
            return jsonify({
                'success': False,
                'error': 'No se encontró la ciudad con el ID proporcionado o no se pudo actualizar.'
            }), 404
    except Exception as e:
        app.logger.error(f"Error al actualizar ciudad: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Ocurrió un error interno. Consulte con el administrador.'
        }), 500

# Elimina una ciudad
@ciuapi.route('/ciudades/<int:id_ciudad>', methods=['DELETE'])
def deleteCiudad(id_ciudad):
    ciudao = CiudadDao()
    try:
        if ciudao.deleteCiudad(id_ciudad):
            return jsonify({
                'success': True,
                'mensaje': f'Ciudad con ID {id_ciudad} eliminada correctamente.',
                'error': None
            }), 200
        else:
            return jsonify({
                'success': False,
                'error': 'No se encontró la ciudad con el ID proporcionado o no se pudo eliminar.'
            }), 404
    except Exception as e:
        app.logger.error(f"Error al eliminar ciudad: {str(e)}")
        return jsonify({
            'success': False,
            'error': 'Ocurrió un error interno. Consulte con el administrador.'
        }), 500
