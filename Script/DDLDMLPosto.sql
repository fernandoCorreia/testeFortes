CREATE DATABASE 'C:\Users\Fefe\Documents\TesteFortes\POSTO.fdb' 
USER 'SYSDBA' 
PASSWORD 'masterkey'
PAGE_SIZE 8192
DEFAULT CHARACTER SET WIN1252;


CONNECT 'C:\Users\Fefe\Documents\TesteFortes\POSTO.fdb' 
USER 'SYSDBA' 
PASSWORD 'masterkey';

CREATE TABLE tbCombustivel(
    CdCombustivel integer NOT NULL PRIMARY KEY,
    DsCombustivel Varchar(20) NOT NULL,
    vlCombustivel decimal(10,2)

);

CREATE TABLE TbTanques (
    Cdtanque INTEGER NOT NULL PRIMARY KEY,
    CdCombustivel Integer NOT NULL,
    FOREIGN KEY (Cdcombustivel) REFERENCES tbCombustivel(CdCombustivel)    
);



CREATE TABLE TbBombas (
    Cdbomba INTEGER NOT NULL PRIMARY KEY,
    Dsbomba VARCHAR(50)  NOT NULL,
    Cdtanque INTEGER NOT NULL,
    FOREIGN KEY (Cdtanque) REFERENCES TbTanques(Cdtanque)
);


CREATE TABLE TbAbastecimentos (
    CdAbastecimento INTEGER NOT NULL PRIMARY KEY,
    Dtabastecimento DATE NOT NULL,
    CdBomba Integer NOT NULL,
    Qtlitros DECIMAL(10, 2) NOT NULL,
    VlTotal DECIMAL(10, 2) NOT NULL,
    PcImposto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (CdBomba) REFERENCES TbBombas(CdBomba)        
);

INSERT  INTO tbCombustivel values(1, 'Gasolina', 3.75);
INSERT  INTO tbCombustivel (2, 'Óleo Diesel', 3.00);

INSERT INTO TbTanques (Cdtanque, CdCombustivel) VALUES (1, 1 );
INSERT INTO TbTanques (Cdtanque, CdCombustivel) VALUES (2, 2 );

INSERT INTO TbBombas (Cdbomba, Dsbomba, Cdtanque) VALUES (1, 'Bomba Gasolina 1', 1);
INSERT INTO TbBombas (Cdbomba, Dsbomba, Cdtanque) VALUES (2, 'Bomba Gasolina 2', 1);
INSERT INTO TbBombas (Cdbomba, Dsbomba, Cdtanque) VALUES (3, 'Bomba Óleo Diesel 1', 2);
INSERT INTO TbBombas (Cdbomba, Dsbomba, Cdtanque) VALUES (4, 'Bomba Óleo Diesel 2', 2);



 Select  * 
 From TBABASTECIMENTOS A 
JOIN TBBOMBAS b ON a.CDBOMBA  = b.CDBOMBA JOIN TBTANQUES  c ON   c.CDTANQUE  = b.CDTANQUE JOIN TBCOMBUSTIVEL d ON  c.CDCOMBUSTIVEL = d.CDCOMBUSTIVEL 
 where  CDABASTECIMENTO = 3
 
 
 UPDATE TbAbastecimentos
 SET 
 CdBomba = 1, 
 QtLitros = 16.9, 
 VlTotal = 82.47
 WHERE  cdabastecimento = 5

