program Pat_Login__p;

uses
  Forms,
  Pat_Login_Main_u in 'Pat_Login_Main_u.pas' {frmMain},
  Pat_login_DM_u in 'Pat_login_DM_u.pas' {DM1: TDataModule},
  LoadingScreen_u in 'LoadingScreen_u.pas' {frmLoading},
  Admin_Home_u in 'Admin_Home_u.pas' {frmAdminHome},
  User_Home_u in 'User_Home_u.pas' {frmUserHome},
  HexaPicker_u in 'HexaPicker_u.pas' {frmHexaPicker};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TfrmLoading, frmLoading);
  Application.CreateForm(TfrmAdminHome, frmAdminHome);
  Application.CreateForm(TfrmUserHome, frmUserHome);
  Application.CreateForm(TfrmHexaPicker, frmHexaPicker);
  Application.Run;
end.
