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
    write('Введите число (для завершения введите 999): ');
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
  gotoxy(x, y);     write('Создать Очередь');
  gotoxy(x, y + 1); write('Назад в главное меню');
end;

procedure MenuOfQueues;
const
  Items = 2;
var
  ok:     boolean;
  Bottom, Top: PtrQ;
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
          ok := false;
        end;
    end;
  end;
end;

end.