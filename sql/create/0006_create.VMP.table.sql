use Essos;
create table VirtualMeteringPoint
(
    VmpID   int not null auto_increment,
    MandantID   int not null,
    CalculationPipelineID   int null,
    ExecutionPipelineID     int null,
    -- bla bla bla
    constraint PK_VMP PRIMARY KEY(VmpID, MandantID),
    constraint FK_VMP_Mandant FOREIGN KEY (MandantID) REFERENCES Mandant(MandantID),
    constraint FK_VMP_CalculationPipeline FOREIGN KEY (CalculationPipelineID) REFERENCES CalculationPipeline(CalculationPipelineID)
);

-- Beispieldaten
insert into VirtualMeteringPoint
(/* VmpID */ MandantID, CalculationPipelineID, ExecutionPipelineID)
values
(/* 1 */ 1, 1, null);