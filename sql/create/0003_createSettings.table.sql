use Essos;

create TABLE SettingsType
(
    stID    int not null auto_increment,
    stDes   VARCHAR(50),
    constraint PK_SettingsType PRIMARY KEY (stID)
);

insert into SettingsType (stDes)
values ('Gartendigital.All-Settings'),                  -- 1
('Gartendigital.Communication.Hub-Settings'),           -- 2
('Gartendigital.RPI-Settings'),                         -- 3
('Gartendigital.Frontend-Settings');                    -- 4

create table Settings
(
    SettingsID  int not null auto_increment,
    stID        int not null,
    settingsName    VARCHAR(30) not null,
    settingsValueString   varchar(255),
    settingsValueBin      varbinary(2048),
    tstamp      timestamp not null,
    Remarks     varchar(255),
    constraint PK_Settings PRIMARY KEY (SettingsID),
    constraint FK_Settings_SettingsType FOREIGN KEY (stID) REFERENCES SettingsType(stID),
    index IX_Settings_SettingsName (settingsName)
)