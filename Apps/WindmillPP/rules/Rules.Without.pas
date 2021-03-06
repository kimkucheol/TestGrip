unit Rules.Without;

interface

uses
  Rules.Interfaces,
  Output.Interfaces,
  System.Classes,
  uPascalDefs;

type
  TRulesWithout = class(TInterfacedObject, IRulesOnMethod)
  private
    FOutput: IOutput;
  public
    constructor Create(const Output: IOutput);

    procedure Process(const Filepath: string; const Classdef: TClassDefinition; const Method: TMethodDefinition; const Lines: TStrings);
  end;

implementation

uses
  System.StrUtils, System.SysUtils;

constructor TRulesWithout.Create(const Output: IOutput);
begin
  FOutput := Output;
end;

procedure TRulesWithout.Process(const Filepath: string; const Classdef: TClassDefinition; const Method: TMethodDefinition; const Lines: TStrings);
var
  Idx: Integer;
  WithPos: Integer;
  CommentPos: Integer;
begin
  for Idx := 0 to Lines.Count - 1 do
  begin
    if ContainsText(Lines[Idx], 'with ') then
    begin
      WithPos := Pos('with ', Lines[Idx].ToLower);
      CommentPos := Pos('//', Lines[Idx]);
      if (CommentPos = 0) or (CommentPos > WithPos) then
      begin
        FOutput.Warning(Filepath, Method.LineNumber + Idx + 1, 'With-statement');
      end;
    end;
  end;
end;

end.
