-- define tables
create table Employee (
	EmployeeID int not null auto_increment,
	FirstName varchar2(100),
	LastName varchar2(100),
	EmailAddress varchar2(100),
	Emp_Password varchar2(512),
	DirectSupervisorID int,
	DepartmentID int,
	EmployeeTypeID int,
	LastLogin timestamp with time zone,
	constraint PK_Employee primary key (EmployeeID)
);

create table Department (
	DepartmentID int not null auto_increment,
	DepartmentHeadID int not null,
	DepartmentName varchar2(100),
	constraint PK_Department primary key (DepartmentID)
);

create table EmployeeType (
	EmployeeTypeID int not null auto_increment,
	EmployeeType varchar2(50),
	constraint PK_EmployeeType primary key (EmployeeTypeID)
);



create table Event (
	EventID int not null auto_increment,
	EventName varchar2(100),
	EventStartTime timestamp with time zone,
	Cost int(10,2),
	LocationID int not null,
	EventTypeID int not null,
	GradingFormatID int not null,
	constraint PK_Event primary key (EventID)
);

create table EventType (
	EventTypeID int not null auto_increment,
	EventType varchar2(50),
	ReimbursementCoveragePercent int,
	constraint PK_EventType primary key (EventTypeID)
);

create table Location (
	LocationID int not null auto_increment,
	StreetAddress1 varchar2(100),
	StreetAddress2 varchar2(100),
	City varchar2(50),
	State varchar2(50),
	ZipCode varchar2(20),
	Country varchar2(50),
	constraint PK_Location primary key (LocationID)
);

create table GradingFormat (
	GradingFormatID int not null auto_increment,
	GradingFormat varchar2(50),
	constraint PK_GradingFormat primary key (GradingFormatID)
);

create table Attachment (
	AttachmentID int not null auto_increment,
	AttachmentLocation varchar2(200),
	ReimbursementID int not null,
	AttachmentDescription varchar2(200),
	constraint PK_Attachment primary key (AttachmentID)
);

create table ReimbursementStatus (
	ReimbursementStatusID int not null auto_increment,
	ReimbursementStatus varchar2(50),
	constraint PK_ReimbursementStatus primary key (ReimbursementStatusID)
);

create table InformationRequest (
	InformationRequestID int not null auto_increment,
	RequesterID int not null,
	RequesteeID int not null,
	ReimbursementID int not null,
	RequesterMessage varchar2(500),
	RequesteeResponse varchar2(500),
	RequestDate timestamp with time zone,
	ResponseDate timestamp with time zone,
	constraint PK_InformationRequest primary key (InformationRequestID)
);

create table Reimbursement (
	ReimbursementID int not null auto_increment,
	RequesterId int not null,
	AssignTo int not null,
	Description varchar2(500),
	WorkRelatedJustification varchar2(500),
	ReimbursementAmountRequested int(10, 2),
	AdditionalInformation varchar2(500),
	ReimbursementStatusID int,
	DateSubmitted timestamp with time zone,
	DateCompleted timestamp with time zone,
	EventID int,
	ReimbursementResponseID int,
	constraint PK_Reimbursement primary key (ReimbursementID)
);

create table ReimbursementResponse (
	ReimbursementResponseID int not null auto_increment,
	ResponderID int not null,
	ReimbursementAmountAwarded int(10, 2),
	ReimbursementAmountExceeded int(10, 2),
	ReimbursementExceedReason varchar2(500),
	DisapprovalReason varchar2(500),
	constraint PK_ReimbursementResponse primary key (ReimbursementResponseID)
);




alter table Employee add constraint FK_Employee_DirectSupervisor foreign key (DirectSupervisorID) references Employee(EmployeeID);
alter table Employee add constraint FK_Employee_Department foreign key (DepartmentID) references Department(DepartmentID);
alter table Employee add constraint FK_Employee_EmployeeType foreign key (EmployeeTypeID) references EmployeeType(EmployeeTypeID);
alter table Department add constraint FK_Department_DepartmentHead foreign key (DepartmentHeadID) references Employee(EmployeeID);
alter table Event add constraint FK_Event_Location foreign key (LocationID) references Location(LocationID);
alter table Event add constraint FK_Event_EventType foreign key (EventTypeID) references EventType(EventTypeID);
alter table Event add constraint FK_Event_GradingFormat foreign key (GradingFormatID) references GradingFormat(GradingFormatID);
alter table Attachment add constraint FK_Attachment_Reimbursement foreign key (ReimbursementID) references Reimbursement(ReimbursementID);
alter table InformationRequest add constraint FK_InfoRequest_Requester foreign key (RequesterID) references Employee(EmployeeID);
alter table InformationRequest add constraint FK_InfoRequest_Requestee foreign key (RequesteeID) references Employee(EmployeeID);
alter table InformationRequest add constraint FK_InfoRequest_Reimbursement foreign key (ReimbursementID) references Reimbursement(ReimbursementID);
alter table Reimbursement add constraint FK_Reimbursement_RequesterID foreign key (RequesterID) references Employee(EmployeeID);
alter table Reimbursement add constraint FK_Reimbursement_Status foreign key (ReimbursementStatusID) references ReimbursementStatus(ReimbursementStatusID);
alter table Reimbursement add constraint FK_Reimbursement_Response foreign key (ReimbursementResponseID) references ReimbursementResponse(ReimbursementResponseID);
alter table ReimbursementResponse add constraint FK_ReimResponse_Responder foreign key (ResponderID) references Employee(EmployeeID);




