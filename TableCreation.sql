DROP TABLE IF EXISTS dbo.StrategicOutcome_Project;
DROP TABLE IF EXISTS dbo.Strategy_Project;
DROP TABLE IF EXISTS dbo.Indicator_Project;
DROP TABLE IF EXISTS dbo.Metric_Project;
DROP TABLE IF EXISTS dbo.Department_Project;
DROP TABLE IF EXISTS dbo.Reason_Project;
DROP TABLE IF EXISTS dbo.CustomerCategory_Project;
DROP TABLE IF EXISTS dbo.Metric;
DROP TABLE IF EXISTS dbo.Strategy;
DROP TABLE IF EXISTS dbo.Indicator;
DROP TABLE IF EXISTS dbo.Project;
DROP TABLE IF EXISTS dbo.Employee;
DROP TABLE IF EXISTS dbo.Department;
DROP TABLE IF EXISTS dbo.StrategicOutcome;
DROP TABLE IF EXISTS dbo.StrategicAnchor;
DROP TABLE IF EXISTS dbo.Category;
DROP TABLE IF EXISTS dbo.Reason;	
DROP TABLE IF EXISTS dbo.CurrentStatus;
DROP TABLE IF EXISTS dbo.CustomerCategory;
DROP TABLE IF EXISTS dbo.DeliveryTeam;
DROP TABLE IF EXISTS dbo.Workload;

CREATE TABLE dbo.Category (
	CategoryID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL,
	Description varchar(1000) NOT NULL
);

CREATE TABLE dbo.CurrentStatus (
	CurrentStatusID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL
);

CREATE TABLE dbo.Department (
	DepartmentID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL
);

CREATE TABLE dbo.Employee (
	EmployeeID int IDENTITY(1,1) PRIMARY KEY,
	FirstName varchar(255) NOT NULL,
	LastName varchar(255) NOT NULL,
	Title varchar(255) NOT NULL,
	DepartmentID int NOT NULL
		REFERENCES dbo.Department(DepartmentID)
);

CREATE TABLE dbo.StrategicAnchor (
	StrategicAnchorID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL,
	Description varchar(1000)
);

CREATE TABLE dbo.DeliveryTeam (
	DeliveryTeamID int IDENTITY(1,1) PRIMARY KEY,
	Description varchar(255) NOT NULL
);

CREATE TABLE dbo.Workload (
	WorkloadID int IDENTITY(1,1) PRIMARY KEY,
	Description varchar(255) NOT NULL
);

CREATE TABLE dbo.Project (
	ProjectID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL,
	Division varchar(1000) NULL,
	Program varchar(1000) NULL,
	ServiceProfile varchar(5000) NOT NULL,
	SubComponent varchar(5000) NOT NULL,
	Website varchar(255) NOT NULL,
	Background varchar(5000) NOT NULL,
	CompletionDateExists bit NOT NULL,
	PeopleImpacted varchar(5000) NOT NULL,
	InformationSharing varchar(5000) NOT NULL,
	Comments varchar(5000) NULL,
	StrategicAnchorID int NULL
		REFERENCES dbo.StrategicAnchor(StrategicAnchorID),
	CategoryID int NULL
		REFERENCES dbo.Category(CategoryID),
	LeadEmployeeID int NULL
		REFERENCES dbo.Employee(EmployeeID),
	SubmittingEmployeeID int NOT NULL
		REFERENCES dbo.Employee(EmployeeID),
	LeadDepartmentID int NOT NULL
		REFERENCES dbo.Department(DepartmentID),
	CurrentStatusID int NOT NULL
		REFERENCES dbo.CurrentStatus(CurrentStatusID),
	DeliveryTeamID int NOT NULL
		REFERENCES dbo.DeliveryTeam(DeliveryTeamID),
	WorkloadID int NULL
		REFERENCES dbo.Workload(WorkloadID),
);

CREATE TABLE dbo.Department_Project (
	Department_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	DepartmentID int NOT NULL
		REFERENCES dbo.Department(DepartmentID),
	ProjectID int NOT NULL
		REFERENCES dbo.Project(ProjectID)
);

CREATE TABLE dbo.StrategicOutcome (
	StrategicOutcomeID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL
);

CREATE TABLE dbo.StrategicOutcome_Project (
	StrategicOutcome_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	ProjectID int NOT NULL 
		REFERENCES dbo.Project(ProjectID),
	StrategicOutcomeID int NOT NULL 
		REFERENCES dbo.StrategicOutcome(StrategicOutcomeID)
);

CREATE TABLE dbo.Indicator (
	IndicatorID int IDENTITY(1,1) PRIMARY KEY,
	Description varchar(1000) NOT NULL,
	StrategicOutcomeID int NOT NULL
		REFERENCES dbo.StrategicOutcome(StrategicOutcomeID),
	Code varchar(16) NULL,
	CouncilPriority bit NOT NULL,
);

CREATE TABLE dbo.Indicator_Project (
	Indicator_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	IndicatorID int NOT NULL
		REFERENCES dbo.Indicator(IndicatorID),
	ProjectID int NOT NULL
		REFERENCES dbo.Project(ProjectID)
);

CREATE TABLE dbo.Metric (
	MetricID int IDENTITY(1,1) PRIMARY KEY,
	IndicatorID int NOT NULL
		REFERENCES dbo.Indicator(IndicatorID),
	Name varchar(1000) NOT NULL,
	Formula varchar(1000) NULL,
	Code varchar(16) NULL,
);

CREATE TABLE dbo.Metric_Project (
	Metric_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	MetricID int NOT NULL
		REFERENCES dbo.Metric(MetricID),
	ProjectID int NOT NULL
		REFERENCES dbo.Project(ProjectID)
);

CREATE TABLE dbo.Strategy (
	StrategyID int IDENTITY(1,1) PRIMARY KEY,
	Description varchar(1000) NOT NULL,
	StrategicOutcomeID int NULL
		REFERENCES dbo.StrategicOutcome(StrategicOutcomeID)
);

CREATE TABLE dbo.Strategy_Project (
	Strategy_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	StrategyID int NOT NULL
		REFERENCES dbo.Strategy(StrategyID),
	ProjectID int NOT NULL
		REFERENCES dbo.Project(ProjectID)
);

CREATE TABLE dbo.Reason (
	ReasonID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL,
	Description varchar(1000) NOT NULL
);

CREATE TABLE dbo.Reason_Project (
	Reason_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	ReasonID int NOT NULL
		REFERENCES dbo.Reason(ReasonID),
	ProjectID int NOT NULL
		REFERENCES dbo.Project(ProjectID)
);

CREATE TABLE dbo.CustomerCategory (
	CustomerCategoryID int IDENTITY(1,1) PRIMARY KEY,
	Name varchar(255) NOT NULL
);

CREATE TABLE dbo.CustomerCategory_Project (
	CustomerCategory_ProjectID int IDENTITY(1,1) PRIMARY KEY,
	CustomerCategoryID int NOT NULL
		REFERENCES dbo.CustomerCategory(CustomerCategoryID),
	ProjectID int NOT NULL
		REFERENCES dbo.Project(ProjectID)
);