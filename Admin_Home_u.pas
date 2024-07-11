unit Admin_Home_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Vcl.ExtCtrls, Vcl.ActnMan, Vcl.ActnColorMaps, Vcl.StdCtrls, Vcl.Menus,
  Vcl.Buttons, Vcl.Imaging.pngimage, Data.DB, Vcl.Grids, Vcl.DBGrids,
   HexaPicker_u;

type
  TfrmAdminHome = class(TForm)
    pnlAdminHomeHome: TPanel;
    mMenuAdminHome: TMainMenu;
    N11: TMenuItem;
    N21: TMenuItem;
    N23: TMenuItem;
    pnlAdminColor: TPanel;
    cldlgAdmin: TColorDialog;
    bmbAdminColorShow: TBitBtn;
    pnlShowColor: TPanel;
    shpPasswordLogin: TShape;
    shpUserNameLogin: TShape;
    imgPasswordLogin: TImage;
    imgUserNameLogin: TImage;
    lblNewUser: TLabel;
    imgRegister: TImage;
    shpLogin: TShape;
    lblLogin: TLabel;
    edtPasswordLogin: TEdit;
    edtUserNameLogin: TEdit;
    bmbLogin: TBitBtn;
    bmbNewUser: TBitBtn;
    pnlAdminShowCurColor: TPanel;
    bmbAdminGoBack: TBitBtn;
    shpNewMainBack: TShape;
    shpNewSecondBack: TShape;
    shpNewAccent: TShape;
    shpCurrMainBack: TShape;
    shpCurrSecondBack: TShape;
    shpCurrAccent: TShape;
    lblCurrColors: TLabel;
    lblNewColors: TLabel;
    shpDivider: TShape;
    bmbConnewColors: TBitBtn;
    bmbCancelnewColors: TBitBtn;
    pnlShowBackMain: TPanel;
    DBGShowData: TDBGrid;
    pMenuColor: TPopupMenu;
    ColorPicker1: TMenuItem;
    ColorPicker2: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    Procedure AdminReturnLogin();
    procedure bmbAdminGoBackClick(Sender: TObject);
    procedure bmbAdminColorShowClick(Sender: TObject);
    Procedure SwapPnlVis(PnlShow : tPanel; pnlHide : TPanel) ;
    procedure N11Click(Sender: TObject);
    Procedure ChooseNewColor(shp : TShape; Colordlg : TColorDialog) ;
    procedure shpNewMainBackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpNewSecondBackMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure shpNewAccentMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    Procedure AdminTestColors(colors : array of Tcolor );
    procedure bmbConnewColorsClick(Sender: TObject);
    Procedure ShapeAccent ( shp : TShape) ;
    Procedure ReleaseShapeAccent ( shp : TShape ) ;
    procedure ColorPicker1Click(Sender: TObject);
    procedure ColorPicker2Click(Sender: TObject);
    Procedure HexaBox () ;
  private
    { Private declarations }
    PshpSender : ^TShape; //a pointer to a shape
  public
    { Public declarations }
  end;

var
  frmAdminHome: TfrmAdminHome;

implementation
uses
Pat_Login_Main_u;

{$R *.dfm}

procedure TfrmAdminHome.AdminReturnLogin;
  begin
   frmAdminHome.Hide; //Hides the admin form
   frmMain.Show; //Shows the login(Main) form.
  end;


procedure TfrmAdminHome.AdminTestColors(colors: array of Tcolor);
  begin
       pnlShowBackMain.ParentBackground := False;
      pnlShowBackMain.Color := Colors[0];

      pnlSHowColor.ParentBackground := false;
      pnlShowColor.Color := Colors[1];

      shpLogin.Brush.Color := Colors[2];
  end;

procedure TfrmAdminHome.bmbAdminColorShowClick(Sender: TObject);


  begin
      frmMain.AssignColors();
  AdminTestColors([shpNewMainback.Brush.Color, shpnewSecondBack.Brush.Color,
                    shpNewAccent.Brush.Color] ) ;
  //  shpTest.Brush.Color := clColor;
  end;

procedure TfrmAdminHome.bmbAdminGoBackClick(Sender: TObject);
  begin
    AdminReturnLogin();
  end;

procedure TfrmAdminHome.bmbConnewColorsClick(Sender: TObject);
     var
   tfNewColors : textfile;

  begin

  if MessageDlg('Are you sure you want to confirm these colors?',mtConfirmation,
                  [mbYes, mbNO] , 1) <> mrYes  then
                    begin
                      //confrim the user wants the chosen colors
                      Exit ;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;
                    end
                      else
  messageDlg('Confirmed.' + #13 +
' Please return to login screen for changs to take effect', mtInformation, [mbOk], 1) ;



     assignFile(tfNewColors, 'Textfiles/colors.txt' ) ;
     reset(tfNewColors) ;
     rewrite(tfNewColors) ;
     append(tfNewColors) ;
     // write to tf
     writeln(tfNewColors, ColorToString(shpNewMainBack.Brush.Color )) ;
     writeln(tfNewColors, ColorToString(shpNewSecondBack.Brush.Color )) ;
     writeln(tfNewColors, ColorToString(shpNewAccent.Brush.Color )) ;

     closeFile(tfNewColors) ;

     frmMain.AssignColors();
     AdmintestColors(frmmain.arrColors) ;
  end;

procedure TfrmAdminHome.ChooseNewColor(shp : TShape; Colordlg  :TColorDialog);
  begin
   Colordlg.Execute()  ;
   shp.Brush.Color := ColorDlg.Color;
  end;

procedure TfrmAdminHome.ColorPicker1Click(Sender: TObject);
  begin
    ShapeAccent( PshpSender^ ) ; //refers to the memory slot that the pointer
                                //is pointing at ; "shpSender^"
    ChooseNewColor(PshpSender^, clDlgAdmin) ;
    ReleaseShapeAccent(PshpSender^);
  end;

procedure TfrmAdminHome.ColorPicker2Click(Sender: TObject);
  var
  clnewColor : Tcolor;
  sColor : string;
  begin
   HexaBox();
  clNewColor := $000000; //sets the default

  clNewColor := frmHexaPicker.shpColorshowcase.Brush.Color;
  PshpSender^.Brush.Color := clNewColor
  {sColor := frmHexaPicker.edtColorInput.Text;
  if length(sColor) <> 6 then
      begin
        messagedlg('Incorrect format or length', mterror, [mbOK], 1);
      end;

    try
      clNewColor := stringtoColor(sColor) ;
              //showmessage('1') ;
    except
           //showmessage('2') ;
           try
           clNewColor := stringtoColor('$' + sColor);
                  except
                    try
                      sColor := frmMain.replaceInStr(sColor, '#', '$') ;
                      //a common format for colors is '#' and then
                      //the color in hexadecimal.
                      clNewColor := stringtoColor(sColor) ;
                      except
                             messageDlg('Error with colors',
                                          mtError, [mbOK], 1);
                    end;
           end;
    end;
    PshpSender^.Brush.Color := clNewColor;
       }
  end;

procedure TfrmAdminHome.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
   frmMain.Close;
  end;

procedure TfrmAdminHome.FormShow(Sender: TObject);
  var
  arrShapes : array[0..3] of TShape;
  i : integer;

  begin
   frmMain.AssignColors(); //Uses the colors stored in colors.txt
   frmAdminHome.Color := frmMain.arrColors[0];

   pnlAdminColor.ParentBackground := False;
   pnlAdminColor.Color := frmMain.arrColors[1];
   pnlShowBackMain.Color := frmMain.arrColors[0];
   pnlAdminhomeHome.Color := frmMain.arrColors[1];

   pnlAdminColor.Height := 620;
   pnlAdminColor.Width := 930;
   pnlAdminColor.Left := 33;
   pnlAdmincolor.Top := 8;

   shpLogin.Brush.Color := frmMain.arrColors[2];

   pnlAdminHomeHome.Hide;

   arrShapes[0] := shpCurrMainBack;
   arrShapes[1] := shpCurrSecondBack;
   arrSHapes[2] := shpCurrAccent;

   for i := 0 to length(arrshapes) do
               begin
                  try
                    ArrShapes[i].Brush.Color := frmMain.arrColors[i];
                  except
                      Continue  ;
                  end;
               end;

  // shpSender := null;


  end;

procedure TfrmAdminHome.HexaBox;
  var
  frmHexaDecimalPicker : TForm;

  begin

     with frmHexaPicker do
      begin
        left := frmAdminHome.Left + frmAdminHome.Width - round(frmHexaDecimalPicker.Width * 1.1);
        top := frmAdminHome.Top;
      end;
       frmHexaPicker.ShowModal;
  end;


procedure TfrmAdminHome.N11Click(Sender: TObject);
  begin
   SwapPnlVis(pnlAdminColor, pnlAdminHomeHome);
  end;

procedure TfrmAdminHome.ReleaseShapeAccent(shp: TShape);
  begin
    shp.Brush.style := bsSolid ;
  end;

procedure TfrmAdminHome.ShapeAccent(shp: TShape);
  begin
     shp.Brush.Style := bsBDiagonal;
  end;

procedure TfrmAdminHome.shpNewAccentMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
   PshpSender := @shpNewAccent;
    pmenuColor.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y) ;
    //sets the pointer shpSender to the memory
    // address of the shape; "@"
  end;

procedure TfrmAdminHome.shpNewMainBackMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
     PshpSender := @shpNewMainBack;  //sets the pointer shpSender to the memory
                                    // address of shpNewMainBack
    pmenuColor.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y) ;
  end;

procedure TfrmAdminHome.shpNewSecondBackMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
    PshpSender := @shpNewSecondBack;
    pmenuColor.Popup(Mouse.CursorPos.X, Mouse.CursorPos.Y) ;
    //sets the pointer shpSender to the memory
    // address of the shape
  end;

procedure TfrmAdminHome.SwapPnlVis(PnlShow, pnlHide: TPanel);
  begin
   pnlHide.Hide;
   pnlShow.Show;
  end;

end.
