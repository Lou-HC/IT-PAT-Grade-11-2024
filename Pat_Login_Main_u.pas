unit Pat_Login_Main_u;    //Louis H. Combrink

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Pat_login_DM_u, Grids, DBGrids, StdCtrls, loadingScreen_u, Admin_Home_u,
  Buttons, User_Home_u,
  ExtCtrls, Vcl.Menus, Vcl.Imaging.pngimage, Vcl.Samples.Spin, Vcl.ComCtrls,
  Vcl.Samples.Gauges;

type
  TarrComps = array of TComponent;
  TfrmMain = class(TForm)
    edtUserNameLogin: TEdit;
    edtPasswordLogin: TEdit;
    bmbLogin: TBitBtn;
    bmbNewUser: TBitBtn;
    pnlNewUser: TPanel;
    edtNewUserUserName: TEdit;
    edtNewUserPassword: TEdit;
    bmbNewUserCon: TBitBtn;
    bmbNewUserCancel: TBitBtn;
    pnlDieBaas: TPanel;
    shpPasswordLogin: TShape;
    shpUserNameLogin: TShape;
    imgPasswordLogin: TImage;
    imgUserNameLogin: TImage;
    shpNewUserUserName: TShape;
    shpNewUserPassword: TShape;
    imgNewUserPassword: TImage;
    imgNewUserUserName: TImage;
    lblNewUser: TLabel;
    imgRegister: TImage;
    shpLogin: TShape;
    lblLogin: TLabel;
    Button1: TButton;
    Button2: TButton;
    imgNewUserCon: TImage;
    lblNewUserCon: TLabel;
    Shape1: TShape;
    Label1: TLabel;
    shpNewUserCancel: TShape;
    lblNewUserCancel: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure bmbLoginClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bmbNewUserClick(Sender: TObject);
    procedure bmbNewUserCancelClick(Sender: TObject);
    procedure bmbNewUserConClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lblNewUserClick(Sender: TObject);
    procedure imgRegisterClick(Sender: TObject);
    procedure edtPasswordLoginChange(Sender: TObject);
    procedure lblLoginClick(Sender: TObject);
    procedure shpLoginMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpLoginMouseEnter(Sender: TObject);
    Procedure Check30CharLim(edt1 : tEdit; edt2: TEdit) ;
    procedure edtUserNameLoginChange(Sender: TObject);
    procedure edtNewUserUserNameChange(Sender: TObject);
    procedure edtNewUserPasswordChange(Sender: TObject);
    Function ReplaceInStr( sIn : string; cReplace : char; cWith : char): string;
    Procedure AssignColors();
    procedure Button2Click(Sender: TObject);
    Procedure ClearAll( Comps : array of TComponent ) ;
    procedure Button3Click(Sender: TObject);
    Procedure Piet(b : Bool);
    procedure imgNewUserConClick(Sender: TObject);
    procedure lblNewUserConClick(Sender: TObject);
    procedure shpNewUserCancelMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lblNewUserCancelClick(Sender: TObject);
  private
    { Private declarations }
    cUserType : char  ;
    sUserName: string;
  public
    { Public declarations }
    arrColors : array[0..5] of TColor
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

procedure TfrmMain.AssignColors;
   var
   tfColors : TextFile;
   sColor : string;
   clNewColor : TColor;
   i : integer;


  begin
  i := 0;
  AssignFile(tfColors, 'Textfiles/colors.txt') ;
  reset(tfColors) ;

  while not eof(tfColors) do
      begin
           readln(tfColors, sColor ) ;
           try
              clNewColor := stringtoColor(sColor) ;
              //showmessage('1') ;
           except
           //showmessage('2') ;
                  try
                      clNewColor := stringtoColor('$' + sColor);
                  except
                            try
                              sColor := replaceInStr(sColor, '#', '$') ;
                              //a common format for colors is '#' and then
                              //the color in hexadecimal.
                              clNewColor := stringtoColor(sColor) ;
                            except
                             messageDlg('Error with colors',
                                          mtError, [mbOK], 1);
                             arrColors[0] := $5F5F5F;
                             arrColors[1] := $818181;
                             arrColors[2] := $1355FC;
                             //sets the colors to a moderate default
                             Break;
                            end;
                  end;
           end;
           arrColors[i] := clNewColor;
           inc(i);
      end;

      closeFile(tfColors);
  end;

procedure TfrmMain.bmbLoginClick(Sender: TObject);
  var
  i : integer ;
  sPassword: string ;
  bFound : boolean;

  begin
   sUserName := edtUserNameLogin.Text ;
   sPassword := edtPasswordLogin.Text;
   bFound := false;
   {
   with Dm1 do
      begin  // with dm1
      adoT1.First;
          while not ADOT1.Eof do
               begin
                  if (sUserName = AdoT1['UserName']) and
                           (sPassword = adoT1['Password']) then
                        begin
                        sUserName := Adot1['UserName'];
                        bFound := true;
                        break;
                        end
                        else if (sUserName = AdoT1['UserName']) and (sPassword  <> adoT1['Password']) then
                          begin
                          showmessage('Password is incorrect') ;
                          exit;
                          end;
                  adot1.Next;
               end;


      end;  // with dm1
          }
      if (edtUserNameLogin.Text = 'Johan') and (edtPasswordLogin.Text = '123') then
            bFound := True;
    if bFound = false then
    begin
      showmessage('Username not found') ;
      exit;
    end;

    frmMain.Hide;
    frmLoading.Show;;;
  end;




procedure TfrmMain.bmbNewUserCancelClick(Sender: TObject);
  begin
    pnlNewUser.Hide;
    pnlDieBaas.Show;
  end;

procedure TfrmMain.bmbNewUserClick(Sender: TObject);
  begin
      {  lblUserNameLogin.Caption := '';
        lblPasswordLogin.Caption := '';
        lblLogin.Caption := ''; }
        pnlNewUser.Show;
        pnlDieBaas.Hide; //Switches between the panels

        with pnlNewUser do
        begin    //Makes the NewUser panel's position similar to Diebaas panel
          top := pnlDiebaas.Top;
          left := pnlDieBaas.Left;;
          width := pnlDieBaas.width;//0.83 is a pretty number :)
          height := pnlDieBaas.Height ;
         // Show;
        end;
        edtNewUserUserName.Text := '';
        edtNewUserPassword.Text := '';
      {  shpNewUserUserName.Top := shpUserNameLogin.Top;
        shpNewUserUserName.left := shpUserNameLogin.left;

        shpNewUserPassword.Top := shpPasswordLogin.Top;
        shpNewUserPassword.left := shpPasswordLogin.left;

        edtNewUserUserName.Top := edtUserNameLogin.Top;
        edtNewUserUserName.left := edtUserNameLogin.left; }



   { with pnlNewUser do
        begin
          width := frmMain.Width;
          Height := frmMain.Height;
          top := 0;
          left := 0;
         // Show;
        end;
        edtNewUserUserName.Left := round((0.5*pnlNewUser.Width) - (0.75*edtNewUserUserName.Width));
        edtNewUserPassword.Left := round((0.5*pnlNewUser.Width) - (0.75*edtNewUserPassword.Width));
        edtNewUserUserName.Text := '';
        edtNewUserPassword.Text := '';
        bmbNewUserCon.Left :=  edtNewUSerUserName.Left;
        bmbNewUserCancel.Left := edtNewUserUserName.Left;
        bmbNewUserCon.Top := round((37/100)*pnlNewUser.Height );
        bmbNewUserCon.Width := edtNewUserUserName.Width ;
        bmbNewUserCancel.Top := round((55/100)*pnlNewUser.Height ) ;
        bmbNewUserCon.Kind := bkYes;
        bmbNewUserCancel.Kind := bkNo;
        bmbNewUserCon.Caption := 'Confrim new User';
        bmbNewUserCancel.Caption := 'Cancel';

        with lblNewUserUserName do
          begin
            left := edtNewUserUserName.Left;
            top := edtNewUseruserName.Top - edtNewUserUserName.Height;;;;;;
            caption := 'Username?';
          end;
          with lblNewUserPassword do
          begin
            left := edtNewUserPassword.Left;
            top := edtNewUserPassword.Top - edtNewUserPassword.Height;;
            caption := 'Password';
          end;     }


  end;

procedure TfrmMain.bmbNewUserConClick(Sender: TObject);
   var
   spas : string;
   bPas : bool;
   i : integer;
  begin
  //UserName Confirmation

       if length(edtNewUserUserName.Text) < 8 then
          begin
          messagedlg('Username length must be 8 or more.',
                       mterror, [mbOk], 0 ) ;
          exit;
          end;
  //end Username confirmation
  //password confirmation
       sPas := edtNewUserPassword.Text;
       bPas := false;
       if length(sPas) < 8 then
        begin
          messagedlg('Password length must be 8 or more.', mterror, [mbOk], 0 );
          exit;
        end;
        for I := 0 to length(spas) do
              begin
                if sPas[i] in ['0'..'9'] then
                     bpas := true;
              end;
                if not bPas then
                  if  messagedlg('Password has no number characters. Proceed?',
                    MtInformation, [mbOk, mbCancel], 0 ) <> mrOk then
                          begin
                            edtNewUserPassword.Clear;
                            exit;
                          end;
        bPas := False;
        for i := 0 to length(sPas) do
          begin
            if not((Upcase(sPas[i]) in ['A'..'Z'])) and
                                    (not (sPas[i] in ['0'..'9']) and
                                                        (spas[i] <> ' ')) then
                  begin
                      bPas := true   ;
                      break ;
                  end;
          end;
          if  not bpas then
             begin
                  messagedlg('Password has no special characters.',
                    MtWarning, [mbOk], 0 );
                            edtNewUserPassword.Clear;
                            exit;
             end;


           //end password comfirmation

     with dm1 do
          begin
             adot1.First;
              while not ADOt1.Eof do
                   begin
                     if edtNewUserUsername.Text = adot1['Username'] then
                           begin
                             showmessage('Username already exists') ;
                             exit;
                           end;
                           ADOT1.Next;
                   end;
            {  ADOT1.Insert ;
              ADOT1['UserName'] := edtNewUserUserName.Text ;
              ADOT1.Insert ;
              ADOT1['UserName'] := edtNewUserUserName.Text ;  }    //brilliant
          end;



  end;

procedure TfrmMain.Button1Click(Sender: TObject);
  var
  pnt : TPoint;
  begin
   frmMain.Hide;
   frmAdminHome.Show;

  end;

procedure TfrmMain.Button2Click(Sender: TObject);
  begin
   frmMain.Hide;
   frmUserHome.Show;
  end;

procedure TfrmMain.Button3Click(Sender: TObject);
  begin
   Piet(false);
  end;

procedure TfrmMain.Check30CharLim(edt1, edt2: TEdit);
  begin
        if (Length(edt1.Text) > 30) or (Length(edt2.Text) > 30) then
        begin // Makes both edits char limit 30
          messagedlg('Maximum character limit of 30 has been reached.' ,
                                              mtError, [mbok] , 1) ;
          edt1.Text := copy(edt1.Text, 1, 30) ;
          edt2.Text := copy(edt2.Text, 1, 30) ;
          //sets each edit to its first 30 chars
          exit;
        end;
  end;

procedure TfrmMain.ClearAll(Comps: array of TComponent);
  var
  i : integer;
  begin
      for i := 0 to length(comps) do
          begin
              try  //Ek is jammer
                if (comps[i] is TEdit) then
                  (comps[i] as TEdit).text := ''
                else if comps[i] is TRichEdit then
                  (comps[i] as TRichEdit).Lines.Clear
                else if comps[i] is TSpinEdit then
                  (comps[i] as tSpinEdit).Value := 0
                else if comps[i] is TLabel then
                  (comps[i] as TLabel).Caption := ''
                else if comps[i] is TProgressbar then
                  (comps[i] as TProgressbar).Position := 0
                else if comps[i] is TGauge then
                  (comps[i] as tGauge).Progress := 0
                else if comps[i] is tPanel then
                  (comps[i] as Tpanel).Caption := ''
                  else
                  Continue;
                //  Regtig jammer....
                //Years of Acedemy training wasted!
                //https://www.bing.com/images/search?view=detailV2&ccid=vsLhoBdj&id=FE57664C5EBCCD9673FC04619AF571CB220730A8&thid=OIP.vsLhoBdj0vxVsxgg1vOnZwHaE9&mediaurl=https%3a%2f%2fi.imgflip.com%2f53wg8f.jpg&cdnurl=https%3a%2f%2fth.bing.com%2fth%2fid%2fR.bec2e1a01763d2fc55b31820d6f3a767%3frik%3dqDAHIstx9ZphBA%26pid%3dImgRaw%26r%3d0&exph=456&expw=680&q=buzz+lightyear+years+of+academy+training&simid=608031129213696525&FORM=IRPRST&ck=7A91B2749A6D07B81375921D75DC2CC4&selectedIndex=3&itb=0&ajaxhist=0&ajaxserp=0
              Except
              Continue;

              end;
          end;
  end;

procedure TfrmMain.edtNewUserPasswordChange(Sender: TObject);
  begin
   Check30CharLim(edtNewUserUserName, edtNewUserPassword) ;
  end;

procedure TfrmMain.edtNewUserUserNameChange(Sender: TObject);
  begin
   Check30CharLim(edtNewUserUserName, edtNewUserPassword) ;
  end;

procedure TfrmMain.edtPasswordLoginChange(Sender: TObject);
  begin
     EdtUserNameLogin.OnChange(self) ;
  end;

procedure TfrmMain.edtUserNameLoginChange(Sender: TObject);
  begin
    Check30CharLim(edtUserNameLogin, edtPasswordLogin);
  end;

procedure TfrmMain.FormCreate(Sender: TObject);

begin

  AssignColors();//Assigns the colors
  frmMain.Color := arrColors[0];
  pnlDieBaas.ParentBackground := False;
  pnlDieBaas.Color := arrColors[1];
  //bmbLogin.Brush.Color := arrColors[2];

  shpLogin.Brush.Color := arrColors[2];
end;

procedure TfrmMain.FormShow(Sender: TObject);
  begin
     edtUserNameLogin.SetFocus;
     pnlDieBaas.Show;
     pnlNewuser.Hide;
     AssignColors();

  frmMain.Color := arrColors[0];

  pnlDieBaas.ParentBackground := False;
  pnlDieBaas.Color := arrColors[1];

  pnlNewUser.ParentBackground := False;
  pnlNewUser.Color := arrColors[1];

  shpLogin.Brush.Color := arrColors[2];
  shpNewUSerCancel.Brush.Color := arrColors[2];
  end;


 procedure TfrmMain.imgNewUserConClick(Sender: TObject);
  begin
    bmbNewUserCon.OnClick(self);
  end;

procedure TfrmMain.imgRegisterClick(Sender: TObject);
begin
       lblNewUser.OnClick(self);
end;

procedure TfrmMain.lblLoginClick(Sender: TObject);
  begin
   bmbLogin.OnClick(self) ;
  end;

procedure TfrmMain.lblNewUserCancelClick(Sender: TObject);
  begin
   bmbNewUserCancel.OnClick(self);
  end;

procedure TfrmMain.lblNewUserClick(Sender: TObject);
begin
    bmbNewUser.OnClick(self);
end;



procedure TfrmMain.lblNewUserConClick(Sender: TObject);
  begin
    imgNewUserCon.OnClick(self);
  end;

procedure TfrmMain.Piet(b: Bool);
  begin
   if b then
     showmessage('haai');
  end;

function TfrmMain.ReplaceInStr(sIn: string; cReplace, cWith: char): string;
  var
  i : integer;
  begin
     for i := 0 to length(sIN) do
          begin
            if sIn[i] = cReplace then
                  begin
                    sIn[i] := cWith;
                  end;
          end;
       
  end;



procedure TfrmMain.shpNewUserCancelMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
  begin
   bmbNewUserCancel.OnClick(self);
  end;

procedure TfrmMain.shpLoginMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
lblLogin.OnClick(self);//Calls the lblLogin's Onclick Function.
end;

procedure TfrmMain.shpLoginMouseEnter(Sender: TObject);
begin

end;

//<a target="_blank" href="https://icons8.com/icon/8953/add-user-male">Add User Male</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
//<a target="_blank" href="https://icons8.com/icon/44033/password">Password</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
  //  <a target="_blank" href="https://icons8.com/icon/nhjymmETB05X/person-male-skin-type-4">User</a> icon by <a target="_blank" href="https://icons8.com">Icons8</a>
end. //Louis H. Combrink
