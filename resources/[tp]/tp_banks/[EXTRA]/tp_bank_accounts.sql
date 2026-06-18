
CREATE TABLE IF NOT EXISTS `tp_bank_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `iban` varchar(50) NOT NULL,
  `identifier` varchar(50) NOT NULL,
  `charidentifier` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `accounts` longtext DEFAULT '{"cash":0, "gold":0}',
  `is_joint` int(11) DEFAULT 0,
  `joint_members` longtext DEFAULT '[]',
  `transactions` longtext DEFAULT '[]',
  `billing` longtext DEFAULT '[]',
  `tax_duration` int(11) DEFAULT 0,
  `job_name` varchar(50) DEFAULT 'n/a',
  `job_salary_duration` int(11) DEFAULT 0,
  `container` int(11) DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin ROW_FORMAT=DYNAMIC;
