use Essos;
create table CalculationPipeline
(
    CalculationPipelineID   int not null auto_increment,
    MandantID               int not null,
    Operand                 decimal not null,
    Operator                enum("+", "-", "*", "/", "<<", ">>", "|", "&") not null,
    ParentCalcID            int null,
    constraint PK_CalculationPipeline PRIMARY key (CalculationPipelineID),
    CONSTRAINT FK_CalculationPipeline_Mandant FOREIGN KEY (MandantID) REFERENCES Mandant(MandantID),
    constraint FK_CalculationPipeline_CalculationPipeline FOREIGN KEY(ParentCalcID) REFERENCES CalculationPipeline(CalculationPipelineID)
);

create table ExecutionPipeline
(
    ExecutionPipelineID     int not null auto_increment,
    MandantID               int not null,
    RunScript               text not null,
    -- bla bla bla
    ParentExecID            int null,
    constraint PK_ExecutionPipeline PRIMARY key (ExecutionPipelineID),
    CONSTRAINT FK_ExecutionPipeline_Mandant FOREIGN KEY (MandantID) REFERENCES Mandant(MandantID),
    constraint FK_ExecutionPipeline_ExecutionPipeline foreign key(ParentExecID) REFERENCES ExecutionPipeline(ExecutionPipelineID)
);

-- Beispieldaten:
insert into CalculationPipeline
(/* calcID */ MandantID, Operand, Operator, ParentCalcID)
values
(/* 1 */ 1, 10, "/", null), (/* 2 */1, 4, "-", 1);
