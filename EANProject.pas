// TODO
// co z przedziałami = 0
// int_read dla liczby jako przedział

unit EANProject;

interface
uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  IntervalArithmetic32and64, Vcl.StdCtrls, Vcl.ExtCtrls, Math, Vcl.Grids;

type
  TForm1 = class(TForm)
    bQuit: TButton;
    rbArithmeticGroup: TRadioGroup;
    panelData: TPanel;
    labAlpha: TLabel;
    labBeta: TLabel;
    labMaxIter: TLabel;
    labEpsilon: TLabel;
    panelResult: TPanel;
    labAlphaResult: TLabel;
    labBetaResult: TLabel;
    labBisection: TLabel;
    labBisectionResult: TLabel;
    labIterNumber: TLabel;
    labIterResult: TLabel;
    labNewAlpha: TLabel;
    labNewBeta: TLabel;
    labPolynResult: TLabel;
    labPolynVal: TLabel;
    labSt: TLabel;
    labStResult: TLabel;
    bRun: TButton;
    edAlpha: TEdit;
    edBeta: TEdit;
    edMaxIter: TEdit;
    edEpsilon: TEdit;
    Data: TStringGrid;
    labN: TLabel;
    edN: TEdit;
    bClear: TButton;
    labE: TLabel;
    edEpsilon2: TEdit;
    rbIntervalGroup: TRadioGroup;
    edAlpha2: TEdit;
    edBeta2: TEdit;
    labAlphaWidth: TLabel;
    labBetaWidth: TLabel;
    labBisectionWidth: TLabel;
    labPolynWidth: TLabel;

    procedure bQuitClick(Sender: TObject);
    procedure alphaBetaKeyPress(Sender: TObject; var Key: Char);
    procedure edMaxIterKeyPress(Sender: TObject; var Key: Char);
    procedure bRunClick(Sender: TObject);
    procedure edNKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure bClearClick(Sender: TObject);
    procedure rbArithmeticGroupClick(Sender: TObject);
    procedure rbIntervalGroupClick(Sender: TObject);
    procedure bisectionClassic(Sender: TObject);
    procedure bisectionInterval(Sender: TObject; IsInterval: Boolean);
    procedure DataKeyPress(Sender: TObject; var Key: Char);
    procedure edEpsilon2KeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

type
  vec_pointer = ^vector;
  vector = array of Extended;
  pointer = ^TBisection;
      TBisection = record
        n              : Integer;
        a              : vector;
        var alpha,beta : Extended;
        mit            : Integer;
        eps            : Extended;
        var w          : Extended;
        var it,st      : integer
      end;

  vec_pointerE = ^vectorE;
  vectorE = array of interval;
  pointerI = ^TBisectionI;
    TBisectionI = record
        n              : Integer;
        a              : vectorE;
        var alpha,beta : interval;
        mit            : Integer;
        eps            : Extended;
        var w          : interval;
        var it,st      : integer
    end;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  rbArithmeticGroup.ItemIndex := 0;
  rbIntervalGroup.ItemIndex := 0;
  rbIntervalGroup.Enabled := False;
  edAlpha2.Visible := False;
  edBeta2.Visible := False;
  Data.Cells[0,0] := 'Degree';
  Data.Cells[1,0] := 'Coefficient';
  Data.Cells[0,1] := '0';
end;


procedure TForm1.rbArithmeticGroupClick(Sender: TObject);
begin
  edAlpha2.Visible := False;
  edBeta2.Visible := False;
  if rbArithmeticGroup.ItemIndex = 0 then
  begin
    rbIntervalGroup.ItemIndex := 0;
    rbIntervalGroup.Enabled := False;
    Data.ColCount := 2;
    Data.Cells[0,0] := 'Degree';
    Data.Cells[1,0] := 'Coefficient';
    Data.Cells[0,1] := '0';
  end
  else if rbArithmeticGroup.ItemIndex = 1 then
  begin
    rbIntervalGroup.Enabled := True;
  end;
end;

procedure TForm1.rbIntervalGroupClick(Sender: TObject);
begin
  if rbIntervalGroup.ItemIndex = 0 then
  begin
    edAlpha2.Visible := False;
    edBeta2.Visible := False;
    Data.ColCount := 2;
    Data.Cells[0,0] := 'Degree';
    Data.Cells[1,0] := 'Coefficient';
    Data.Cells[0,1] := '0';
  end
  else if rbIntervalGroup.ItemIndex = 1 then
  begin
    edAlpha2.Visible := True;
    edBeta2.Visible := True;
    Data.ColCount := 3;
    Data.Cells[0,0] := 'Degree';
    Data.Cells[1,0] := 'Coef. alpha';
    Data.Cells[2,0] := 'Coef. beta';
    Data.Cells[0,1] := '0';
  end;

end;

procedure TForm1.bClearClick(Sender: TObject);
var
  i: Integer;
begin
  edAlpha.Text := '';
  edBeta.Text := '';
  edMaxIter.Text := '';
  edEpsilon.Text := '';
  edEpsilon2.Text := '';
  edN.Text := '0';
  rbArithmeticGroup.ItemIndex := 0;
  rbIntervalGroup.ItemIndex := 0;
  rbIntervalGroup.Enabled := False;
  edAlpha2.Text := '';
  edBeta2.Text := '';
  edAlpha2.Visible := False;
  edBeta2.Visible := False;
  // clearing Data:
  Data.ColCount := 2;
  for i := 0 to Data.ColCount - 1 do
    Data.Cols[i].Clear;
  Data.Cells[0,0] := 'Degree';
  Data.Cells[1,0] := 'Coefficient';
  Data.Cells[0,1] := '0';
  Data.RowCount := 2;
  // clearing results:
  labAlphaResult.Caption := '';
  labBetaResult.Caption := '';
  labStResult.Caption := '';
  labBisectionResult.Caption := '';
  labPolynResult.Caption := '';
  labIterResult.Caption := '';
  // clearing width labels:
  labAlphaWidth.Caption := '';
  labBetaWidth.Caption := '';
  labBisectionWidth.Caption := '';
  labPolynWidth.Caption := '';
end;

procedure TForm1.bQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.alphaBetaKeyPress(Sender: TObject; var Key: Char);
var DecimalSeparator : char;
begin
  DecimalSeparator := ',';
  if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  begin
    //ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and
    (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    //ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and ((Sender as TEdit).SelStart <> 0) then
  begin
    //ShowMessage('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end;
end;

procedure TForm1.edEpsilon2KeyPress(Sender: TObject; var Key: Char);
var DecimalSeparator : char;
begin
  DecimalSeparator := ',';
  if not (Key in [#8, '0'..'9', '-', DecimalSeparator]) then
  begin
    //ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and
    (Pos(Key, (Sender as TEdit).Text) > 0) then
  begin
    //ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and ((Sender as TEdit).SelStart <> 0) then
  begin
    //ShowMessage('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end
  else if ((Key in ['0'..'9']) and ((Sender as TEdit).GetTextLen = 0)) then
  begin
    // this has to be negative value
    Key := #0;
  end;

end;

procedure TForm1.edMaxIterKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8, '0'..'9']) then
  begin
    Key := #0;
  end
end;


procedure TForm1.edNKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
oldNumberOfRows: Integer;
row: Integer;
begin
  if edN.Text <> '' then
  begin
    oldNumberOfRows := Data.RowCount;
    Data.RowCount := strtoint(edN.Text) + 2;
    if Data.RowCount = oldNumberOfRows then exit
    // to increase number of rows:
    else if Data.RowCount > oldNumberOfRows then
    begin
      for row := oldNumberOfRows to Data.RowCount do
      begin
        Data.Cells[0,row] := inttostr(row - 1);
      end;
    end;
  end;
end;

function iabs ( x : interval) : interval;
begin
    if ((x.b*x.a < 0) or (x.a=0) or (x.b=0)) then result.a:=0
    else result.a := min(abs(x.a), abs(x.b));
    result.b := max(abs(x.a), abs(x.b));
end;

function imin ( x : interval) : extended;
begin
   if x.a < x.b then result := x.a
   else result := x.b;
end;

function imax ( x : interval) : extended;
begin
   if x.a > x.b then result := x.a
   else result := x.b;
end;

function bisection (dataptr: pointer): Extended;
  var i                    : Integer;
      gamma,pa,pb,pg,w1,w2 : Extended;
  // determining polynomial value:
  function polvalue (n: Integer; a: vector; x: Extended): Extended;
    var i : Integer;
        p : Extended;
    begin
      p:=a[n];
      for i:=n-1 downto 0 do
        p:=p*x+a[i];
      polvalue:=p
    end {polvalue};
begin
  if (dataptr^.n < 1) or (dataptr^.mit < 1) or (dataptr^.alpha >= dataptr^.beta)
    then dataptr^.st:=1
  else
  begin
    pa:=polvalue(dataptr^.n,dataptr^.a,dataptr^.alpha);
    pb:=polvalue(dataptr^.n,dataptr^.a,dataptr^.beta);
    if pa*pb >= 0 then dataptr^.st:=2
    else
    begin
      dataptr^.st:=3;
      dataptr^.it:=0;
      repeat
        dataptr^.it:=dataptr^.it+1;
        gamma:=(dataptr^.alpha+dataptr^.beta)/2;
        w1:=abs(dataptr^.beta);
        w2:=abs(dataptr^.alpha);
        if w1<w2 then w1:=w2;
        if w1=0 then dataptr^.st:=0
        else if (dataptr^.beta-dataptr^.alpha)/w1 < dataptr^.eps
          then dataptr^.st:=0
        else
        begin
          pg:=polvalue(dataptr^.n,dataptr^.a,gamma);
          if pg=0 then dataptr^.st:=0
          else
          begin
            if pa*pg < 0 then dataptr^.beta:=gamma
            else dataptr^.alpha:=gamma;
            pa:=polvalue(dataptr^.n,dataptr^.a,dataptr^.alpha);
            pb:=polvalue(dataptr^.n,dataptr^.a,dataptr^.beta);
          end
        end
      until (dataptr^.it=dataptr^.mit) or (dataptr^.st=0)
    end
  end;
  if (dataptr^.st=0) or (dataptr^.st=3)then
  begin
    bisection:=gamma;
    dataptr^.w:=pg
  end
end;

function bisectionI (dataptr: pointerI): interval;
var
  i                         : Integer;
  pa, pb, gamma, w1,w2, pg  : interval;
  help                      : interval;
  function polvalue (n: Integer; a: vectorE; x: interval): interval;
    var i : Integer;
        p : interval;
    begin
      p :=a[n];
      for i:=n-1 downto 0 do
        p := iadd(imul(p,x), a[i]);
      polvalue:=p
    end {polvalue};
begin
  // fixing reversed intervals:
  dataptr^.alpha := projection(dataptr^.alpha);
  dataptr^.beta := projection(dataptr^.beta);
  for i := 0 to dataptr^.n do
      dataptr^.a[i] := projection(dataptr^.a[i]);
  //
  if (dataptr^.n < 1) or (dataptr^.mit < 1) or (dataptr^.alpha.a >= dataptr^.beta.b)
    then dataptr^.st:=1
  else
  begin
    pa:=polvalue(dataptr^.n,dataptr^.a,dataptr^.alpha);
    pa := projection(pa);
    pb:=polvalue(dataptr^.n,dataptr^.a,dataptr^.beta);
    pb := projection(pb);
    if imul(pa,pb).a >= 0 then dataptr^.st:=2
    else
    begin
      dataptr^.st:=3;
      dataptr^.it:=0;
      repeat
        dataptr^.it:=dataptr^.it+1;
        help.a := 2;
        help.b := 2;
        gamma:= idiv(iadd(dataptr^.alpha,dataptr^.beta), help);
        gamma:= projection(gamma);
        w1 := iabs(dataptr^.beta);
        w2 := iabs(dataptr^.alpha);
        if w1.b < w2.a then w1 := w2;
        if ((w1.a <= 0) and (w1.b >= 0)) then dataptr^.st:=0
        else if idiv(isub(dataptr^.beta,dataptr^.alpha),w1).b < dataptr^.eps
          then dataptr^.st:=0
        else
        begin
          pg:=polvalue(dataptr^.n,dataptr^.a,gamma);
          pg := projection(pg);
          if ((pg.a <= 0) and (pg.b >= 0)) then dataptr^.st:=0
          else
          begin
            if imul(pa,pg).b < 0 then dataptr^.beta:=gamma
            else dataptr^.alpha:=gamma;
            pa:=polvalue(dataptr^.n,dataptr^.a,dataptr^.alpha);
            pa := projection(pa);
            pb:=polvalue(dataptr^.n,dataptr^.a,dataptr^.beta);
            pa := projection(pa)
          end
        end
      until (dataptr^.it=dataptr^.mit) or (dataptr^.st=0)
    end
  end;
  if (dataptr^.st=0) or (dataptr^.st=3)then
  begin
    bisectionI:=gamma;
    dataptr^.w:=pg
  end
end;

procedure TForm1.bisectionClassic(Sender: TObject);
var
  alldata: TBisection;
  alldataptr: pointer;
  bisectionResult: Extended;
  i: Integer;
begin
  alldata.eps := Power(strtoint(edEpsilon.Text)* 10, strtoint(edEpsilon2.Text));
  alldata.n := strtoint(edN.Text);      // 1-n
  setLength(alldata.a, alldata.n + 1);  // 0-n
  for i := 0 to alldata.n do
  begin
    alldata.a[i] := strtofloat(Data.Cells[1,i + 1]);
  end;
  alldata.alpha := strtofloat(edAlpha.Text);
  alldata.beta := strtofloat(edBeta.Text);
  alldata.mit := strtoint(edMaxIter.Text);
  alldataptr := @alldata;
  bisectionResult := bisection(alldataptr);
  // RESULT:
  labAlphaResult.Caption := formatfloat('0.00000000000000E+0000', alldata.alpha);
  labBetaResult.Caption := formatfloat('0.00000000000000E+0000', alldata.beta);
  labStResult.Caption := inttostr(alldata.st);
  if (alldata.st <> 1) and (alldata.st <> 2) then
  begin
    labBisectionResult.Caption := formatfloat('0.00000000000000E+0000', bisectionResult);
    labPolynResult.Caption := formatfloat('0.00000000000000E+0000', alldata.w);
    labIterResult.Caption := inttostr(alldata.it);
  end;
end;


procedure TForm1.bisectionInterval(Sender: TObject; IsInterval: Boolean);
var
  alldata: TBisectionI;
  alldataptr: pointerI;
  bisectionResult: interval;
  i: Integer;
begin
  alldata.eps := Power(strtoint(edEpsilon.Text)* 10, strtoint(edEpsilon2.Text));
  alldata.n := strtoint(edN.Text);
  setLength(alldata.a, alldata.n + 1);
  for i := 0 to alldata.n do
  begin
    alldata.a[i].a := left_read(Data.Cells[1,i + 1]);
    if IsInterval then alldata.a[i].b := right_read(Data.Cells[2,i + 1])
    else alldata.a[i].b := right_read(Data.Cells[1,i + 1]);
  end;
  alldata.alpha.a := left_read(edAlpha.Text);
  alldata.beta.a := left_read(edBeta.Text);
  if IsInterval then
  begin
    alldata.alpha.b := right_read(edAlpha2.Text);
    alldata.beta.b := right_read(edBeta2.Text);
  end
  else
  begin
    alldata.alpha.b := right_read(edAlpha.Text);
    alldata.beta.b := right_read(edBeta.Text);
  end;
  alldata.mit := strtoint(edMaxIter.Text);
  alldataptr := @alldata;
  bisectionResult := bisectionI(alldataptr);
  // RESULT:
  labAlphaResult.Caption := formatfloat('0.00000000000000E+0000', alldata.alpha.a)
    + ' ; ' + formatfloat('0.00000000000000E+0000', alldata.alpha.b);
  labAlphaWidth.Caption := 'Width: ' + formatfloat('0.00E+0000', int_width(alldata.alpha));
  labBetaResult.Caption := formatfloat('0.00000000000000E+0000', alldata.beta.a)
    + ' ; ' + formatfloat('0.00000000000000E+0000', alldata.beta.b);
  labBetaWidth.Caption := 'Width: ' + formatfloat('0.00E+0000', int_width(alldata.beta));
  labStResult.Caption := inttostr(alldata.st);
  if (alldata.st <> 1) and (alldata.st <> 2) then
  begin
    labBisectionResult.Caption := formatfloat('0.00000000000000E+0000', bisectionResult.a)
      + ' ; ' + formatfloat('0.00000000000000E+0000', bisectionResult.b);
    labBisectionWidth.Caption := 'Width: ' + formatfloat('0.00E+0000', int_width(bisectionResult));
    labPolynResult.Caption := formatfloat('0.00000000000000E+0000', alldata.w.a)
      + ' ; ' + formatfloat('0.00000000000000E+0000', alldata.w.b);
    labPolynWidth.Caption := 'Width: ' + formatfloat('0.00E+0000', int_width(alldata.w));
    labIterResult.Caption := inttostr(alldata.it);
  end;
end;

procedure TForm1.bRunClick(Sender: TObject);
begin
  // clearing results:
  labAlphaResult.Caption := '';
  labBetaResult.Caption := '';
  labStResult.Caption := '';
  labBisectionResult.Caption := '';
  labPolynResult.Caption := '';
  labIterResult.Caption := '';
  //
  if rbArithmeticGroup.ItemIndex = 0 then
    bisectionClassic(Sender)
  else if ((rbArithmeticGroup.ItemIndex = 1) and (rbIntervalGroup.ItemIndex = 0)) then
    bisectionInterval(Sender, False)
  else if ((rbArithmeticGroup.ItemIndex = 1) and (rbIntervalGroup.ItemIndex = 1)) then
    bisectionInterval(Sender, True);
end;

procedure TForm1.DataKeyPress(Sender: TObject; var Key: Char);
var DecimalSeparator : char;
begin
  DecimalSeparator := ',';
  if not (Key in [#8, '0'..'9', '-',DecimalSeparator]) then
  begin
    //ShowMessage('Invalid key: ' + Key);
    Key := #0;
  end
  else if ((Key = DecimalSeparator) or (Key = '-')) and
    (Pos(Key, (Sender as TStringGrid).Cells[(Sender as TStringGrid).Col,(Sender as TStringGrid).Row ]) > 0) then
  begin
    //ShowMessage('Invalid Key: twice ' + Key);
    Key := #0;
  end
  else if (Key = '-') and (((Sender as TStringGrid).Cells[(Sender as TStringGrid).Col,(Sender as TStringGrid).Row].IsEmpty) = false) then
  begin
    //ShowMessage('Only allowed at beginning of number: ' + Key);
    Key := #0;
  end;
end;

end.
