-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema bp_renegociacao
-- -----------------------------------------------------
-- Concebido inicialmente como sistema de registro de negociações da equipe 
-- de renegociação vacation.
DROP SCHEMA IF EXISTS `bp_renegociacao` ;

-- -----------------------------------------------------
-- Schema bp_renegociacao
--
-- Concebido inicialmente como sistema de registro de negociações da equipe 
-- de renegociação vacation.
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bp_renegociacao` ;
USE `bp_renegociacao` ;

-- -----------------------------------------------------
-- Table `bp_renegociacao`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`usuario` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ativo` TINYINT(1) NULL DEFAULT 1,
  `primeiro_nome` VARCHAR(45) NULL,
  `nome` VARCHAR(255) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `ts_usuario_id` INT NOT NULL,
  `matricula` VARCHAR(22) NULL,
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`origem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`origem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`tipo_solicitacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`tipo_solicitacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`situacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`situacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`ocorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`ocorrencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `numero_ocorrencia` BIGINT(20) NULL,
  `idvendats` BIGINT(20) NULL,
  `idvendaxcontrato` BIGINT(20) NULL,
  `status` CHAR(1) NULL,
  `idmotivots` INT NULL,
  `dtocorrencia` DATETIME NULL,
  `idpessoa_cliente` BIGINT(20) NULL,
  `nome_cliente` VARCHAR(100) NULL,
  `numeroprojeto` INT NULL,
  `numerocontrato` BIGINT(20) NULL,
  `idprojetots` INT(11) NULL,
  `valor_venda` DECIMAL(10,2) NULL,
  `idusuario_resp` INT NULL COMMENT 'CM.USUARIOSISTEMA',
  `nomeusuario_resp` VARCHAR(45) NULL,
  `idusuario_cadastro` INT NULL,
  `nomeusuario_cadastro` VARCHAR(45) NULL,
  `atendida` TINYINT(1) NULL DEFAULT 0,
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`cliente` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NULL,
  `ts_cliente_id` BIGINT(20) NULL COMMENT 'REFERENCES IDPESSOA ON TS',
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`origem_contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`origem_contrato` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`projeto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`projeto` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idprojetots` INT(11) NULL,
  `idagenciats` INT(11) NULL,
  `nomeprojeto` VARCHAR(100) NULL,
  `numeroprojeto` INT(11) NULL,
  `proxnumcontrato` BIGINT(20) NULL,
  `trgdtinclusao` DATE NULL,
  `trguserinclusao` VARCHAR(30) NULL,
  `flgativo` CHAR(1) NULL,
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`contrato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`contrato` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `cliente_id` INT(11) NOT NULL,
  `projeto_id` INT(11) NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `data_venda` DATE NOT NULL,
  `valor_venda` DECIMAL(10,2) NULL,
  `validade` INT NULL,
  `pontos` VARCHAR(10) NULL,
  `revertido` TINYINT(1) NULL DEFAULT 0,
  `cancelado` TINYINT(1) NULL DEFAULT 0,
  `ts_idvendats` BIGINT(20) NULL,
  `ts_idvendaxcontrato` BIGINT(20) NULL,
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  `origem_contrato_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_contrato_cliente1_idx` (`cliente_id` ASC) ,
  INDEX `fk_contrato_origem_contrato1_idx` (`origem_contrato_id` ASC) ,
  INDEX `fk_contrato_projeto1_idx` (`projeto_id` ASC) ,
  CONSTRAINT `fk_contrato_cliente1`
    FOREIGN KEY (`cliente_id`)
    REFERENCES `bp_renegociacao`.`cliente` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_origem_contrato1`
    FOREIGN KEY (`origem_contrato_id`)
    REFERENCES `bp_renegociacao`.`origem_contrato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_contrato_projeto1`
    FOREIGN KEY (`projeto_id`)
    REFERENCES `bp_renegociacao`.`projeto` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`negociacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`negociacao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `usuario_id` INT NULL,
  `origem_id` INT NULL,
  `tipo_solicitacao_id` INT NULL,
  `situacao_id` INT NULL,
  `ocorrencia_id` INT NULL,
  `contrato_id` INT NULL,
  `data_finalizacao` DATE NULL,
  `observacao` LONGTEXT NULL,
  `motivo_cancelamento_ocorrencia_id` INT NULL,
  `multa` DECIMAL(10,2) NULL DEFAULT 0,
  `reembolso` DECIMAL(10,2) NULL DEFAULT 0,
  `numero_pc` VARCHAR(10) NULL,
  `taxas_extras` DECIMAL(10,2) NULL DEFAULT 0,
  `valor_primeira_parcela` DECIMAL(10,2) NULL DEFAULT 0,
  `finalizada` TINYINT(1) NULL DEFAULT 0,
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  INDEX `fk_caixa_renegociacao_usuario_idx` (`usuario_id` ASC) ,
  INDEX `fk_caixa_renegociacao_origem1_idx` (`origem_id` ASC) ,
  INDEX `fk_caixa_renegociacao_tipo_solicitacao1_idx` (`tipo_solicitacao_id` ASC) ,
  INDEX `fk_caixa_renegociacao_situacao1_idx` (`situacao_id` ASC) ,
  INDEX `fk_negociacao_ocorrencia1_idx` (`ocorrencia_id` ASC) ,
  INDEX `fk_negociacao_contrato1_idx` (`contrato_id` ASC) ,
  CONSTRAINT `fk_caixa_renegociacao_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `bp_renegociacao`.`usuario` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caixa_renegociacao_origem1`
    FOREIGN KEY (`origem_id`)
    REFERENCES `bp_renegociacao`.`origem` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caixa_renegociacao_tipo_solicitacao1`
    FOREIGN KEY (`tipo_solicitacao_id`)
    REFERENCES `bp_renegociacao`.`tipo_solicitacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_caixa_renegociacao_situacao1`
    FOREIGN KEY (`situacao_id`)
    REFERENCES `bp_renegociacao`.`situacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negociacao_ocorrencia1`
    FOREIGN KEY (`ocorrencia_id`)
    REFERENCES `bp_renegociacao`.`ocorrencia` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_negociacao_contrato1`
    FOREIGN KEY (`contrato_id`)
    REFERENCES `bp_renegociacao`.`contrato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'equi. caixa_renegociacao';


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`motivo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`motivo` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idmotivots` INT NULL,
  `codreduzido` VARCHAR(3) NULL,
  `descricao` VARCHAR(100) NULL,
  `aplicacao` CHAR(1) NULL,
  `flgativo` CHAR(1) NULL,
  `trgdtinclusao` DATETIME NULL,
  `created_at` TIMESTAMP(2) NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP(2) NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`retencao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`retencao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `negociacao_id` INT NOT NULL,
  `contrato_id` INT NULL,
  `data` DATETIME NULL,
  `valor_antigo` DECIMAL(10,2) NULL,
  `valor_novo` DECIMAL(10,2) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_retencao_negociacao1_idx` (`negociacao_id` ASC) ,
  INDEX `fk_retencao_contrato1_idx` (`contrato_id` ASC),
  CONSTRAINT `fk_retencao_negociacao1`
    FOREIGN KEY (`negociacao_id`)
    REFERENCES `bp_renegociacao`.`negociacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_retencao_contrato1`
    FOREIGN KEY (`contrato_id`)
    REFERENCES `bp_renegociacao`.`contrato` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`reversao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`reversao` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `negociacao_id` INT NOT NULL,
  `data` DATETIME NULL,
  `novocontrato_id` INT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_reversao_negociacao1_idx` (`negociacao_id` ASC) ,
  CONSTRAINT `fk_reversao_negociacao1`
    FOREIGN KEY (`negociacao_id`)
    REFERENCES `bp_renegociacao`.`negociacao` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bp_renegociacao`.`ts_lancamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bp_renegociacao`.`ts_lancamentos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `idvendats` BIGINT(20) NULL,
  `idvendaxcontrato` BIGINT(20) NULL,
  `idlancamentots` BIGINT(20) NULL,
  `coddocumento` BIGINT(20) NULL,
  `vlroriginal` DECIMAL NULL,
  `descricao` VARCHAR(45) NULL,
  `saldocar` DECIMAL NULL,
  `valorpagocar` DECIMAL NULL,
  `statuscar` VARCHAR(45) NULL,
  `dataprogramada` DATE NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;