unit Stacks;

interface

type
  EXST = ^ST;
  ST = record
    Data: integer;
    Next: EXST;
  end;

procedure AddStack(var Top: EXST; value: integer);
procedure MakeStack(var Top: EXST);
procedure ViewStack(Top: EXST);
procedure ConnectionStacks(var Top1, Top2: EXST);
procedure MenuOfStacks;

implementation

uses
  crt, Queues, menu;

procedure AddStack(var Top: EXST; value: integer);
var
  temp: EXST;
begin
  New(temp);
  temp^.Data := value;
  temp^.Next := Top;
  Top := temp;
end;

procedure MakeStack(var Top: EXST);
var
  value: integer;
begin
  Top := nil;
  while value <> 999 do
  begin
    write('Введите число (999 для выхода): ');
    readln(value);
    if value <> 999 then
      AddStack(Top, value);
  end;
end;

procedure ViewStack(Top: EXST);
var
  curr: EXST;
begin
  curr := Top;
  while curr <> nil do
  begin
    write(curr^.Data);
    write(' ');
    curr := curr^.Next;
  end;
end;

procedure ConnectionStacks(var Top1, Top2: EXST);
var
  curr: EXST;
begin
  if Top1 = nil then
  begin
    Top1 := Top2;
  end
  else
  begin
    curr := Top1;
    while curr^.Next <> nil do
    begin
      curr := curr^.Next;
    end;
    curr^.Next := Top2;
  end;
end;

procedure StackToQueue(var Top1: EXST; var Bottom, Top: PtrQ);
var
  curr: EXST;
  revStack: EXST;
begin
  revStack := nil;
  curr := Top1;
  while curr <> nil do
  begin
    addStack(revStack, curr^.Data);
    curr := curr^.Next;
  end;
  curr := revStack;
  while curr <> nil do
  begin
    addQueue(Bottom, Top, curr^.Data);
    curr := curr^.Next;
  end;
end;


procedure DrawStacksMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Создать Стэк');
  gotoxy(x, y + 1); write('2. Добавить элемент в Стэк');
  gotoxy(x, y + 2); write('3. Соеденить 2 разных Стэка');
  gotoxy(x, y + 3); write('4. Создание Очереди из Стэка');
  gotoxy(x, y + 4); write('Назад в главное меню');
end;

procedure MenuOfStacks;
const
  Items = 5;
var
  ok:     boolean;
  Top1, Top2: EXST;
  Bottom, Top: PtrQ;
  value:  integer;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawStacksMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          MakeStack(Top1);
          write('Элементы Cтэка: ');
          ViewStack(Top1);
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          write('Введите число: ');
          read(value);
          AddStack(Top1, value);
          write('Элементы Cтэка: ');
          ViewStack(Top1);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          writeln('Создать Стэк 1');
          MakeStack(Top1);
          writeln('Создать Стэк 2');
          MakeStack(Top2);
          ConnectionStacks(Top1, Top2);
          writeln('Объединенный Cтэк: ');
          ViewStack(Top1);
          PressAnyKey;
        end;
      4:
        begin
          clrscr;
          MakeStack(Top1);
          write('Элементы Cтэка: ');
          ViewStack(Top1);
          writeln('');
          StackToQueue(Top1, Bottom, Top);
          write('Очередь из Стэка: ');
          ViewQueue(Bottom);
          PressAnyKey
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