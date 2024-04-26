unit Nodes;

interface

type
  NodePtr = ^Node;
  Node = record
    Name: char;
    Left, Right: NodePtr;
  end;

procedure MakeSubTree(Leave: NodePtr);
procedure MakeTree(var Top: NodePtr);
procedure WayUpToDown(Top: NodePtr);
procedure WayDownToUp(Top: NodePtr);
function Height(Top: NodePtr): byte;
procedure WayHorizontal(Top: NodePtr; Level: byte);
procedure ViewTreeUpToDown(Top: NodePtr);
procedure ViewTreeDownToUp(Top: NodePtr);
procedure ViewTreeHorizontal(Top: NodePtr);
procedure MenuOfNodes;

implementation

uses
  crt, menu;

var
  Top: NodePtr;
  Key, Symbol: char;
  OK: boolean;

procedure MakeSubTree(Leave: NodePtr);
var
  Top: NodePtr;
begin
  write('Введите текущий узел: ');
  readln(Leave^.Name);
  write('Добавить ЛЕВОЕ поддерево для ', Leave^.Name, ' ? ');
  readln(Key);
  if Key in ['y', 'Y', 'н', 'Н'] then
  begin
    new(Top);
    Leave^.Left := Top;
    MakeSubTree(Top);
  end
  else
    Leave^.Left := nil;
  write('Добавить ПРАВОЕ поддерево для ', Leave^.Name, ' ? ');
  readln(Key);
  if Key in ['y', 'Y', 'н', 'Н'] then
  begin
    new(Top);
    Leave^.Right := Top;
    MakeSubTree(Top);
  end
  else
    Leave^.Right := nil;
end;

procedure MakeTree(var Top: NodePtr);
begin
  new(Top);
  MakeSubTree(Top);
end;

procedure WayUpToDown(Top: NodePtr);
begin
  if Top <> nil then
  begin
    write(Top^.Name, ' ');
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
    write(Top^.Name, ' ');
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
    if Level = 1 then
      write(Top^.Name, ' ')
    else
    begin
      WayHorizontal(Top^.Left, level - 1);
      WayHorizontal(Top^.Right, level - 1);
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
    writeln('');
    WayHorizontal(Top, i);
  end;
end;

procedure DrawNodesMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Дерево сверху вниз');
  gotoxy(x, y + 1); write('2. Дерево снизу вверх');
  gotoxy(x, y + 2); write('3. Горизонтальное дерево');
  gotoxy(x, y + 3); write('Назад в главное меню');
end;

procedure MenuOfNodes;
const
  Items = 4;
var
  ok: boolean;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawNodesMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          MakeTree(Top);
          writeln('Дерево сверху вниз: ');
          ViewTreeUpToDown(Top);
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          MakeTree(Top);
          writeln('Дерево снизу вверх:');
          ViewTreeDownToUp(Top);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          MakeTree(Top);
          write('Горизонтальное дерево:');
          ViewTreeHorizontal(Top);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.