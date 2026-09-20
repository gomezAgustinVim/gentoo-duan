---@diagnostic disable: undefined-global

return {

	s(
		{ trig = "ctmp", snippetType = "autosnippet" },
		fmta(
			[[

drop temporary table if exists <>;
create temporary table <>

drop temporary table <>;
    ]],
			{ i(1), rep(1), rep(1) }
		)
	),

	s(
		{ trig = "crpro", snippetType = "autosnippet" },
		fmta(
			[[

DELIMITER $$
DROP PROCEDURE IF EXISTS <> $$
CREATE PROCEDURE <> (<>)
READS SQL DATA -- o modifies SQL DATA
BEGIN

<>

END $$
DELIMITER ;

    ]],
			{ i(1), rep(1), i(2), i(3) }
		)
	),

	s(
		{ trig = "crfun", snippetType = "autosnippet" },
		fmta(
			[[

DELIMITER $$
DROP FUNCTION IF EXISTS <> $$
CREATE FUNCTION <> (<>)
RETURNS <>
DETERMINISTIC -- si es deterministic, no se puede usar insert, update, delete
BEGIN
    DECLARE <>

<>

RETURN <>

END $$
DELIMITER ;

    ]],
			{ i(1), rep(1), i(2), i(3), i(4), i(5), i(6) }
		)
	),

	-- ejmplo de trigger
	-- DELIMITER $$
	-- DROP TRIGGER IF EXISTS `inmobiliaria_calciferhowl`.`garantia_BEFORE_INSERT`$$
	-- CREATE DEFINER = CURRENT_USER TRIGGER
	-- `inmobiliaria_calciferhowl`.`garantia_BEFORE_INSERT`
	-- BEFORE UPDATE ON `garantia` FOR EACH ROW
	-- BEGIN
	-- 	insert into garantia_audit (id_tipo_garantia, id_garante
	-- 			, id_solicitud, fecha_alta, fecha_baja
	--             , estado, user)
	-- 	values (new.id_tipo_garantia, new.id_garante
	-- 			,new.id_solicitud, new.fecha_alta, new.fecha_baja
	--             , new.estado, current_user);
	-- END$$
	-- DELIMITER ;

	-- current_user me apuesto a que normalmente será root@localhost
	-- create definer no se si es necesario 100% de las veces

	s(
		{ trig = "trigbefore", snippetType = "autosnippet" },
		fmta(
			[[

DELIMITER $$
DROP TRIGGER IF EXISTS <> $$
CREATE TRIGGER <>
BEFORE <> ON <>
FOR EACH ROW
BEGIN
<>

END $$
DELIMITER ;

    ]],
			{ i(1), rep(1), i(2), i(3), i(4) }
		)
	),

	s(
		{ trig = "trigafter", snippetType = "autosnippet" },
		fmta(
			[[

DELIMITER $$
DROP TRIGGER IF EXISTS <> $$
CREATE TRIGGER <>
AFTER <> ON <>
FOR EACH ROW
BEGIN
<>

END $$
DELIMITER ;

    ]],
			{ i(1), rep(1), i(2), i(3), i(4) }
		)
	),
}
