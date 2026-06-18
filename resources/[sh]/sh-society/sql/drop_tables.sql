SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `sh_society_audit`;
DROP TABLE IF EXISTS `sh_society_adverts`;
DROP TABLE IF EXISTS `sh_society_stores`;
DROP TABLE IF EXISTS `sh_society_blips`;
DROP TABLE IF EXISTS `sh_society_invoices`;
DROP TABLE IF EXISTS `sh_society_ledger_tx`;
DROP TABLE IF EXISTS `sh_society_ledger`;
DROP TABLE IF EXISTS `sh_society_employees`;
DROP TABLE IF EXISTS `sh_society_rank_permissions`;
DROP TABLE IF EXISTS `sh_society_ranks`;
DROP TABLE IF EXISTS `sh_society_societies`;

-- legacy schema table from older sh-society variants
DROP TABLE IF EXISTS `sh_society_businesses`;

SET FOREIGN_KEY_CHECKS = 1;
