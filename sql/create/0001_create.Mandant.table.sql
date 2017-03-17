use Essos;
create TABLE Mandant
(
    MandantID   int not null auto_increment,
    ParentMandantID int null,
    Des VARCHAR(50) character set 'utf8' null,
    constraint PK_Mandant PRIMARY KEY(MandantID),
    CONSTRAINT FK_Mandant_Mandant foreign key (ParentMandantID) REFERENCES Mandant(MandantID)
);
