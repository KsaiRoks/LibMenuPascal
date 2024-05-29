unit NodesEdit;

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
procedure SearchNode(Top: NodePtr; var Leave: NodePtr);
procedure AddSubTree(Top: NodePtr);
procedure DeleteNode(var Top: NodePtr);
procedure MenuOfNodesEdit;

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

procedure SearchNode(Top: NodePtr; var Leave: NodePtr);
begin
  if Top <> nil then
  begin
    if Symbol = Top^.Name then
      Leave := Top
    else
    begin
      SearchNode(Top^.Left, Leave);
      SearchNode(Top^.Right, Leave);
    end;
  end;
end;

procedure AddSubTree(Top: NodePtr);
var
  Leave: NodePtr;
begin
  write('Введите искомый символ: ');
  readln(Symbol);
  SearchNode(Top, Leave);
  if leave = nil then
    write('Символ не найден')
  else
  begin
    write('Добавить ЛЕВОЕ поддерево для ', Leave^.Name, ' ? ');
    readln(Key);
    if Key in ['y', 'Y', 'н', 'Н'] then
    begin
      if Leave^.Left <> nil then
      begin
        write('ЛЕВОЕ поддерево для ', Leave^.Name, ' уже существует! Заменить? ');
        readln(Key);
        if Key in ['y', 'Y', 'н', 'Н'] then
        begin
          MakeTree(Top);
          Leave^.Left := Top;
        end;
      end
      else
      begin
        MakeTree(Top);
        Leave^.Left := Top;
      end;
    end;
    write('Добавить ПРАВОЕ поддерево для ', Leave^.Name, ' ? ');
    readln(Key);
    if Key in ['y', 'Y', 'н', 'Н'] then
    begin
      if Leave^.Right <> nil then
      begin
        write('ПРАВОЕ поддерево для ', Leave^.Name, ' уже существует! Заменить?');
        readln(Key);
        if Key in ['y', 'Y', 'н', 'Н'] then
        begin
          MakeTree(Top);
          Leave^.Right := Top;
        end;
      end
      else
      begin
        MakeTree(Top);
        Leave^.Right := Top;
      end;
    end;
  end;
end;

procedure DeleteNode(var Top: NodePtr);
begin
  if Top <> nil then
  begin
    DeleteNode(Top^.Left);
    DeleteNode(Top^.Right);
    dispose(Top);
    Top := nil;
  end;
end;

procedure DeleteSubTree(var Top: NodePtr);
var
  Leave: NodePtr;
begin
  write('Введите искомый символ: ');
  readln(Symbol);
  SearchNode(Top, Leave);
  if Leave = nil then
    write('Символ не найден')
  else
  begin
    write('Удалить ЛЕВОЕ поддерево для ', Leave^.Name, ' ? ');
    readln(Key);
    if Key in ['y', 'Y', 'н', 'Н'] then
    begin
      DeleteNode(Leave^.Left);
      Leave^.Left := nil;
    end;
    write('Удалить ПРАВОЕ поддерево для ', Leave^.Name, ' ? ');
    readln(Key);
    if Key in ['y', 'Y', 'н', 'Н'] then
    begin
      DeleteNode(Leave^.Right);
      Leave^.Right := nil;
    end;
  end;
end;

procedure DrawNodesEditMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Создать дерево');
  gotoxy(x, y + 1); write('2. Дерево сверху вниз');
  gotoxy(x, y + 2); write('3. Дерево снизу вверх');
  gotoxy(x, y + 3); write('4. Горизонтальное дерево');
  gotoxy(x, y + 4); write('5. Добавить поддерево');
  gotoxy(x, y + 5); write('6. Удалить поддерево');
  gotoxy(x, y + 6); write('Назад в главное меню');
end;

procedure MenuOfNodesEdit;
const
  Items = 7;
var
  ok: boolean;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawNodesEditMenu(X, Y);
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
          AddSubTree(Top);
          PressAnyKey;
        end;
      6:
        begin
          clrscr;
          DeleteSubTree(Top);
          PressAnyKey;
        end;
      7:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.