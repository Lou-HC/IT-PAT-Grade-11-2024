unit User_Home_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ActnMan, Vcl.ActnColorMaps,
  Vcl.Grids, System.Win.TaskbarCore, Vcl.Taskbar, Vcl.ComCtrls, Vcl.WinXCtrls,
  Vcl.Touch.Keyboard, Pat_login_DM_u;

type
  TUser = record
    Username : string[30];
    Password : string[30];
    Firstname : string[30] ;
    Lastname : string[30]  ;
    Usertype : string[1];
  end;
  TfrmUserHome = class(TForm)
    Panel1: TPanel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    Procedure AssignUser();
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmUserHome: TfrmUserHome;
  User : TUser;

implementation

uses
Pat_Login_Main_u;

{$R *.dfm}

procedure TfrmUserHome.AssignUser;
  begin
    with DM1 do
      begin
        with User do
          begin
            Username := ADOT1['Username'];  //Assigns the username variable to ADOT1[username]
            FirstName:= ADOT1['Firstname'];
            lastname := ADOT1['lastname'] ;
            Password := ADOT1['Password'];
            Usertype := ADOT1['Usertype'];
          end;
      end;

  end;

procedure TfrmUserHome.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
     frmMain.Close;
  end;

procedure TfrmUserHome.FormShow(Sender: TObject);
  begin
   AssignUser();
  end;

end.
