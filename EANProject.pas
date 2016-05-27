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

    procedure bQuitClick(Sender: TObject);
    procedure edAlphaBethaKeyPress(Sender: TObject; var Key: Char);
    procedure edMaxIterKeyPress(Sender: TObject; var Key: Char);
    procedure bRunClick(Sender: TObject);
    procedure edNKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure bClearClick(Sender: TObject);

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

//function setValues(): vec_pointer; external 'My_DLL' index 1;
//function setN(): Integer; external 'My_DLL' index 2;

implementation

{$R *.dfm}

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
  // clearing Data:
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
end;

procedure TForm1.bQuitClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.edAlphaBethaKeyPress(Sender: TObject; var Key: Char);
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

procedure TForm1.FormCreate(Sender: TObject);
begin
  rbArithmeticGroup.ItemIndex := 0;
  Data.Cells[0,0] := 'Degree';
  Data.Cells[1,0] := 'Coefficient';
  Data.Cells[0,1] := '0';
end;

function bisection (dataptr: pointer): Extended;
  var i                    : Integer;
      gamma,pa,pb,pg,w1,w2 : Extended;
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
  if (dataptr^.n<1) or (dataptr^.mit<1) or (dataptr^.alpha>=dataptr^.beta)
    then dataptr^.st:=1
    else begin
           pa:=polvalue(dataptr^.n,dataptr^.a,dataptr^.alpha);
           pb:=polvalue(dataptr^.n,dataptr^.a,dataptr^.beta);
           if pa*pb>=0
             then dataptr^.st:=2
             else begin
                    dataptr^.st:=3;
                    dataptr^.it:=0;
                    repeat
                      dataptr^.it:=dataptr^.it+1;
                      gamma:=(dataptr^.alpha+dataptr^.beta)/2;
                      w1:=abs(dataptr^.beta);
                      w2:=abs(dataptr^.alpha);
                      if w1<w2
                        then w1:=w2;
                      if w1=0
                        then dataptr^.st:=0
                        else if (dataptr^.beta-dataptr^.alpha)/w1<dataptr^.eps
                               then dataptr^.st:=0
                               else begin
                                      pg:=polvalue(dataptr^.n,dataptr^.a,gamma);
                                      if pg=0
                                        then dataptr^.st:=0
                                        else begin
                                               if pa*pg<0
                                                 then dataptr^.beta:=gamma
                                                 else dataptr^.alpha:=gamma;
                                               pa:=polvalue(dataptr^.n,dataptr^.a,dataptr^.alpha);
                                               pb:=polvalue(dataptr^.n,dataptr^.a,dataptr^.beta)
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

procedure TForm1.bRunClick(Sender: TObject);
var
  alldata: TBisection;
  alldataptr: pointer;
  bisectionResult: Extended;
  i: Integer;
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
end;

end.

{---------------------------------------------------------------------------}
{                                                                           }
{  The function bisection finds an approximate value of a root of the       }
{  polynomial p(x)=a[n]x^n+a[n-1]x^(n-1)+...+a[1]x+a[0], lying in a given   }
{  interval [a,b], by bisection method.                                     }
{  Data:                                                                    }
{    n          - the degree of polynomial,                                 }
{    a          - an array of coefficients of the polynomial (the element   }
{                 a[i] should contain the value of coefficient before x^i;  }
{                 i=0,1,...,n),                                             }
{    alpha,beta - the ends of the interval which includes the root (changed }
{                 on exit),                                                 }
{    mit        - maximum number of iterations,                             }
{    eps        - relative accuracy of the solution.                        }
{  Results:                                                                 }
{    bisection(n,a,alpha,beta,mit,eps,w,it,st) - approximate value of the   }
{                                                root,                      }
{    alpha,beta                                - the ends of the last       }
{                                                subinterval considered     }
{                                                within the function        }
{                                                bisection,                 }
{    w                                         - the value of polynomial at }
{                                                the approximate root,      }
{    it                                        - number of iterations.      }
{  Other parameters:                                                        }
{    st - a variable which within the function bisection is assigned the    }
{         value of:                                                         }
{           1, if n<1 or mit<1 or alpha>=beta,                              }
{           2, if p(alpha)p(beta)>=0,                                       }
{           3, if the given accuracy eps is not achieved in mit iteration   }
{              steps,                                                       }
{           0, otherwise.                                                   }
{         Note: If st=1 or st=2, then                                       }
{               bisection(n,a,alpha,beta,mit,eps,w,it,st),                  }
{               w and it are not calculated. If st=3, then                  }
{               bisection(n,a,alpha,beta,mit,eps,w,it,st) yields the last   }
{               approximation to the root.                                  }
{  Unlocal identifier:                                                      }
{    vector - a type identifier of extended array [q0..qn], where q0<=0 and }
{             qn>=n.                                                        }
{                                                                           }
{---------------------------------------------------------------------------}
