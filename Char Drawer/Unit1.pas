unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, ComCtrls, ToolWin, Menus, StdCtrls, ExtDlgs,
  XPMan, System.ImageList, Vcl.Samples.Spin;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ImageList1: TImageList;
    PaintBox1: TPaintBox;
    ToolButton9: TToolButton;
    ToolButton5: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton6: TToolButton;
    ToolButton13: TToolButton;
    ComboBox1: TComboBox;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    About1: TMenuItem;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    Savetofile1: TMenuItem;
    Preview1: TMenuItem;
    N1: TMenuItem;
    Exit1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ToolButton19: TToolButton;
    OpenPictureDialog1: TOpenPictureDialog;
    ConvertBMPtoChar1: TMenuItem;
    N2: TMenuItem;
    Newdraw1: TMenuItem;
    ToolButton20: TToolButton;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Brush1: TMenuItem;
    Line1: TMenuItem;
    Box1: TMenuItem;
    Ellipse1: TMenuItem;
    N3: TMenuItem;
    Fill1: TMenuItem;
    FillComplete1: TMenuItem;
    Options1: TMenuItem;
    oolBar1: TMenuItem;
    FontDialog1: TFontDialog;
    ToolButton21: TToolButton;
    Font1: TMenuItem;
    ToolButton22: TToolButton;
    Label1: TLabel;
    SpinEdit1: TSpinEdit;
    procedure NewArea;
    procedure FormCreate(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBox1Resize(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ComboBox1Select(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ConvertBMPtoChar1Click(Sender: TObject);
    procedure Preview1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Newdraw1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure Savetofile1Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure Undo1Click(Sender: TObject);
    procedure Brush1Click(Sender: TObject);
    procedure Line1Click(Sender: TObject);
    procedure Box1Click(Sender: TObject);
    procedure Ellipse1Click(Sender: TObject);
    procedure Fill1Click(Sender: TObject);
    procedure FillComplete1Click(Sender: TObject);
    procedure oolBar1Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure Font1Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TDrawState = (dsFree, dsEllipse, dsBox, dsFill, dsLine);

//const


var
  Form1: TForm1;
  (* *)
  DrawState: TDrawState;
  isDowned: boolean = False;
  CircleS: boolean;
  LineS: boolean;
  BoxS: boolean;
  DrawChar: Char;
  FillChar: Char;
  (* *)
  DrawArea, DrawBuffer, RedoArea: array of array of char;
  ImageBuffer, Buffer: TBitmap;
  (* *)
  AreaWidth, AreaHeight: integer;
  CurX, CurY, CirX, CirY: integer;

  ChrW : integer = 9;
  ChrH : integer = 14;


implementation

uses Unit2, Unit3, Unit4;

Procedure ClearBitmap(var BMP:TBitmap);
begin
    if Assigned(BMP) then BMP.Free;
    BMP := TBitmap.Create;
    Bmp.Width := AreaWidth;
    Bmp.Height := AreaHeight;
end;

Procedure DrawBWBitmapBuff(BMP:TBitmap);
var
    i,j : integer;
begin
    for i := 0 to AreaWidth-1 do
      for j := 0 to AreaHeight-1 do
        if BMP.Canvas.Pixels[i,j] <> clWhite then DrawBuffer[i,j] := DrawChar;
end;

Procedure DrawBWBitmap(BMP:TBitmap);
var
    i,j : integer;
begin
    for i := 0 to AreaWidth-1 do
      for j := 0 to AreaHeight-1 do
        if BMP.Canvas.Pixels[i,j] <> clWhite then DrawArea[i,j] := DrawChar;
end;

procedure GetRedo;
var
    i,j: integer;
begin
    for i := 0 to AreaWidth - 1 do
        for j := 0 to AreaHeight - 1 do
            DrawArea[i,j] := RedoArea[i,j];
end;

procedure MadeRedo;
var
    i,j: integer;
begin
    for i := 0 to AreaWidth - 1 do
        for j := 0 to AreaHeight - 1 do
            RedoArea[i,j] := DrawArea[i,j];
end;

procedure FillArea;
var
    i,j: integer;
begin
    for i := 0 to AreaWidth - 1 do
        for j := 0 to AreaHeight - 1 do
            DrawArea[i,j] := DrawChar;
end;

function FillRegion(x,y: integer) : integer;
var
    i,j : integer;
begin
    Result := 0;

    if DrawArea[x,y] <> FillChar then exit;

    if (DrawArea[x,y] = FillChar) then begin
      DrawArea[x,y]  := DrawChar;
    end;
      
    try
        if (x-1>=0)  then
        if DrawArea[x-1,y]   = FillChar then FillRegion(x-1,y);
        if (x-1>=0) and (y-1 >= 1)  then
        if (y+1<=AreaHeight-1) then
        if DrawArea[x,y+1]   = FillChar then FillRegion(x,y+1);

        if (x+1<=AreaWidth-1) and (y-1>=1) then
        if (x+1<=AreaWidth-1) then
        if DrawArea[x+1,y]   = FillChar then FillRegion(x+1,y);
        if (y-1 >= 0) then
        if DrawArea[x,y-1]   = FillChar then FillRegion(x,y-1);
    except
        exit;
    end;
end;

Procedure ClearBuff;
var
    i,j: integer;
begin
    for i := 0 to AreaWidth - 1 do
        for j := 0 to AreaHeight - 1 do
            DrawBuffer[i,j] := ' ';
end;

procedure ClearArea;
var
    i,j: integer;
begin
    for i := 0 to AreaWidth - 1 do
        for j := 0 to AreaHeight - 1 do
            DrawArea[i,j] := ' ';
end;

procedure InitDrawArea;
var
    i: integer;
begin
    SetLength(DrawArea, AreaWidth);
    for i := 0 to AreaWidth - 1 do
        SetLength(DrawArea[i], AreaHeight);

    SetLength(RedoArea, AreaWidth);
    for i := 0 to AreaWidth - 1 do
        SetLength(RedoArea[i], AreaHeight);

    SetLength(DrawBuffer, AreaWidth);
    for i := 0 to AreaWidth - 1 do
        SetLength(DrawBuffer[i], AreaHeight);


    ClearArea;
    MadeRedo;

    Form1.PaintBox1.Height := (AreaHeight * ChrH) + ChrH + 10;
    Form1.PaintBox1.Width  := (AreaWidth * ChrW) + ChrW + 10;

    if Assigned(Buffer) then Buffer.Free;

    Buffer := TBitmap.Create;
    Buffer.pixelformat := pf24bit;
    Buffer.width := Form1.PaintBox1.Width;
    Buffer.height := Form1.PaintBox1.Height;

    if Assigned(ImageBuffer) then ImageBuffer.Free;

    ImageBuffer := TBitmap.Create;
    ImageBuffer.pixelformat := pf24bit;
    ImageBuffer.width := AreaWidth;
    ImageBuffer.height := AreaHeight;
end;

procedure ConvertImageToChars(BMP:TBitmap);
var
    i,j: integer;
begin
    AreaWidth := BMP.Width;
    AreaHeight := BMP.Height;
    InitDrawArea;

    for i := 0 to AreaWidth-1 do
        for j := 0 to AreaHeight-1 do
            if BMP.Canvas.Pixels[i,j] <> clWhite then DrawArea[i,j] := DrawChar;
end;

function OutOfArea(x,y: integer): boolean;
begin
    result := false;
    if (x < 1) or (y < 1) then
        Result := true
        else
    if (x > AreaWidth) or (y > AreaHeight) then
        Result := true;
end;

Procedure DrawBufferEx(curX, curY: integer; UseBuff: boolean = false);
var
    i,j: integer;
begin
    Buffer.Canvas.Brush.Color := ClWhite;

    //Buffer.Canvas.Font.Size := 14;


    Buffer.Canvas.FillRect(Buffer.Canvas.ClipRect);
    //Buffer.Canvas.FloodFill((curX*ChrW),(curY*ChrH),clWhite,fsBorder);
    Buffer.Canvas.Font.Name := Form1.FontDialog1.Font.Name;


    if Form1.ToolButton22.Down = true then begin
      Buffer.Canvas.Pen.Color := clSilver;
    end;

    if Form1.ToolButton22.Down = false then begin
      Buffer.Canvas.Pen.Color := clWhite;
    end;

    Buffer.Canvas.Font.Color := Form1.FontDialog1.Font.Color;


    (* *)
    for i := 1 to AreaHeight+1 do begin
        Buffer.Canvas.MoveTo(ChrW ,i * ChrH);
        Buffer.Canvas.LineTo(AreaWidth * ChrW + ChrW,i * ChrH);
    end;

    for i := 1 to AreaWidth+1 do begin
        Buffer.Canvas.MoveTo(i * ChrW ,ChrH);
        Buffer.Canvas.LineTo(i * ChrW ,AreaHeight * ChrH + ChrH);
    end;
    (* *)
    if not UseBuff then begin
        for i := 0 to AreaWidth-1 do
            for j := 0 to AreaHeight-1 do
                if DrawArea[i,j] <> ' ' then
                    Buffer.Canvas.TextOut((i+1)*ChrW+1,(j+1)*ChrH+1,DrawArea[i,j]);
    end else begin
        for i := 0 to AreaWidth-1 do
            for j := 0 to AreaHeight-1 do begin
                if DrawArea[i,j] <> ' ' then
                    Buffer.Canvas.TextOut((i+1)*ChrW+1,(j+1)*ChrH+1,DrawArea[i,j]);
                if DrawBuffer[i,j] <> ' ' then
                    Buffer.Canvas.TextOut((i+1)*ChrW+1,(j+1)*ChrH+1,DrawBuffer[i,j]);
            end;
    end;
    (* *)
    if not OutOfArea(curY, curX) then begin
        Buffer.Canvas.Pen.Color := clRed;
        Buffer.Canvas.Rectangle((curX*ChrW),(curY*ChrH),(curX*ChrW)+ChrW+1,(curY*ChrH)+ChrH+1);
    end;
    (* *)
end;

procedure DrawAreaProc(curX, curY: integer; UseBuff: boolean = false);
begin
    DrawBufferEx(curX, curY, usebuff);
    Form1.PaintBox1.Canvas.Draw(3,0,buffer);
end;

{$R *.dfm}

procedure TForm1.NewArea;
var
    i: integer;
begin
    AreaWidth := Form4.SpinEdit1.Value;
    AreaHeight := Form4.SpinEdit2.Value;
    InitDrawArea;
    DrawChar := '0';
    CurX := -1; CurY := -1;
    (* *)
    ComboBox1.Items.Clear;
    for i := 33 to 255 do
        ComboBox1.Items.Add(chr(i));

    ComboBox1.ItemIndex := 15;
end;


procedure TForm1.FormCreate(Sender: TObject);
var
    i: integer;
begin
    AreaWidth := 25;
    AreaHeight := 25;
    InitDrawArea;
    DrawChar := '0';
    DrawState := dsFree;
    CurX := -1;
    CurY := -1;
    ToolButton6.Down := true;
    ToolButton22.Down := true;
    FontDialog1.Font.Name := 'Terminal';
    (* *)
    for i := 33 to 255 do
        ComboBox1.Items.Add(chr(i));

    ComboBox1.ItemIndex := 15;
end;

procedure TForm1.Line1Click(Sender: TObject);
begin
      LineS := False;
    DrawState := dsLine;
    ToolButton6.Down := false;
    ToolButton8.Down := false;
    ToolButton5.Down := true;
    ToolButton10.Down := false;
    ToolButton11.Down := false;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
    CurX := X div ChrW;
    CurY := Y div ChrH;
    StatusBar1.Panels.Items[1].Text := 'X: '+inttostr(CurX-1)+'; Y: '+inttostr(CurY-1);

    case DrawState of
        dsFill     : DrawAreaProc(CurX,CurY);
        dsBox      : begin
                        if BoxS then begin
                            ClearBitmap(ImageBuffer);
                            ImageBuffer.Canvas.Rectangle(CirX-1,CirY-1, (x div ChrW) ,(y div ChrH));
                            ClearBuff;
                            DrawBWBitmapBuff(ImageBuffer);
                            DrawAreaProc(CurX,CurY, True);
                        end else
                        DrawAreaProc(CurX,CurY);
                    end;
        dsLine     : begin
                        if LineS then begin
                            ClearBitmap(ImageBuffer);
                            ImageBuffer.Canvas.MoveTo(CirX-1, CirY-1);
                            ImageBuffer.Canvas.LineTo((x div ChrW) ,(y div ChrH)-1);
                            //Image2.Picture.Bitmap := BufferD;
                            ClearBuff;
                            DrawBWBitmapBuff(ImageBuffer);
                            DrawAreaProc(CurX,CurY, True);
                        end else
                        DrawAreaProc(CurX,CurY);
                    end;
        dsEllipse : begin
                        if CircleS then begin
                            ClearBitmap(ImageBuffer);
                            ImageBuffer.Canvas.Ellipse(CirX,CirY,(x div ChrW) ,(y div ChrH));
                            //Image2.Picture.Bitmap := BufferD;
                            ClearBuff;
                            DrawBWBitmapBuff(ImageBuffer);
                            DrawAreaProc(CurX,CurY, True);
                        end else
                        DrawAreaProc(CurX,CurY);
                    end;
        dsFree   :  begin
                      if isDowned then begin
                          if not OutOfArea(CurX,CurY) then
                              DrawArea[CurX-1,CurY-1] := DrawChar;
                      end;
                      DrawAreaProc(CurX,CurY);
                    end;
    end;
end;

procedure TForm1.ScrollBox1Resize(Sender: TObject);
begin
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.SpinEdit1Change(Sender: TObject);
begin
  ChrW := SpinEdit1.Value;
  ChrH := SpinEdit1.Value;
  Buffer.Canvas.Font.Size := SpinEdit1.Value;
  PaintBox1.Invalidate;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    case DrawState of
        dsFill    : begin
                        if not OutOfArea(CurX,CurY) then begin
                            FillChar := drawArea[(x div ChrW)-1,(y div ChrH)-1];
                            if FillChar = DrawChar then exit;
                            MadeRedo;
                            FillRegion((x div ChrW)-1,(y div ChrH)-1);
                        end;
                    end;
        dsBox     : begin
                         if not BoxS then begin
                            CirX := (x div ChrW);
                            CirY := (y div ChrH);
                            BoxS := true;
                         end;
                    end;
        dsLine    : begin
                         if not LineS then begin
                            CirX := (x div ChrW);
                            CirY := (y div ChrH);
                            ImageBuffer.Canvas.MoveTo(CirX, CirY);
                            LineS := true;
                         end;
                    end;
        dsEllipse : begin
                         if not CircleS then begin
                            CirX := (x div ChrW);
                            CirY := (y div ChrH);
                            CircleS := true;
                         end;
                    end;
        dsFree    : begin
                        isDowned := true;

                        MadeRedo;

                        if not OutOfArea(CurX,CurY) then
                        if DrawArea[(x div ChrW)-1,(y div ChrH)-1] = ' ' then
                           DrawArea[(x div ChrW)-1,(y div ChrH)-1] := DrawChar else
                           DrawArea[(x div ChrW)-1,(y div ChrH)-1] :=' ';
                    end;
    end;
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
    case DrawState of
        dsEllipse : begin
                        CircleS  := False;
                        DrawState := dsFree;
                        CirX := -1;
                        CirY := -1;
                        MadeRedo;
                        DrawBWBitmap(ImageBuffer);
                    end;
        dsLine    : begin
                        LineS  := False;
                        DrawState := dsFree;
                        CirX := -1;
                        CirY := -1;
                        MadeRedo;
                        DrawBWBitmap(ImageBuffer);
                    end;
        dsBox    : begin
                        BoxS  := False;
                        DrawState := dsFree;
                        CirX := -1;
                        CirY := -1;
                        MadeRedo;
                        DrawBWBitmap(ImageBuffer);
                    end;
    end;

    isDowned := False;
end;

procedure TForm1.Fill1Click(Sender: TObject);
begin
  DrawState := dsFill;
    ToolButton6.Down := false;
    ToolButton5.Down := false;
    ToolButton10.Down := false;
    ToolButton11.Down := false;
    ToolButton8.Down := true;
end;

procedure TForm1.FillComplete1Click(Sender: TObject);
begin
  FillArea;
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.Font1Click(Sender: TObject);
begin
  ToolButton21.OnClick(self);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Finalize(DrawArea);
    Finalize(DrawBuffer);
    Buffer.Free;
    Action := caFree;
end;

procedure TForm1.ToolButton11Click(Sender: TObject);
begin
    CircleS := False;
    DrawState := dsEllipse;
    ToolButton6.Down := false;
    ToolButton8.Down := false;
    ToolButton5.Down := false;
    ToolButton10.Down := false;
    ToolButton11.Down := true;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
    DrawState := dsFree;
    ToolButton8.Down := false;
    ToolButton6.Down := true;
    ToolButton5.Down := false;
    ToolButton10.Down := false;
    ToolButton11.Down := false;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
    LineS := False;
    DrawState := dsLine;
    ToolButton6.Down := false;
    ToolButton8.Down := false;
    ToolButton5.Down := true;
    ToolButton10.Down := false;
    ToolButton11.Down := false;
end;

procedure TForm1.ToolButton10Click(Sender: TObject);
begin
    CircleS := False;
    DrawState := dsBox;
    ToolButton6.Down := false;
    ToolButton8.Down := false;
    ToolButton5.Down := false;
    ToolButton10.Down := true;
    ToolButton11.Down := false;
end;

procedure TForm1.ToolButton13Click(Sender: TObject);
begin
    FillArea;
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.Box1Click(Sender: TObject);
begin
      CircleS := False;
    DrawState := dsBox;
    ToolButton6.Down := false;
    ToolButton8.Down := false;
    ToolButton5.Down := false;
    ToolButton10.Down := true;
    ToolButton11.Down := false;
end;

procedure TForm1.Brush1Click(Sender: TObject);
begin
  DrawState := dsFree;
    ToolButton8.Down := false;
    ToolButton6.Down := true;
    ToolButton5.Down := false;
    ToolButton10.Down := false;
    ToolButton11.Down := false;
end;

procedure TForm1.ComboBox1Select(Sender: TObject);
begin
    DrawChar := ComboBox1.Text[1];
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
    DrawState := dsFill;
    ToolButton6.Down := false;
    ToolButton5.Down := false;
    ToolButton10.Down := false;
    ToolButton11.Down := false;
    ToolButton8.Down := true;
end;

procedure TForm1.Undo1Click(Sender: TObject);
begin
  ToolButton14.OnClick(self);
end;

procedure TForm1.ToolButton14Click(Sender: TObject);
begin
    GetRedo;
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
var
    i,j: integer;
    Line: String;
begin
    Form2.Memo1.Clear;

    for i := 0 to AreaHeight - 1 do begin
        Line := '';
        for j := 0 to AreaWidth - 1 do
            Line := Line + DrawArea[j,i];
        Form2.Memo1.Lines.Add(Line);
    end;
    Form2.ShowModal;
end;

procedure TForm1.ToolButton16Click(Sender: TObject);
begin
    Form3.ShowModal;
end;

procedure TForm1.About1Click(Sender: TObject);
begin
    Form3.ShowModal;
end;

procedure TForm1.ToolButton17Click(Sender: TObject);
begin
    Close;
end;

procedure TForm1.Ellipse1Click(Sender: TObject);
begin
      CircleS := False;
    DrawState := dsEllipse;
    ToolButton6.Down := false;
    ToolButton8.Down := false;
    ToolButton5.Down := false;
    ToolButton10.Down := false;
    ToolButton11.Down := true;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
    Close;
end;

procedure TForm1.ToolButton19Click(Sender: TObject);
var
    BMP: TBitmap;
begin
    if OpenPictureDialog1.Execute then begin
        BMP := TBitmap.Create;
        BMP.LoadFromFile(OpenPictureDialog1.FileName);
        ConvertImageToChars(BMP);
        BMP.Free;
    end;
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.ConvertBMPtoChar1Click(Sender: TObject);
begin
    ToolButton19.OnClick(self);
end;

procedure TForm1.Preview1Click(Sender: TObject);
begin
    ToolButton3.OnClick(self);
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
    Form4.ShowModal;
    ChrW := SpinEdit1.Value;
  ChrH := SpinEdit1.Value;
  Buffer.Canvas.Font.Size := SpinEdit1.Value;
  PaintBox1.Invalidate;
end;

procedure TForm1.Newdraw1Click(Sender: TObject);
begin
    Form4.ShowModal;
end;

procedure TForm1.oolBar1Click(Sender: TObject);
begin
  ToolBar1.Visible :=  oolBar1.Checked;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
var
  Savelist: TStringList;
  i,j: integer;
  tmp: string;
begin
    if not SaveDialog1.Execute then exit;

    Savelist := TStringList.Create;
    for i := 0 to AreaHeight-1 do begin
        tmp := '';
        for j := 0 to AreaWidth-1 do
            tmp := tmp + DrawArea[j,i];
        Savelist.Add(tmp);
    end;

    Savelist.SaveToFile(SaveDialog1.FileName);
    Savelist.Free;
end;

procedure TForm1.Savetofile1Click(Sender: TObject);
begin
    ToolButton2.OnClick(self);
end;

procedure TForm1.ToolButton20Click(Sender: TObject);
begin
    MadeRedo;
    ClearArea;
    DrawAreaProc(CurX,CurY);
end;

procedure TForm1.ToolButton21Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    FontDialog1.Font.Name := FontDialog1.Font.Name;
    StatusBar1.Panels[5].Text := FontDialog1.Font.Name + '9';
  end;
end;

procedure TForm1.ToolButton22Click(Sender: TObject);
begin
  if Buffer.Canvas.Pen.Color = clSilver then
  begin
    ToolBar1.Buttons[7].Down := false;
  end else begin
    ToolBar1.Buttons[7].Down := true;
  end;
end;

end.
