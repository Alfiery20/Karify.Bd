INSERT INTO Rol(Nombre) VALUES ('Administrador'), ('Profesor'), ('Alumno')

INSERT INTO RUTA(Menu, Ruta) VALUES ('Gestion Permisos', 'gestionpermisos'), ('Revisión de Proyectos', 'revisionproyectos'), 
							('Gestion de Proyectos', 'gestionproyectos'), ('Configuración', 'configuracion')

INSERT INTO ROLXRUTA(IdRol, IdRuta) 
	VALUES (1, 1), (1, 2), (1, 3), (1, 4),
			(2, 2), (2, 4), 
			(3, 3), (3, 4)

INSERT INTO FACULTAD(Nombre) 
		VALUES ('Facultad de Agronomía'),
				('Facultad de Ciencias Biológicas'),
				('Facultad de Ciencias Económicas Administrativas y Contables'),
				('Facultad de Ciencias Físicas y Matemáticas'),
				('Facultad de Ciencias Histórico Sociales y Educación'),
				('Facultad de Derecho y Ciencia Politica'),
				('Facultad de Enfermería'),
				('Facultad de Ingeniería Agricola'),
				('Facultad de Ingeniería Mecánica y Eléctrica'),
				('Facultad de Ingeniería Zootecnica'),
				('Facultad de Medicina Humana'), 
				('Facultad de Medicina Veterinaria'),
				('Facultad de Ingeniería Civil, de Sistemas y Arquitectura'),
				('Facultad de Ingeniería Química e Industrias Alimentaria')

INSERT INTO ESCUELA(Nombre, CorreoAtencion, IdFacultad) 
		VALUES ('Agronomía', 'mramosg@unprg.edu.pe', 1),
				('Ciencias Biológicas', 'escuela_biologia@unprg.edu.pe', 2),
				('Administración', 'mesadepartes_faceac@unprg.edu.pe', 3), 
					('Comercio y Negocios Internacionales', 'mesadepartes_faceac@unprg.edu.pe', 3),
					('Contabilidad', 'mesadepartes_faceac@unprg.edu.pe', 3),
					('Economía', 'mesadepartes_faceac@unprg.edu.pe', 3),
				('Estadística', 'mesadepartes_facfym@unprg.edu.pe', 4),
					('Física', 'mesadepartes_facfym@unprg.edu.pe', 4),
					('Ingeniería en Computación e Informática', 'mesadepartes_facfym@unprg.edu.pe', 4),
					('Ingeniería Electrónica', 'mesadepartes_facfym@unprg.edu.pe', 4),
					('Matemáticas', 'mesadepartes_facfym@unprg.edu.pe', 4),
				('Arqueología', 'mesadepartes_fachse@unprg.edu.pe', 5),
					('Arte', 'mesadepartes_fachse@unprg.edu.pe', 5),
					('Ciencias de la Comunicación', 'mesadepartes_fachse@unprg.edu.pe', 5),
					('Educación', 'mesadepartes_fachse@unprg.edu.pe', 5),
					('Psicología', 'mesadepartes_fachse@unprg.edu.pe', 5),
					('Sociología', 'mesadepartes_fachse@unprg.edu.pe', 5),
				('Ciencia Política', 'mesadepartes_fdcp@unprg.edu.pe', 6),
					('Derecho', 'mesadepartes_fdcp@unprg.edu.pe', 6),
				('Enfermería', 'escuela_enfermeria@unprg.edu.pe', 7),
				('Ingeniería Agrícola', 'mesadepartes_fia@unprg.edu.pe', 8),
				('Ingeniería Mecánica y Eléctrica', 'mesadepartes_fime@unprg.edu.pe', 9),
				('Ingeniería Zootecnia', 'mesadepartes_fiz@unprg.edu.pe', 10),
				('Medicina Humana', 'mmesadepartes_fmh@unprg.edu.pe', 11),
				('Medicina Veterinaria', 'mesadepartes_fmv@unprg.edu.pe', 12),
				('Arquitectura', 'mesadepartes_ficsa@unprg.edu.pe', 13),
					('Ingeniería Civil', 'mesadepartes_ficsa@unprg.edu.pe', 13),	
					('Ingeniería de Sistemas', 'mesadepartes_ficsa@unprg.edu.pe', 13),	
				('Ingeniería de Industrias Alimentarias', 'mesadepartes_fiqia@unprg.edu.pe', 14),
					('Ingeniería Química', 'mesadepartes_fiqia@unprg.edu.pe', 14)
