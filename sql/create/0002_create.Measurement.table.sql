use Essos;
create table Measurement
(
    measurementID   int not null auto_increment,
    MandantID       int not null,
    meteredValue    decimal (5, 2), /* -999.99 to +999.99 */
    tstamp          TIMESTAMP not NULL,

    CONSTRAINT PK_Measurement PRIMARY KEY(measurementID),
    CONSTRAINT FK_Measurement_Mandant FOREIGN KEY (MandantID) REFERENCES Mandant(MandantID)
)Engine=InnoDB;