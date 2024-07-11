unit Pat_login_DM_u;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM1 = class(TDataModule)
    ADOCon1: TADOConnection;
    ADOT1: TADOTable;
    ADOQ1: TADOQuery;
    DS1: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM1: TDM1;

implementation

{$R *.dfm}

end.
