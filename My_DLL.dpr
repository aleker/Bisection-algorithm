library My_DLL;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
System.SysUtils,
  System.Classes,
  Vcl.Dialogs,
  Vcl.Grids;

  var n: Integer;
type
  vec_pointer = ^vector;
  vector = array of Extended;

{$R *.res}

function setN(): Integer; stdcall;
begin
  setN := 3;
end;

function setValues(): vec_pointer; stdcall;
var vec: vector;
  begin
    setLength(vec, setN() + 1);
    vec[0] := 3;
    vec[1] := -1;
    vec[2] := -3;
    vec[3] := 1;
    setValues := @vec;
  end;

exports
  setValues index 1,
  setN index 2;

begin
end.
