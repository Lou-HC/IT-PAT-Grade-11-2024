unit LoadingScreen_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, jpeg, Vcl.Samples.Gauges;

type
  TfrmLoading = class(TForm)
    pgbLoad: TProgressBar;
    tmrLoad: TTimer;
    imgKat: TImage;
    tGau: TGauge;
    tmrgaugeLoad: TTimer;
    procedure tmrLoadTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure imgKatClick(Sender: TObject);
    procedure tmrgaugeLoadTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLoading: TfrmLoading;


implementation

uses
Pat_Login_Main_u  ,Pat_login_DM_u , Admin_Home_u , User_Home_u;


{$R *.dfm}

procedure TfrmLoading.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
   frmMain.Close;
  end;

procedure TfrmLoading.FormCreate(Sender: TObject);
  begin
//    tmrLoad.Enabled := true;
    pgbLoad.Width := frmLoading.Width;
    pgbLoad.left := 0;
    imgKat.Left := 100;
    imgKat.Top := tGau.Top;
    imgKat.Height := frmLoading.Height - pgbLoad.Height - 10 ;

  end;

procedure TfrmLoading.FormShow(Sender: TObject);
  begin
    tmrLoad.Enabled := true;
    tmrGaugeLoad.Enabled := True;
  end;

procedure TfrmLoading.imgKatClick(Sender: TObject);
  begin
   pgbLoad.Position := 100;
  end;

procedure TfrmLoading.tmrgaugeLoadTimer(Sender: TObject);
  begin
   tGau.Progress := pgbLoad.Position ;
  end;

procedure TfrmLoading.tmrLoadTimer(Sender: TObject);
  begin
  tmrLoad.Interval := random(1678) ;
    pgbLoad.Position := pgbLoad.Position + round((1.45968745896*tmrLoad.Interval)/140);
      if pgbLoad.Position >= 100 then
      begin
         { if dm1.ADOT1['UserType'] = 'A' then
              begin
                   frmAdminHome.Show;
                   frmLoading.Hide;
              end
              else if dm1.ADOT1['UserType'] = 'U' then
                begin
                  frmUserHome.Show;
                  frmLoading.Hide;
                end
                  else if dm1.ADOT1['UserType'] = 'E' then
                    sleep(0) ;   }

            frmAdminHome.Show;
            frmLoading.Hide;
          pgbLoad.Position := 0;
          tmrLoad.Enabled := false;
      end;   // pos = 100
  end;

end.
