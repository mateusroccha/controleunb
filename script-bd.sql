SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `controleunb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `controleunb` ;

-- -----------------------------------------------------
-- Table `controleunb`.`Login`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Login` (
  `id_login` INT NOT NULL AUTO_INCREMENT ,
  `usuario_login` VARCHAR(45) NOT NULL ,
  `senha_login` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_login`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Pessoa`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Pessoa` (
  `matricula_pessoa` INT NOT NULL AUTO_INCREMENT ,
  `foto_pessoa` BLOB NULL ,
  `nome_pessoa` VARCHAR(45) NOT NULL ,
  `endereco_pessoa` VARCHAR(45) NOT NULL ,
  `id_login` INT NOT NULL ,
  PRIMARY KEY (`matricula_pessoa`, `id_login`) ,
  INDEX `fk_Pessoa_Login_idx` (`id_login` ASC) ,
  CONSTRAINT `fk_Pessoa_Login`
    FOREIGN KEY (`id_login` )
    REFERENCES `controleunb`.`Login` (`id_login` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Estudante`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Estudante` (
  `ano_ingresso_estudante` DATE NOT NULL ,
  `matricula_pessoa` INT NOT NULL ,
  INDEX `fk_Estudante_Pessoa1_idx` (`matricula_pessoa` ASC) ,
  PRIMARY KEY (`matricula_pessoa`) ,
  CONSTRAINT `fk_Estudante_Pessoa1`
    FOREIGN KEY (`matricula_pessoa` )
    REFERENCES `controleunb`.`Pessoa` (`matricula_pessoa` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Professor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Professor` (
  `cpf_professor` VARCHAR(45) NOT NULL ,
  `matricula_pessoa` INT NOT NULL ,
  INDEX `fk_Professor_Pessoa1_idx` (`matricula_pessoa` ASC) ,
  PRIMARY KEY (`matricula_pessoa`) ,
  CONSTRAINT `fk_Professor_Pessoa1`
    FOREIGN KEY (`matricula_pessoa` )
    REFERENCES `controleunb`.`Pessoa` (`matricula_pessoa` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Servidor`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Servidor` (
  `cargo_servidor` VARCHAR(45) NOT NULL ,
  `matricula_pessoa` INT NOT NULL ,
  INDEX `fk_Servidor_Pessoa1_idx` (`matricula_pessoa` ASC) ,
  PRIMARY KEY (`matricula_pessoa`) ,
  CONSTRAINT `fk_Servidor_Pessoa1`
    FOREIGN KEY (`matricula_pessoa` )
    REFERENCES `controleunb`.`Pessoa` (`matricula_pessoa` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Funcionario`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Funcionario` (
  `data_contrato_funcionario` DATE NOT NULL ,
  `matricula_pessoa` INT NOT NULL ,
  INDEX `fk_Funcionario_Pessoa1_idx` (`matricula_pessoa` ASC) ,
  PRIMARY KEY (`matricula_pessoa`) ,
  CONSTRAINT `fk_Funcionario_Pessoa1`
    FOREIGN KEY (`matricula_pessoa` )
    REFERENCES `controleunb`.`Pessoa` (`matricula_pessoa` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Tipo`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Tipo` (
  `id_tipo` INT NOT NULL AUTO_INCREMENT ,
  `nome_tipo` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_tipo`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Gravidade`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Gravidade` (
  `id_gravidade` INT NOT NULL AUTO_INCREMENT ,
  `nome_gravidade` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_gravidade`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Local`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Local` (
  `id_local` INT NOT NULL AUTO_INCREMENT ,
  `nome_local` VARCHAR(45) NOT NULL ,
  `sigla_local` VARCHAR(45) NOT NULL ,
  PRIMARY KEY (`id_local`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Denuncia`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Denuncia` (
  `id_denuncia` INT NOT NULL AUTO_INCREMENT ,
  `descricao_denuncia` VARCHAR(100) NULL ,
  `id_tipo` INT NOT NULL ,
  `id_gravidade` INT NOT NULL ,
  `id_local` INT NOT NULL ,
  `id_pessoa` INT NOT NULL ,
  PRIMARY KEY (`id_denuncia`, `id_tipo`, `id_gravidade`, `id_local`, `id_pessoa`) ,
  INDEX `fk_Denuncia_Tipo1_idx` (`id_tipo` ASC) ,
  INDEX `fk_Denuncia_Gravidade1_idx` (`id_gravidade` ASC) ,
  INDEX `fk_Denuncia_Local1_idx` (`id_local` ASC) ,
  INDEX `fk_Denuncia_Pessoa1_idx` (`id_pessoa` ASC) ,
  CONSTRAINT `fk_Denuncia_Tipo1`
    FOREIGN KEY (`id_tipo` )
    REFERENCES `controleunb`.`Tipo` (`id_tipo` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Denuncia_Gravidade1`
    FOREIGN KEY (`id_gravidade` )
    REFERENCES `controleunb`.`Gravidade` (`id_gravidade` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Denuncia_Local1`
    FOREIGN KEY (`id_local` )
    REFERENCES `controleunb`.`Local` (`id_local` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Denuncia_Pessoa1`
    FOREIGN KEY (`id_pessoa` )
    REFERENCES `controleunb`.`Pessoa` (`matricula_pessoa` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `controleunb`.`Ordem_Servico`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `controleunb`.`Ordem_Servico` (
  `data_inicial` DATE NOT NULL ,
  `data_final` DATE NULL ,
  `id_denuncia` INT NOT NULL ,
  `matricula_pessoa` INT NOT NULL ,
  INDEX `fk_Ordem_Servico_Denuncia1_idx` (`id_denuncia` ASC) ,
  INDEX `fk_Ordem_Servico_Funcionario1_idx` (`matricula_pessoa` ASC) ,
  PRIMARY KEY (`matricula_pessoa`, `id_denuncia`) ,
  CONSTRAINT `fk_Ordem_Servico_Denuncia1`
    FOREIGN KEY (`id_denuncia` )
    REFERENCES `controleunb`.`Denuncia` (`id_denuncia` )
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ordem_Servico_Funcionario1`
    FOREIGN KEY (`matricula_pessoa` )
    REFERENCES `controleunb`.`Funcionario` (`matricula_pessoa` )
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `controleunb` ;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `controleunb`.`gravidade` (`nome_gravidade`) VALUES ('baixa leve');
INSERT INTO `controleunb`.`gravidade` (`nome_gravidade`) VALUES ('baixa');
INSERT INTO `controleunb`.`gravidade` (`nome_gravidade`) VALUES ('media');
INSERT INTO `controleunb`.`gravidade` (`nome_gravidade`) VALUES ('semi alta');
INSERT INTO `controleunb`.`gravidade` (`nome_gravidade`) VALUES ('alta');

INSERT INTO `controleunb`.`tipo` (`nome_tipo`) VALUES ('vaso sanitario');
INSERT INTO `controleunb`.`tipo` (`nome_tipo`) VALUES ('torneira');
INSERT INTO `controleunb`.`tipo` (`nome_tipo`) VALUES ('bebedouro');
INSERT INTO `controleunb`.`tipo` (`nome_tipo`) VALUES ('pia');
INSERT INTO `controleunb`.`tipo` (`nome_tipo`) VALUES ('porta');

INSERT INTO `controleunb`.`local` (`nome_local`, `sigla_local`) VALUES ('Pavilhao Joao Calmon', 'PJC');
INSERT INTO `controleunb`.`local` (`nome_local`, `sigla_local`) VALUES ('Pavilhao Anisio Teixeira', 'PAT');
INSERT INTO `controleunb`.`local` (`nome_local`, `sigla_local`) VALUES ('Faculdade de Educacao', 'FE');
INSERT INTO `controleunb`.`local` (`nome_local`, `sigla_local`) VALUES ('Instituto Central Ciencias', 'ICC');
INSERT INTO `controleunb`.`local` (`nome_local`, `sigla_local`) VALUES ('Bloco de Sala de Aula Norte', 'BSA');

INSERT INTO `controleunb`.`login` (`usuario_login`, `senha_login`) VALUES ('bruno', '123');
INSERT INTO `controleunb`.`login` (`usuario_login`, `senha_login`) VALUES ('mateus', '123456');
INSERT INTO `controleunb`.`login` (`usuario_login`, `senha_login`) VALUES ('marcos', '123456789');
INSERT INTO `controleunb`.`login` (`usuario_login`, `senha_login`) VALUES ('pedro', '416236');
INSERT INTO `controleunb`.`login` (`usuario_login`, `senha_login`) VALUES ('vitor', '416236');

INSERT INTO `controleunb`.`pessoa` (`nome_pessoa`, `endereco_pessoa`, `id_login`) VALUES ('Bruno Oliveira', 'qnn 1 conjunto a casa 21', '1');
INSERT INTO `controleunb`.`pessoa` (`nome_pessoa`, `endereco_pessoa`, `id_login`) VALUES ('Mateus Rocha', 'qnm 30 conjunto f casa 10', '2');
INSERT INTO `controleunb`.`pessoa` (`nome_pessoa`, `endereco_pessoa`, `id_login`) VALUES ('Marcos Paes', 'qnp 5 conjunto g casa 30', '3');
INSERT INTO `controleunb`.`pessoa` (`nome_pessoa`, `endereco_pessoa`, `id_login`) VALUES ('Pedro Oliveira', 'qno 10 conjunto i casa 7', '4');
INSERT INTO `controleunb`.`pessoa` (`nome_pessoa`, `endereco_pessoa`, `id_login`) VALUES ('Caroline Oliveira', 'qnq 10 conjunto l casa 10', '5');

INSERT INTO `controleunb`.`estudante` (`ano_ingresso_estudante`, `matricula_pessoa`) VALUES ('2016-01-01', '1');

INSERT INTO `controleunb`.`funcionario` (`data_contrato_funcionario`, `matricula_pessoa`) VALUES ('2000-02-10', '3');

INSERT INTO `controleunb`.`professor` (`cpf_professor`, `matricula_pessoa`) VALUES ('12312312312', '2');

INSERT INTO `controleunb`.`servidor` (`cargo_servidor`, `matricula_pessoa`) VALUES ('TI', '4');

INSERT INTO `controleunb`.`denuncia` (`descricao_denuncia`, `id_tipo`, `id_gravidade`, `id_local`, `id_pessoa`) VALUES ('vazamento no banheiro', '1', '1', '1', '1');
INSERT INTO `controleunb`.`denuncia` (`descricao_denuncia`, `id_tipo`, `id_gravidade`, `id_local`, `id_pessoa`) VALUES ('vazamento', '2', '1', '2', '2');
INSERT INTO `controleunb`.`denuncia` (`descricao_denuncia`, `id_tipo`, `id_gravidade`, `id_local`, `id_pessoa`) VALUES ('vazamento', '3', '1', '3', '3');
INSERT INTO `controleunb`.`denuncia` (`descricao_denuncia`, `id_tipo`, `id_gravidade`, `id_local`, `id_pessoa`) VALUES ('vazamento pia', '2', '1', '2', '2');
INSERT INTO `controleunb`.`denuncia` (`descricao_denuncia`, `id_tipo`, `id_gravidade`, `id_local`, `id_pessoa`) VALUES ('vazamento vaso sanitario', '1', '3', '4', '5');

INSERT INTO `controleunb`.`ordem_servico` (`data_inicial`, `data_final`, `id_denuncia`, `matricula_pessoa`) VALUES ('2019-06-01', '2019-06-02', '1', '3');
INSERT INTO `controleunb`.`ordem_servico` (`data_inicial`, `data_final`, `id_denuncia`, `matricula_pessoa`) VALUES ('2019-06-05', '2019-06-05', '2', '3');
INSERT INTO `controleunb`.`ordem_servico` (`data_inicial`, `id_denuncia`, `matricula_pessoa`) VALUES ('2019-06-20', '3', '3');

create view denuncia_view
	as select d.id_denuncia, d.descricao_denuncia, p.*, t.*, g.*, l.*  from denuncia as d
	inner join pessoa as p on d.id_pessoa = p.matricula_pessoa
	inner join tipo as t on d.id_tipo = t.id_tipo
	inner join gravidade as g on d.id_gravidade = g.id_gravidade
	inner join local as l on d.id_local = l.id_local;

DELIMITER $$
USE `controleunb`$$
CREATE PROCEDURE confereDenuncia(idDenuncia int, descricao varchar(100), idPessoa int, idTipo int, idGravidade int, idLocal int)
	BEGIN
		IF ((idDenuncia is null) && (descricao is null) && (idPessoa is null) && (idTipo is null) && (idGravidade is null) && (idLocal is null)) THEN
			SELECT 'idDenuncia, descricao, idPessoa, idTipo, idGravidade e idLocal devem ser fornecidos!' AS Mensagem;
		ELSE
			INSERT INTO denuncia (id_denuncia, descricao_denuncia, id_pessoa, id_tipo, id_gravidade, id_local) 
			VALUES (idDenuncia, descricao, idPessoa, idTipo, idGravidade, idLocal);
		END IF; 
	END;$$

DELIMITER ;

