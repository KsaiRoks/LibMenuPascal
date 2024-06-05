unit NodesBin;

interface

type
  NodePtr = ^Node;
  Node = record
    Key: byte;
    Left, Right: NodePtr;
  end;

procedure MakeNode(NewKey: byte; var Top: NodePtr);
procedure MakeTree(var Top: NodePtr);
function SearchNode(Top: NodePtr; SearchKey: byte): NodePtr;
procedure WayUpToDown(Top: NodePtr);
procedure WayDownToUp(Top: NodePtr);
function Height(Top: NodePtr): byte;
procedure WayHorizontal(Top: NodePtr; Level: byte);
procedure ViewTreeUpToDown(Top: NodePtr);
procedure ViewTreeDownToUp(Top: NodePtr);
procedure ViewTreeHorizontal(Top: NodePtr);
procedure MenuOfNodesBin;

implementation

uses
  crt, menu;

var
  Top: NodePtr;

procedure MakeNode(NewKey: byte; var Top: NodePtr);
begin
  if Top = nil then
  begin
    new(Top);
    Top^.Key := NewKey;
    Top^.Left := nil;
    Top^.Right := nil;
  end
  else if NewKey < Top^.Key then
  begin
    MakeNode(NewKey, Top^.Left);
  end
  else if NewKey > Top^.Key then
  begin
    MakeNode(NewKey, Top^.Right);
  end;
end;

procedure MakeTree(var Top: NodePtr);
var
  i, n, inputKey: byte;
begin
  write('Введите корень дерева: ');
  readln(n);

  new(Top);
  Top^.Key := n;
  Top^.Left := nil;
  Top^.Right := nil;

  write('Введите количество чисел для добавления в дерево: ');
  readln(n);
  for i := 1 to n do
  begin
    write('Введите новое число: ');
    read(inputKey);
    MakeNode(inputKey, Top);
  end;
end;

function SearchNode(Top: NodePtr; SearchKey: byte): NodePtr;
begin
  if Top = nil then
    SearchNode := nil
  else if Top^.Key = SearchKey then
    SearchNode := Top
  else if SearchKey < Top^.Key then
    SearchNode := SearchNode(Top^.Left, SearchKey)
  else
    SearchNode := SearchNode(Top^.Right, SearchKey)
end;

procedure WayUpToDown(Top: NodePtr);
begin
  if Top <> nil then
  begin
    write(Top^.Key, ' ');
    WayUpToDown(Top^.Left);
    WayUpToDown(Top^.Right);
  end
end;

procedure WayDownToUp(Top: NodePtr);
begin
  if Top <> nil then
  begin
    WayDownToUp(Top^.Left);
    WayDownToUp(Top^.Right);
    write(Top^.Key, ' ');
  end
end;

function Height(Top: NodePtr): byte;
var
  HeightLeft, HeightRight: byte;
begin
  if Top = nil then
    Height := 0
  else
  begin
    HeightLeft := Height(Top^.Left);
    HeightRight := Height(Top^.Right);
    if HeightLeft > HeightRight then
      Height := HeightLeft + 1
    else
      Height := HeightRight + 1
  end;
end;

procedure WayHorizontal(Top: NodePtr; Level: byte);
begin
  if Top <> nil then
  begin
    if Level = 1 then
      write(Top^.key, ' ')
    else if level > 1 then
    begin
      WayHorizontal(Top^.Left, level - 1);
      WayHorizontal(Top^.Right, level - 1);
    end;
  end;
end;


procedure ViewTreeUpToDown(Top: NodePtr);
begin
  if Top <> nil then
  begin
    WayUpToDown(Top);
  end
end;

procedure ViewTreeDownToUp(Top: NodePtr);
begin
  if Top <> nil then
  begin
    WayDownToUp(Top);
  end
end;

procedure ViewTreeHorizontal(Top: NodePtr);
var
  i, HeightTree: byte;
begin
  HeightTree := Height(Top);
  for i := 1 to HeightTree do
  begin
    writeln;
    WayHorizontal(Top, i);
  end;
end;


procedure DrawNodesBinMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Создать дерево');
  gotoxy(x, y + 1); write('2. Дерево сверху вниз');
  gotoxy(x, y + 2); write('3. Дерево снизу вверх');
  gotoxy(x, y + 3); write('4. Горизонтальное дерево');
  gotoxy(x, y + 4); write('Назад в главное меню');
end;

procedure MenuOfNodesBin;
const
  Items = 5;
var
  ok: boolean;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawNodesBinMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of
      1:
        begin
          clrscr;
          MakeTree(Top);
          PressAnyKey;
        end;     
      2:
        begin
          clrscr;
          writeln('Дерево сверху вниз: ');
          ViewTreeUpToDown(Top);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          writeln('Дерево снизу вверх:');
          ViewTreeDownToUp(Top);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          write('Горизонтальное дерево:');
          ViewTreeHorizontal(Top);
          PressAnyKey;
        end;
      5:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.