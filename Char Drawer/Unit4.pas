unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin;

type
  TForm4 = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm4.Button2Click(Sender: TObject);
begin
    Close;
end;

procedure TForm4.Button1Click(Sender: TObject);
begin
    Form1.NewArea;
    Form1.StatusBar1.Panels.Items[3].Text := 'X: '+inttostr(SpinEdit1.Value)+
                                             '; Y: '+inttostr(SpinEdit2.Value);
    Close;
end;

end.
