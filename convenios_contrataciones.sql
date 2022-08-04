-- GENERA LA FRECUENCIA (USO) DE COBERTURAS INDICANDO EL PSS
SELECT
    DIM_COBERTURA.COD_COBERTURA,
    DIM_COBERTURA.DESC_COBERTURA,
    DIM_COBERTURA.COD_TIPO_COBERTURA,
    DIM_COBERTURA.DESC_TIPO_COBERTURA,
    DIM_TIPO_SERVICIO_SALUD.DESC_TIPO_SERVICIO_SALUD,
    HECHO_RECLAMACIONES.INTEGRALIDAD,
    HECHO_RECLAMACIONES.FRECUENCIA,
    FECHA_APERTURA,
    DIM_PLANES.DESC_TIPO_PLAN,
    DIM_RECLAMANTE.COD_RECLAMANTE,
    DIM_RECLAMANTE.DESC_RECLAMANTE,
    HECHO_RECLAMACIONES.MONTO_RECLAMADO,
    HECHO_RECLAMACIONES.MONTO_PAGADO
FROM DIM_COBERTURA
    INNER JOIN HECHO_RECLAMACIONES
        ON DIM_COBERTURA.ID_COBERTURA = HECHO_RECLAMACIONES.ID_COBERTURA
    INNER JOIN DIM_RECLAMANTE 
        ON HECHO_RECLAMACIONES.ID_RECLAMANTE = DIM_RECLAMANTE.ID_RECLAMANTE
    INNER JOIN DIM_ESTATUS
        ON HECHO_RECLAMACIONES.ID_ESTATUS = DIM_ESTATUS.ID_ESTATUS
    INNER JOIN DIM_PLANES
        ON HECHO_RECLAMACIONES.ID_PLAN = DIM_PLANES.ID_PLAN
    INNER JOIN DIM_TIPO_SERVICIO_SALUD
        ON HECHO_RECLAMACIONES.ID_TIPO_SERVICIO_SALUD = DIM_TIPO_SERVICIO_SALUD.ID_TIPO_SERVICIO_SALUD
    WHERE (DIM_COBERTURA.COD_TIPO_COBERTURA IN ('1','210','215') OR DIM_TIPO_SERVICIO_SALUD.COD_TIPO_SERVICIO_SALUD = '77' 
        AND HECHO_RECLAMACIONES.FECHA_APERTURA BETWEEN '8-1-2021' AND '07-31-2022'
        AND DIM_RECLAMANTE.COD_RECLAMANTE = '245657477'
        AND DIM_ESTATUS.COD_ESTATUS NOT IN ('52','213'));


-- GENERA LA FRECUENCIA (USO) DE COBERTURAS INDICANDO EL PSS
SELECT
    DIM_COBERTURA.COD_COBERTURA,
    DIM_COBERTURA.COD_TIPO_COBERTURA,
    DIM_COBERTURA.DESC_COBERTURA,
    HECHO_RECLAMACIONES.INTEGRALIDAD,
    HECHO_RECLAMACIONES.FRECUENCIA,
    FECHA_APERTURA,
    DIM_PLANES.DESC_TIPO_PLAN,
    DIM_RECLAMANTE.COD_RECLAMANTE,
    DIM_RECLAMANTE.DESC_RECLAMANTE,
    HECHO_RECLAMACIONES.MONTO_RECLAMADO,
    HECHO_RECLAMACIONES.MONTO_PAGADO
FROM DIM_COBERTURA
    INNER JOIN HECHO_RECLAMACIONES
        ON DIM_COBERTURA.ID_COBERTURA = HECHO_RECLAMACIONES.ID_COBERTURA
    INNER JOIN DIM_RECLAMANTE 
        ON HECHO_RECLAMACIONES.ID_RECLAMANTE = DIM_RECLAMANTE.ID_RECLAMANTE
    INNER JOIN DIM_ESTATUS
        ON HECHO_RECLAMACIONES.ID_ESTATUS = DIM_ESTATUS.ID_ESTATUS
    INNER JOIN DIM_PLANES
        ON HECHO_RECLAMACIONES.ID_PLAN = DIM_PLANES.ID_PLAN
    WHERE HECHO_RECLAMACIONES.FECHA_APERTURA BETWEEN '1-1-2021' AND '12-31-2021'
        -- AND DIM_COBERTURA.COD_AGRUPADOR_PRIMARIO NOT IN ('N1','34','48','-2','N2','-2','N3','41','49','42') AGRUPADORES DE MEDICAMENTOS, MATERIALES, ETC
        AND DIM_ESTATUS.COD_ESTATUS NOT IN ('52','213')
        AND HECHO_RECLAMACIONES.MONTO_PAGADO > 0
        AND DIM_COBERTURA.COD_COBERTURA = '881401'
        AND DIM_RECLAMANTE.COD_RECLAMANTE = '1689137';

-- FRECUENCIA DE USO DE COBERTURAS EN RESUMEN
SELECT
    DIM_COBERTURA.COD_COBERTURA,
    DIM_COBERTURA.DESC_COBERTURA,
    SUM(HECHO_RECLAMACIONES.FRECUENCIA) AS 'TOTAL FRECUENCIA'
FROM DIM_COBERTURA
    INNER JOIN HECHO_RECLAMACIONES
        ON DIM_COBERTURA.ID_COBERTURA = HECHO_RECLAMACIONES.ID_COBERTURA
    INNER JOIN DIM_RECLAMANTE 
        ON HECHO_RECLAMACIONES.ID_RECLAMANTE = DIM_RECLAMANTE.ID_RECLAMANTE
    INNER JOIN DIM_ESTATUS
        ON HECHO_RECLAMACIONES.ID_ESTATUS = DIM_ESTATUS.ID_ESTATUS
    INNER JOIN DIM_PLANES
        ON HECHO_RECLAMACIONES.ID_PLAN = DIM_PLANES.ID_PLAN
    WHERE HECHO_RECLAMACIONES.FECHA_APERTURA BETWEEN '1-1-2021' AND '12-31-2021'
        -- AND DIM_COBERTURA.COD_AGRUPADOR_PRIMARIO NOT IN ('N1','34','48','-2','N2','-2','N3','41','49','42') AGRUPADORES DE MEDICAMENTOS, MATERIALES, ETC
        AND DIM_ESTATUS.COD_ESTATUS NOT IN ('52','213')
        AND HECHO_RECLAMACIONES.MONTO_PAGADO > 0
        AND DIM_COBERTURA.COD_COBERTURA IN ('997898', '997648')
        AND DIM_RECLAMANTE.COD_RECLAMANTE = '1480'        
GROUP BY 
    DIM_COBERTURA.COD_COBERTURA,
    DIM_COBERTURA.DESC_COBERTURA
ORDER BY [TOTAL FRECUENCIA] DESC;

-- FRECUENCIA DE USO DE COBERTURAS PARA REEMBOLSO
SELECT
    DIM_COBERTURA.COD_COBERTURA,
    DIM_COBERTURA.DESC_COBERTURA,
    DIM_COBERTURA.DESC_AGRUPADOR_PRIMARIO,
    HECHO_RECLAMACIONES.INTEGRALIDAD,
    HECHO_RECLAMACIONES.FRECUENCIA,
    FECHA_APERTURA,
    ANIO,
    MONTH(FECHA_APERTURA) AS 'MONTH',
    DIM_PLANES.DESC_TIPO_PLAN,
    DIM_RECLAMANTE.COD_RECLAMANTE,
    DIM_RECLAMANTE.DESC_RECLAMANTE,
    HECHO_RECLAMACIONES.MONTO_RECLAMADO,
    HECHO_RECLAMACIONES.MONTO_PAGADO,
    DIM_ESTATUS.DESC_ESTATUS
FROM DIM_COBERTURA
    INNER JOIN HECHO_RECLAMACIONES
        ON DIM_COBERTURA.ID_COBERTURA = HECHO_RECLAMACIONES.ID_COBERTURA
    INNER JOIN DIM_RECLAMANTE 
        ON HECHO_RECLAMACIONES.ID_RECLAMANTE = DIM_RECLAMANTE.ID_RECLAMANTE
    INNER JOIN DIM_ESTATUS
        ON HECHO_RECLAMACIONES.ID_ESTATUS = DIM_ESTATUS.ID_ESTATUS
    INNER JOIN DIM_PLANES
        ON HECHO_RECLAMACIONES.ID_PLAN = DIM_PLANES.ID_PLAN
    INNER JOIN DIM_TIPO_RECLAMO
        ON DIM_TIPO_RECLAMO.ID_TIPO_RECLAMO = HECHO_RECLAMACIONES.ID_TIPO_RECLAMO
    WHERE HECHO_RECLAMACIONES.FECHA_APERTURA >= '1-1-2020'
        AND DIM_TIPO_RECLAMO.COD_TIPO_RECLAMO = 'R'
        AND DIM_COBERTURA.COD_AGRUPADOR_PRIMARIO NOT IN ('N1','34','48','-2','N2','-2','N3','41','49','42')
        AND DIM_ESTATUS.COD_ESTATUS NOT IN ('52','213')
        AND HECHO_RECLAMACIONES.MONTO_PAGADO > 0;
