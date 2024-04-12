unit Queues;

interface

type
  PtrQ = ^Que;
  Que = record
    Data: integer;
    Next: PtrQ;
  end;

procedure AddQueue(var Bottom, Top: PtrQ; value: integer);
procedure MakeQueue(var Bottom, Top: PtrQ);
procedure ViewQueue(Bottom: PtrQ);
procedure MenuOfQueues;

implementation

uses
  crt, menu;

procedure AddQueue(var Bottom, Top: PtrQ; value: integer);
var
  temp: PtrQ;
begin
  New(temp);
  temp^.Data := value;
  temp^.Next := nil;
  if Top = nil then
  begin
    Bottom := temp;
    Top := temp;
  end
  else
  begin
    Top^.Next := temp;
    Top := temp;
  end;
end;

procedure MakeQueue(var Bottom, Top: PtrQ);
var
  value: integer;
begin
  Bottom := nil;
  Top := nil;
  while value <> 999 do
  begin
    write('Введите число (999 для выхода): ');
    read(value);
    if value <> 999 then
      AddQueue(Bottom, Top, value);
  end;
end;

procedure ViewQueue(Bottom: PtrQ);
var
  curr: PtrQ;
begin
  curr := Bottom;
  while curr <> nil do
  begin
    write(curr^.Data, ' ');
    curr := curr^.Next;
  end;
end;

procedure DrawQueuesMenu(x, y: integer);
begin
  clrscr;
  gotoxy(x, y);     write('1. Создать Очередь');
  gotoxy(x, y + 1); write('2. Добавить элемент в Очередь');
  gotoxy(x, y + 2); write('Назад в главное меню');
end;

procedure MenuOfQueues;
const
  Items = 3;
var
  ok:     boolean;
  Bottom, Top: PtrQ;
  value:  integer;
  n:      byte;
begin
  ok := true; 
  while ok = true do
  begin
    DrawQueuesMenu(X, Y);
    n := SelectMenu(X - 2, Y, Items);
    case n of     
      1:
        begin
          clrscr;
          MakeQueue(Bottom, Top);
          write('Элементы Очереди: ');
          ViewQueue(Bottom);
          PressAnyKey;
        end;
      2:
        begin
          clrscr;
          write('Введите число: ');
          read(value);
          AddQueue(Bottom, Top, Value);
          write('Элементы Очереди: ');
          ViewQueue(Bottom);
          PressAnyKey;
        end;
      3:
        begin
          clrscr;
          ok := false;
        end;
    end;
  end;
end;

end.