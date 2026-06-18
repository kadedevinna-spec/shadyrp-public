-- Matriz de permissões por cargo Discord (MX-Admin / rsg-adminmenu)
-- Com PermissionMatrixStrictDefault = true (padrão): sem linhas = tudo negado na prática;
-- só allowed=1 concede ação. O Founder ignora a matriz para poder configurar.
-- A tabela é criada automaticamente ao iniciar o recurso (permission_matrix.lua).

CREATE TABLE IF NOT EXISTS `mx_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `role_key` varchar(32) NOT NULL,
  `command_key` varchar(64) NOT NULL,
  `allowed` tinyint(1) NOT NULL DEFAULT 0,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_role_cmd` (`role_key`,`command_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
