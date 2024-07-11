unit HexaPicker_u;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons
  ;


type
  TfrmHexaPicker = class(TForm)
    shpColorshowcase: TShape;
    edtColorInput: TEdit;
    bmbConfirmcolor: TBitBtn;
    lblHash: TLabel;
    procedure edtColorInputChange(Sender: TObject);
    procedure bmbConfirmcolorClick(Sender: TObject);
    Function HexRGBtoBGR(sInput : string) : string;
    procedure FormShow(Sender: TObject);
    procedure shpColorshowcaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmHexaPicker: TfrmHexaPicker;

implementation
    uses Pat_Login_main_u, Admin_Home_U;
{$R *.dfm}

procedure TfrmHexaPicker.bmbConfirmcolorClick(Sender: TObject);
  begin
   self.Close;  //Hides the form
   //edtColorInput.Text := HexRGBtoBGR(edtColorInput.Text)
  end;

procedure TfrmHexaPicker.edtColorInputChange(Sender: TObject);
  begin

  if length(edtColorInput.Text) > 6 then
     begin
      messagedlg('Incorrect color length: length exceeds 6 characters',
       mtError, [mbOK], 1) ;
       edtColorInput.Text := copy(edtColorInput.Text, 1, 6);
        exit;
     end;
   shpColorshowcase.Brush.Color :=
   stringtocolor('$' + HexRGBtoBGR(edtColorInput.text));
  end;

procedure TfrmHexaPicker.FormShow(Sender: TObject);
  begin
   frmHexaPicker.Color := frmMain.arrColors[0];
   edtColorInput.Text := '';
   lblHash.Font.Color := $FFFFFF; //white

   //shpColorshowcase.Brush.Color := frmMain.arrColors[0];

   //edtColorInput.Text := copy(colortoString(shpColorshowcase.Brush.Color), 2, 6);
  end;

function TfrmHexaPicker.HexRGBtoBGR(sInput: string): string;
    var
    i : integer;
  begin
  //this function takes the common format R G B to B G R which Delphi uses.
    result := '000000' ; //default

    for I := 1 to length(sINput) do
       begin
         if not( (upCase(sInput[i]) in ['A'..'F']) or ((sInput[i]) in ['0'..'9'])) then
            begin
            messagedlg('Incorrect color character type.',
             mtError, [mbOK], 1) ;
            exit;
            end;
       end;
   if length(sInput) > 6  then
   begin
    messagedlg('Incorrect color length: length exceeds 6 characters', mtError,
                                                                   [mbOK], 1) ;
    exit;
   end;
   if length(sInput) < 6 then
    begin
      while length(sInput) < 6 do
        sInput := sInput + '0'; //sets all null values to '0'
    end;

    sInput := copy(sInput, 5, 2) + copy(sInput, 3 ,2 ) + copy(sInput, 1, 2);

    result := sInput;
  end;

procedure TfrmHexaPicker.shpColorshowcaseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  begin
   frmAdminHome.ChooseNewColor(shpColorshowcase, frmAdminHome.cldlgAdmin)
  end;

end.
