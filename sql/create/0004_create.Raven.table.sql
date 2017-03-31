/* Tabelle in welcher die Nachrichten von den Raben landen, sowie deren Antworten */
use Essos;

create table Raven
(
    RavenID int not null auto_increment,
    MandantID int not null,
    Message text,
    MessageResponse text null,
    tstamp  timestamp,
    constraint PK_Raven primary key(RavenID),
    constraint FK_Raven_Mandant foreign key (MandantID) references Mandant(MandantID)
)Engine=InnoDB;